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
-- Name: authentications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE authentications (
    id integer NOT NULL,
    gamer_id integer,
    provider character varying(255),
    uid character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: authentications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE authentications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authentications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE authentications_id_seq OWNED BY authentications.id;


--
-- Name: encuentros; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE encuentros (
    id integer NOT NULL,
    gamera_id integer,
    gamerb_id integer,
    posicion_en_ronda integer,
    ronda_id integer,
    flag_ganador character varying(255),
    descripcion character varying(255),
    encuentro_anterior_a_id integer,
    encuentro_anterior_b_id character varying(255),
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
-- Name: inscripciones; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE inscripciones (
    id integer NOT NULL,
    torneo_id integer,
    gamer_id integer,
    estado character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: inscripciones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE inscripciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inscripciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE inscripciones_id_seq OWNED BY inscripciones.id;


--
-- Name: juegos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE juegos (
    id integer NOT NULL,
    nombre character varying(255),
    descripcion character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: juegos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE juegos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: juegos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE juegos_id_seq OWNED BY juegos.id;


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
    ronda_id integer,
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
    cierre_inscripcion_fecha timestamp without time zone,
    cierre_inscripcion_tiempo timestamp without time zone,
    periodo_confirmacion_en_minutos integer,
    tipo_torneo character varying(255),
    tipo_generacion character varying(255),
    gamer_id integer,
    juego_id integer,
    estado character varying(255),
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

ALTER TABLE ONLY authentications ALTER COLUMN id SET DEFAULT nextval('authentications_id_seq'::regclass);


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

ALTER TABLE ONLY inscripciones ALTER COLUMN id SET DEFAULT nextval('inscripciones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY juegos ALTER COLUMN id SET DEFAULT nextval('juegos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rondas ALTER COLUMN id SET DEFAULT nextval('rondas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY torneos ALTER COLUMN id SET DEFAULT nextval('torneos_id_seq'::regclass);


--
-- Name: authentications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY authentications
    ADD CONSTRAINT authentications_pkey PRIMARY KEY (id);


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
-- Name: inscripciones_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY inscripciones
    ADD CONSTRAINT inscripciones_pkey PRIMARY KEY (id);


--
-- Name: juegos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY juegos
    ADD CONSTRAINT juegos_pkey PRIMARY KEY (id);


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
-- Name: authentications_gamer_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY authentications
    ADD CONSTRAINT authentications_gamer_id_fk FOREIGN KEY (gamer_id) REFERENCES gamers(id);


--
-- Name: encuentros_ronda_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY encuentros
    ADD CONSTRAINT encuentros_ronda_id_fk FOREIGN KEY (ronda_id) REFERENCES rondas(id);


--
-- Name: inscripciones_gamer_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inscripciones
    ADD CONSTRAINT inscripciones_gamer_id_fk FOREIGN KEY (gamer_id) REFERENCES gamers(id);


--
-- Name: inscripciones_torneo_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inscripciones
    ADD CONSTRAINT inscripciones_torneo_id_fk FOREIGN KEY (torneo_id) REFERENCES torneos(id);


--
-- Name: rondas_ronda_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rondas
    ADD CONSTRAINT rondas_ronda_id_fk FOREIGN KEY (ronda_id) REFERENCES rondas(id);


--
-- Name: rondas_torneo_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rondas
    ADD CONSTRAINT rondas_torneo_id_fk FOREIGN KEY (torneo_id) REFERENCES torneos(id);


--
-- Name: torneos_gamer_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY torneos
    ADD CONSTRAINT torneos_gamer_id_fk FOREIGN KEY (gamer_id) REFERENCES gamers(id);


--
-- Name: torneos_juego_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY torneos
    ADD CONSTRAINT torneos_juego_id_fk FOREIGN KEY (juego_id) REFERENCES juegos(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20131210145649');

INSERT INTO schema_migrations (version) VALUES ('20131230234849');

INSERT INTO schema_migrations (version) VALUES ('20140323192709');

INSERT INTO schema_migrations (version) VALUES ('20140412192319');

INSERT INTO schema_migrations (version) VALUES ('20140412192350');

INSERT INTO schema_migrations (version) VALUES ('20140810225253');

INSERT INTO schema_migrations (version) VALUES ('20140817033501');

INSERT INTO schema_migrations (version) VALUES ('20141020220459');
