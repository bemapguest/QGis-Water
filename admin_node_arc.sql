----﻿
CREATE OR REPLACE FUNCTION ft_node_admin ()
   RETURNS trigger
AS
$BODY$

BEGIN
   NEW.city_id :=
      (SELECT id
         FROM city
        WHERE ST_Intersects (NEW.geom_1, city.geom));
   NEW.street_id :=
      (  SELECT id
           FROM street
          WHERE ST_DWithin (NEW.geom_1, street.geom, 5)
       ORDER BY ST_Distance (NEW.geom_1, street.geom)
          LIMIT 1);

    RETURN NEW;
END;
$BODY$
   LANGUAGE plpgsql
   VOLATILE
   COST 100;

CREATE TRIGGER tr_node_admin
   BEFORE INSERT OR UPDATE OF geom_1
   ON node
   FOR EACH ROW
EXECUTE PROCEDURE ft_node_admin ();



CREATE OR REPLACE FUNCTION fn_arc_admin ()
   RETURNS trigger
AS
$BODY$

BEGIN
   NEW.city_id :=
      (SELECT id
         FROM city
        WHERE ST_Intersects (ST_StartPoint (NEW.geom_1), city.geom));
   NEW.street_id :=
      (  SELECT id
           FROM street
          WHERE ST_DWithin (NEW.geom_1, street.geom, 5)
       ORDER BY ST_Distance (NEW.geom_1, street.geom)
          LIMIT 1);

 
   RETURN NEW;
END;
$BODY$
   LANGUAGE plpgsql
   VOLATILE
   COST 100;

CREATE TRIGGER tr_arc_admin
   BEFORE INSERT OR UPDATE OF geom_1
   ON arc
   FOR EACH ROW
EXECUTE PROCEDURE fn_arc_admin ();
----

