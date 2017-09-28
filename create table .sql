---------------------------------------
--- Type de donnée spécifique à la classe de précision﻿
--- Datatype for precision class
---------------------------------------

--drop type precision_class;

--CREATE TYPE precision_class AS ENUM ('A', 'B', 'C'); -- A <20 cm B > 40cm et C > 40cm

---------------------------------------
-- Listes de valeurs
-- Value lists
---------------------------------------

-- Pressure zone color /Couleur des étages de pression

DROP TABLE vl_pressure_zone_color CASCADE;

CREATE TABLE vl_pressure_zone_color
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_pressure_zone_color_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );

INSERT INTO vl_pressure_zone_color
     VALUES (1,
             'Bleu',
             '',
             '',
             '',
             '',
             '');

INSERT INTO vl_pressure_zone_color
     VALUES (2,
             'Bleu nuit',
             '',
             '',
             '',
             '',
             '');

INSERT INTO vl_pressure_zone_color
     VALUES (3,
             'Magenta',
             '',
             '',
             '',
             '',
             '');

INSERT INTO vl_pressure_zone_color
     VALUES (4,
             'Rouge',
             '',
             '',
             '',
             '',
             '');

INSERT INTO vl_pressure_zone_color
     VALUES (5,
             'Orange',
             '',
             '',
             '',
             '',
             '');

INSERT INTO vl_pressure_zone_color
     VALUES (6,
             'Vert',
             '',
             '',
             '',
             '',
             '');

INSERT INTO vl_pressure_zone_color
     VALUES (7,
             'Vert bouteille',
             '',
             '',
             '',
             '',
             '');

INSERT INTO vl_pressure_zone_color
     VALUES (8,
             'Fuchia',
             '',
             '',
             '',
             '',
             '');


-- Data source / Source de données

DROP TABLE vl_data_source CASCADE;

CREATE TABLE vl_data_source
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_date_source_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );


INSERT INTO vl_data_source
     VALUES (0,
             'Inconnu',
             'Unknown',
             'ND',
             '',
             'Inconnu',
             'Unknown');

INSERT INTO vl_data_source
     VALUES (1,
             'Récolement',
             'As-built',
             '',
             '',
             '',
             'U');

INSERT INTO vl_data_source
     VALUES (2,
             'Enquête terrain',
             '',
             '',
             '',
             '',
             '');


-- Location / Emplacement

DROP TABLE vl_location CASCADE;

CREATE TABLE vl_location
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_location_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );

-- Types d'écoulement / Flow type

DROP TABLE vl_flow_type CASCADE;

CREATE TABLE vl_flow_type
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_flow_type_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );


INSERT INTO vl_flow_type
     VALUES (0,
             'Inconnu',
             'Unknown',
             'ND',
             '',
             'Inconnu',
             'Unknown');

INSERT INTO vl_flow_type
     VALUES (1,
             'Gravitaire',
             'Gravity',
             'GRAV',
             'GRAV',
             'Réseau gravitaire',
             'Gravity Flow');

INSERT INTO vl_flow_type
     VALUES (2,
             'Refoulement',
             'Discharge',
             'REF',
             'DISCH',
             'Réseau refoulement',
             'Discharge pipe');

-- Emplacements / Location

DROP TABLE vl_location CASCADE;

CREATE TABLE vl_location
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_location_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );



INSERT INTO vl_location
     VALUES (0,
             'Inconnu',
             'Unknown',
             'ND',
             '',
             'Inconnu',
             'Unknown');

INSERT INTO vl_location
     VALUES (1,
             'Chaussée',
             'Roadway',
             'CHAUSSEE',
             'ROAD',
             'Sous chaussée',
             'Under roadway');

INSERT INTO vl_location
     VALUES (2,
             'Trottoir',
             'Pavement',
             'TROTTOIR',
             'PAVEMENT',
             'Sous trottoir',
             'Under pavement');

INSERT INTO vl_location
     VALUES (3,
             'Chemin',
             'Pathway',
             'CHEMIN',
             'PATHWAY',
             'Sous chemin',
             'Under pathway');

INSERT INTO vl_location
     VALUES (4,
             'Encorbellement',
             'Bridge',
             'ENCORBEL',
             'BRIDGE',
             'Encorbellement',
             'bridge');

INSERT INTO vl_location
     VALUES (5,
             'Fonçage',
             '',
             'FONCAGE',
             '',
             'Fonçage / traversée',
             '');



-- Type d'eau / Water Type

DROP TABLE vl_water_type CASCADE;

CREATE TABLE vl_water_type
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_water_type_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );

INSERT INTO vl_water_type
     VALUES (1,
             'Eau potable',
             'Drinking water',
             'POTABLE',
             'DRINKING',
             'Eau Potable',
             'Drinking Water');

INSERT INTO vl_water_type
     VALUES (2,
             'Eau brute',
             'Raw water',
             'BRUTE',
             'RAW',
             'Eau brute',
             'Raw water');

INSERT INTO vl_water_type
     VALUES (3,
             'Eau industrielle',
             'Industrial water',
             'INDUS',
             'INDUS',
             'Eau de process industriel',
             'Industrial water');

INSERT INTO vl_water_type
     VALUES (0,
             'Inconnu',
             'Unknown',
             'ND',
             '',
             'Inconnu',
             '');


-- Type réhabilitation / Réhabilitation Type

DROP TABLE vl_rehab_type CASCADE;

CREATE TABLE vl_rehab_type
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_rehab_type_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );

INSERT INTO vl_rehab_type
     VALUES (1,
             'Chemisage',
             '',
             'CHEMISAGE',
             '',
             'Chemisage',
             '');

INSERT INTO vl_rehab_type
     VALUES (2,
             'Tubage',
             '',
             'TUBAGE',
             '',
             'Tubage',
             '');

INSERT INTO vl_rehab_type
     VALUES (3,
             'Chemisage / PEHD',
             '',
             'CHEMISAGE',
             '',
             'Chemisage / PEHD',
             '');

INSERT INTO vl_rehab_type
     VALUES (4,
             'Chemisage / Résine',
             '',
             'CHEMISAGE',
             '',
             'Chemisage / Résine',
             '');

INSERT INTO vl_rehab_type
     VALUES (5,
             'Tubage / PEHD',
             '',
             'TUBAGE',
             '',
             'Tubage / PEHD',
             '');


-- Type réhabilitation / Réhabilitation Type

DROP TABLE vl_material CASCADE;

CREATE TABLE vl_material
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (32),
   value_en         CHARACTER VARYING (32),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_material_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );

INSERT INTO vl_material
     VALUES (1,
             'Acier',
             NULL,
             'A',
             NULL,
             'Acier',
             NULL);

INSERT INTO vl_material
     VALUES (2,
             'Acier Galva',
             NULL,
             'Galva',
             NULL,
             'Acier Galva',
             NULL);

INSERT INTO vl_material
     VALUES (3,
             'Acier Inoxydable',
             NULL,
             'Inox',
             NULL,
             'Acier Inoxydable',
             NULL);

INSERT INTO vl_material
     VALUES (4,
             'Amiante Ciment',
             NULL,
             'AC',
             NULL,
             'Amiante Ciment',
             NULL);

INSERT INTO vl_material
     VALUES (5,
             'Autre',
             NULL,
             '{null}',
             NULL,
             'Autre',
             NULL);

INSERT INTO vl_material
     VALUES (6,
             'Béton',
             NULL,
             'B',
             NULL,
             'Béton',
             NULL);

INSERT INTO vl_material
     VALUES (7,
             'Béton Ame Tôle Acier Ciment',
             NULL,
             'BAT',
             NULL,
             'Béton Ame Tôle Acier Ciment',
             NULL);

INSERT INTO vl_material
     VALUES (8,
             'Ciment',
             NULL,
             'Ci',
             NULL,
             'Ciment',
             NULL);

INSERT INTO vl_material
     VALUES (9,
             'Cuivre',
             NULL,
             'Cu',
             NULL,
             'Cuivre',
             NULL);

INSERT INTO vl_material
     VALUES (10,
             'Fibre de Verre',
             NULL,
             'VP',
             NULL,
             'Fibre de Verre',
             NULL);

INSERT INTO vl_material
     VALUES (11,
             'Fibro-Ciment',
             NULL,
             'Fib-C',
             NULL,
             'Fibro-Ciment',
             NULL);

INSERT INTO vl_material
     VALUES (12,
             'Fonte Centriflex',
             NULL,
             'FCx',
             NULL,
             'Fonte Centriflex',
             NULL);

INSERT INTO vl_material
     VALUES (13,
             'Fonte Ductile',
             NULL,
             'FD',
             NULL,
             'Fonte Ductile',
             NULL);

INSERT INTO vl_material
     VALUES (14,
             'Fonte Ductile (ISOPAM)',
             NULL,
             'FD',
             NULL,
             'Fonte Ductile (ISOPAM)',
             NULL);

INSERT INTO vl_material
     VALUES (15,
             'Fonte Ductile (TT)',
             NULL,
             'FD',
             NULL,
             'Fonte Ductile (TT)',
             NULL);

INSERT INTO vl_material
     VALUES (16,
             'Fonte Ductile (blutop)',
             NULL,
             'FD',
             NULL,
             'Fonte Ductile (blutop)',
             NULL);

INSERT INTO vl_material
     VALUES (17,
             'Fonte Ductile 2GS',
             NULL,
             '2GS',
             NULL,
             'Fonte Ductile 2GS',
             NULL);

INSERT INTO vl_material
     VALUES (18,
             'Fonte Grise',
             NULL,
             'FG',
             NULL,
             'Fonte Grise',
             NULL);

INSERT INTO vl_material
     VALUES (19,
             'Fonte indéterminée',
             NULL,
             'Fte',
             NULL,
             'Fonte indéterminée',
             NULL);

INSERT INTO vl_material
     VALUES (20,
             'Grès Vernisse',
             NULL,
             'GV',
             NULL,
             'Grès Vernisse',
             NULL);

INSERT INTO vl_material
     VALUES (22,
             'Matériau Plastique Indéterminé',
             NULL,
             'Plast',
             NULL,
             'Matériau Plastique Indéterminé',
             NULL);

INSERT INTO vl_material
     VALUES (23,
             'Maçonné',
             NULL,
             'M',
             NULL,
             'Maçonné',
             NULL);

INSERT INTO vl_material
     VALUES (24,
             'PEHD Excel-Plus',
             NULL,
             'PE-Ex',
             NULL,
             'PEHD Excel-Plus',
             NULL);

INSERT INTO vl_material
     VALUES (25,
             'PVC Bi-Orienté',
             NULL,
             'BiO',
             NULL,
             'PVC Bi-Orienté',
             NULL);

INSERT INTO vl_material
     VALUES (26,
             'PVC Renforce Verre',
             NULL,
             'PVR',
             NULL,
             'PVC Renforce Verre',
             NULL);

INSERT INTO vl_material
     VALUES (27,
             'Plomb',
             NULL,
             'Pb',
             NULL,
             'Plomb',
             NULL);

INSERT INTO vl_material
     VALUES (28,
             'Polychlorure de Vinyle',
             NULL,
             'PVC',
             NULL,
             'Polychlorure de Vinyle',
             NULL);

INSERT INTO vl_material
     VALUES (29,
             'Polypropylène',
             NULL,
             'PP',
             NULL,
             'Polypropylène',
             NULL);

INSERT INTO vl_material
     VALUES (30,
             'Polyéthylène BD',
             NULL,
             'PEBD',
             NULL,
             'Polyéthylène BD',
             NULL);

INSERT INTO vl_material
     VALUES (31,
             'Polyéthylène HD',
             NULL,
             'PEHD',
             NULL,
             'Polyéthylène HD',
             NULL);

INSERT INTO vl_material
     VALUES (32,
             'Polyéthylène ind.',
             NULL,
             'PE',
             NULL,
             'Polyéthylène ind.',
             NULL);

INSERT INTO vl_material
     VALUES (0,
             'Inconnu',
             NULL,
             '{null}',
             NULL,
             'Inconnu',
             NULL);



-- Type réhabilitation / Réhabilitation Type

DROP TABLE vl_status CASCADE;

CREATE TABLE vl_status
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_status_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );

INSERT INTO vl_status
     VALUES (0,
             'ND',
             'Unknown',
             NULL,
             NULL,
             NULL,
             NULL);

INSERT INTO vl_status
     VALUES (1,
             'En service',
             'In use',
             NULL,
             NULL,
             NULL,
             NULL);

INSERT INTO vl_status
     VALUES (2,
             'Hors service',
             'Out of service',
             NULL,
             NULL,
             NULL,
             NULL);

INSERT INTO vl_status
     VALUES (3,
             'Abandonné',
             'Disused',
             NULL,
             NULL,
             NULL,
             NULL);

-- Domaine / Domain

DROP TABLE vl_domain CASCADE;

CREATE TABLE vl_domain
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_domain_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );

INSERT INTO vl_domain
     VALUES (1,
             'Public',
             'Public',
             NULL,
             NULL,
             NULL,
             NULL);

INSERT INTO vl_domain
     VALUES (2,
             'Privé',
             'Private',
             NULL,
             NULL,
             NULL,
             NULL);

INSERT INTO vl_domain
     VALUES (0,
             'ND',
             'Unknown',
             NULL,
             NULL,
             NULL,
             NULL);

-- Type vanne / Valve type

DROP TABLE vl_valve_type CASCADE;

CREATE TABLE vl_valve_type
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_valve_type_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );

INSERT INTO vl_valve_type
     VALUES (1,
             'Autre',
             NULL,
             '{null}',
             NULL,
             'Autre',
             NULL);

INSERT INTO vl_valve_type
     VALUES (2,
             'Electrovanne',
             NULL,
             '{null}',
             NULL,
             'Electrovanne',
             NULL);

INSERT INTO vl_valve_type
     VALUES (3,
             'Robinet vanne',
             NULL,
             'RV',
             NULL,
             'Robinet vanne',
             NULL);

INSERT INTO vl_valve_type
     VALUES (4,
             'Vanne 1/4 tour',
             NULL,
             'V',
             NULL,
             'Vanne 1/4 tour',
             NULL);

INSERT INTO vl_valve_type
     VALUES (5,
             'Vanne papillon',
             NULL,
             '{null}',
             NULL,
             'Vanne papillon',
             NULL);

-- Position vanne / Valve position

DROP TABLE vl_valve_position CASCADE;

CREATE TABLE vl_valve_position
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_valve_position_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );

INSERT INTO vl_valve_position
     VALUES (0,
             'ND',
             NULL,
             'O',
             NULL,
             'ND',
             NULL);

INSERT INTO vl_valve_position
     VALUES (1,
             'Ouverte',
             NULL,
             'O',
             NULL,
             'Ouverte',
             NULL);

INSERT INTO vl_valve_position
     VALUES (2,
             'Bloquée ouverte',
             NULL,
             'O',
             NULL,
             'Bloquée ouverte',
             NULL);

INSERT INTO vl_valve_position
     VALUES (3,
             'Fermée',
             NULL,
             'F',
             NULL,
             'Fermée',
             NULL);

INSERT INTO vl_valve_position
     VALUES (4,
             'Bloquée fermée',
             NULL,
             'F',
             NULL,
             'Bloquée fermée',
             NULL);

-- Marque vanne / Valve manufacturer

DROP TABLE vl_valve_manufacturer CASCADE;

CREATE TABLE vl_valve_manufacturer
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_valve_manufacturer_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );

INSERT INTO vl_valve_manufacturer
     VALUES (0,
             'ND',
             NULL,
             NULL,
             NULL,
             NULL,
             NULL);

-- Modèle vanne / Valve model

DROP TABLE vl_valve_model CASCADE;

CREATE TABLE vl_valve_model
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_valve_model_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );

INSERT INTO vl_valve_model
     VALUES (0,
             'ND',
             NULL,
             NULL,
             NULL,
             NULL,
             NULL);

-- Fonction vanne / Valve function

DROP TABLE vl_valve_function CASCADE;

CREATE TABLE vl_valve_function
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_valve_function_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );

INSERT INTO vl_valve_function
     VALUES (0,
             'Inconnu',
             NULL,
             '{null}',
             NULL,
             'Inconnu',
             NULL);

INSERT INTO vl_valve_function
     VALUES (1,
             'Interconnexion',
             NULL,
             '{null}',
             NULL,
             'Interconnexion',
             NULL);

INSERT INTO vl_valve_function
     VALUES (2,
             'Isolement',
             NULL,
             '{null}',
             NULL,
             'Isolement',
             NULL);

INSERT INTO vl_valve_function
     VALUES (3,
             'Régulation',
             NULL,
             '{null}',
             NULL,
             'Régulation',
             NULL);

INSERT INTO vl_valve_function
     VALUES (4,
             'Sectorisation',
             NULL,
             '{null}',
             NULL,
             'Sectorisation',
             NULL);

INSERT INTO vl_valve_function
     VALUES (5,
             'Sécurité',
             NULL,
             '{null}',
             NULL,
             'Sécurité',
             NULL);

-- Fonction canalisation / Pipe function

DROP TABLE vl_pipe_function CASCADE;

CREATE TABLE vl_pipe_function
(
   id               serial NOT NULL,
   value_fr         CHARACTER VARYING (24),
   value_en         CHARACTER VARYING (24),
   short_fr         CHARACTER VARYING (12),
   short_en         CHARACTER VARYING (12),
   description_fr   CHARACTER VARYING (100),
   description_en   CHARACTER VARYING (100),
   CONSTRAINT vl_pipe_function_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );


INSERT INTO vl_pipe_function
     VALUES (1,
             'Distribution',
             NULL,
             '{null}',
             NULL,
             'Distribution',
             NULL);

INSERT INTO vl_pipe_function
     VALUES (2,
             'Adduction',
             NULL,
             '{null}',
             NULL,
             'Adduction',
             NULL);

--insert into vl_valve_position values (2,'Branchement',null,'{null}',null,'Branchement',null);

INSERT INTO vl_pipe_function
     VALUES (3,
             'Canal',
             NULL,
             '{null}',
             NULL,
             'Canal',
             NULL);



INSERT INTO vl_pipe_function
     VALUES (5,
             'Incendie',
             NULL,
             '{null}',
             NULL,
             'Incendie',
             NULL);

INSERT INTO vl_pipe_function
     VALUES (6,
             'Inconnue',
             NULL,
             '{null}',
             NULL,
             'Inconnue',
             NULL);

INSERT INTO vl_pipe_function
     VALUES (7,
             'Principale',
             NULL,
             '{null}',
             NULL,
             'Principale',
             NULL);

INSERT INTO vl_pipe_function
     VALUES (8,
             'Purge',
             NULL,
             '{null}',
             NULL,
             'Purge',
             NULL);

INSERT INTO vl_pipe_function
     VALUES (9,
             'Raccord',
             NULL,
             '{null}',
             NULL,
             'Raccord',
             NULL);

INSERT INTO vl_pipe_function
     VALUES (10,
             'Secondaire',
             NULL,
             '{null}',
             NULL,
             'Secondaire',
             NULL);

INSERT INTO vl_pipe_function
     VALUES (11,
             'Transport',
             NULL,
             '{null}',
             NULL,
             'Transport',
             NULL);

INSERT INTO vl_pipe_function
     VALUES (12,
             'Vidange',
             NULL,
             '{null}',
             NULL,
             'Vidange',
             NULL);

---------------------------------------
-- Tables "Chapeau"
-- Main Tables
---------------------------------------

--City / Commune

DROP TABLE city CASCADE;

CREATE TABLE city
(
  id serial NOT NULL,
  code character varying(24),
  name character varying(200),
  population integer,
  geom geometry(MultiPolygon,2154),
  CONSTRAINT city_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);



CREATE UNIQUE INDEX ix_city_code
   ON city (code);

CREATE INDEX ix_city_geom ON city USING GIST (geom);

--Rue / Street

DROP TABLE street CASCADE;

CREATE TABLE street
(
  id serial NOT NULL,
  city_id integer,
  code character varying(24),
  type character varying(24),
  name character varying(200),
  geom geometry(MultiLineString,2154),
  CONSTRAINT street_id_pkey PRIMARY KEY (id),
  CONSTRAINT street_city_fkey FOREIGN KEY (city_id) REFERENCES city (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION  
  
)
WITH (
  OIDS=FALSE
);



CREATE UNIQUE INDEX ix_street_code
   ON city (code);

CREATE INDEX ix_street_geom ON street USING GIST (geom);

-- maîtrise d'ouvrage / owner

DROP TABLE owner CASCADE;

CREATE TABLE owner
(
   id         serial NOT NULL,
   name       CHARACTER VARYING (200),
   comments   CHARACTER VARYING (200),
   CONSTRAINT owner_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );

-- maîtrise d'oeuvre / operator

DROP TABLE operator CASCADE;

CREATE TABLE operator
(
   id         serial NOT NULL,
   name       CHARACTER VARYING (200),
   comments   CHARACTER VARYING (200),
   CONSTRAINT operator_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );


--Contrat / Contract

DROP TABLE contract CASCADE;

CREATE TABLE contract
(
  id serial NOT NULL,
  code CHARACTER VARYING(24),
  name CHARACTER VARYING(200),
  type integer,
  owner_id integer,
  operator_id integer,
  date_end timestamp,
  comments CHARACTER VARYING(200),
   geom			   geometry('MultiPolygon',2154),  
  CONSTRAINT contract_id_pkey PRIMARY KEY (id),
  CONSTRAINT contract_owner_fkey FOREIGN KEY (owner_id) REFERENCES owner (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT contract_operator_fkey FOREIGN KEY (operator_id) REFERENCES operator (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

CREATE UNIQUE INDEX ix_contract_code
   ON city (code);

CREATE INDEX ix_contract_geom ON street USING GIST (geom);



-- Récolement / AS_Built

DROP TABLE asbuilt CASCADE;

CREATE TABLE asbuilt
(
   id              serial NOT NULL,
   name            CHARACTER VARYING (200),
   works_date      timestamp,
   works_company   CHARACTER VARYING (200),
   geom			   geometry('MultiPolygon',2154),
   comments        CHARACTER VARYING (200),
   CONSTRAINT asbuilt_id_pkey PRIMARY KEY (id)
)
WITH ( OIDS = FALSE );

CREATE INDEX ix_asbuilt_geom ON asbuilt USING GIST (geom);

-- Etage de pression / Pressure zone

DROP TABLE pressure_zone CASCADE;

CREATE TABLE pressure_zone
(
  id serial NOT NULL,
  name character varying(200),
  average_pressure numeric(12,2),
  piezo_level numeric(12,2),
  comments character varying(200),
  color integer,
  geom geometry(Polygon,2154),
  constraint pressure_zone_color_fkey FOREIGN KEY (color) REFERENCES vl_pressure_zone_color (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION, 
  CONSTRAINT pressure_zone_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);



CREATE INDEX ix_pressure_zone_geom ON pressure_zone USING GIST (geom);

-- Secteur / district

DROP TABLE district CASCADE;

CREATE TABLE district
(
  id serial NOT NULL,
  name character varying(200),
  comments character varying(200),
  geom geometry(Polygon,2154),
  CONSTRAINT district_id_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);



CREATE INDEX ix_district_geom ON district USING GIST (geom);


---------------------------------------
-- création des Tables ARC
---------------------------------------

DROP TABLE arc CASCADE;

CREATE TABLE arc
(
  id serial NOT NULL,
  start_node integer,
  end_node integer,
  city_id integer,
  street_id integer,
  geom_1 geometry(LineString,2154), --GEOM de travail
  geom_2 geometry(LineString,2154), -- GEOM de précision (données Géomètre) 
  geom_3 geometry(LineString,2154), -- GEOM simplifié    
  length numeric(12,2),
  data_source integer,
  date_insert timestamp without time zone,
  date_update timestamp without time zone,
  CONSTRAINT arc_pkey PRIMARY KEY (id),
  CONSTRAINT arc_start_node_fkey FOREIGN KEY (start_node) REFERENCES node (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT arc_end_node_fkey FOREIGN KEY (end_node) REFERENCES node (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT arc_city_fkey FOREIGN KEY (city_id) REFERENCES city (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION , 
  CONSTRAINT arc_street_fkey FOREIGN KEY (street_id) REFERENCES street (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT arc_data_source_fkey FOREIGN KEY (data_source) REFERENCES vl_data_source (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION  
)
WITH (
  OIDS=FALSE
);



CREATE INDEX ix_arc_geom_1 ON arc USING GIST (geom_1);

DROP TABLE pipe CASCADE;

---------------------------------------

CREATE TABLE pipe
(
  id serial NOT NULL,
  arc_id integer,
  location integer,
  domain integer DEFAULT 0,
  precision_class precision_class DEFAULT 'C'::precision_class, -- Valeurs possible : A, B , C
  flow_type  integer DEFAULT 1,
  water_type  integer DEFAULT 1,
  function integer DEFAULT 1,
  contract_id integer,
  asbuilt_id integer,
  pressure_zone_id integer,
  district_id integer,
  year integer,
  material integer DEFAULT 0,
  diameter integer,
  internal_diam integer,
  external_diam integer,
  year_rehab integer,
  rehab_type integer DEFAULT 1,
  status integer DEFAULT 1,
  comments CHARACTER VARYING (200),
  CONSTRAINT pipe_pkey PRIMARY KEY (id),
  CONSTRAINT pipe_flow_type_fkey FOREIGN KEY (flow_type) REFERENCES vl_flow_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pipe_function_fkey FOREIGN KEY (function) REFERENCES vl_pipe_function (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pipe_water_type_fkey FOREIGN KEY (water_type) REFERENCES vl_water_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pipe_domain_fkey FOREIGN KEY (domain) REFERENCES vl_domain (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pipe_asbuilt_fkey FOREIGN KEY (asbuilt_id) REFERENCES asbuilt (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pipe_rehab_type_fkey FOREIGN KEY (rehab_type) REFERENCES vl_rehab_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pipe_status_fkey FOREIGN KEY (status) REFERENCES vl_status (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pipe_material_fkey FOREIGN KEY (material) REFERENCES vl_material (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION  ,
 CONSTRAINT pipe_pressure_zone_fkey FOREIGN KEY (pressure_zone_id) REFERENCES pressure_zone (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION   ,
  CONSTRAINT pipe_district_fkey FOREIGN KEY (district_id) REFERENCES district (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION   ,
  CONSTRAINT pipe_location_fkey FOREIGN KEY (location) REFERENCES vl_location (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION


)
WITH (
  OIDS=FALSE
);


---------------------------------------
-- création des Tables NOEUD
---------------------------------------

DROP TABLE node CASCADE;

CREATE TABLE node
(
  id serial NOT NULL,
  city_id character varying(5),
  street_id integer,
  geom_1 geometry(Point,2154),-- GEOM de travail
  geom_2 geometry(Point,2154),-- GEOM GPS géomètre  
  geom_3 geometry(Point,2154),   -- GEOM Simplifié
  data_source integer,
  date_insert timestamp without time zone,
  date_update timestamp without time zone,
  CONSTRAINT node_pkey PRIMARY KEY (id),
  CONSTRAINT arc_data_source_fkey FOREIGN KEY (data_source) REFERENCES vl_data_source (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION  
  
  --CONSTRAINT node_water_type_fkey FOREIGN KEY (water_type) REFERENCES t_water_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);



DROP TABLE valve CASCADE;

CREATE TABLE valve
(
  id serial NOT NULL,
  node_id integer,
  location integer,
  domain integer,
  precision_class precision_class DEFAULT 'C'::precision_class, -- Valeurs possible : A, B , C
  contract_id integer,
  asbuilt_id integer,
  pressure_zone_id integer,
  district_id integer,
  ground_level numeric(12,2),
  type integer,
  function integer,
  rotation numeric(12,2),
  position integer,
  manufacturer integer,
  model integer,
  diameter integer,
  topo_x numeric(12,2),
  topo_y numeric(12,2),
  topo_z numeric(12,2),
  year integer,
  status integer DEFAULT 1,
  comments CHARACTER VARYING (200),
  CONSTRAINT valve_pkey PRIMARY KEY (id),
  CONSTRAINT valve_domain_fkey FOREIGN KEY (domain) REFERENCES vl_domain (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT valve_manufacturer_fkey FOREIGN KEY (manufacturer) REFERENCES vl_valve_manufacturer (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT valve_model_fkey FOREIGN KEY (model) REFERENCES vl_valve_model (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT valve_position_fkey FOREIGN KEY (position) REFERENCES vl_valve_position (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT valve_type_fkey FOREIGN KEY (type) REFERENCES vl_valve_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT valve_function_fkey FOREIGN KEY (function) REFERENCES vl_valve_function (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT valve_asbuilt_fkey FOREIGN KEY (asbuilt_id) REFERENCES asbuilt (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT valve_status_fkey FOREIGN KEY (status) REFERENCES vl_status (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT valve_pressure_zone_fkey FOREIGN KEY (pressure_zone_id) REFERENCES pressure_zone (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION   ,
  CONSTRAINT valve_district_fkey FOREIGN KEY (district_id) REFERENCES district (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT valve_location_fkey FOREIGN KEY (location) REFERENCES vl_location (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION

)
WITH (
  OIDS=FALSE
);


-- drop view v_valve cascade;
--
-- CREATE OR REPLACE VIEW v_valve as
--
-- select
--   v.type,
--   v.function ,
--   v.rotation ,
--   v.position ,
--   v.manufacturer ,
--   v.model ,
--   v.diameter ,
--   v.topo_x ,
--   v.topo_y ,
--   v.topo_z ,
--   v.year,
--   n.id ,
--   n.city_id,
--   n.street_id ,
--   n.location,
--   n.domain,
--   n.precision_class,
--   n.water_type ,
--   n.asbuilt_id ,
--   n.pressure_zone_id,
--   n.ground_level,
--   n.comments,
--   n.geom ,
--   n.data_source ,
--   n.date_insert ,
--   n.date_update
--  from
--  valve v,
--  node n
--  where
--  v.node_id=n.id;
--
--
--
