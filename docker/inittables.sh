#!/bin/bash
#set -e
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    \c gallery;
CREATE TABLE IF NOT EXISTS public."Users"
(
    id serial NOT NULL,
    primary_name character varying(20) NOT NULL,
    second_name character varying(20) NOT NULL,
    email character varying(65) NOT NULL,
    login character varying(20) NOT NULL,
    password_hash character varying(320) NOT NULL,
    role integer NOT NULL,
    tokens character varying[],
    PRIMARY KEY (id),
    UNIQUE (id)
);


CREATE TABLE IF NOT EXISTS public."Roles"
(
    id serial NOT NULL,
    role_name character varying(25) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (id)
);


CREATE TABLE IF NOT EXISTS public."Gallery"
(
    id serial NOT NULL,
    gallery_owner integer NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT id UNIQUE (id)
);

CREATE TABLE IF NOT EXISTS public."Gallery_Access"
(
    "user" integer NOT NULL,
    gallery integer NOT NULL

);

CREATE TABLE IF NOT EXISTS public."Backup"
(
    id serial NOT NULL,
    gallery integer NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (id)
);

CREATE TABLE IF NOT EXISTS public."Media"
(
    id serial NOT NULL,
    type integer NOT NULL,
    creation_date date NOT NULL,
    is_av boolean NOT NULL,
    backup_id integer NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (id)
);

CREATE TABLE IF NOT EXISTS public."Media_Dictonary"
(
    id serial NOT NULL,
    name character varying(20) NOT NULL,
    size integer NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (id)
);

CREATE TABLE IF NOT EXISTS public."Photo"
(
    id serial NOT NULL,
    owner character varying(32) NOT NULL,
    name character varying(32) NOT NULL,
    size integer NOT NULL,
    resolution character varying(10) NOT NULL,
    extension character varying(5) NOT NULL,
    galleries integer[] NOT NULL,
    photo_file bytea NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (id)
);

CREATE TABLE IF NOT EXISTS public."Tags"
(
    photo_id serial NOT NULL,
    name character varying(32) NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Categories"
(
    id serial NOT NULL,
    name character varying NOT NULL,
    parent_category integer,
    PRIMARY KEY (id),
    UNIQUE (id)
);

CREATE TABLE IF NOT EXISTS public."Categorized_Photos"
(
    photo integer NOT NULL,
    category integer
);

ALTER TABLE IF EXISTS public."Users"
    ADD FOREIGN KEY (role)
    REFERENCES public."Roles" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Gallery"
    ADD FOREIGN KEY (gallery_owner)
    REFERENCES public."Users" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Gallery_Access"
    ADD FOREIGN KEY ("user")
    REFERENCES public."Users" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Gallery_Access"
    ADD FOREIGN KEY (gallery)
    REFERENCES public."Gallery" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Backup"
    ADD FOREIGN KEY (gallery)
    REFERENCES public."Gallery" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Media"
    ADD FOREIGN KEY (type)
    REFERENCES public."Media_Dictonary" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Media"
    ADD FOREIGN KEY (backup_id)
    REFERENCES public."Backup" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Tags"
    ADD FOREIGN KEY (photo_id)
    REFERENCES public."Photo" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Categories"
    ADD FOREIGN KEY (parent_category)
    REFERENCES public."Categories" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Categorized_Photos"
    ADD FOREIGN KEY (photo)
    REFERENCES public."Photo" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Categorized_Photos"
    ADD FOREIGN KEY (category)
    REFERENCES public."Categories" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
EOSQL