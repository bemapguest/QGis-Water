-- CREATE VIEW PIPE
---------------------------------

CREATE OR REPLACE VIEW v_arc_pipe_geom_1
AS
   SELECT a.start_node,
          a.end_node,
          a.city_id,
          a.street_id,
          a.geom_1,
          a.length,
          a.data_source,
          a.date_insert,
          a.date_update,
          p.id,
          p.arc_id,
          p.location,
          p.domain,
          p.precision_class,
          p.flow_type,
          p.water_type,
          p.function,
          p.contract_id,
          p.asbuilt_id,
          p.pressure_zone_id,
          z.color,
          p.district_id,
          p.year,
          p.material,
          p.diameter,
          p.external_diam,
          p.internal_diam,
          p.year_rehab,
          p.rehab_type,
          p.status,
          p.comments
     FROM pipe p
          INNER JOIN arc a ON a.id = p.arc_id
          LEFT OUTER JOIN pressure_zone z ON z.id = p.pressure_zone_id;


-- CREATE FUNCTION fn_arc_pipe_insert
---------------------------------          

CREATE OR REPLACE FUNCTION fn_arc_pipe_insert()
RETURNS trigger AS
$BODY$	
	DECLARE
        _arcId             integer;
        _start_node        integer;
        _start_node_geom   geometry;
        _end_node          integer;
        _end_node_geom     geometry;
        _id                integer;
        _column_name character varying;
        _result character varying;    
        
	BEGIN	

        --- Check if there is node at start point
        --- If there is, the value is stored in _start_node
        SELECT n.id
        FROM node n
        WHERE sT_Distance (ST_StartPoint (NEW.geom_1), n.geom_1) < 1
        ORDER BY ST_Distance (ST_StartPoint (NEW.geom_1), n.geom_1)
        LIMIT 1
        INTO _start_node;

        IF _start_node IS NULL THEN
            _start_node = nextval ('node_id_seq');
            INSERT INTO node (id,geom_1) VALUES (_start_node,ST_StartPoint (NEW.geom_1));
        END IF;	  

        SELECT geom_1 FROM node WHERE id = _start_node INTO _start_node_geom;


        --- Check if there is node at end point
        --- If there is, the value is stored in _end_node
        SELECT n.id
        FROM node n
        WHERE sT_Distance (ST_EndPoint (NEW.geom_1), n.geom_1) < 1
        ORDER BY ST_Distance (ST_EndPoint (NEW.geom_1), n.geom_1)
        LIMIT 1
        INTO _end_node;

        IF _end_node IS NULL THEN
            _end_node = nextval ('node_id_seq');
            INSERT INTO node (id,geom_1) VALUES (_end_node,ST_EndPoint (NEW.geom_1));
        END IF;	   

        SELECT geom_1 FROM node WHERE id = _end_node INTO _end_node_geom;     

        --- Insert into arc 
		
		insert into arc 
		(
			geom_1,
			length,
			data_source,
			date_insert,
			date_update,
            start_node,
            end_node
		)			
		values 
		(
			NEW.geom_1,
			st_length(NEW.geom_1),
			NEW.data_source,
			now(),
			null,
            _start_node,
            _end_node				
		) returning id into NEW.id;

        --- Update geom_1 from the nodes geometries          

        update arc set geom_1=ST_SetPoint (NEW.geom_1, 0, _start_node_geom) where id=new.id;
        update arc set geom_1=ST_SetPoint (NEW.geom_1, ST_NumPoints (NEW.geom_1) - 1, _end_node_geom) where id=new.id;

        --- Insert into pipe         
		
		insert into pipe 
		(
			arc_id,
			location,
			domain,
			precision_class,
			flow_type,
			water_type,
			function,
			contract_id,
			asbuilt_id,
			pressure_zone_id,
			district_id,
			year,
			material,
			diameter,
			year_rehab,
			rehab_type,
			status,
			comments
    		)
		values
		(
			NEW.id,
			NEW.location,
			NEW.domain,
			NEW.precision_class,
			NEW.flow_type,
			NEW.water_type,
			NEW.function,
			NEW.contract_id,
			NEW.asbuilt_id,
			NEW.pressure_zone_id,
			NEW.district_id,
			NEW.year,
			NEW.material,
			NEW.diameter,
			NEW.year_rehab,
			NEW.rehab_type,
			NEW.status,
			NEW.comments	
		);

    -- The following lines update the operational data from the arc connected to the strat point
    -- A améliorer / résultat ne s'affecte pas à l'update
    
    _id=currval ('pipe_id_seq');
    FOR _column_name IN SELECT column_name FROM information_schema.columns WHERE table_name   = 'pipe' and column_name not in ('id','arc_id','comment')  LOOP    
        execute format('select %s from pipe WHERE arc_id IN (SELECT id FROM arc WHERE end_node = %s) LIMIT 1', _column_name,_start_node) into _result;
        IF length(_result) >= 1 THEN
            execute format('update pipe set %s=%s where %s is null and id=%s', _column_name,_result,_column_name,_id);
        END IF;
    END LOOP;	
	RETURN NEW;
	
    END;
    $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


-- CREATE TRIGGER tr_arc_pipe_insert
---------------------------------   

CREATE TRIGGER tr_arc_pipe_insert
   INSTEAD OF INSERT
   ON v_arc_pipe_geom_1
   FOR EACH ROW
EXECUTE PROCEDURE fn_arc_pipe_insert ();


-- CREATE FUNCTION fn_arc_pipe_update
---------------------------------     

CREATE OR REPLACE FUNCTION fn_arc_pipe_update ()
   RETURNS trigger
AS
$BODY$
DECLARE
    _start_node        integer;
    _start_node_geom   geometry;
    _end_node          integer;
    _end_node_geom     geometry;
    _column_name character varying;
    _result character varying;    
    _node_id integer;
    _id integer;
    _arcId integer;

BEGIN
   UPDATE arc
      SET geom_1 = NEW.geom_1,
          length = st_length (NEW.geom_1),
          city_id = NEW.city_id,
          street_id = NEW.street_id,
          data_source = NEW.data_source,
          date_insert = OLD.date_insert,
          date_update = now ()
    WHERE id = new.arc_id;

   UPDATE pipe
      SET location = NEW.location,
          domain = NEW.domain,
          precision_class = NEW.precision_class,
          flow_type = NEW.flow_type,
          water_type = NEW.water_type,
          function = NEW.function,
          contract_id = NEW.contract_id,
          asbuilt_id = NEW.asbuilt_id,
          pressure_zone_id = NEW.pressure_zone_id,
          district_id = NEW.district_id,
          year = NEW.year,
          material = NEW.material,
          diameter = NEW.diameter,
          year_rehab = NEW.year_rehab,
          rehab_type = NEW.rehab_type,
          status = NEW.status,
          comments = NEW.comments
    WHERE id = new.id;
    
    -- The following lines update the operational data from the arc connected to the strat point
    _node_id=NEW.start_node;
    _id=NEW.id;
    FOR _column_name IN SELECT column_name FROM information_schema.columns WHERE table_name   = 'pipe' and column_name not in ('id','arc_id','comment')  LOOP    
        execute format('select %s from pipe WHERE arc_id IN (SELECT id FROM arc WHERE end_node = %s) LIMIT 1', _column_name,_node_id) into _result;
        IF length(_result) >= 1 THEN
            execute format('update pipe set %s=%s where %s is null and id=%s', _column_name,_result,_column_name,_id);
        END IF;
    END LOOP;

    --- Update the geom of the nodes connected if y-there is no node at new location

    --- Check if there is node at start point
    --- If there is, the value is stored in _start_node
    SELECT n.id
    FROM node n
    WHERE sT_Distance (ST_StartPoint (NEW.geom_1), n.geom_1) < 1
    ORDER BY ST_Distance (ST_StartPoint (NEW.geom_1), n.geom_1)
    LIMIT 1
    INTO _start_node;


    SELECT geom_1 FROM node WHERE id = _start_node INTO _start_node_geom;

    IF _start_node IS not NULL and _start_node<>NEW.start_node THEN
        update arc set start_node = _start_node where id=NEW.arc_id;
    else 
        update node set geom_1=St_startpoint(NEW.geom_1) where id=NEW.start_node; 
        FOR _arcId in select id from arc where id<>NEW.arc_id and start_node=NEW.start_node LOOP
            update arc set geom_1=st_setpoint(geom_1,0,st_startpoint(NEW.geom_1)) where id=_arcId;   
        END LOOP;
        FOR _arcId in select id from arc where id<>NEW.arc_id and end_node=NEW.start_node LOOP
            update arc set geom_1=st_setpoint(geom_1,ST_NumPoints (geom_1) - 1,st_startpoint(NEW.geom_1)) where id=_arcId;   
        END LOOP;
    END IF;	 

    --- Check if there is node at end point
    --- If there is, the value is stored in _end_node
    SELECT n.id
    FROM node n
    WHERE sT_Distance (ST_EndPoint (NEW.geom_1), n.geom_1) < 1
    ORDER BY ST_Distance (ST_EndPoint (NEW.geom_1), n.geom_1)
    LIMIT 1
    INTO _end_node;


    SELECT geom_1 FROM node WHERE id = _end_node INTO _end_node_geom;

    IF _end_node IS not NULL and _end_node<>NEW.end_node THEN
        update arc set end_node = _end_node where id=NEW.arc_id;
    else 
        update node set geom_1=St_endpoint(NEW.geom_1) where id=NEW.end_node; 
        FOR _arcId in select id from arc where id<>NEW.arc_id and end_node=NEW.end_node LOOP
            update arc set geom_1=st_setpoint(geom_1,ST_NumPoints (geom_1) - 1,st_endpoint(NEW.geom_1)) where id=_arcId;   
        END LOOP;
        FOR _arcId in select id from arc where id<>NEW.arc_id and start_node=NEW.end_node LOOP
            update arc set geom_1=st_setpoint(geom_1,0,st_endpoint(NEW.geom_1)) where id=_arcId;   
        END LOOP;        
    END IF;	  
        
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql
VOLATILE
COST 100;

-- CREATE TRIGGER tr_arc_pipe_update
---------------------------------   

CREATE TRIGGER tr_arc_pipe_update
   INSTEAD OF UPDATE
   ON v_arc_pipe_geom_1
   FOR EACH ROW
EXECUTE PROCEDURE fn_arc_pipe_update ();

-- CREATE FUNCTION fn_arc_pipe_delete
---------------------------------   

CREATE OR REPLACE FUNCTION fn_arc_pipe_delete ()
   RETURNS trigger
AS
$BODY$
BEGIN

   DELETE FROM arc WHERE id = OLD.arc_id;
   DELETE FROM pipe WHERE id = OLD.id;

RETURN NULL;
END;
$BODY$
LANGUAGE plpgsql
VOLATILE
COST 100;

-- CREATE TRIGGER tr_arc_pipe_delete
---------------------------------   

CREATE TRIGGER tr_arc_pipe_delete
   INSTEAD OF DELETE
   ON v_arc_pipe_geom_1
   FOR EACH ROW
EXECUTE PROCEDURE fn_arc_pipe_delete ();