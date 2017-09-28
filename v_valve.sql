------CREATE VIEW v_node_valve_geom_1
----------------------------------------------

CREATE OR REPLACE VIEW v_node_valve_geom_1
AS
   SELECT 
          n.geom_1,
          n.data_source,
          n.date_insert,
          n.date_update,
          v.id,
          v.node_id,
          v.location,
          v.domain,
          v.precision_class,
          v.contract_id,
          v.asbuilt_id,
          v.pressure_zone_id,
          v.district_id,
          v.ground_level,
          v.type,
          v.function,
          v.rotation,
          v.position,
          v.manufacturer,
          v.model,
          v.diameter,
          v.topo_x,
          v.topo_y,
          v.topo_z,
          v.year,
          v.status,
          v.comments
     FROM valve v INNER JOIN node n ON n.id = v.node_id;


------CREATE FUNCTION ft_v_node_valve_insert
---------------------------------------------- 
CREATE OR REPLACE FUNCTION ft_v_node_valve_insert()
  RETURNS trigger AS
$BODY$
    DECLARE
	_node_id integer;
	_arc_row record;
	_new_arc_id integer;
	_angle numeric(12,2);
    _start_node integer;
    
	BEGIN

    --- QUERY TO CHECK IF THE OBJECT IS LESS THAN 10 CM FROM AN EXISTING NODE		
	SELECT n.id FROM node n WHERE sT_Distance(NEW.geom_1, n.geom_1)<0.1 order by ST_Distance(NEW.geom_1, n.geom_1) limit 1 INTO _node_id ;
	
    --- CREATE 2 NEW GEOMETRIES IF THE OBJECT IS CLOSED TO AN EXISTING LINE
    select 
    a.id as id,
    a.data_source,
    a.start_node,
    ST_Line_Substring (a.geom_1,0,ST_Line_Locate_Point(a.geom_1,NEW.geom_1)) as first_half,
    ST_Line_Substring (a.geom_1,ST_Line_Locate_Point(a.geom_1,NEW.geom_1),1) as other_half 
    from arc a 
    where  ST_Intersects(st_buffer(NEW.geom_1,1),a.geom_1)='t' 
	INTO _arc_row ;

    --- ESTIMATE THE ANGLE WITH A BUFER AROUND THE OBJECT
	select 
    degrees(st_azimuth(NEW.geom_1,St_intersection(ST_ExteriorRing(ST_Buffer(NEW.geom_1, 1)) , a.geom_1))) 
    from arc a 
	where a.id=_arc_row.id
	and St_geometrytype(St_intersection(ST_ExteriorRing(ST_Buffer(NEW.geom_1, 1)) , a.geom_1))='ST_Point'
	limit 1 into _angle;

    drop table temp_azimuth;
    create table temp_azimuth (id integer,arc_id integer,angle numeric(12,2),geom geometry);
    insert into temp_azimuth values(1,_angle,_arc_row.id,NEW.geom_1);

	--IF A NODE EXISTS THEN...
	
	IF _node_id is not null then

		update node set 
		data_source=NEW.data_source,
		date_update=now()
		where id=_node_id;	

		INSERT INTO valve (
			node_id,
			location,
			domain,
			precision_class,
			contract_id,
			asbuilt_id,
			pressure_zone_id,
			district_id,
			ground_level,
			type,
			function,
			rotation,
			position,
			manufacturer,
			model,
			diameter,
			topo_x,
			topo_y,
			topo_z,
			year,
			status,
			comments) 
		  VALUES (
			_node_id,
			NEW.location,
			NEW.domain,
			NEW.precision_class,
			NEW.contract_id,
			NEW.asbuilt_id,
			NEW.pressure_zone_id,
			NEW.district_id,
			NEW.ground_level,
			NEW.type,
			NEW.function,
			_angle,
			NEW.position,
			new.manufacturer,
			new.model,
			new.diameter,
			new.topo_x,
			new.topo_y,
			new.topo_z,
			new.year,
			new.status,
			new.comments   
		);

	--ELSIF A NODE DOES NOT EXIST AND THE OBJECT IS CLOSED TO AN EXITING ARC THEN...	
    ELSIF _node_id is null AND _arc_row.id is not null then
		INSERT INTO node (
			geom_1,
			data_source,
			date_insert)
		  values(
			new.geom_1,
			new.data_source,
			now()
			) 
		 returning id into NEW.id; 		
 
		INSERT INTO valve (
			node_id,
			location,
			domain,
			precision_class,
			contract_id,
			asbuilt_id,
			pressure_zone_id,
			district_id,
			ground_level,
			type,
			function,
			rotation,
			position,
			manufacturer,
			model,
			diameter,
			topo_x,
			topo_y,
			topo_z,
			year,
			status,
			comments)  
		  VALUES (
		  	NEW.id,
			NEW.location,
			NEW.domain,
			NEW.precision_class,
			NEW.contract_id,
			NEW.asbuilt_id,
			NEW.pressure_zone_id,
			NEW.district_id,
			NEW.ground_level,
			NEW.type,
			NEW.function,
			-- Prévoir une focntion ST_azymth pour calculer un angle
			_angle,
			NEW.position,
			new.manufacturer,
			new.model,
			new.diameter,
			new.topo_x,
			new.topo_y,
			new.topo_z,
			new.year,
			new.status,
			new.comments     
		);

		insert into arc (
			geom_1,
			length,
            start_node,
            end_node,
			data_source,
			date_insert)
		values (		
			_arc_row.first_half,
			st_length(_arc_row.first_half),
            _arc_row.start_node,
            NEW.id,
			_arc_row.data_source,
			now()) returning id into _new_arc_id;
		
		insert into pipe (arc_id,location,domain,precision_class,flow_type,water_type,function,contract_id,asbuilt_id,pressure_zone_id,district_id,year,material,diameter,internal_diam,external_diam,year_rehab,rehab_type,status,comments)
		select _new_arc_id,location,domain,precision_class,flow_type,water_type,function,contract_id,asbuilt_id,pressure_zone_id,district_id,year,material,diameter,internal_diam,external_diam,year_rehab,rehab_type,status,comments from pipe where arc_id=_arc_row.id;	
			
		update arc set geom_1=_arc_row.other_half,start_node=NEW.id,length=st_length(_arc_row.other_half) where id=_arc_row.id;
		
	END IF;	
        RETURN NEW;
    END;
    $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  
  CREATE TRIGGER tr_v_node_valve_insert
   INSTEAD OF INSERT
   ON v_node_valve_geom_1
   FOR EACH ROW
EXECUTE PROCEDURE ft_v_node_valve_insert ();



CREATE OR REPLACE FUNCTION ft_v_node_valve_update()
  RETURNS trigger AS
$BODY$

BEGIN
    
update node set 
	geom_1=NEW.geom_1,
	data_source=NEW.data_source,
	date_update=now()
where id=NEW.node_id;	

update valve set 
	location=NEW.location,
	domain=NEW.domain,
	precision_class=NEW.precision_class,
	contract_id=NEW.contract_id,
	asbuilt_id=NEW.asbuilt_id,
	pressure_zone_id=NEW.pressure_zone_id,
	district_id=NEW.district_id,
	ground_level=NEW.ground_level,
	type=NEW.type,
	function=NEW.function,
	rotation=NEW.rotation,
	position=NEW.position,
	manufacturer=NEW.manufacturer,
	model=NEW.model,
	diameter=NEW.diameter,
	topo_x=NEW.topo_x,
	topo_y=NEW.topo_y,
	topo_z=NEW.topo_z,
	year=NEW.year,
	status=NEW.status,
	comments=NEW.comments
where id=NEW.id	 ;


    RETURN NEW;
    END;
    $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

 CREATE TRIGGER tr_v_node_valve_update
   INSTEAD OF UPDATE
   ON v_node_valve_geom_1
   FOR EACH ROW
EXECUTE PROCEDURE ft_v_node_valve_update ();

CREATE OR REPLACE FUNCTION fn_node_valve_delete ()
   RETURNS trigger
AS
$BODY$
BEGIN

   DELETE FROM valve
         WHERE id = OLD.id;


   RETURN NULL;
END;
$BODY$
   LANGUAGE plpgsql
   VOLATILE
   COST 100;

CREATE TRIGGER tr_v_node_valve_delete
   INSTEAD OF DELETE
   ON v_node_valve_geom_1
   FOR EACH ROW
EXECUTE PROCEDURE fn_node_valve_delete ();