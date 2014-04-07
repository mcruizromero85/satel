--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: encuentros; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE encuentros (
    id integer NOT NULL,
    estado character varying(255),
    posicion_en_ronda integer,
    id_inscripcion_gamer_a integer,
    id_inscripcion_gamer_b integer,
    id_inscripcion_gamer_ganador integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: encuentros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE encuentros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: encuentros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE encuentros_id_seq OWNED BY encuentros.id;


--
-- Name: gamers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE gamers (
    id integer NOT NULL,
    nick character varying(255),
    correo character varying(255),
    nombres character varying(255),
    apellidos character varying(255),
    fecha_ultimo_login date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: gamers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gamers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gamers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE gamers_id_seq OWNED BY gamers.id;


--
-- Name: pruebas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pruebas (
    id integer NOT NULL,
    titulo character varying(255),
    descripcion character varying(255),
    formato character varying(255),
    modalidad character varying(255),
    juego_id integer,
    modalidad_reporte_victoria character varying(255),
    vacantes integer,
    cierre_inscripcion_fecha date,
    cierre_inscripcion_tiempo time without time zone,
    cierre_check_in_fecha date,
    cierre_check_in_tiempo time without time zone,
    inicio_torneo_fecha date,
    inicio_torneo_tiempo character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: pruebas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pruebas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pruebas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pruebas_id_seq OWNED BY pruebas.id;


--
-- Name: rondas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rondas (
    id integer NOT NULL,
    numero integer,
    inicio_fecha date,
    inicio_tiempo time without time zone,
    modo_ganar character varying(255),
    torneo_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: rondas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rondas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rondas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rondas_id_seq OWNED BY rondas.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: torneos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE torneos (
    id integer NOT NULL,
    titulo character varying(255),
    paginaweb character varying(255),
    vacantes integer,
    cierre_inscripcion_fecha date,
    cierre_inscripcion_tiempo time without time zone,
    cierre_check_in_fecha date,
    cierre_check_in_tiempo time without time zone,
    inicio_torneo_fecha date,
    inicio_torneo_tiempo time without time zone,
    id_gamer integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: torneos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE torneos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: torneos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE torneos_id_seq OWNED BY torneos.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY encuentros ALTER COLUMN id SET DEFAULT nextval('encuentros_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY gamers ALTER COLUMN id SET DEFAULT nextval('gamers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pruebas ALTER COLUMN id SET DEFAULT nextval('pruebas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rondas ALTER COLUMN id SET DEFAULT nextval('rondas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY torneos ALTER COLUMN id SET DEFAULT nextval('torneos_id_seq'::regclass);


--
-- Name: encuentros_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY encuentros
    ADD CONSTRAINT encuentros_pkey PRIMARY KEY (id);


--
-- Name: gamers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY gamers
    ADD CONSTRAINT gamers_pkey PRIMARY KEY (id);


--
-- Name: pruebas_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pruebas
    ADD CONSTRAINT pruebas_pkey PRIMARY KEY (id);


--
-- Name: rondas_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rondas
    ADD CONSTRAINT rondas_pkey PRIMARY KEY (id);


--
-- Name: torneos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY torneos
    ADD CONSTRAINT torneos_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20131210145649');

INSERT INTO schema_migrations (version) VALUES ('20131224000829');

INSERT INTO schema_migrations (version) VALUES ('20131230234849');

INSERT INTO schema_migrations (version) VALUES ('20140323174242');

INSERT INTO schema_migrations (version) VALUES ('20140323192709');

INSERT INTO schema_migrations (version) VALUES ('20140406010445');
