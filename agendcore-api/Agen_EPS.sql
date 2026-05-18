--
-- PostgreSQL database dump
--

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 17.0

-- Started on 2026-05-05 18:40:36

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE "Agen_EPS";
--
-- TOC entry 4727 (class 1262 OID 18822)
-- Name: Agen_EPS; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Agen_EPS" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE "Agen_EPS" OWNER TO postgres;

\connect "Agen_EPS"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 274 (class 1259 OID 19300)
-- Name: agendas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agendas (
    id_agenda integer NOT NULL,
    id_ips integer NOT NULL,
    id_sede integer NOT NULL,
    id_servicio integer NOT NULL,
    id_profesional integer,
    id_estado_agenda integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    observacion text,
    fhir_id character varying(100),
    fhir_version_id character varying(100),
    fecha_sincronizacion_fhir timestamp without time zone,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT chk_agenda_fechas CHECK ((fecha_fin >= fecha_inicio))
);


ALTER TABLE public.agendas OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 19299)
-- Name: agendas_id_agenda_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agendas_id_agenda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.agendas_id_agenda_seq OWNER TO postgres;

--
-- TOC entry 4728 (class 0 OID 0)
-- Dependencies: 273
-- Name: agendas_id_agenda_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agendas_id_agenda_seq OWNED BY public.agendas.id_agenda;


--
-- TOC entry 248 (class 1259 OID 19000)
-- Name: aseguradoras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aseguradoras (
    id_aseguradora integer NOT NULL,
    nombre character varying(150) NOT NULL,
    nit character varying(30) NOT NULL,
    razon_social character varying(180),
    telefono character varying(30),
    correo character varying(120),
    activo boolean DEFAULT true NOT NULL,
    fhir_id character varying(100),
    fhir_version_id character varying(100),
    fecha_sincronizacion_fhir timestamp without time zone,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE public.aseguradoras OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 18999)
-- Name: aseguradoras_id_aseguradora_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aseguradoras_id_aseguradora_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aseguradoras_id_aseguradora_seq OWNER TO postgres;

--
-- TOC entry 4729 (class 0 OID 0)
-- Dependencies: 247
-- Name: aseguradoras_id_aseguradora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aseguradoras_id_aseguradora_seq OWNED BY public.aseguradoras.id_aseguradora;


--
-- TOC entry 290 (class 1259 OID 19565)
-- Name: auditoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auditoria (
    id_auditoria integer NOT NULL,
    id_usuario integer,
    accion character varying(100) NOT NULL,
    tabla_afectada character varying(100) NOT NULL,
    id_registro_afectado integer,
    detalle jsonb,
    ip_origen character varying(50),
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.auditoria OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 19564)
-- Name: auditoria_id_auditoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auditoria_id_auditoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auditoria_id_auditoria_seq OWNER TO postgres;

--
-- TOC entry 4730 (class 0 OID 0)
-- Dependencies: 289
-- Name: auditoria_id_auditoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auditoria_id_auditoria_seq OWNED BY public.auditoria.id_auditoria;


--
-- TOC entry 278 (class 1259 OID 19360)
-- Name: bloqueos_agenda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bloqueos_agenda (
    id_bloqueo integer NOT NULL,
    id_agenda integer NOT NULL,
    id_usuario integer,
    motivo character varying(150) NOT NULL,
    fecha_inicio timestamp without time zone NOT NULL,
    fecha_fin timestamp without time zone NOT NULL,
    observacion text,
    activo boolean DEFAULT true NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_bloqueo_fechas CHECK ((fecha_fin > fecha_inicio))
);


ALTER TABLE public.bloqueos_agenda OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 19359)
-- Name: bloqueos_agenda_id_bloqueo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bloqueos_agenda_id_bloqueo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bloqueos_agenda_id_bloqueo_seq OWNER TO postgres;

--
-- TOC entry 4731 (class 0 OID 0)
-- Dependencies: 277
-- Name: bloqueos_agenda_id_bloqueo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bloqueos_agenda_id_bloqueo_seq OWNED BY public.bloqueos_agenda.id_bloqueo;


--
-- TOC entry 293 (class 1259 OID 19635)
-- Name: bt2_job_instance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bt2_job_instance (
    id character varying(100) NOT NULL,
    job_cancelled boolean NOT NULL,
    cmb_recs_processed integer,
    cmb_recs_per_sec double precision,
    create_time timestamp(6) without time zone NOT NULL,
    cur_gated_step_id character varying(100),
    definition_id character varying(100) NOT NULL,
    definition_ver integer NOT NULL,
    end_time timestamp(6) without time zone,
    error_count integer NOT NULL,
    error_msg character varying(500),
    est_remaining character varying(100),
    fast_tracking boolean,
    params_json character varying(2000),
    params_json_lob oid,
    params_json_vc text,
    progress_pct double precision NOT NULL,
    report oid,
    report_vc text,
    start_time timestamp(6) without time zone,
    stat character varying(20) NOT NULL,
    tot_elapsed_millis integer,
    client_id character varying(200),
    user_name character varying(200),
    update_time timestamp(6) without time zone,
    user_data_json text,
    warning_msg character varying(4000),
    work_chunks_purged boolean NOT NULL
);


ALTER TABLE public.bt2_job_instance OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 19642)
-- Name: bt2_work_chunk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bt2_work_chunk (
    id character varying(100) NOT NULL,
    create_time timestamp(6) without time zone NOT NULL,
    end_time timestamp(6) without time zone,
    error_count integer NOT NULL,
    error_msg character varying(500),
    instance_id character varying(100) NOT NULL,
    definition_id character varying(100) NOT NULL,
    definition_ver integer NOT NULL,
    next_poll_time timestamp(6) without time zone,
    poll_attempts integer,
    records_processed integer,
    seq integer NOT NULL,
    chunk_data oid,
    chunk_data_vc text,
    start_time timestamp(6) without time zone,
    stat character varying(20) NOT NULL,
    tgt_step_id character varying(100) NOT NULL,
    update_time timestamp(6) without time zone,
    warning_msg character varying(4000)
);


ALTER TABLE public.bt2_work_chunk OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 18866)
-- Name: canales_atencion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.canales_atencion (
    id_canal integer NOT NULL,
    codigo character varying(30) NOT NULL,
    nombre character varying(80) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.canales_atencion OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 18865)
-- Name: canales_atencion_id_canal_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.canales_atencion_id_canal_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.canales_atencion_id_canal_seq OWNER TO postgres;

--
-- TOC entry 4732 (class 0 OID 0)
-- Dependencies: 223
-- Name: canales_atencion_id_canal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.canales_atencion_id_canal_seq OWNED BY public.canales_atencion.id_canal;


--
-- TOC entry 280 (class 1259 OID 19382)
-- Name: citas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.citas (
    id_cita integer NOT NULL,
    id_ips integer NOT NULL,
    id_paciente integer NOT NULL,
    id_cobertura integer,
    id_aseguradora integer,
    id_cupo integer NOT NULL,
    id_servicio integer NOT NULL,
    id_profesional integer,
    id_sede integer NOT NULL,
    id_estado_cita integer NOT NULL,
    id_canal integer NOT NULL,
    id_tipo_consulta integer,
    id_modalidad integer,
    fecha_inicio timestamp without time zone NOT NULL,
    fecha_fin timestamp without time zone NOT NULL,
    id_motivo_cancelacion integer,
    comentario text,
    fhir_id character varying(100),
    fhir_version_id character varying(100),
    fecha_sincronizacion_fhir timestamp without time zone,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT chk_cita_fechas CHECK ((fecha_fin > fecha_inicio))
);


ALTER TABLE public.citas OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 19381)
-- Name: citas_id_cita_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.citas_id_cita_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.citas_id_cita_seq OWNER TO postgres;

--
-- TOC entry 4733 (class 0 OID 0)
-- Dependencies: 279
-- Name: citas_id_cita_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.citas_id_cita_seq OWNED BY public.citas.id_cita;


--
-- TOC entry 270 (class 1259 OID 19238)
-- Name: coberturas_paciente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coberturas_paciente (
    id_cobertura integer NOT NULL,
    id_paciente integer NOT NULL,
    id_aseguradora integer NOT NULL,
    id_estado_cobertura integer NOT NULL,
    numero_poliza character varying(80),
    fecha_inicio date NOT NULL,
    fecha_fin date,
    fhir_id character varying(100),
    fhir_version_id character varying(100),
    fecha_sincronizacion_fhir timestamp without time zone,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT chk_cobertura_fechas CHECK (((fecha_fin IS NULL) OR (fecha_fin >= fecha_inicio)))
);


ALTER TABLE public.coberturas_paciente OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 19237)
-- Name: coberturas_paciente_id_cobertura_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coberturas_paciente_id_cobertura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coberturas_paciente_id_cobertura_seq OWNER TO postgres;

--
-- TOC entry 4734 (class 0 OID 0)
-- Dependencies: 269
-- Name: coberturas_paciente_id_cobertura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coberturas_paciente_id_cobertura_seq OWNED BY public.coberturas_paciente.id_cobertura;


--
-- TOC entry 292 (class 1259 OID 19580)
-- Name: cola_sincronizacion_fhir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cola_sincronizacion_fhir (
    id_sync integer NOT NULL,
    id_estado_sincronizacion integer NOT NULL,
    tipo_recurso character varying(50) NOT NULL,
    nombre_tabla_origen character varying(100) NOT NULL,
    id_referencia integer NOT NULL,
    metodo_http character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    endpoint_fhir character varying(120),
    payload jsonb NOT NULL,
    respuesta jsonb,
    intentos integer DEFAULT 0 NOT NULL,
    mensaje_error text,
    fhir_id character varying(100),
    fhir_version_id character varying(100),
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_procesamiento timestamp without time zone,
    CONSTRAINT chk_intentos_sync CHECK ((intentos >= 0)),
    CONSTRAINT chk_metodo_http CHECK (((metodo_http)::text = ANY ((ARRAY['POST'::character varying, 'PUT'::character varying, 'PATCH'::character varying, 'DELETE'::character varying])::text[])))
);


ALTER TABLE public.cola_sincronizacion_fhir OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 19579)
-- Name: cola_sincronizacion_fhir_id_sync_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cola_sincronizacion_fhir_id_sync_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cola_sincronizacion_fhir_id_sync_seq OWNER TO postgres;

--
-- TOC entry 4735 (class 0 OID 0)
-- Dependencies: 291
-- Name: cola_sincronizacion_fhir_id_sync_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cola_sincronizacion_fhir_id_sync_seq OWNED BY public.cola_sincronizacion_fhir.id_sync;


--
-- TOC entry 276 (class 1259 OID 19336)
-- Name: cupos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cupos (
    id_cupo integer NOT NULL,
    id_agenda integer NOT NULL,
    id_estado_cupo integer NOT NULL,
    fecha_inicio timestamp without time zone NOT NULL,
    fecha_fin timestamp without time zone NOT NULL,
    bloqueado_hasta timestamp without time zone,
    id_usuario_bloqueo integer,
    fhir_id character varying(100),
    fhir_version_id character varying(100),
    fecha_sincronizacion_fhir timestamp without time zone,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT chk_cupo_fechas CHECK ((fecha_fin > fecha_inicio))
);


ALTER TABLE public.cupos OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 19335)
-- Name: cupos_id_cupo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cupos_id_cupo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cupos_id_cupo_seq OWNER TO postgres;

--
-- TOC entry 4736 (class 0 OID 0)
-- Dependencies: 275
-- Name: cupos_id_cupo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cupos_id_cupo_seq OWNED BY public.cupos.id_cupo;


--
-- TOC entry 242 (class 1259 OID 18958)
-- Name: departamentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departamentos (
    id_departamento integer NOT NULL,
    codigo character varying(20),
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.departamentos OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 18957)
-- Name: departamentos_id_departamento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departamentos_id_departamento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.departamentos_id_departamento_seq OWNER TO postgres;

--
-- TOC entry 4737 (class 0 OID 0)
-- Dependencies: 241
-- Name: departamentos_id_departamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departamentos_id_departamento_seq OWNED BY public.departamentos.id_departamento;


--
-- TOC entry 260 (class 1259 OID 19113)
-- Name: especialidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.especialidades (
    id_especialidad integer NOT NULL,
    codigo character varying(30),
    nombre character varying(120) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.especialidades OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 19112)
-- Name: especialidades_id_especialidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.especialidades_id_especialidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.especialidades_id_especialidad_seq OWNER TO postgres;

--
-- TOC entry 4738 (class 0 OID 0)
-- Dependencies: 259
-- Name: especialidades_id_especialidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.especialidades_id_especialidad_seq OWNED BY public.especialidades.id_especialidad;


--
-- TOC entry 232 (class 1259 OID 18908)
-- Name: estados_agenda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estados_agenda (
    id_estado_agenda integer NOT NULL,
    codigo character varying(30) NOT NULL,
    nombre character varying(80) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.estados_agenda OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 18907)
-- Name: estados_agenda_id_estado_agenda_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estados_agenda_id_estado_agenda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estados_agenda_id_estado_agenda_seq OWNER TO postgres;

--
-- TOC entry 4739 (class 0 OID 0)
-- Dependencies: 231
-- Name: estados_agenda_id_estado_agenda_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estados_agenda_id_estado_agenda_seq OWNED BY public.estados_agenda.id_estado_agenda;


--
-- TOC entry 226 (class 1259 OID 18876)
-- Name: estados_cita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estados_cita (
    id_estado_cita integer NOT NULL,
    codigo character varying(30) NOT NULL,
    nombre character varying(80) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.estados_cita OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 18875)
-- Name: estados_cita_id_estado_cita_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estados_cita_id_estado_cita_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estados_cita_id_estado_cita_seq OWNER TO postgres;

--
-- TOC entry 4740 (class 0 OID 0)
-- Dependencies: 225
-- Name: estados_cita_id_estado_cita_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estados_cita_id_estado_cita_seq OWNED BY public.estados_cita.id_estado_cita;


--
-- TOC entry 230 (class 1259 OID 18898)
-- Name: estados_cobertura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estados_cobertura (
    id_estado_cobertura integer NOT NULL,
    codigo character varying(30) NOT NULL,
    nombre character varying(80) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.estados_cobertura OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 18897)
-- Name: estados_cobertura_id_estado_cobertura_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estados_cobertura_id_estado_cobertura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estados_cobertura_id_estado_cobertura_seq OWNER TO postgres;

--
-- TOC entry 4741 (class 0 OID 0)
-- Dependencies: 229
-- Name: estados_cobertura_id_estado_cobertura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estados_cobertura_id_estado_cobertura_seq OWNED BY public.estados_cobertura.id_estado_cobertura;


--
-- TOC entry 234 (class 1259 OID 18918)
-- Name: estados_cupo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estados_cupo (
    id_estado_cupo integer NOT NULL,
    codigo character varying(30) NOT NULL,
    nombre character varying(80) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.estados_cupo OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 18917)
-- Name: estados_cupo_id_estado_cupo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estados_cupo_id_estado_cupo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estados_cupo_id_estado_cupo_seq OWNER TO postgres;

--
-- TOC entry 4742 (class 0 OID 0)
-- Dependencies: 233
-- Name: estados_cupo_id_estado_cupo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estados_cupo_id_estado_cupo_seq OWNED BY public.estados_cupo.id_estado_cupo;


--
-- TOC entry 236 (class 1259 OID 18928)
-- Name: estados_sincronizacion_fhir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estados_sincronizacion_fhir (
    id_estado_sincronizacion integer NOT NULL,
    codigo character varying(30) NOT NULL,
    nombre character varying(80) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.estados_sincronizacion_fhir OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 18927)
-- Name: estados_sincronizacion_fhir_id_estado_sincronizacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estados_sincronizacion_fhir_id_estado_sincronizacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estados_sincronizacion_fhir_id_estado_sincronizacion_seq OWNER TO postgres;

--
-- TOC entry 4743 (class 0 OID 0)
-- Dependencies: 235
-- Name: estados_sincronizacion_fhir_id_estado_sincronizacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estados_sincronizacion_fhir_id_estado_sincronizacion_seq OWNED BY public.estados_sincronizacion_fhir.id_estado_sincronizacion;


--
-- TOC entry 218 (class 1259 OID 18834)
-- Name: generos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.generos (
    id_genero integer NOT NULL,
    codigo character varying(30) NOT NULL,
    descripcion character varying(80) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.generos OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 18833)
-- Name: generos_id_genero_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.generos_id_genero_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.generos_id_genero_seq OWNER TO postgres;

--
-- TOC entry 4744 (class 0 OID 0)
-- Dependencies: 217
-- Name: generos_id_genero_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.generos_id_genero_seq OWNED BY public.generos.id_genero;


--
-- TOC entry 295 (class 1259 OID 19649)
-- Name: hfj_binary_storage_blob; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_binary_storage_blob (
    blob_id character varying(200) NOT NULL,
    blob_data oid,
    content_type character varying(100) NOT NULL,
    blob_hash character varying(128),
    published_date timestamp(6) without time zone NOT NULL,
    resource_id character varying(100) NOT NULL,
    blob_size bigint NOT NULL,
    storage_content_bin bytea
);


ALTER TABLE public.hfj_binary_storage_blob OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 19656)
-- Name: hfj_blk_export_colfile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_blk_export_colfile (
    pid bigint NOT NULL,
    res_id character varying(100) NOT NULL,
    collection_pid bigint NOT NULL
);


ALTER TABLE public.hfj_blk_export_colfile OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 19661)
-- Name: hfj_blk_export_collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_blk_export_collection (
    pid bigint NOT NULL,
    type_filter character varying(1000),
    res_type character varying(40) NOT NULL,
    optlock integer NOT NULL,
    job_pid bigint NOT NULL
);


ALTER TABLE public.hfj_blk_export_collection OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 19668)
-- Name: hfj_blk_export_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_blk_export_job (
    pid bigint NOT NULL,
    created_time timestamp(6) without time zone NOT NULL,
    exp_time timestamp(6) without time zone,
    job_id character varying(36) NOT NULL,
    request character varying(1024) NOT NULL,
    exp_since timestamp(6) without time zone,
    job_status character varying(10) NOT NULL,
    status_message character varying(500),
    status_time timestamp(6) without time zone NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.hfj_blk_export_job OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 19675)
-- Name: hfj_blk_import_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_blk_import_job (
    pid bigint NOT NULL,
    batch_size integer NOT NULL,
    file_count integer NOT NULL,
    job_desc character varying(500),
    job_id character varying(36) NOT NULL,
    row_processing_mode character varying(20) NOT NULL,
    job_status character varying(10) NOT NULL,
    status_message character varying(500),
    status_time timestamp(6) without time zone NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.hfj_blk_import_job OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 19682)
-- Name: hfj_blk_import_jobfile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_blk_import_jobfile (
    pid bigint NOT NULL,
    job_contents oid,
    job_contents_vc text,
    file_description character varying(500),
    file_seq integer NOT NULL,
    tenant_name character varying(200),
    job_pid bigint NOT NULL
);


ALTER TABLE public.hfj_blk_import_jobfile OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 19689)
-- Name: hfj_forced_id; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_forced_id (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    forced_id character varying(100) NOT NULL,
    resource_pid bigint NOT NULL,
    resource_type character varying(100) DEFAULT ''::character varying
);


ALTER TABLE public.hfj_forced_id OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 19695)
-- Name: hfj_history_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_history_tag (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    tag_id bigint,
    res_ver_pid bigint NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(40) NOT NULL,
    res_type_id smallint
);


ALTER TABLE public.hfj_history_tag OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 19700)
-- Name: hfj_idx_cmb_tok_nu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_idx_cmb_tok_nu (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    hash_complete bigint NOT NULL,
    idx_string character varying(500),
    res_id bigint
);


ALTER TABLE public.hfj_idx_cmb_tok_nu OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 19707)
-- Name: hfj_idx_cmp_string_uniq; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_idx_cmp_string_uniq (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    hash_complete bigint,
    hash_complete_2 bigint,
    idx_string character varying(500) NOT NULL,
    res_id bigint
);


ALTER TABLE public.hfj_idx_cmp_string_uniq OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 19714)
-- Name: hfj_partition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_partition (
    part_id integer NOT NULL,
    part_desc character varying(200),
    part_name character varying(200) NOT NULL
);


ALTER TABLE public.hfj_partition OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 19719)
-- Name: hfj_res_identifier_pt_uniq; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_res_identifier_pt_uniq (
    ident_system_pid bigint NOT NULL,
    ident_value character varying(500) NOT NULL,
    fhir_id character varying(64) NOT NULL
);


ALTER TABLE public.hfj_res_identifier_pt_uniq OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 19726)
-- Name: hfj_res_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_res_link (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    src_path character varying(500) NOT NULL,
    src_resource_id bigint NOT NULL,
    source_resource_type character varying(40) NOT NULL,
    src_res_type_id smallint,
    target_res_partition_date date,
    target_res_partition_id integer,
    target_resource_id bigint,
    target_resource_type character varying(40) NOT NULL,
    target_res_type_id smallint,
    target_resource_url character varying(200),
    target_resource_version bigint,
    sp_updated timestamp(6) without time zone
);


ALTER TABLE public.hfj_res_link OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 19733)
-- Name: hfj_res_param_present; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_res_param_present (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    hash_presence bigint,
    sp_present boolean NOT NULL,
    res_id bigint NOT NULL
);


ALTER TABLE public.hfj_res_param_present OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 19738)
-- Name: hfj_res_reindex_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_res_reindex_job (
    pid bigint NOT NULL,
    job_deleted boolean NOT NULL,
    reindex_count integer,
    res_type character varying(100),
    suspended_until timestamp(6) without time zone,
    update_threshold_high timestamp(6) without time zone NOT NULL,
    update_threshold_low timestamp(6) without time zone
);


ALTER TABLE public.hfj_res_reindex_job OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 19743)
-- Name: hfj_res_search_url; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_res_search_url (
    res_search_url character varying(768) NOT NULL,
    partition_id integer NOT NULL,
    created_time timestamp(6) without time zone NOT NULL,
    partition_date date,
    res_id bigint NOT NULL
);


ALTER TABLE public.hfj_res_search_url OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 19750)
-- Name: hfj_res_system; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_res_system (
    pid bigint NOT NULL,
    system_url character varying(500) NOT NULL
);


ALTER TABLE public.hfj_res_system OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 19757)
-- Name: hfj_res_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_res_tag (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    tag_id bigint,
    res_id bigint,
    res_type character varying(40) NOT NULL,
    res_type_id smallint
);


ALTER TABLE public.hfj_res_tag OWNER TO postgres;

--
-- TOC entry 313 (class 1259 OID 19762)
-- Name: hfj_res_ver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_res_ver (
    partition_id integer,
    pid bigint NOT NULL,
    res_deleted_at timestamp(6) without time zone,
    res_version character varying(7),
    has_tags boolean NOT NULL,
    res_published timestamp(6) without time zone NOT NULL,
    res_updated timestamp(6) without time zone NOT NULL,
    res_encoding character varying(5) NOT NULL,
    partition_date date,
    request_id character varying(16),
    res_text oid,
    res_id bigint NOT NULL,
    res_text_vc text,
    res_type character varying(40) NOT NULL,
    res_type_id smallint,
    res_ver bigint NOT NULL,
    source_uri character varying(768)
);


ALTER TABLE public.hfj_res_ver OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 19769)
-- Name: hfj_res_ver_prov; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_res_ver_prov (
    res_ver_pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    request_id character varying(16),
    res_pid bigint NOT NULL,
    source_uri character varying(768)
);


ALTER TABLE public.hfj_res_ver_prov OWNER TO postgres;

--
-- TOC entry 315 (class 1259 OID 19776)
-- Name: hfj_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_resource (
    res_id bigint NOT NULL,
    partition_id integer,
    res_deleted_at timestamp(6) without time zone,
    res_version character varying(7),
    has_tags boolean NOT NULL,
    res_published timestamp(6) without time zone NOT NULL,
    res_updated timestamp(6) without time zone NOT NULL,
    fhir_id character varying(64),
    sp_has_links boolean NOT NULL,
    hash_sha256 character varying(64),
    sp_index_status smallint,
    res_language character varying(20),
    sp_cmpstr_uniq_present boolean,
    sp_cmptoks_present boolean,
    sp_coords_present boolean NOT NULL,
    sp_date_present boolean NOT NULL,
    sp_number_present boolean NOT NULL,
    sp_quantity_nrml_present boolean NOT NULL,
    sp_quantity_present boolean NOT NULL,
    sp_string_present boolean NOT NULL,
    sp_token_present boolean NOT NULL,
    sp_uri_present boolean NOT NULL,
    partition_date date,
    res_type character varying(40) NOT NULL,
    res_type_id smallint,
    search_url_present boolean,
    res_ver bigint NOT NULL
);


ALTER TABLE public.hfj_resource OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 19781)
-- Name: hfj_resource_modified; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_resource_modified (
    res_id character varying(256) NOT NULL,
    resource_type character varying(40) NOT NULL,
    res_ver character varying(8) NOT NULL,
    created_time timestamp(6) without time zone NOT NULL,
    summary_message character varying(4000) NOT NULL
);


ALTER TABLE public.hfj_resource_modified OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 19788)
-- Name: hfj_resource_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_resource_type (
    res_type_id smallint NOT NULL,
    res_type character varying(100) NOT NULL
);


ALTER TABLE public.hfj_resource_type OWNER TO postgres;

--
-- TOC entry 318 (class 1259 OID 19793)
-- Name: hfj_revinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_revinfo (
    rev bigint NOT NULL,
    revtstmp timestamp(6) without time zone
);


ALTER TABLE public.hfj_revinfo OWNER TO postgres;

--
-- TOC entry 319 (class 1259 OID 19798)
-- Name: hfj_search; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_search (
    pid bigint NOT NULL,
    created timestamp(6) without time zone NOT NULL,
    search_deleted boolean,
    expiry_or_null timestamp(6) without time zone,
    failure_code integer,
    failure_message character varying(500),
    last_updated_high timestamp(6) without time zone,
    last_updated_low timestamp(6) without time zone,
    num_blocked integer,
    num_found integer NOT NULL,
    partition_id integer,
    preferred_page_size integer,
    resource_id bigint,
    resource_type character varying(200),
    search_param_map oid,
    search_param_map_bin bytea,
    search_query_string oid,
    search_query_string_hash integer,
    search_query_string_vc text,
    search_type integer NOT NULL,
    search_status character varying(10) NOT NULL,
    total_count integer,
    search_uuid character varying(48) NOT NULL,
    optlock_version integer
);


ALTER TABLE public.hfj_search OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 19805)
-- Name: hfj_search_include; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_search_include (
    pid bigint NOT NULL,
    search_include character varying(200) NOT NULL,
    inc_recurse boolean NOT NULL,
    revinclude boolean NOT NULL,
    search_pid bigint NOT NULL
);


ALTER TABLE public.hfj_search_include OWNER TO postgres;

--
-- TOC entry 321 (class 1259 OID 19810)
-- Name: hfj_search_result; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_search_result (
    pid bigint NOT NULL,
    search_order integer NOT NULL,
    resource_partition_id integer,
    resource_pid bigint NOT NULL,
    search_pid bigint NOT NULL
);


ALTER TABLE public.hfj_search_result OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 19815)
-- Name: hfj_spidx_coords; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_spidx_coords (
    sp_id bigint NOT NULL,
    partition_id integer,
    partition_date date,
    hash_identity bigint,
    sp_missing boolean NOT NULL,
    sp_name character varying(100),
    res_id bigint NOT NULL,
    res_type character varying(100),
    sp_updated timestamp(6) without time zone,
    sp_latitude double precision,
    sp_longitude double precision
);


ALTER TABLE public.hfj_spidx_coords OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 19820)
-- Name: hfj_spidx_date; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_spidx_date (
    sp_id bigint NOT NULL,
    partition_id integer,
    partition_date date,
    hash_identity bigint,
    sp_missing boolean NOT NULL,
    sp_name character varying(100),
    res_id bigint NOT NULL,
    res_type character varying(100),
    sp_updated timestamp(6) without time zone,
    sp_value_high timestamp(6) without time zone,
    sp_value_high_date_ordinal integer,
    sp_value_low timestamp(6) without time zone,
    sp_value_low_date_ordinal integer
);


ALTER TABLE public.hfj_spidx_date OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 19825)
-- Name: hfj_spidx_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_spidx_identity (
    sp_identity_id integer NOT NULL,
    hash_identity bigint NOT NULL,
    sp_name character varying(256) NOT NULL,
    res_type character varying(100) NOT NULL
);


ALTER TABLE public.hfj_spidx_identity OWNER TO postgres;

--
-- TOC entry 325 (class 1259 OID 19830)
-- Name: hfj_spidx_number; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_spidx_number (
    sp_id bigint NOT NULL,
    partition_id integer,
    partition_date date,
    hash_identity bigint,
    sp_missing boolean NOT NULL,
    sp_name character varying(100),
    res_id bigint NOT NULL,
    res_type character varying(100),
    sp_updated timestamp(6) without time zone,
    sp_value numeric(19,2)
);


ALTER TABLE public.hfj_spidx_number OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 19835)
-- Name: hfj_spidx_quantity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_spidx_quantity (
    sp_id bigint NOT NULL,
    partition_id integer,
    partition_date date,
    hash_identity bigint,
    sp_missing boolean NOT NULL,
    sp_name character varying(100),
    res_id bigint NOT NULL,
    res_type character varying(100),
    sp_updated timestamp(6) without time zone,
    hash_identity_and_units bigint,
    hash_identity_sys_units bigint,
    sp_system character varying(200),
    sp_units character varying(200),
    sp_value double precision
);


ALTER TABLE public.hfj_spidx_quantity OWNER TO postgres;

--
-- TOC entry 327 (class 1259 OID 19842)
-- Name: hfj_spidx_quantity_nrml; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_spidx_quantity_nrml (
    sp_id bigint NOT NULL,
    partition_id integer,
    partition_date date,
    hash_identity bigint,
    sp_missing boolean NOT NULL,
    sp_name character varying(100),
    res_id bigint NOT NULL,
    res_type character varying(100),
    sp_updated timestamp(6) without time zone,
    hash_identity_and_units bigint,
    hash_identity_sys_units bigint,
    sp_system character varying(200),
    sp_units character varying(200),
    sp_value double precision
);


ALTER TABLE public.hfj_spidx_quantity_nrml OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 19849)
-- Name: hfj_spidx_string; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_spidx_string (
    sp_id bigint NOT NULL,
    partition_id integer,
    partition_date date,
    hash_identity bigint,
    sp_missing boolean NOT NULL,
    sp_name character varying(100),
    res_id bigint NOT NULL,
    res_type character varying(100),
    sp_updated timestamp(6) without time zone,
    hash_exact bigint,
    hash_norm_prefix bigint,
    sp_value_exact character varying(768),
    sp_value_normalized character varying(768)
);


ALTER TABLE public.hfj_spidx_string OWNER TO postgres;

--
-- TOC entry 329 (class 1259 OID 19856)
-- Name: hfj_spidx_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_spidx_token (
    sp_id bigint NOT NULL,
    partition_id integer,
    partition_date date,
    hash_identity bigint,
    sp_missing boolean NOT NULL,
    sp_name character varying(100),
    res_id bigint NOT NULL,
    res_type character varying(100),
    sp_updated timestamp(6) without time zone,
    hash_sys bigint,
    hash_sys_and_value bigint,
    hash_value bigint,
    sp_system character varying(200),
    sp_value character varying(200)
);


ALTER TABLE public.hfj_spidx_token OWNER TO postgres;

--
-- TOC entry 330 (class 1259 OID 19863)
-- Name: hfj_spidx_uri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_spidx_uri (
    sp_id bigint NOT NULL,
    partition_id integer,
    partition_date date,
    hash_identity bigint,
    sp_missing boolean NOT NULL,
    sp_name character varying(100),
    res_id bigint NOT NULL,
    res_type character varying(100),
    sp_updated timestamp(6) without time zone,
    hash_uri bigint,
    sp_uri character varying(500)
);


ALTER TABLE public.hfj_spidx_uri OWNER TO postgres;

--
-- TOC entry 331 (class 1259 OID 19870)
-- Name: hfj_subscription_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_subscription_stats (
    pid bigint NOT NULL,
    created_time timestamp(6) without time zone NOT NULL,
    res_id bigint
);


ALTER TABLE public.hfj_subscription_stats OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 19875)
-- Name: hfj_tag_def; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hfj_tag_def (
    tag_id bigint NOT NULL,
    tag_code character varying(200),
    tag_display character varying(200),
    tag_system character varying(200),
    tag_type integer NOT NULL,
    tag_user_selected boolean,
    tag_version character varying(30)
);


ALTER TABLE public.hfj_tag_def OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 19476)
-- Name: historial_cambios_cita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historial_cambios_cita (
    id_historial integer NOT NULL,
    id_cita integer NOT NULL,
    id_usuario integer,
    estado_anterior character varying(80),
    estado_nuevo character varying(80),
    observacion text,
    fecha_cambio timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.historial_cambios_cita OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 19475)
-- Name: historial_cambios_cita_id_historial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historial_cambios_cita_id_historial_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historial_cambios_cita_id_historial_seq OWNER TO postgres;

--
-- TOC entry 4745 (class 0 OID 0)
-- Dependencies: 283
-- Name: historial_cambios_cita_id_historial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historial_cambios_cita_id_historial_seq OWNED BY public.historial_cambios_cita.id_historial;


--
-- TOC entry 246 (class 1259 OID 18982)
-- Name: ips; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ips (
    id_ips integer NOT NULL,
    nombre character varying(150) NOT NULL,
    razon_social character varying(180),
    nit character varying(30) NOT NULL,
    codigo_habilitacion character varying(50),
    direccion character varying(200),
    telefono character varying(30),
    correo character varying(120),
    id_municipio integer,
    activo boolean DEFAULT true NOT NULL,
    fhir_id character varying(100),
    fhir_version_id character varying(100),
    fecha_sincronizacion_fhir timestamp without time zone,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE public.ips OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 18981)
-- Name: ips_id_ips_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ips_id_ips_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ips_id_ips_seq OWNER TO postgres;

--
-- TOC entry 4746 (class 0 OID 0)
-- Dependencies: 245
-- Name: ips_id_ips_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ips_id_ips_seq OWNED BY public.ips.id_ips;


--
-- TOC entry 286 (class 1259 OID 19496)
-- Name: lista_espera; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lista_espera (
    id_lista_espera integer NOT NULL,
    id_ips integer NOT NULL,
    id_paciente integer NOT NULL,
    id_servicio integer NOT NULL,
    id_sede integer,
    id_profesional integer,
    id_tipo_consulta integer,
    id_modalidad integer,
    prioridad integer DEFAULT 3 NOT NULL,
    observacion text,
    activo boolean DEFAULT true NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_prioridad_lista_espera CHECK (((prioridad >= 1) AND (prioridad <= 5)))
);


ALTER TABLE public.lista_espera OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 19495)
-- Name: lista_espera_id_lista_espera_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lista_espera_id_lista_espera_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lista_espera_id_lista_espera_seq OWNER TO postgres;

--
-- TOC entry 4747 (class 0 OID 0)
-- Dependencies: 285
-- Name: lista_espera_id_lista_espera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lista_espera_id_lista_espera_seq OWNED BY public.lista_espera.id_lista_espera;


--
-- TOC entry 240 (class 1259 OID 18948)
-- Name: modalidades_atencion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modalidades_atencion (
    id_modalidad integer NOT NULL,
    codigo character varying(30) NOT NULL,
    nombre character varying(100) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.modalidades_atencion OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 18947)
-- Name: modalidades_atencion_id_modalidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.modalidades_atencion_id_modalidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.modalidades_atencion_id_modalidad_seq OWNER TO postgres;

--
-- TOC entry 4748 (class 0 OID 0)
-- Dependencies: 239
-- Name: modalidades_atencion_id_modalidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.modalidades_atencion_id_modalidad_seq OWNED BY public.modalidades_atencion.id_modalidad;


--
-- TOC entry 228 (class 1259 OID 18886)
-- Name: motivos_cancelacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motivos_cancelacion (
    id_motivo_cancelacion integer NOT NULL,
    codigo character varying(30) NOT NULL,
    descripcion text NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.motivos_cancelacion OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 18885)
-- Name: motivos_cancelacion_id_motivo_cancelacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.motivos_cancelacion_id_motivo_cancelacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.motivos_cancelacion_id_motivo_cancelacion_seq OWNER TO postgres;

--
-- TOC entry 4749 (class 0 OID 0)
-- Dependencies: 227
-- Name: motivos_cancelacion_id_motivo_cancelacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.motivos_cancelacion_id_motivo_cancelacion_seq OWNED BY public.motivos_cancelacion.id_motivo_cancelacion;


--
-- TOC entry 333 (class 1259 OID 19882)
-- Name: mpi_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mpi_link (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    created timestamp(6) without time zone NOT NULL,
    eid_match boolean,
    golden_resource_partition_id integer,
    golden_resource_pid bigint NOT NULL,
    new_person boolean,
    link_source integer NOT NULL,
    match_result integer NOT NULL,
    target_type character varying(40),
    person_partition_id integer,
    person_pid bigint NOT NULL,
    rule_count bigint,
    score double precision,
    target_partition_id integer,
    target_pid bigint NOT NULL,
    updated timestamp(6) without time zone NOT NULL,
    vector bigint,
    version character varying(16) NOT NULL
);


ALTER TABLE public.mpi_link OWNER TO postgres;

--
-- TOC entry 334 (class 1259 OID 19887)
-- Name: mpi_link_aud; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mpi_link_aud (
    pid bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    partition_date date,
    partition_id integer,
    created timestamp(6) without time zone,
    eid_match boolean,
    golden_resource_partition_id integer,
    golden_resource_pid bigint,
    new_person boolean,
    link_source integer,
    match_result integer,
    target_type character varying(40),
    person_partition_id integer,
    person_pid bigint,
    rule_count bigint,
    score double precision,
    target_partition_id integer,
    target_pid bigint,
    updated timestamp(6) without time zone,
    vector bigint,
    version character varying(16)
);


ALTER TABLE public.mpi_link_aud OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 18967)
-- Name: municipios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.municipios (
    id_municipio integer NOT NULL,
    id_departamento integer NOT NULL,
    codigo character varying(20),
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.municipios OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 18966)
-- Name: municipios_id_municipio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.municipios_id_municipio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.municipios_id_municipio_seq OWNER TO postgres;

--
-- TOC entry 4750 (class 0 OID 0)
-- Dependencies: 243
-- Name: municipios_id_municipio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.municipios_id_municipio_seq OWNED BY public.municipios.id_municipio;


--
-- TOC entry 288 (class 1259 OID 19544)
-- Name: notificaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notificaciones (
    id_notificacion integer NOT NULL,
    id_cita integer,
    id_paciente integer,
    canal character varying(30) NOT NULL,
    destinatario character varying(150) NOT NULL,
    asunto character varying(150),
    mensaje text NOT NULL,
    enviada boolean DEFAULT false NOT NULL,
    fecha_envio timestamp without time zone,
    error_envio text,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.notificaciones OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 19543)
-- Name: notificaciones_id_notificacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notificaciones_id_notificacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notificaciones_id_notificacion_seq OWNER TO postgres;

--
-- TOC entry 4751 (class 0 OID 0)
-- Dependencies: 287
-- Name: notificaciones_id_notificacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notificaciones_id_notificacion_seq OWNED BY public.notificaciones.id_notificacion;


--
-- TOC entry 335 (class 1259 OID 19892)
-- Name: npm_package; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.npm_package (
    pid bigint NOT NULL,
    cur_version_id character varying(200),
    package_desc character varying(512),
    package_id character varying(200) NOT NULL,
    updated_time timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.npm_package OWNER TO postgres;

--
-- TOC entry 336 (class 1259 OID 19899)
-- Name: npm_package_ver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.npm_package_ver (
    pid bigint NOT NULL,
    pkg_author character varying(512),
    author_upper character varying(512),
    current_version boolean NOT NULL,
    pkg_desc character varying(512),
    desc_upper character varying(512),
    fhir_version character varying(10) NOT NULL,
    fhir_version_id character varying(20) NOT NULL,
    partition_id integer,
    binary_res_id bigint NOT NULL,
    package_id character varying(200) NOT NULL,
    package_size_bytes bigint NOT NULL,
    saved_time timestamp(6) without time zone NOT NULL,
    updated_time timestamp(6) without time zone NOT NULL,
    version_id character varying(200) NOT NULL,
    package_pid bigint NOT NULL
);


ALTER TABLE public.npm_package_ver OWNER TO postgres;

--
-- TOC entry 337 (class 1259 OID 19906)
-- Name: npm_package_ver_res; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.npm_package_ver_res (
    pid bigint NOT NULL,
    canonical_url character varying(200),
    canonical_version character varying(200),
    file_dir character varying(200),
    fhir_version character varying(10) NOT NULL,
    fhir_version_id character varying(20) NOT NULL,
    file_name character varying(200),
    partition_id integer,
    res_size_bytes bigint NOT NULL,
    binary_res_id bigint NOT NULL,
    res_type character varying(40) NOT NULL,
    updated_time timestamp(6) without time zone NOT NULL,
    packver_pid bigint NOT NULL
);


ALTER TABLE public.npm_package_ver_res OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 19209)
-- Name: pacientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pacientes (
    id_paciente integer NOT NULL,
    id_tipo_documento integer NOT NULL,
    numero_documento character varying(50) NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    fecha_nacimiento date NOT NULL,
    id_genero integer,
    id_sexo_biologico integer,
    telefono character varying(30),
    correo character varying(120),
    activo boolean DEFAULT true NOT NULL,
    fhir_id character varying(100),
    fhir_version_id character varying(100),
    fecha_sincronizacion_fhir timestamp without time zone,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT chk_fecha_nacimiento CHECK ((fecha_nacimiento <= CURRENT_DATE))
);


ALTER TABLE public.pacientes OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 19208)
-- Name: pacientes_id_paciente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pacientes_id_paciente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pacientes_id_paciente_seq OWNER TO postgres;

--
-- TOC entry 4752 (class 0 OID 0)
-- Dependencies: 267
-- Name: pacientes_id_paciente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pacientes_id_paciente_seq OWNED BY public.pacientes.id_paciente;


--
-- TOC entry 254 (class 1259 OID 19066)
-- Name: permisos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permisos (
    id_permiso integer NOT NULL,
    codigo character varying(80) NOT NULL,
    nombre character varying(120) NOT NULL,
    descripcion text,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.permisos OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 19065)
-- Name: permisos_id_permiso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permisos_id_permiso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permisos_id_permiso_seq OWNER TO postgres;

--
-- TOC entry 4753 (class 0 OID 0)
-- Dependencies: 253
-- Name: permisos_id_permiso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permisos_id_permiso_seq OWNED BY public.permisos.id_permiso;


--
-- TOC entry 264 (class 1259 OID 19153)
-- Name: profesionales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profesionales (
    id_profesional integer NOT NULL,
    id_tipo_documento integer,
    numero_documento character varying(50),
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    tarjeta_profesional character varying(50) NOT NULL,
    id_especialidad integer NOT NULL,
    telefono character varying(30),
    correo character varying(120),
    activo boolean DEFAULT true NOT NULL,
    fhir_id character varying(100),
    fhir_version_id character varying(100),
    fecha_sincronizacion_fhir timestamp without time zone,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE public.profesionales OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 19152)
-- Name: profesionales_id_profesional_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profesionales_id_profesional_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profesionales_id_profesional_seq OWNER TO postgres;

--
-- TOC entry 4754 (class 0 OID 0)
-- Dependencies: 263
-- Name: profesionales_id_profesional_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profesionales_id_profesional_seq OWNED BY public.profesionales.id_profesional;


--
-- TOC entry 272 (class 1259 OID 19262)
-- Name: reglas_duracion_cita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reglas_duracion_cita (
    id_regla integer NOT NULL,
    id_ips integer,
    id_aseguradora integer NOT NULL,
    id_tipo_consulta integer NOT NULL,
    id_modalidad integer NOT NULL,
    id_especialidad integer,
    duracion_minutos integer NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT chk_duracion_positiva CHECK ((duracion_minutos > 0))
);


ALTER TABLE public.reglas_duracion_cita OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 19261)
-- Name: reglas_duracion_cita_id_regla_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reglas_duracion_cita_id_regla_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reglas_duracion_cita_id_regla_seq OWNER TO postgres;

--
-- TOC entry 4755 (class 0 OID 0)
-- Dependencies: 271
-- Name: reglas_duracion_cita_id_regla_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reglas_duracion_cita_id_regla_seq OWNED BY public.reglas_duracion_cita.id_regla;


--
-- TOC entry 282 (class 1259 OID 19460)
-- Name: respuestas_cita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.respuestas_cita (
    id_respuesta integer NOT NULL,
    id_cita integer NOT NULL,
    mensaje text NOT NULL,
    enviado boolean DEFAULT false NOT NULL,
    fecha_envio timestamp without time zone,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fhir_id character varying(100),
    fhir_version_id character varying(100),
    fecha_sincronizacion_fhir timestamp without time zone
);


ALTER TABLE public.respuestas_cita OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 19459)
-- Name: respuestas_cita_id_respuesta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.respuestas_cita_id_respuesta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.respuestas_cita_id_respuesta_seq OWNER TO postgres;

--
-- TOC entry 4756 (class 0 OID 0)
-- Dependencies: 281
-- Name: respuestas_cita_id_respuesta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.respuestas_cita_id_respuesta_seq OWNED BY public.respuestas_cita.id_respuesta;


--
-- TOC entry 256 (class 1259 OID 19078)
-- Name: rol_permiso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rol_permiso (
    id_rol_permiso integer NOT NULL,
    id_rol integer NOT NULL,
    id_permiso integer NOT NULL
);


ALTER TABLE public.rol_permiso OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 19077)
-- Name: rol_permiso_id_rol_permiso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rol_permiso_id_rol_permiso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rol_permiso_id_rol_permiso_seq OWNER TO postgres;

--
-- TOC entry 4757 (class 0 OID 0)
-- Dependencies: 255
-- Name: rol_permiso_id_rol_permiso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rol_permiso_id_rol_permiso_seq OWNED BY public.rol_permiso.id_rol_permiso;


--
-- TOC entry 222 (class 1259 OID 18854)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id_rol integer NOT NULL,
    codigo character varying(30) NOT NULL,
    nombre character varying(80) NOT NULL,
    descripcion text,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 18853)
-- Name: roles_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_rol_seq OWNER TO postgres;

--
-- TOC entry 4758 (class 0 OID 0)
-- Dependencies: 221
-- Name: roles_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_rol_seq OWNED BY public.roles.id_rol;


--
-- TOC entry 266 (class 1259 OID 19176)
-- Name: roles_profesional; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles_profesional (
    id_rol_profesional integer NOT NULL,
    id_profesional integer NOT NULL,
    id_ips integer NOT NULL,
    id_sede integer NOT NULL,
    id_servicio integer NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    fecha_inicio date DEFAULT CURRENT_DATE NOT NULL,
    fecha_fin date,
    fhir_id character varying(100),
    fhir_version_id character varying(100),
    fecha_sincronizacion_fhir timestamp without time zone,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT chk_rol_profesional_fechas CHECK (((fecha_fin IS NULL) OR (fecha_fin >= fecha_inicio)))
);


ALTER TABLE public.roles_profesional OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 19175)
-- Name: roles_profesional_id_rol_profesional_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_profesional_id_rol_profesional_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_profesional_id_rol_profesional_seq OWNER TO postgres;

--
-- TOC entry 4759 (class 0 OID 0)
-- Dependencies: 265
-- Name: roles_profesional_id_rol_profesional_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_profesional_id_rol_profesional_seq OWNED BY public.roles_profesional.id_rol_profesional;


--
-- TOC entry 250 (class 1259 OID 19013)
-- Name: sedes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sedes (
    id_sede integer NOT NULL,
    id_ips integer NOT NULL,
    nombre character varying(120) NOT NULL,
    identificador character varying(50) NOT NULL,
    codigo_habilitacion character varying(50),
    id_municipio integer,
    direccion character varying(200),
    telefono character varying(30),
    activo boolean DEFAULT true NOT NULL,
    fhir_id character varying(100),
    fhir_version_id character varying(100),
    fecha_sincronizacion_fhir timestamp without time zone,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE public.sedes OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 19012)
-- Name: sedes_id_sede_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sedes_id_sede_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sedes_id_sede_seq OWNER TO postgres;

--
-- TOC entry 4760 (class 0 OID 0)
-- Dependencies: 249
-- Name: sedes_id_sede_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sedes_id_sede_seq OWNED BY public.sedes.id_sede;


--
-- TOC entry 351 (class 1259 OID 20144)
-- Name: seq_blkexcol_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_blkexcol_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_blkexcol_pid OWNER TO postgres;

--
-- TOC entry 352 (class 1259 OID 20145)
-- Name: seq_blkexcolfile_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_blkexcolfile_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_blkexcolfile_pid OWNER TO postgres;

--
-- TOC entry 353 (class 1259 OID 20146)
-- Name: seq_blkexjob_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_blkexjob_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_blkexjob_pid OWNER TO postgres;

--
-- TOC entry 354 (class 1259 OID 20147)
-- Name: seq_blkimjob_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_blkimjob_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_blkimjob_pid OWNER TO postgres;

--
-- TOC entry 355 (class 1259 OID 20148)
-- Name: seq_blkimjobfile_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_blkimjobfile_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_blkimjobfile_pid OWNER TO postgres;

--
-- TOC entry 356 (class 1259 OID 20149)
-- Name: seq_cncpt_map_grp_elm_tgt_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_cncpt_map_grp_elm_tgt_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_cncpt_map_grp_elm_tgt_pid OWNER TO postgres;

--
-- TOC entry 357 (class 1259 OID 20150)
-- Name: seq_codesystem_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_codesystem_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_codesystem_pid OWNER TO postgres;

--
-- TOC entry 358 (class 1259 OID 20151)
-- Name: seq_codesystemver_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_codesystemver_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_codesystemver_pid OWNER TO postgres;

--
-- TOC entry 359 (class 1259 OID 20152)
-- Name: seq_concept_desig_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_concept_desig_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_concept_desig_pid OWNER TO postgres;

--
-- TOC entry 360 (class 1259 OID 20153)
-- Name: seq_concept_map_group_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_concept_map_group_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_concept_map_group_pid OWNER TO postgres;

--
-- TOC entry 361 (class 1259 OID 20154)
-- Name: seq_concept_map_grp_elm_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_concept_map_grp_elm_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_concept_map_grp_elm_pid OWNER TO postgres;

--
-- TOC entry 362 (class 1259 OID 20155)
-- Name: seq_concept_map_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_concept_map_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_concept_map_pid OWNER TO postgres;

--
-- TOC entry 363 (class 1259 OID 20156)
-- Name: seq_concept_pc_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_concept_pc_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_concept_pc_pid OWNER TO postgres;

--
-- TOC entry 364 (class 1259 OID 20157)
-- Name: seq_concept_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_concept_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_concept_pid OWNER TO postgres;

--
-- TOC entry 365 (class 1259 OID 20158)
-- Name: seq_concept_prop_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_concept_prop_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_concept_prop_pid OWNER TO postgres;

--
-- TOC entry 366 (class 1259 OID 20159)
-- Name: seq_empi_link_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_empi_link_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_empi_link_id OWNER TO postgres;

--
-- TOC entry 367 (class 1259 OID 20160)
-- Name: seq_forcedid_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_forcedid_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_forcedid_id OWNER TO postgres;

--
-- TOC entry 368 (class 1259 OID 20161)
-- Name: seq_hfj_revinfo; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_hfj_revinfo
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_hfj_revinfo OWNER TO postgres;

--
-- TOC entry 369 (class 1259 OID 20162)
-- Name: seq_historytag_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_historytag_id
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_historytag_id OWNER TO postgres;

--
-- TOC entry 370 (class 1259 OID 20163)
-- Name: seq_idxcmbtoknu_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_idxcmbtoknu_id
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_idxcmbtoknu_id OWNER TO postgres;

--
-- TOC entry 371 (class 1259 OID 20164)
-- Name: seq_idxcmpstruniq_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_idxcmpstruniq_id
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_idxcmpstruniq_id OWNER TO postgres;

--
-- TOC entry 372 (class 1259 OID 20165)
-- Name: seq_npm_pack; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_npm_pack
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_npm_pack OWNER TO postgres;

--
-- TOC entry 373 (class 1259 OID 20166)
-- Name: seq_npm_packver; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_npm_packver
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_npm_packver OWNER TO postgres;

--
-- TOC entry 374 (class 1259 OID 20167)
-- Name: seq_npm_packverres; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_npm_packverres
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_npm_packverres OWNER TO postgres;

--
-- TOC entry 375 (class 1259 OID 20168)
-- Name: seq_res_reindex_job; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_res_reindex_job
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_res_reindex_job OWNER TO postgres;

--
-- TOC entry 376 (class 1259 OID 20169)
-- Name: seq_reslink_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_reslink_id
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_reslink_id OWNER TO postgres;

--
-- TOC entry 377 (class 1259 OID 20170)
-- Name: seq_resource_history_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_resource_history_id
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_resource_history_id OWNER TO postgres;

--
-- TOC entry 378 (class 1259 OID 20171)
-- Name: seq_resource_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_resource_id
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_resource_id OWNER TO postgres;

--
-- TOC entry 379 (class 1259 OID 20172)
-- Name: seq_resource_type; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_resource_type
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_resource_type OWNER TO postgres;

--
-- TOC entry 380 (class 1259 OID 20173)
-- Name: seq_resparmpresent_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_resparmpresent_id
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_resparmpresent_id OWNER TO postgres;

--
-- TOC entry 381 (class 1259 OID 20174)
-- Name: seq_restag_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_restag_id
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_restag_id OWNER TO postgres;

--
-- TOC entry 382 (class 1259 OID 20175)
-- Name: seq_search; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_search
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_search OWNER TO postgres;

--
-- TOC entry 383 (class 1259 OID 20176)
-- Name: seq_search_inc; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_search_inc
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_search_inc OWNER TO postgres;

--
-- TOC entry 384 (class 1259 OID 20177)
-- Name: seq_search_res; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_search_res
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_search_res OWNER TO postgres;

--
-- TOC entry 385 (class 1259 OID 20178)
-- Name: seq_spidx_coords; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_spidx_coords
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_spidx_coords OWNER TO postgres;

--
-- TOC entry 386 (class 1259 OID 20179)
-- Name: seq_spidx_date; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_spidx_date
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_spidx_date OWNER TO postgres;

--
-- TOC entry 387 (class 1259 OID 20180)
-- Name: seq_spidx_identity; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_spidx_identity
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_spidx_identity OWNER TO postgres;

--
-- TOC entry 388 (class 1259 OID 20181)
-- Name: seq_spidx_number; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_spidx_number
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_spidx_number OWNER TO postgres;

--
-- TOC entry 389 (class 1259 OID 20182)
-- Name: seq_spidx_quantity; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_spidx_quantity
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_spidx_quantity OWNER TO postgres;

--
-- TOC entry 390 (class 1259 OID 20183)
-- Name: seq_spidx_quantity_nrml; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_spidx_quantity_nrml
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_spidx_quantity_nrml OWNER TO postgres;

--
-- TOC entry 391 (class 1259 OID 20184)
-- Name: seq_spidx_string; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_spidx_string
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_spidx_string OWNER TO postgres;

--
-- TOC entry 392 (class 1259 OID 20185)
-- Name: seq_spidx_token; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_spidx_token
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_spidx_token OWNER TO postgres;

--
-- TOC entry 393 (class 1259 OID 20186)
-- Name: seq_spidx_uri; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_spidx_uri
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_spidx_uri OWNER TO postgres;

--
-- TOC entry 394 (class 1259 OID 20187)
-- Name: seq_subscription_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_subscription_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_subscription_id OWNER TO postgres;

--
-- TOC entry 395 (class 1259 OID 20188)
-- Name: seq_tagdef_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_tagdef_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_tagdef_id OWNER TO postgres;

--
-- TOC entry 396 (class 1259 OID 20189)
-- Name: seq_valueset_c_dsgntn_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_valueset_c_dsgntn_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_valueset_c_dsgntn_pid OWNER TO postgres;

--
-- TOC entry 397 (class 1259 OID 20190)
-- Name: seq_valueset_concept_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_valueset_concept_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_valueset_concept_pid OWNER TO postgres;

--
-- TOC entry 398 (class 1259 OID 20191)
-- Name: seq_valueset_pid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_valueset_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_valueset_pid OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 19125)
-- Name: servicios_salud; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servicios_salud (
    id_servicio integer NOT NULL,
    id_ips integer NOT NULL,
    id_sede integer NOT NULL,
    id_especialidad integer,
    nombre character varying(120) NOT NULL,
    descripcion text,
    activo boolean DEFAULT true NOT NULL,
    fhir_id character varying(100),
    fhir_version_id character varying(100),
    fecha_sincronizacion_fhir timestamp without time zone,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE public.servicios_salud OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 19124)
-- Name: servicios_salud_id_servicio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.servicios_salud_id_servicio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.servicios_salud_id_servicio_seq OWNER TO postgres;

--
-- TOC entry 4761 (class 0 OID 0)
-- Dependencies: 261
-- Name: servicios_salud_id_servicio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.servicios_salud_id_servicio_seq OWNED BY public.servicios_salud.id_servicio;


--
-- TOC entry 258 (class 1259 OID 19097)
-- Name: sesiones_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sesiones_usuario (
    id_sesion integer NOT NULL,
    id_usuario integer NOT NULL,
    token_hash text,
    ip_origen character varying(50),
    user_agent text,
    fecha_inicio timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_fin timestamp without time zone,
    activa boolean DEFAULT true NOT NULL
);


ALTER TABLE public.sesiones_usuario OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 19096)
-- Name: sesiones_usuario_id_sesion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sesiones_usuario_id_sesion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sesiones_usuario_id_sesion_seq OWNER TO postgres;

--
-- TOC entry 4762 (class 0 OID 0)
-- Dependencies: 257
-- Name: sesiones_usuario_id_sesion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sesiones_usuario_id_sesion_seq OWNED BY public.sesiones_usuario.id_sesion;


--
-- TOC entry 220 (class 1259 OID 18844)
-- Name: sexos_biologicos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sexos_biologicos (
    id_sexo_biologico integer NOT NULL,
    codigo character varying(30) NOT NULL,
    descripcion character varying(80) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.sexos_biologicos OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 18843)
-- Name: sexos_biologicos_id_sexo_biologico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sexos_biologicos_id_sexo_biologico_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sexos_biologicos_id_sexo_biologico_seq OWNER TO postgres;

--
-- TOC entry 4763 (class 0 OID 0)
-- Dependencies: 219
-- Name: sexos_biologicos_id_sexo_biologico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sexos_biologicos_id_sexo_biologico_seq OWNED BY public.sexos_biologicos.id_sexo_biologico;


--
-- TOC entry 238 (class 1259 OID 18938)
-- Name: tipos_consulta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos_consulta (
    id_tipo_consulta integer NOT NULL,
    codigo character varying(30) NOT NULL,
    nombre character varying(120) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tipos_consulta OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 18937)
-- Name: tipos_consulta_id_tipo_consulta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipos_consulta_id_tipo_consulta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipos_consulta_id_tipo_consulta_seq OWNER TO postgres;

--
-- TOC entry 4764 (class 0 OID 0)
-- Dependencies: 237
-- Name: tipos_consulta_id_tipo_consulta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipos_consulta_id_tipo_consulta_seq OWNED BY public.tipos_consulta.id_tipo_consulta;


--
-- TOC entry 216 (class 1259 OID 18824)
-- Name: tipos_documento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos_documento (
    id_tipo_documento integer NOT NULL,
    codigo character varying(10) NOT NULL,
    descripcion character varying(80) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.tipos_documento OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 18823)
-- Name: tipos_documento_id_tipo_documento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipos_documento_id_tipo_documento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipos_documento_id_tipo_documento_seq OWNER TO postgres;

--
-- TOC entry 4765 (class 0 OID 0)
-- Dependencies: 215
-- Name: tipos_documento_id_tipo_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipos_documento_id_tipo_documento_seq OWNED BY public.tipos_documento.id_tipo_documento;


--
-- TOC entry 338 (class 1259 OID 19913)
-- Name: trm_codesystem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trm_codesystem (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    code_system_uri character varying(200) NOT NULL,
    current_version_partition_id integer,
    current_version_pid bigint,
    cs_name character varying(200),
    res_id bigint NOT NULL
);


ALTER TABLE public.trm_codesystem OWNER TO postgres;

--
-- TOC entry 339 (class 1259 OID 19918)
-- Name: trm_codesystem_ver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trm_codesystem_ver (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    cs_display character varying(200),
    codesystem_pid bigint,
    cs_version_id character varying(200),
    res_id bigint NOT NULL
);


ALTER TABLE public.trm_codesystem_ver OWNER TO postgres;

--
-- TOC entry 340 (class 1259 OID 19923)
-- Name: trm_concept; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trm_concept (
    pid bigint NOT NULL,
    partition_id integer,
    codeval character varying(500) NOT NULL,
    codesystem_pid bigint NOT NULL,
    display character varying(400),
    index_status smallint,
    parent_pids oid,
    parent_pids_vc text,
    code_sequence integer,
    concept_updated timestamp(6) without time zone
);


ALTER TABLE public.trm_concept OWNER TO postgres;

--
-- TOC entry 341 (class 1259 OID 19930)
-- Name: trm_concept_desig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trm_concept_desig (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    cs_ver_pid bigint NOT NULL,
    concept_pid bigint NOT NULL,
    lang character varying(500),
    use_code character varying(500),
    use_display character varying(500),
    use_system character varying(500),
    val character varying(2000),
    val_vc text
);


ALTER TABLE public.trm_concept_desig OWNER TO postgres;

--
-- TOC entry 342 (class 1259 OID 19937)
-- Name: trm_concept_map; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trm_concept_map (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    res_id bigint NOT NULL,
    source_url character varying(200),
    target_url character varying(200),
    url character varying(200) NOT NULL,
    ver character varying(200)
);


ALTER TABLE public.trm_concept_map OWNER TO postgres;

--
-- TOC entry 343 (class 1259 OID 19944)
-- Name: trm_concept_map_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trm_concept_map_group (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    concept_map_pid bigint NOT NULL,
    concept_map_url character varying(200),
    source_url character varying(200) NOT NULL,
    source_vs character varying(200),
    source_version character varying(200),
    target_url character varying(200) NOT NULL,
    target_vs character varying(200),
    target_version character varying(200)
);


ALTER TABLE public.trm_concept_map_group OWNER TO postgres;

--
-- TOC entry 344 (class 1259 OID 19951)
-- Name: trm_concept_map_grp_element; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trm_concept_map_grp_element (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    source_code character varying(500) NOT NULL,
    concept_map_group_pid bigint NOT NULL,
    concept_map_url character varying(200),
    source_display character varying(500),
    system_url character varying(200),
    system_version character varying(200),
    valueset_url character varying(200)
);


ALTER TABLE public.trm_concept_map_grp_element OWNER TO postgres;

--
-- TOC entry 345 (class 1259 OID 19958)
-- Name: trm_concept_map_grp_elm_tgt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trm_concept_map_grp_elm_tgt (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    target_code character varying(500),
    concept_map_grp_elm_pid bigint NOT NULL,
    concept_map_url character varying(200),
    target_display character varying(500),
    target_equivalence character varying(50),
    system_url character varying(200),
    system_version character varying(200),
    valueset_url character varying(200)
);


ALTER TABLE public.trm_concept_map_grp_elm_tgt OWNER TO postgres;

--
-- TOC entry 346 (class 1259 OID 19965)
-- Name: trm_concept_pc_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trm_concept_pc_link (
    pid bigint NOT NULL,
    partition_id integer,
    child_pid bigint NOT NULL,
    codesystem_pid bigint NOT NULL,
    parent_pid bigint NOT NULL,
    rel_type integer
);


ALTER TABLE public.trm_concept_pc_link OWNER TO postgres;

--
-- TOC entry 347 (class 1259 OID 19970)
-- Name: trm_concept_property; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trm_concept_property (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    prop_codesystem character varying(500),
    cs_ver_pid bigint,
    concept_pid bigint NOT NULL,
    prop_display character varying(500),
    prop_key character varying(500) NOT NULL,
    prop_type integer NOT NULL,
    prop_val character varying(500),
    prop_val_bin bytea,
    prop_val_lob oid
);


ALTER TABLE public.trm_concept_property OWNER TO postgres;

--
-- TOC entry 348 (class 1259 OID 19977)
-- Name: trm_valueset; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trm_valueset (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    expansion_status character varying(50) NOT NULL,
    expanded_at timestamp(6) without time zone,
    vsname character varying(200),
    res_id bigint NOT NULL,
    total_concept_designations bigint DEFAULT 0 NOT NULL,
    total_concepts bigint DEFAULT 0 NOT NULL,
    url character varying(200) NOT NULL,
    ver character varying(200)
);


ALTER TABLE public.trm_valueset OWNER TO postgres;

--
-- TOC entry 349 (class 1259 OID 19986)
-- Name: trm_valueset_c_designation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trm_valueset_c_designation (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    valueset_concept_pid bigint NOT NULL,
    lang character varying(500),
    use_code character varying(500),
    use_display character varying(500),
    use_system character varying(500),
    val character varying(2000) NOT NULL,
    valueset_pid bigint NOT NULL
);


ALTER TABLE public.trm_valueset_c_designation OWNER TO postgres;

--
-- TOC entry 350 (class 1259 OID 19993)
-- Name: trm_valueset_concept; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trm_valueset_concept (
    pid bigint NOT NULL,
    partition_id integer,
    partition_date date,
    codeval character varying(500) NOT NULL,
    display character varying(400),
    index_status bigint,
    valueset_order integer NOT NULL,
    source_direct_parent_pids oid,
    source_direct_parent_pids_vc text,
    source_pid bigint,
    system_url character varying(200) NOT NULL,
    system_ver character varying(200),
    valueset_pid bigint NOT NULL
);


ALTER TABLE public.trm_valueset_concept OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 19036)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    id_ips integer,
    id_sede integer,
    id_rol integer NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    correo character varying(120) NOT NULL,
    usuario character varying(80) NOT NULL,
    clave_hash text NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    ultimo_ingreso timestamp without time zone,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 19035)
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 4766 (class 0 OID 0)
-- Dependencies: 251
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;


--
-- TOC entry 3803 (class 2604 OID 19303)
-- Name: agendas id_agenda; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agendas ALTER COLUMN id_agenda SET DEFAULT nextval('public.agendas_id_agenda_seq'::regclass);


--
-- TOC entry 3768 (class 2604 OID 19003)
-- Name: aseguradoras id_aseguradora; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aseguradoras ALTER COLUMN id_aseguradora SET DEFAULT nextval('public.aseguradoras_id_aseguradora_seq'::regclass);


--
-- TOC entry 3824 (class 2604 OID 19568)
-- Name: auditoria id_auditoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria ALTER COLUMN id_auditoria SET DEFAULT nextval('public.auditoria_id_auditoria_seq'::regclass);


--
-- TOC entry 3807 (class 2604 OID 19363)
-- Name: bloqueos_agenda id_bloqueo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bloqueos_agenda ALTER COLUMN id_bloqueo SET DEFAULT nextval('public.bloqueos_agenda_id_bloqueo_seq'::regclass);


--
-- TOC entry 3745 (class 2604 OID 18869)
-- Name: canales_atencion id_canal; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canales_atencion ALTER COLUMN id_canal SET DEFAULT nextval('public.canales_atencion_id_canal_seq'::regclass);


--
-- TOC entry 3810 (class 2604 OID 19385)
-- Name: citas id_cita; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas ALTER COLUMN id_cita SET DEFAULT nextval('public.citas_id_cita_seq'::regclass);


--
-- TOC entry 3798 (class 2604 OID 19241)
-- Name: coberturas_paciente id_cobertura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coberturas_paciente ALTER COLUMN id_cobertura SET DEFAULT nextval('public.coberturas_paciente_id_cobertura_seq'::regclass);


--
-- TOC entry 3826 (class 2604 OID 19583)
-- Name: cola_sincronizacion_fhir id_sync; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cola_sincronizacion_fhir ALTER COLUMN id_sync SET DEFAULT nextval('public.cola_sincronizacion_fhir_id_sync_seq'::regclass);


--
-- TOC entry 3805 (class 2604 OID 19339)
-- Name: cupos id_cupo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupos ALTER COLUMN id_cupo SET DEFAULT nextval('public.cupos_id_cupo_seq'::regclass);


--
-- TOC entry 3763 (class 2604 OID 18961)
-- Name: departamentos id_departamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamentos ALTER COLUMN id_departamento SET DEFAULT nextval('public.departamentos_id_departamento_seq'::regclass);


--
-- TOC entry 3783 (class 2604 OID 19116)
-- Name: especialidades id_especialidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidades ALTER COLUMN id_especialidad SET DEFAULT nextval('public.especialidades_id_especialidad_seq'::regclass);


--
-- TOC entry 3753 (class 2604 OID 18911)
-- Name: estados_agenda id_estado_agenda; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_agenda ALTER COLUMN id_estado_agenda SET DEFAULT nextval('public.estados_agenda_id_estado_agenda_seq'::regclass);


--
-- TOC entry 3747 (class 2604 OID 18879)
-- Name: estados_cita id_estado_cita; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_cita ALTER COLUMN id_estado_cita SET DEFAULT nextval('public.estados_cita_id_estado_cita_seq'::regclass);


--
-- TOC entry 3751 (class 2604 OID 18901)
-- Name: estados_cobertura id_estado_cobertura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_cobertura ALTER COLUMN id_estado_cobertura SET DEFAULT nextval('public.estados_cobertura_id_estado_cobertura_seq'::regclass);


--
-- TOC entry 3755 (class 2604 OID 18921)
-- Name: estados_cupo id_estado_cupo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_cupo ALTER COLUMN id_estado_cupo SET DEFAULT nextval('public.estados_cupo_id_estado_cupo_seq'::regclass);


--
-- TOC entry 3757 (class 2604 OID 18931)
-- Name: estados_sincronizacion_fhir id_estado_sincronizacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_sincronizacion_fhir ALTER COLUMN id_estado_sincronizacion SET DEFAULT nextval('public.estados_sincronizacion_fhir_id_estado_sincronizacion_seq'::regclass);


--
-- TOC entry 3739 (class 2604 OID 18837)
-- Name: generos id_genero; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generos ALTER COLUMN id_genero SET DEFAULT nextval('public.generos_id_genero_seq'::regclass);


--
-- TOC entry 3815 (class 2604 OID 19479)
-- Name: historial_cambios_cita id_historial; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_cambios_cita ALTER COLUMN id_historial SET DEFAULT nextval('public.historial_cambios_cita_id_historial_seq'::regclass);


--
-- TOC entry 3765 (class 2604 OID 18985)
-- Name: ips id_ips; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ips ALTER COLUMN id_ips SET DEFAULT nextval('public.ips_id_ips_seq'::regclass);


--
-- TOC entry 3817 (class 2604 OID 19499)
-- Name: lista_espera id_lista_espera; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lista_espera ALTER COLUMN id_lista_espera SET DEFAULT nextval('public.lista_espera_id_lista_espera_seq'::regclass);


--
-- TOC entry 3761 (class 2604 OID 18951)
-- Name: modalidades_atencion id_modalidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modalidades_atencion ALTER COLUMN id_modalidad SET DEFAULT nextval('public.modalidades_atencion_id_modalidad_seq'::regclass);


--
-- TOC entry 3749 (class 2604 OID 18889)
-- Name: motivos_cancelacion id_motivo_cancelacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motivos_cancelacion ALTER COLUMN id_motivo_cancelacion SET DEFAULT nextval('public.motivos_cancelacion_id_motivo_cancelacion_seq'::regclass);


--
-- TOC entry 3764 (class 2604 OID 18970)
-- Name: municipios id_municipio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipios ALTER COLUMN id_municipio SET DEFAULT nextval('public.municipios_id_municipio_seq'::regclass);


--
-- TOC entry 3821 (class 2604 OID 19547)
-- Name: notificaciones id_notificacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificaciones ALTER COLUMN id_notificacion SET DEFAULT nextval('public.notificaciones_id_notificacion_seq'::regclass);


--
-- TOC entry 3795 (class 2604 OID 19212)
-- Name: pacientes id_paciente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes ALTER COLUMN id_paciente SET DEFAULT nextval('public.pacientes_id_paciente_seq'::regclass);


--
-- TOC entry 3777 (class 2604 OID 19069)
-- Name: permisos id_permiso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos ALTER COLUMN id_permiso SET DEFAULT nextval('public.permisos_id_permiso_seq'::regclass);


--
-- TOC entry 3788 (class 2604 OID 19156)
-- Name: profesionales id_profesional; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesionales ALTER COLUMN id_profesional SET DEFAULT nextval('public.profesionales_id_profesional_seq'::regclass);


--
-- TOC entry 3800 (class 2604 OID 19265)
-- Name: reglas_duracion_cita id_regla; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reglas_duracion_cita ALTER COLUMN id_regla SET DEFAULT nextval('public.reglas_duracion_cita_id_regla_seq'::regclass);


--
-- TOC entry 3812 (class 2604 OID 19463)
-- Name: respuestas_cita id_respuesta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas_cita ALTER COLUMN id_respuesta SET DEFAULT nextval('public.respuestas_cita_id_respuesta_seq'::regclass);


--
-- TOC entry 3779 (class 2604 OID 19081)
-- Name: rol_permiso id_rol_permiso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol_permiso ALTER COLUMN id_rol_permiso SET DEFAULT nextval('public.rol_permiso_id_rol_permiso_seq'::regclass);


--
-- TOC entry 3743 (class 2604 OID 18857)
-- Name: roles id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id_rol SET DEFAULT nextval('public.roles_id_rol_seq'::regclass);


--
-- TOC entry 3791 (class 2604 OID 19179)
-- Name: roles_profesional id_rol_profesional; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_profesional ALTER COLUMN id_rol_profesional SET DEFAULT nextval('public.roles_profesional_id_rol_profesional_seq'::regclass);


--
-- TOC entry 3771 (class 2604 OID 19016)
-- Name: sedes id_sede; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sedes ALTER COLUMN id_sede SET DEFAULT nextval('public.sedes_id_sede_seq'::regclass);


--
-- TOC entry 3785 (class 2604 OID 19128)
-- Name: servicios_salud id_servicio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios_salud ALTER COLUMN id_servicio SET DEFAULT nextval('public.servicios_salud_id_servicio_seq'::regclass);


--
-- TOC entry 3780 (class 2604 OID 19100)
-- Name: sesiones_usuario id_sesion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sesiones_usuario ALTER COLUMN id_sesion SET DEFAULT nextval('public.sesiones_usuario_id_sesion_seq'::regclass);


--
-- TOC entry 3741 (class 2604 OID 18847)
-- Name: sexos_biologicos id_sexo_biologico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sexos_biologicos ALTER COLUMN id_sexo_biologico SET DEFAULT nextval('public.sexos_biologicos_id_sexo_biologico_seq'::regclass);


--
-- TOC entry 3759 (class 2604 OID 18941)
-- Name: tipos_consulta id_tipo_consulta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_consulta ALTER COLUMN id_tipo_consulta SET DEFAULT nextval('public.tipos_consulta_id_tipo_consulta_seq'::regclass);


--
-- TOC entry 3737 (class 2604 OID 18827)
-- Name: tipos_documento id_tipo_documento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_documento ALTER COLUMN id_tipo_documento SET DEFAULT nextval('public.tipos_documento_id_tipo_documento_seq'::regclass);


--
-- TOC entry 3774 (class 2604 OID 19039)
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 4597 (class 0 OID 19300)
-- Dependencies: 274
-- Data for Name: agendas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4571 (class 0 OID 19000)
-- Dependencies: 248
-- Data for Name: aseguradoras; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4613 (class 0 OID 19565)
-- Dependencies: 290
-- Data for Name: auditoria; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4601 (class 0 OID 19360)
-- Dependencies: 278
-- Data for Name: bloqueos_agenda; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4616 (class 0 OID 19635)
-- Dependencies: 293
-- Data for Name: bt2_job_instance; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4617 (class 0 OID 19642)
-- Dependencies: 294
-- Data for Name: bt2_work_chunk; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4547 (class 0 OID 18866)
-- Dependencies: 224
-- Data for Name: canales_atencion; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4603 (class 0 OID 19382)
-- Dependencies: 280
-- Data for Name: citas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4593 (class 0 OID 19238)
-- Dependencies: 270
-- Data for Name: coberturas_paciente; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4615 (class 0 OID 19580)
-- Dependencies: 292
-- Data for Name: cola_sincronizacion_fhir; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4599 (class 0 OID 19336)
-- Dependencies: 276
-- Data for Name: cupos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4565 (class 0 OID 18958)
-- Dependencies: 242
-- Data for Name: departamentos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4583 (class 0 OID 19113)
-- Dependencies: 260
-- Data for Name: especialidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.especialidades VALUES (1, 'MEDGEN', 'Medicina General', true);
INSERT INTO public.especialidades VALUES (2, 'PED', 'Pediatria', true);
INSERT INTO public.especialidades VALUES (3, 'MEDFAM', 'Medicina Familiar', true);


--
-- TOC entry 4555 (class 0 OID 18908)
-- Dependencies: 232
-- Data for Name: estados_agenda; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4549 (class 0 OID 18876)
-- Dependencies: 226
-- Data for Name: estados_cita; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4553 (class 0 OID 18898)
-- Dependencies: 230
-- Data for Name: estados_cobertura; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4557 (class 0 OID 18918)
-- Dependencies: 234
-- Data for Name: estados_cupo; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4559 (class 0 OID 18928)
-- Dependencies: 236
-- Data for Name: estados_sincronizacion_fhir; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4541 (class 0 OID 18834)
-- Dependencies: 218
-- Data for Name: generos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4618 (class 0 OID 19649)
-- Dependencies: 295
-- Data for Name: hfj_binary_storage_blob; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4619 (class 0 OID 19656)
-- Dependencies: 296
-- Data for Name: hfj_blk_export_colfile; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4620 (class 0 OID 19661)
-- Dependencies: 297
-- Data for Name: hfj_blk_export_collection; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4621 (class 0 OID 19668)
-- Dependencies: 298
-- Data for Name: hfj_blk_export_job; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4622 (class 0 OID 19675)
-- Dependencies: 299
-- Data for Name: hfj_blk_import_job; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4623 (class 0 OID 19682)
-- Dependencies: 300
-- Data for Name: hfj_blk_import_jobfile; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4624 (class 0 OID 19689)
-- Dependencies: 301
-- Data for Name: hfj_forced_id; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4625 (class 0 OID 19695)
-- Dependencies: 302
-- Data for Name: hfj_history_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4626 (class 0 OID 19700)
-- Dependencies: 303
-- Data for Name: hfj_idx_cmb_tok_nu; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4627 (class 0 OID 19707)
-- Dependencies: 304
-- Data for Name: hfj_idx_cmp_string_uniq; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4628 (class 0 OID 19714)
-- Dependencies: 305
-- Data for Name: hfj_partition; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4629 (class 0 OID 19719)
-- Dependencies: 306
-- Data for Name: hfj_res_identifier_pt_uniq; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4630 (class 0 OID 19726)
-- Dependencies: 307
-- Data for Name: hfj_res_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hfj_res_link VALUES (1000, NULL, NULL, 'Location.managingOrganization', 1001, 'Location', 100, NULL, NULL, 1000, 'Organization', 136, NULL, NULL, '2026-04-30 01:07:44.908');
INSERT INTO public.hfj_res_link VALUES (1001, NULL, NULL, 'HealthcareService.location', 1002, 'HealthcareService', 83, NULL, NULL, 1001, 'Location', 100, NULL, NULL, '2026-04-30 02:38:21.225');
INSERT INTO public.hfj_res_link VALUES (1002, NULL, NULL, 'HealthcareService.providedBy', 1002, 'HealthcareService', 83, NULL, NULL, 1000, 'Organization', 136, NULL, NULL, '2026-04-30 02:38:21.225');
INSERT INTO public.hfj_res_link VALUES (1003, NULL, NULL, 'Location.managingOrganization', 1003, 'Location', 100, NULL, NULL, 1000, 'Organization', 136, NULL, NULL, '2026-04-30 03:52:32.265');
INSERT INTO public.hfj_res_link VALUES (1051, NULL, NULL, 'Location.managingOrganization', 1052, 'Location', 100, NULL, NULL, 1051, 'Organization', 136, NULL, NULL, '2026-05-02 13:24:12.959');
INSERT INTO public.hfj_res_link VALUES (1052, NULL, NULL, 'Location.managingOrganization', 1054, 'Location', 100, NULL, NULL, 1053, 'Organization', 136, NULL, NULL, '2026-05-02 13:54:29.368');
INSERT INTO public.hfj_res_link VALUES (1053, NULL, NULL, 'Location.managingOrganization', 1056, 'Location', 100, NULL, NULL, 1055, 'Organization', 136, NULL, NULL, '2026-05-04 15:14:46.898');
INSERT INTO public.hfj_res_link VALUES (1054, NULL, NULL, 'HealthcareService.location', 1057, 'HealthcareService', 83, NULL, NULL, 1056, 'Location', 100, NULL, NULL, '2026-05-04 15:16:09.428');
INSERT INTO public.hfj_res_link VALUES (1055, NULL, NULL, 'HealthcareService.providedBy', 1057, 'HealthcareService', 83, NULL, NULL, 1055, 'Organization', 136, NULL, NULL, '2026-05-04 15:16:09.428');
INSERT INTO public.hfj_res_link VALUES (1056, NULL, NULL, 'Location.managingOrganization', 1059, 'Location', 100, NULL, NULL, 1058, 'Organization', 136, NULL, NULL, '2026-05-04 16:27:52.94');
INSERT INTO public.hfj_res_link VALUES (1057, NULL, NULL, 'HealthcareService.providedBy', 1060, 'HealthcareService', 83, NULL, NULL, 1058, 'Organization', 136, NULL, NULL, '2026-05-04 16:29:03.421');
INSERT INTO public.hfj_res_link VALUES (1058, NULL, NULL, 'HealthcareService.location', 1060, 'HealthcareService', 83, NULL, NULL, 1059, 'Location', 100, NULL, NULL, '2026-05-04 16:29:03.421');


--
-- TOC entry 4631 (class 0 OID 19733)
-- Dependencies: 308
-- Data for Name: hfj_res_param_present; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4632 (class 0 OID 19738)
-- Dependencies: 309
-- Data for Name: hfj_res_reindex_job; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4633 (class 0 OID 19743)
-- Dependencies: 310
-- Data for Name: hfj_res_search_url; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4634 (class 0 OID 19750)
-- Dependencies: 311
-- Data for Name: hfj_res_system; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4635 (class 0 OID 19757)
-- Dependencies: 312
-- Data for Name: hfj_res_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4636 (class 0 OID 19762)
-- Dependencies: 313
-- Data for Name: hfj_res_ver; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hfj_res_ver VALUES (NULL, 1000, NULL, 'R4', false, '2026-04-30 01:04:34.204', '2026-04-30 01:04:34.204', 'JSON', NULL, NULL, NULL, 1000, '{"resourceType":"Organization","identifier":[{"system":"https://acme.com/ips/nit","value":"57766565666"}],"active":true,"name":"Prueba"}', 'Organization', 136, 1, NULL);
INSERT INTO public.hfj_res_ver VALUES (NULL, 1001, NULL, 'R4', false, '2026-04-30 01:07:44.908', '2026-04-30 01:07:44.908', 'JSON', NULL, NULL, NULL, 1001, '{"resourceType":"Location","status":"active","name":"Prueba Norte","address":{"text":"Sin dirección"},"managingOrganization":{"reference":"Organization/1000"}}', 'Location', 100, 1, NULL);
INSERT INTO public.hfj_res_ver VALUES (NULL, 1002, NULL, 'R4', false, '2026-04-30 02:38:21.225', '2026-04-30 02:38:21.225', 'JSON', NULL, NULL, NULL, 1002, '{"resourceType":"HealthcareService","active":true,"providedBy":{"reference":"Organization/1000"},"type":[{"text":"Medicina General"}],"location":[{"reference":"Location/1001"}],"name":"Consulta Medicina General"}', 'HealthcareService', 83, 1, NULL);
INSERT INTO public.hfj_res_ver VALUES (NULL, 1003, NULL, 'R4', false, '2026-04-30 03:52:32.265', '2026-04-30 03:52:32.265', 'JSON', NULL, NULL, NULL, 1003, '{"resourceType":"Location","status":"active","name":"Prueba Sur","address":{"text":"Sin dirección"},"managingOrganization":{"reference":"Organization/1000"}}', 'Location', 100, 1, NULL);
INSERT INTO public.hfj_res_ver VALUES (NULL, 1051, NULL, 'R4', false, '2026-05-02 13:22:41.956', '2026-05-02 13:22:41.956', 'JSON', NULL, NULL, NULL, 1051, '{"resourceType":"Organization","identifier":[{"system":"https://acme.com/ips/nit","value":"67677667-1"}],"active":true,"name":"Pruebas"}', 'Organization', 136, 1, NULL);
INSERT INTO public.hfj_res_ver VALUES (NULL, 1052, NULL, 'R4', false, '2026-05-02 13:24:12.959', '2026-05-02 13:24:12.959', 'JSON', NULL, NULL, NULL, 1052, '{"resourceType":"Location","status":"active","name":"Pruebas Noroccidente","address":{"text":"Callefalsa 123"},"managingOrganization":{"reference":"Organization/1051"}}', 'Location', 100, 1, NULL);
INSERT INTO public.hfj_res_ver VALUES (NULL, 1053, NULL, 'R4', false, '2026-05-02 13:53:36.287', '2026-05-02 13:53:36.287', 'JSON', NULL, NULL, NULL, 1053, '{"resourceType":"Organization","identifier":[{"system":"https://acme.com/ips/nit","value":"565565556-1"}],"active":true,"name":"Acme"}', 'Organization', 136, 1, NULL);
INSERT INTO public.hfj_res_ver VALUES (NULL, 1054, NULL, 'R4', false, '2026-05-02 13:54:29.368', '2026-05-02 13:54:29.368', 'JSON', NULL, NULL, NULL, 1054, '{"resourceType":"Location","status":"active","name":"Norte","address":{"text":"Calle falsa 234"},"managingOrganization":{"reference":"Organization/1053"}}', 'Location', 100, 1, NULL);
INSERT INTO public.hfj_res_ver VALUES (NULL, 1055, NULL, 'R4', false, '2026-05-04 15:12:02.527', '2026-05-04 15:12:02.527', 'JSON', NULL, NULL, NULL, 1055, '{"resourceType":"Organization","identifier":[{"system":"https://acme.com/ips/nit","value":"656565656556"}],"active":true,"name":"prueba 25"}', 'Organization', 136, 1, NULL);
INSERT INTO public.hfj_res_ver VALUES (NULL, 1056, NULL, 'R4', false, '2026-05-04 15:14:46.898', '2026-05-04 15:14:46.898', 'JSON', NULL, NULL, NULL, 1056, '{"resourceType":"Location","status":"active","name":"Pruebas Sur","address":{"text":"Sin dirección"},"managingOrganization":{"reference":"Organization/1055"}}', 'Location', 100, 1, NULL);
INSERT INTO public.hfj_res_ver VALUES (NULL, 1057, NULL, 'R4', false, '2026-05-04 15:16:09.428', '2026-05-04 15:16:09.428', 'JSON', NULL, NULL, NULL, 1057, '{"resourceType":"HealthcareService","active":true,"providedBy":{"reference":"Organization/1055"},"type":[{"text":"Medicina Familiar"}],"location":[{"reference":"Location/1056"}],"name":"yyyyyy"}', 'HealthcareService', 83, 1, NULL);
INSERT INTO public.hfj_res_ver VALUES (NULL, 1058, NULL, 'R4', false, '2026-05-04 16:26:54.178', '2026-05-04 16:26:54.178', 'JSON', NULL, NULL, NULL, 1058, '{"resourceType":"Organization","identifier":[{"system":"https://acme.com/ips/nit","value":"656656665-8"}],"active":true,"name":"Prueba2455"}', 'Organization', 136, 1, NULL);
INSERT INTO public.hfj_res_ver VALUES (NULL, 1059, NULL, 'R4', false, '2026-05-04 16:27:52.94', '2026-05-04 16:27:52.94', 'JSON', NULL, NULL, NULL, 1059, '{"resourceType":"Location","status":"active","name":"Prueba Clase","address":{"text":"Sin dirección"},"managingOrganization":{"reference":"Organization/1058"}}', 'Location', 100, 1, NULL);
INSERT INTO public.hfj_res_ver VALUES (NULL, 1060, NULL, 'R4', false, '2026-05-04 16:29:03.421', '2026-05-04 16:29:03.421', 'JSON', NULL, NULL, NULL, 1060, '{"resourceType":"HealthcareService","active":true,"providedBy":{"reference":"Organization/1058"},"type":[{"text":"Pediatria"}],"location":[{"reference":"Location/1059"}],"name":"Mediprueba"}', 'HealthcareService', 83, 1, NULL);


--
-- TOC entry 4637 (class 0 OID 19769)
-- Dependencies: 314
-- Data for Name: hfj_res_ver_prov; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4638 (class 0 OID 19776)
-- Dependencies: 315
-- Data for Name: hfj_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hfj_resource VALUES (1000, NULL, NULL, 'R4', false, '2026-04-30 01:04:34.204', '2026-04-30 01:04:34.204', '1000', false, '787c3093118f8fd37d99a3e183a0e1a6655890ed5f27f7888af6454a2b29a37b', 0, NULL, false, false, false, false, false, false, false, true, true, false, NULL, 'Organization', 136, false, 1);
INSERT INTO public.hfj_resource VALUES (1001, NULL, NULL, 'R4', false, '2026-04-30 01:07:44.908', '2026-04-30 01:07:44.908', '1001', true, '600b771bbb11c314e7a104d61b59a313f6d78cf42cdc5ecd164d132970139fe0', 0, NULL, false, false, false, false, false, false, false, true, true, false, NULL, 'Location', 100, false, 1);
INSERT INTO public.hfj_resource VALUES (1002, NULL, NULL, 'R4', false, '2026-04-30 02:38:21.225', '2026-04-30 02:38:21.225', '1002', true, 'c03060ec18c92ec2eedc9c0e417c44d29aa2ea186e1566674e040274d4f01b89', 0, NULL, false, false, false, false, false, false, false, true, true, false, NULL, 'HealthcareService', 83, false, 1);
INSERT INTO public.hfj_resource VALUES (1003, NULL, NULL, 'R4', false, '2026-04-30 03:52:32.265', '2026-04-30 03:52:32.265', '1003', true, 'b7884947c944c592475be35d9bd8cdd8f43f707bc1ce0e2a7fc4a8d54b04288b', 0, NULL, false, false, false, false, false, false, false, true, true, false, NULL, 'Location', 100, false, 1);
INSERT INTO public.hfj_resource VALUES (1051, NULL, NULL, 'R4', false, '2026-05-02 13:22:41.956', '2026-05-02 13:22:41.956', '1051', false, 'bb054a68ae68cf0e4de20b2038f1b8e9ec6d468d587e1b955ed231150551d9ce', 0, NULL, false, false, false, false, false, false, false, true, true, false, NULL, 'Organization', 136, false, 1);
INSERT INTO public.hfj_resource VALUES (1052, NULL, NULL, 'R4', false, '2026-05-02 13:24:12.959', '2026-05-02 13:24:12.959', '1052', true, '7d631843163d479d4a8809dc2c0395009ff81ef8f07acf7080524dfaeabc0c1e', 0, NULL, false, false, false, false, false, false, false, true, true, false, NULL, 'Location', 100, false, 1);
INSERT INTO public.hfj_resource VALUES (1053, NULL, NULL, 'R4', false, '2026-05-02 13:53:36.287', '2026-05-02 13:53:36.287', '1053', false, '71e56318a0d5361d09c8c11476499d9cc8b6cb07015560368bef708493bc7cf6', 0, NULL, false, false, false, false, false, false, false, true, true, false, NULL, 'Organization', 136, false, 1);
INSERT INTO public.hfj_resource VALUES (1054, NULL, NULL, 'R4', false, '2026-05-02 13:54:29.368', '2026-05-02 13:54:29.368', '1054', true, '142553c687507d9553b039a494edae8b447586e4586e4cd96484f05ff7b8adbc', 0, NULL, false, false, false, false, false, false, false, true, true, false, NULL, 'Location', 100, false, 1);
INSERT INTO public.hfj_resource VALUES (1055, NULL, NULL, 'R4', false, '2026-05-04 15:12:02.527', '2026-05-04 15:12:02.527', '1055', false, '983b5bd73eb5c357fc1e5771f85a8dea682a0ca74797e249600ff6369649f952', 0, NULL, false, false, false, false, false, false, false, true, true, false, NULL, 'Organization', 136, false, 1);
INSERT INTO public.hfj_resource VALUES (1056, NULL, NULL, 'R4', false, '2026-05-04 15:14:46.898', '2026-05-04 15:14:46.898', '1056', true, '450bea93ea88c72d1f08715f66cb95edb02492325c55887175e63a8988f01059', 0, NULL, false, false, false, false, false, false, false, true, true, false, NULL, 'Location', 100, false, 1);
INSERT INTO public.hfj_resource VALUES (1057, NULL, NULL, 'R4', false, '2026-05-04 15:16:09.428', '2026-05-04 15:16:09.428', '1057', true, '817d27bf147b72491f69bb14400fcff430e49c152477a19a3fa74df26a8ea867', 0, NULL, false, false, false, false, false, false, false, true, true, false, NULL, 'HealthcareService', 83, false, 1);
INSERT INTO public.hfj_resource VALUES (1058, NULL, NULL, 'R4', false, '2026-05-04 16:26:54.178', '2026-05-04 16:26:54.178', '1058', false, 'fb65e038b5a084d42ee7b51728922205237777d420cf54fbd78a324fd2f6f4fd', 0, NULL, false, false, false, false, false, false, false, true, true, false, NULL, 'Organization', 136, false, 1);
INSERT INTO public.hfj_resource VALUES (1059, NULL, NULL, 'R4', false, '2026-05-04 16:27:52.94', '2026-05-04 16:27:52.94', '1059', true, '962fbf2c2c68dd5b5770bfc425be3b5c2f800507c52ef55be8c91cf368be4707', 0, NULL, false, false, false, false, false, false, false, true, true, false, NULL, 'Location', 100, false, 1);
INSERT INTO public.hfj_resource VALUES (1060, NULL, NULL, 'R4', false, '2026-05-04 16:29:03.421', '2026-05-04 16:29:03.421', '1060', true, '0343571b0f5af691c88f3167b282572b0f0d217858a46f25007a5f8469e55b22', 0, NULL, false, false, false, false, false, false, false, true, true, false, NULL, 'HealthcareService', 83, false, 1);


--
-- TOC entry 4639 (class 0 OID 19781)
-- Dependencies: 316
-- Data for Name: hfj_resource_modified; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4640 (class 0 OID 19788)
-- Dependencies: 317
-- Data for Name: hfj_resource_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hfj_resource_type VALUES (1, 'Account');
INSERT INTO public.hfj_resource_type VALUES (2, 'ActivityDefinition');
INSERT INTO public.hfj_resource_type VALUES (3, 'ActorDefinition');
INSERT INTO public.hfj_resource_type VALUES (4, 'AdministrableProductDefinition');
INSERT INTO public.hfj_resource_type VALUES (5, 'AdverseEvent');
INSERT INTO public.hfj_resource_type VALUES (6, 'AllergyIntolerance');
INSERT INTO public.hfj_resource_type VALUES (7, 'Appointment');
INSERT INTO public.hfj_resource_type VALUES (8, 'AppointmentResponse');
INSERT INTO public.hfj_resource_type VALUES (9, 'ArtifactAssessment');
INSERT INTO public.hfj_resource_type VALUES (10, 'AuditEvent');
INSERT INTO public.hfj_resource_type VALUES (11, 'Basic');
INSERT INTO public.hfj_resource_type VALUES (12, 'Binary');
INSERT INTO public.hfj_resource_type VALUES (13, 'BiologicallyDerivedProduct');
INSERT INTO public.hfj_resource_type VALUES (14, 'BiologicallyDerivedProductDispense');
INSERT INTO public.hfj_resource_type VALUES (15, 'BodySite');
INSERT INTO public.hfj_resource_type VALUES (16, 'BodyStructure');
INSERT INTO public.hfj_resource_type VALUES (17, 'Bundle');
INSERT INTO public.hfj_resource_type VALUES (18, 'CapabilityStatement');
INSERT INTO public.hfj_resource_type VALUES (19, 'CarePlan');
INSERT INTO public.hfj_resource_type VALUES (20, 'CareTeam');
INSERT INTO public.hfj_resource_type VALUES (21, 'CatalogEntry');
INSERT INTO public.hfj_resource_type VALUES (22, 'ChargeItem');
INSERT INTO public.hfj_resource_type VALUES (23, 'ChargeItemDefinition');
INSERT INTO public.hfj_resource_type VALUES (24, 'Citation');
INSERT INTO public.hfj_resource_type VALUES (25, 'Claim');
INSERT INTO public.hfj_resource_type VALUES (26, 'ClaimResponse');
INSERT INTO public.hfj_resource_type VALUES (27, 'ClinicalImpression');
INSERT INTO public.hfj_resource_type VALUES (28, 'ClinicalUseDefinition');
INSERT INTO public.hfj_resource_type VALUES (29, 'CodeSystem');
INSERT INTO public.hfj_resource_type VALUES (30, 'Communication');
INSERT INTO public.hfj_resource_type VALUES (31, 'CommunicationRequest');
INSERT INTO public.hfj_resource_type VALUES (32, 'CompartmentDefinition');
INSERT INTO public.hfj_resource_type VALUES (33, 'Composition');
INSERT INTO public.hfj_resource_type VALUES (34, 'ConceptMap');
INSERT INTO public.hfj_resource_type VALUES (35, 'Condition');
INSERT INTO public.hfj_resource_type VALUES (36, 'ConditionDefinition');
INSERT INTO public.hfj_resource_type VALUES (37, 'Conformance');
INSERT INTO public.hfj_resource_type VALUES (38, 'Consent');
INSERT INTO public.hfj_resource_type VALUES (39, 'Contract');
INSERT INTO public.hfj_resource_type VALUES (40, 'Coverage');
INSERT INTO public.hfj_resource_type VALUES (41, 'CoverageEligibilityRequest');
INSERT INTO public.hfj_resource_type VALUES (42, 'CoverageEligibilityResponse');
INSERT INTO public.hfj_resource_type VALUES (43, 'DataElement');
INSERT INTO public.hfj_resource_type VALUES (44, 'DetectedIssue');
INSERT INTO public.hfj_resource_type VALUES (45, 'Device');
INSERT INTO public.hfj_resource_type VALUES (46, 'DeviceAssociation');
INSERT INTO public.hfj_resource_type VALUES (47, 'DeviceComponent');
INSERT INTO public.hfj_resource_type VALUES (48, 'DeviceDefinition');
INSERT INTO public.hfj_resource_type VALUES (49, 'DeviceDispense');
INSERT INTO public.hfj_resource_type VALUES (50, 'DeviceMetric');
INSERT INTO public.hfj_resource_type VALUES (51, 'DeviceRequest');
INSERT INTO public.hfj_resource_type VALUES (52, 'DeviceUsage');
INSERT INTO public.hfj_resource_type VALUES (53, 'DeviceUseRequest');
INSERT INTO public.hfj_resource_type VALUES (54, 'DeviceUseStatement');
INSERT INTO public.hfj_resource_type VALUES (55, 'DiagnosticOrder');
INSERT INTO public.hfj_resource_type VALUES (56, 'DiagnosticReport');
INSERT INTO public.hfj_resource_type VALUES (57, 'DocumentManifest');
INSERT INTO public.hfj_resource_type VALUES (58, 'DocumentReference');
INSERT INTO public.hfj_resource_type VALUES (59, 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_resource_type VALUES (60, 'EligibilityRequest');
INSERT INTO public.hfj_resource_type VALUES (61, 'EligibilityResponse');
INSERT INTO public.hfj_resource_type VALUES (62, 'Encounter');
INSERT INTO public.hfj_resource_type VALUES (63, 'EncounterHistory');
INSERT INTO public.hfj_resource_type VALUES (64, 'Endpoint');
INSERT INTO public.hfj_resource_type VALUES (65, 'EnrollmentRequest');
INSERT INTO public.hfj_resource_type VALUES (66, 'EnrollmentResponse');
INSERT INTO public.hfj_resource_type VALUES (67, 'EpisodeOfCare');
INSERT INTO public.hfj_resource_type VALUES (68, 'EventDefinition');
INSERT INTO public.hfj_resource_type VALUES (69, 'Evidence');
INSERT INTO public.hfj_resource_type VALUES (70, 'EvidenceReport');
INSERT INTO public.hfj_resource_type VALUES (71, 'EvidenceVariable');
INSERT INTO public.hfj_resource_type VALUES (72, 'ExampleScenario');
INSERT INTO public.hfj_resource_type VALUES (73, 'ExpansionProfile');
INSERT INTO public.hfj_resource_type VALUES (74, 'ExplanationOfBenefit');
INSERT INTO public.hfj_resource_type VALUES (75, 'FamilyMemberHistory');
INSERT INTO public.hfj_resource_type VALUES (76, 'Flag');
INSERT INTO public.hfj_resource_type VALUES (77, 'FormularyItem');
INSERT INTO public.hfj_resource_type VALUES (78, 'GenomicStudy');
INSERT INTO public.hfj_resource_type VALUES (79, 'Goal');
INSERT INTO public.hfj_resource_type VALUES (80, 'GraphDefinition');
INSERT INTO public.hfj_resource_type VALUES (81, 'Group');
INSERT INTO public.hfj_resource_type VALUES (82, 'GuidanceResponse');
INSERT INTO public.hfj_resource_type VALUES (83, 'HealthcareService');
INSERT INTO public.hfj_resource_type VALUES (84, 'ImagingManifest');
INSERT INTO public.hfj_resource_type VALUES (85, 'ImagingObjectSelection');
INSERT INTO public.hfj_resource_type VALUES (86, 'ImagingSelection');
INSERT INTO public.hfj_resource_type VALUES (87, 'ImagingStudy');
INSERT INTO public.hfj_resource_type VALUES (88, 'Immunization');
INSERT INTO public.hfj_resource_type VALUES (89, 'ImmunizationEvaluation');
INSERT INTO public.hfj_resource_type VALUES (90, 'ImmunizationRecommendation');
INSERT INTO public.hfj_resource_type VALUES (91, 'ImplementationGuide');
INSERT INTO public.hfj_resource_type VALUES (92, 'Ingredient');
INSERT INTO public.hfj_resource_type VALUES (93, 'InsurancePlan');
INSERT INTO public.hfj_resource_type VALUES (94, 'InventoryItem');
INSERT INTO public.hfj_resource_type VALUES (95, 'InventoryReport');
INSERT INTO public.hfj_resource_type VALUES (96, 'Invoice');
INSERT INTO public.hfj_resource_type VALUES (97, 'Library');
INSERT INTO public.hfj_resource_type VALUES (98, 'Linkage');
INSERT INTO public.hfj_resource_type VALUES (99, 'List');
INSERT INTO public.hfj_resource_type VALUES (100, 'Location');
INSERT INTO public.hfj_resource_type VALUES (101, 'ManufacturedItemDefinition');
INSERT INTO public.hfj_resource_type VALUES (102, 'Measure');
INSERT INTO public.hfj_resource_type VALUES (103, 'MeasureReport');
INSERT INTO public.hfj_resource_type VALUES (104, 'Media');
INSERT INTO public.hfj_resource_type VALUES (105, 'Medication');
INSERT INTO public.hfj_resource_type VALUES (106, 'MedicationAdministration');
INSERT INTO public.hfj_resource_type VALUES (107, 'MedicationDispense');
INSERT INTO public.hfj_resource_type VALUES (108, 'MedicationKnowledge');
INSERT INTO public.hfj_resource_type VALUES (109, 'MedicationOrder');
INSERT INTO public.hfj_resource_type VALUES (110, 'MedicationRequest');
INSERT INTO public.hfj_resource_type VALUES (111, 'MedicationStatement');
INSERT INTO public.hfj_resource_type VALUES (112, 'MedicinalProduct');
INSERT INTO public.hfj_resource_type VALUES (113, 'MedicinalProductAuthorization');
INSERT INTO public.hfj_resource_type VALUES (114, 'MedicinalProductContraindication');
INSERT INTO public.hfj_resource_type VALUES (115, 'MedicinalProductDefinition');
INSERT INTO public.hfj_resource_type VALUES (116, 'MedicinalProductIndication');
INSERT INTO public.hfj_resource_type VALUES (117, 'MedicinalProductIngredient');
INSERT INTO public.hfj_resource_type VALUES (118, 'MedicinalProductInteraction');
INSERT INTO public.hfj_resource_type VALUES (119, 'MedicinalProductManufactured');
INSERT INTO public.hfj_resource_type VALUES (120, 'MedicinalProductPackaged');
INSERT INTO public.hfj_resource_type VALUES (121, 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_resource_type VALUES (122, 'MedicinalProductUndesirableEffect');
INSERT INTO public.hfj_resource_type VALUES (123, 'MessageDefinition');
INSERT INTO public.hfj_resource_type VALUES (124, 'MessageHeader');
INSERT INTO public.hfj_resource_type VALUES (125, 'MolecularSequence');
INSERT INTO public.hfj_resource_type VALUES (126, 'NamingSystem');
INSERT INTO public.hfj_resource_type VALUES (127, 'NutritionIntake');
INSERT INTO public.hfj_resource_type VALUES (128, 'NutritionOrder');
INSERT INTO public.hfj_resource_type VALUES (129, 'NutritionProduct');
INSERT INTO public.hfj_resource_type VALUES (130, 'Observation');
INSERT INTO public.hfj_resource_type VALUES (131, 'ObservationDefinition');
INSERT INTO public.hfj_resource_type VALUES (132, 'OperationDefinition');
INSERT INTO public.hfj_resource_type VALUES (133, 'OperationOutcome');
INSERT INTO public.hfj_resource_type VALUES (134, 'Order');
INSERT INTO public.hfj_resource_type VALUES (135, 'OrderResponse');
INSERT INTO public.hfj_resource_type VALUES (136, 'Organization');
INSERT INTO public.hfj_resource_type VALUES (137, 'OrganizationAffiliation');
INSERT INTO public.hfj_resource_type VALUES (138, 'PackagedProductDefinition');
INSERT INTO public.hfj_resource_type VALUES (139, 'Parameters');
INSERT INTO public.hfj_resource_type VALUES (140, 'Patient');
INSERT INTO public.hfj_resource_type VALUES (141, 'PaymentNotice');
INSERT INTO public.hfj_resource_type VALUES (142, 'PaymentReconciliation');
INSERT INTO public.hfj_resource_type VALUES (143, 'Permission');
INSERT INTO public.hfj_resource_type VALUES (144, 'Person');
INSERT INTO public.hfj_resource_type VALUES (145, 'PlanDefinition');
INSERT INTO public.hfj_resource_type VALUES (146, 'Practitioner');
INSERT INTO public.hfj_resource_type VALUES (147, 'PractitionerRole');
INSERT INTO public.hfj_resource_type VALUES (148, 'Procedure');
INSERT INTO public.hfj_resource_type VALUES (149, 'ProcedureRequest');
INSERT INTO public.hfj_resource_type VALUES (150, 'ProcessRequest');
INSERT INTO public.hfj_resource_type VALUES (151, 'ProcessResponse');
INSERT INTO public.hfj_resource_type VALUES (152, 'Provenance');
INSERT INTO public.hfj_resource_type VALUES (153, 'Questionnaire');
INSERT INTO public.hfj_resource_type VALUES (154, 'QuestionnaireResponse');
INSERT INTO public.hfj_resource_type VALUES (155, 'ReferralRequest');
INSERT INTO public.hfj_resource_type VALUES (156, 'RegulatedAuthorization');
INSERT INTO public.hfj_resource_type VALUES (157, 'RelatedPerson');
INSERT INTO public.hfj_resource_type VALUES (158, 'RequestGroup');
INSERT INTO public.hfj_resource_type VALUES (159, 'RequestOrchestration');
INSERT INTO public.hfj_resource_type VALUES (160, 'Requirements');
INSERT INTO public.hfj_resource_type VALUES (161, 'ResearchDefinition');
INSERT INTO public.hfj_resource_type VALUES (162, 'ResearchElementDefinition');
INSERT INTO public.hfj_resource_type VALUES (163, 'ResearchStudy');
INSERT INTO public.hfj_resource_type VALUES (164, 'ResearchSubject');
INSERT INTO public.hfj_resource_type VALUES (165, 'RiskAssessment');
INSERT INTO public.hfj_resource_type VALUES (166, 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_resource_type VALUES (167, 'Schedule');
INSERT INTO public.hfj_resource_type VALUES (168, 'SearchParameter');
INSERT INTO public.hfj_resource_type VALUES (169, 'Sequence');
INSERT INTO public.hfj_resource_type VALUES (170, 'ServiceDefinition');
INSERT INTO public.hfj_resource_type VALUES (171, 'ServiceRequest');
INSERT INTO public.hfj_resource_type VALUES (172, 'Slot');
INSERT INTO public.hfj_resource_type VALUES (173, 'Specimen');
INSERT INTO public.hfj_resource_type VALUES (174, 'SpecimenDefinition');
INSERT INTO public.hfj_resource_type VALUES (175, 'StructureDefinition');
INSERT INTO public.hfj_resource_type VALUES (176, 'StructureMap');
INSERT INTO public.hfj_resource_type VALUES (177, 'Subscription');
INSERT INTO public.hfj_resource_type VALUES (178, 'SubscriptionStatus');
INSERT INTO public.hfj_resource_type VALUES (179, 'SubscriptionTopic');
INSERT INTO public.hfj_resource_type VALUES (180, 'Substance');
INSERT INTO public.hfj_resource_type VALUES (181, 'SubstanceDefinition');
INSERT INTO public.hfj_resource_type VALUES (182, 'SubstanceNucleicAcid');
INSERT INTO public.hfj_resource_type VALUES (183, 'SubstancePolymer');
INSERT INTO public.hfj_resource_type VALUES (184, 'SubstanceProtein');
INSERT INTO public.hfj_resource_type VALUES (185, 'SubstanceReferenceInformation');
INSERT INTO public.hfj_resource_type VALUES (186, 'SubstanceSourceMaterial');
INSERT INTO public.hfj_resource_type VALUES (187, 'SubstanceSpecification');
INSERT INTO public.hfj_resource_type VALUES (188, 'SupplyDelivery');
INSERT INTO public.hfj_resource_type VALUES (189, 'SupplyRequest');
INSERT INTO public.hfj_resource_type VALUES (190, 'Task');
INSERT INTO public.hfj_resource_type VALUES (191, 'TerminologyCapabilities');
INSERT INTO public.hfj_resource_type VALUES (192, 'TestPlan');
INSERT INTO public.hfj_resource_type VALUES (193, 'TestReport');
INSERT INTO public.hfj_resource_type VALUES (194, 'TestScript');
INSERT INTO public.hfj_resource_type VALUES (195, 'Transport');
INSERT INTO public.hfj_resource_type VALUES (196, 'ValueSet');
INSERT INTO public.hfj_resource_type VALUES (197, 'VerificationResult');
INSERT INTO public.hfj_resource_type VALUES (198, 'VisionPrescription');


--
-- TOC entry 4641 (class 0 OID 19793)
-- Dependencies: 318
-- Data for Name: hfj_revinfo; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4642 (class 0 OID 19798)
-- Dependencies: 319
-- Data for Name: hfj_search; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4643 (class 0 OID 19805)
-- Dependencies: 320
-- Data for Name: hfj_search_include; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4644 (class 0 OID 19810)
-- Dependencies: 321
-- Data for Name: hfj_search_result; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4645 (class 0 OID 19815)
-- Dependencies: 322
-- Data for Name: hfj_spidx_coords; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4646 (class 0 OID 19820)
-- Dependencies: 323
-- Data for Name: hfj_spidx_date; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4647 (class 0 OID 19825)
-- Dependencies: 324
-- Data for Name: hfj_spidx_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hfj_spidx_identity VALUES (1, 3996291536834913663, '_id:of-type', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2, -4027643992239405074, 'status', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (3, 1555763355647208697, 'name', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (4, -1845299098766446091, 'experimental:of-type', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (5, 1354528300729960870, 'result', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (6, -18459056080706743, 'requesting-organization', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (7, 7296959842842045436, 'telecom:of-type', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (8, -3752715313865219251, 'resource', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (9, -27826690091628155, 'successor', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (10, -5307318395234165142, '_id:of-type', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (11, -295524796622893877, '_security:of-type', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (12, -1957325048321080533, 'based-on', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (13, -5289670075014967272, 'keyword:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (14, -4855119839303297305, 'resource', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (15, -1963437547359690271, 'status:of-type', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (16, -8295105140809051493, 'context', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (17, -4638178891112719916, 'code:of-type', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (18, 116645299548472756, '_source', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (19, -3586941213417260576, 'body-site:of-type', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (20, -6813312595875470802, '_tag:of-type', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (21, -2565194370370837717, 'date', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (22, -8673349540023655670, 'category', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (23, 8346904986141256413, 'version:of-type', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (24, 8927663242081685293, 'identifier', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (25, -3801383131369123137, 'reason-reference', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (26, -2070133600585705360, '_id', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (27, 4903945520715742224, 'title', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (28, -5610025717673574277, 'context-type', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (29, -4498526961323074149, 'identifier', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (30, 248211854894104675, 'status:of-type', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (31, -5793313544770555727, 'instantiates-canonical', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (32, -4632787814886223344, 'location', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (33, -7494583687546927070, 'identifier:of-type', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (34, 3797714600629962096, '_profile', 'DeviceDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (35, -8676702171296766100, 'participant', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (36, 7734917647913487197, 'context-type:of-type', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (37, -9070334923678318489, '_tag', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (38, -6243255583039310895, '_id:of-type', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (39, -8029359316122951608, '_lastUpdated', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (40, -4925726099162895493, '_id:of-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (41, -653510238484807827, 'program', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (42, 4092867345844769879, 'appointment', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (43, -6116236853306933786, 'priority:of-type', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (44, 7210636459280515114, 'identifier:of-type', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (45, -446830280871105978, 'software', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (46, -3550563504097603002, '_security', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (47, 5020796344704786895, '_security', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (48, -8793829188569818962, 'type', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (49, -4025372684728109500, 'performer', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (50, 10597097314556852, 'context-quantity', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (51, 3716139793172890023, '_id', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (52, -871197374437745001, 'status', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (53, -8870209812555738076, '_security', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (54, -1111435419979335149, 'facility', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (55, -8146619804869635952, 'date', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (56, -2401832192288555789, 'identifier:of-type', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (57, 8477177146423250968, 'status', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (58, 1538785246860324983, 'subject', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (59, 3872216908525606917, '_tag:of-type', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (60, 7274577965774417580, 'receiver', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (61, 8603905921108348331, 'type', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (62, -8926269353652865026, 'address', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (63, -4211774291246712664, '_source', 'SubstanceSourceMaterial');
INSERT INTO public.hfj_spidx_identity VALUES (64, -117187000259012431, 'name', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (65, -1388539049805534064, 'performer', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (66, -836940912899371326, '_tag:of-type', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (67, 734799321578519916, '_security', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (68, -14493362523075060, 'category', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (69, -4766391362901734149, '_profile', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (70, -1687440898365822918, 'target', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (71, 7173684325484574600, 'address-city', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (72, -6212878417384668784, '_tag', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (73, 6161697834631502907, 'finding-code:of-type', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (74, 7509705519412699525, 'url', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (75, -1694234295043955790, 'status:of-type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (76, 3870800889003211950, '_tag', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (77, 4475063458442136558, 'endpoint', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (78, -7087262627337143672, 'context', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (79, -2994662128189993332, '_source', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (80, 5702663522099701131, 'base', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (81, 1140946999366125200, 'publisher', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (82, -752444773170310097, 'effective', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (83, 6836928211918621083, 'contenttype:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (84, 3419276801384802000, 'status', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (85, 4839883707803066041, '_id:of-type', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (86, -5949946664766951259, 'publisher', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (87, -8726802802291724869, 'publisher', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (88, 8635330403800996086, '_lastUpdated', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (89, 2479326657120457517, '_security:of-type', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (90, -47096425814438768, '_source', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (91, 5119828810776094679, 'identifier', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (92, 1207325209502537486, '_id:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (93, -4540876323114271019, 'status:of-type', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (94, -3963456768486289727, 'status', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (95, 1635555425133118258, 'email', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (96, -705954181268410223, '_profile', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (97, 740355139480839733, 'status', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (98, 6024987971950663720, '_profile', 'MedicinalProductPackaged');
INSERT INTO public.hfj_spidx_identity VALUES (99, -2423301116214471913, 'subject', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (100, 1795770421435388288, 'telecom', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (101, 3985930600206539827, 'author', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (102, -3435606094736193476, 'identifier:of-type', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (103, 7752966567322419240, '_tag', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (104, 506645789844663069, '_security', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (105, 494223416045896516, '_source', 'SubstanceNucleicAcid');
INSERT INTO public.hfj_spidx_identity VALUES (106, -8584367015995639912, 'activity-reference', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (107, 3125245158524421750, 'date', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (108, 2779975623370181039, 'group-identifier', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (109, -2302145188537027116, '_tag', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (110, -937461159256446943, 'responsible', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (111, -3403606423101028366, '_profile', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (112, 2040783817827701664, '_profile', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (113, 7129999157149636889, '_lastUpdated', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (114, 4400382438859235492, 'incoming-referral', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (115, 4550596607159903312, 'part-status:of-type', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (116, 7875267478982667679, 'language', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (117, -7759957852288539560, 'service-category:of-type', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (118, 845008778505089897, '_tag:of-type', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (119, -316154034986509458, 'name', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (120, 1492367578042901097, 'context:of-type', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (121, 3909251310443951259, 'context-type:of-type', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (122, -1823579633432952345, '_source', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (123, 8428041514507513509, 'code:of-type', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (124, 8659349343101363366, '_profile', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (125, 2722003841343900702, 'actor', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (126, -6563802239459487720, 'url', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (127, -3078467815667571850, 'context-type', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (128, -1845891447482909065, 'seriousness', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (129, 2513840474318682873, 'identifier', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (130, 6934701819100910907, '_profile', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (131, -4519460405349491687, 'publisher', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (132, -6712960439174456766, '_profile', 'SubstancePolymer');
INSERT INTO public.hfj_spidx_identity VALUES (133, 6509806593007705366, '_lastUpdated', 'SubstanceReferenceInformation');
INSERT INTO public.hfj_spidx_identity VALUES (134, 5178605508075409480, 'request', 'EnrollmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (135, 5152962946740337582, 'facility', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (136, 7142149569103085150, '_tag:of-type', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (137, -4066995061187482166, 'topic:of-type', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (138, -5531875548725680473, 'outcome:of-type', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (139, 5061911636065024656, 'manifestation', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (140, -2432415196244159089, '_tag', 'SubstanceSpecification');
INSERT INTO public.hfj_spidx_identity VALUES (141, 8029180228013731493, '_security:of-type', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (142, 7967643225516488536, '_security', 'ObservationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (143, 8803254958834162279, '_security', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (144, -7000960520703644624, 'active', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (145, -4734856827164228232, 'location', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (146, -8411219284583686940, '_security', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (147, -5290105635327009298, 'identifier', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (148, -8658861995411873558, 'status:of-type', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (149, 6218902818141746404, '_id', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (150, -2743741805871657835, 'based-on', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (151, -6172159706983674143, '_id:of-type', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (152, -1566668562821769013, 'service-type:of-type', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (153, -7182723964168661174, 'type:of-type', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (154, 3003411935858124258, 'code:of-type', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (155, 5753126918773554440, 'priority:of-type', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (156, -3464761526993915949, 'abatement-string', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (157, -3819960604438302455, '_lastUpdated', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (158, -6904283625115633846, '_id:of-type', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (159, -8974486738176566088, '_source', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (160, -7048637615223938876, '_lastUpdated', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (161, 3372961400487993574, '_profile', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (162, 185285925950587316, '_security', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (163, -5371663801521722987, 'participant-type', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (164, -2052345944035114611, 'status:of-type', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (165, 8045589041540849482, '_security', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (166, -5113024383064136636, 'address-state', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (167, 3055572707268981470, 'practitioner', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (168, 4204914202734720058, 'author', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (169, 5299169953604282331, '_security', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (170, 6750975586043316724, 'date', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (171, 7775821839604921595, '_security', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (172, 8480609597716713424, '_lastUpdated', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (173, 8132207542498870438, '_tag:of-type', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (174, -5104377249492242659, 'encounter', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (175, -7946411630247364444, 'context:of-type', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (176, -8108401393659484287, 'jurisdiction', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (177, 4521723271894019583, '_id', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (178, 8157917882792413502, '_lastUpdated', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (179, -4380239892396318927, 'depends-on', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (180, -7909035406865068960, 'participant', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (181, -6653791929401159740, 'identifier:of-type', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (182, -6114459181857550689, '_lastUpdated', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (183, 2205050921344654109, 'identifier', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (184, 5475233972061471888, '_lastUpdated', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (185, -8945934307015099302, '_tag', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (186, 6948490533401939566, '_tag', 'MedicinalProductManufactured');
INSERT INTO public.hfj_spidx_identity VALUES (187, 7945900359821591066, '_tag', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (188, 6786517132958248595, 'modality:of-type', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (189, -3124535772006970453, 'status:of-type', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (190, 2213028111784799949, '_tag', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (191, -2326833945429148161, 'context-type:of-type', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (192, -4494989377711591703, '_lastUpdated', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (193, -8658836622050993797, 'instantiates-uri', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (194, -8158491146652832755, 'date', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (195, 899696004278908355, 'patient', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (196, -1809015901082096532, '_id:of-type', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (197, 3259717474638103789, 'version:of-type', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (198, -64611896094119900, 'specialty:of-type', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (199, -7083120953946875518, '_tag', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (200, -2152130728837130691, 'code:of-type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (201, -3318138733690418030, 'identifier:of-type', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (202, -915571691382528416, 'goal', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (203, 9164101430391103344, 'identifier', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (204, 1171145862479156861, 'code:of-type', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (205, -5611556936084232567, '_id:of-type', 'BiologicallyDerivedProduct');
INSERT INTO public.hfj_spidx_identity VALUES (206, -3252485973760046336, 'identifier:of-type', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (207, -5712187056565919838, 'status', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (208, -8319569141431058896, '_source', 'BiologicallyDerivedProduct');
INSERT INTO public.hfj_spidx_identity VALUES (209, -2862676864567890043, '_security', 'SubstanceNucleicAcid');
INSERT INTO public.hfj_spidx_identity VALUES (210, -6061088770986561341, 'encounter', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (211, -1765658486370878141, 'address-country', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (212, 2587163624667515293, '_id:of-type', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (213, -1700857627371223144, '_profile', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (214, -7744874942958610201, '_security:of-type', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (215, 8455368470282015672, 'context-type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (216, 1061523578487418571, 'patient', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (217, 5623047278183230706, '_source', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (218, 4301795247340248185, 'endpoint', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (219, 5243791755929780825, '_profile', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (220, -7457632253221050086, 'reason-code', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (333, -3919589008801767121, '_tag', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (221, -3883507826247351265, '_tag:of-type', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (222, -1499480291559293339, '_security:of-type', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (223, -8465257008235247878, 'oraldiet', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (224, -6888451397728926112, 'identifier', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (225, 4357376269093117170, '_security', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (226, -1042235468546757879, '_tag:of-type', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (227, -4805515592533516783, 'status', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (228, 4969076054626794348, 'based-on', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (229, -4849422490510699969, '_profile', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (230, -7422867579268811398, 'identifier', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (231, 7957495109208832424, 'code', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (232, -3139871815730160064, 'quantity', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (233, -7083560773288773703, 'status', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (234, -2431853165868552094, '_source', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (235, 5852831865819199650, 'issuer', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (236, -5910544316325964640, 'url', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (237, -303968749170436843, '_security', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (238, 7908915107291765582, 'context-type', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (239, 375760644918529966, 'jurisdiction:of-type', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (240, 7472370274018759091, 'event:of-type', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (241, -4610340718171317713, 'context-type:of-type', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (242, -7761745913389084512, '_id', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (243, -8196357471419616350, 'confidentiality', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (244, -3868783927391535462, 'notes', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (245, -858881339519487969, 'location', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (246, -4778818447331400021, '_id:of-type', 'DeviceUseStatement');
INSERT INTO public.hfj_spidx_identity VALUES (247, 2466522746818544572, 'identifier', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (248, 5522871932089566237, 'organization', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (249, -7114104584522289123, 'version', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (250, 786036248711061061, 'depends-on', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (251, -6201755358459748107, 'section', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (252, 7702618659184068261, 'identifier', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (253, -1632369643904949331, '_source', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (254, 8137556269776876824, '_security:of-type', 'Linkage');
INSERT INTO public.hfj_spidx_identity VALUES (255, 4549163257419730285, '_profile', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (256, 5381467719443288838, 'context', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (257, -8999783602779128351, 'identifier', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (258, -7071754869764078893, 'context-quantity', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (259, 5977687704967142146, '_source', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (260, -8825521993025585870, '_security:of-type', 'MedicinalProduct');
INSERT INTO public.hfj_spidx_identity VALUES (261, 7014131095020983941, '_lastUpdated', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (262, 167861647791750501, 'gender:of-type', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (263, -2400738530947303070, 'patient', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (264, -808365097195948358, 'partof', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (265, 4586606744857791503, '_id', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (266, 8350848194533027074, 'name', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (267, -5978229300634289543, 'url', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (268, -5695680918861328556, 'encounter', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (269, -5501151251895172555, '_profile', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (270, -9194943849224510222, 'disposition', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (271, -4935771067377265889, 'type:of-type', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (272, 353405812737798920, 'date', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (273, 8306201705814869104, 'identifier:of-type', 'DeviceUseStatement');
INSERT INTO public.hfj_spidx_identity VALUES (274, 1172496041139890319, '_id', 'Binary');
INSERT INTO public.hfj_spidx_identity VALUES (275, 448346365559636876, 'form', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (276, -435960312555265288, 'service-type:of-type', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (277, -5282796113599685434, 'group-identifier:of-type', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (278, -3735953998871322867, '_id:of-type', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (279, -2226819740018180641, 'status:of-type', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (280, -4317769737247229775, '_tag:of-type', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (281, 1609472147805460346, 'context:of-type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (282, -347270844687740153, '_security', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (283, -2280984578959187297, 'topic:of-type', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (284, -1521648691062090600, '_id', 'ObservationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (285, -7418069358587522884, 'url', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (286, -1004329934989173707, 'context:of-type', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (287, 5627107277392970489, '_source', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (288, 7206155870749214244, '_security:of-type', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (289, 9146071828188801786, 'address-country', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (290, -83318499392370109, 'created', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (291, 6662142137346532238, '_tag:of-type', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (292, 8987844939685567762, 'identifier', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (293, 6783426681278885810, '_security', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (294, -5132598973244812506, 'criticality', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (295, 8785149070252432096, '_security:of-type', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (296, -1048230749066140892, 'created', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (297, -3809199379171216103, 'effective', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (298, 1691133150457308545, '_profile', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (299, 8676094177019917420, 'context:of-type', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (300, -6430928270783787174, 'jurisdiction:of-type', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (301, 8704177642151923546, 'enterer', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (302, -1087679638538809218, 'service-category:of-type', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (303, 2161467483370934246, '_lastUpdated', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (304, -8093481599289354752, '_id', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (305, -3381471673027431013, 'status-reason:of-type', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (306, -1056420059094456307, 'identifier', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (307, 8911183014462611800, 'name', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (308, 6204742320999478935, 'identifier', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (309, -4961924127550622911, '_security:of-type', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (310, 8968831240550277547, '_security', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (311, -7981370237780818477, 'type:of-type', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (312, 8491084613134702815, '_tag:of-type', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (313, -4043438278233403952, 'name', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (314, -7376849905152195732, 'active', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (315, 1059695520939864224, 'onset-info', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (316, 8116483357904418216, 'priority', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (317, -93716862334079373, 'author', 'Linkage');
INSERT INTO public.hfj_spidx_identity VALUES (318, -5114874200454653456, 'context-type:of-type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (319, -5184198535463218028, 'context-quantity', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (320, 2340104261194441513, '_tag', 'DeviceDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (321, -966225171813841966, 'focus:of-type', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (322, 6239836903405276466, '_lastUpdated', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (323, 8292400728050673118, 'specialty:of-type', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (324, 3731685984730886323, 'address-postalcode', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (325, 2760318278999305406, '_tag:of-type', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (326, 4248934594953965954, 'version:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (327, -4931645560625616953, 'type', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (328, -4018452824482046296, '_id', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (329, 572026258063466956, 'encounter', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (330, 2530632251273967392, 'phone:of-type', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (331, 3324303649315339949, 'container-id', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (332, -5810636579741520662, '_tag', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (334, -2645880597763503087, '_security:of-type', 'MedicinalProductPackaged');
INSERT INTO public.hfj_spidx_identity VALUES (335, -4215394891228465286, '_source', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (336, 2468637295525292760, 'facility:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (337, 9175185781830461618, 'context:of-type', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (338, 2385297409738781287, 'container-id:of-type', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (339, -7533943853970611242, 'given', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (340, -9151398550344965945, '_lastUpdated', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (341, -2153300690444496366, 'subject', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (342, -1682725928452237743, '_tag', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (343, -8302347179276466775, 'medication', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (344, -4593458576009870100, '_tag:of-type', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (345, 5796900917438384119, 'start:of-type', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (346, -8998943343771057114, '_profile', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (347, -1419919308808608459, 'patient', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (348, 6573332073520525947, 'outcome:of-type', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (349, 7592689107245509544, 'appointment', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (350, -7389629923557339100, 'class-type', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (351, -778435420789921760, '_id', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (352, 6827792128454970868, 'context-quantity', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (353, -481322366208111096, '_tag:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (354, 6240250091502484002, 'form:of-type', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (355, -712148835276084455, 'identifier:of-type', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (356, 9010472821046170563, '_id', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (357, 2299628306710415242, 'performing-organization', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (358, -1720498291353497717, 'patient', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (359, -367355869682674932, '_security', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (360, -9206699520595654203, 'context-type:of-type', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (361, -7195386376646741227, 'telecom:of-type', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (362, -1010051568988311438, 'jurisdiction', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (363, -6447436552324430446, 'identifier:of-type', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (364, 3337318147979869420, '_security:of-type', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (365, -1126511406427404125, 'totalnet', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (366, -2575070668397007000, 'description', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (367, 6408766732321122470, 'payment-issuer', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (368, -6417046773430757645, 'severity:of-type', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (369, -3658298876224279899, 'subscriber', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (370, 5165563732154849194, 'reason-code:of-type', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (371, -8663088371240231474, 'study', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (372, 5599884137969483047, 'subtype:of-type', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (373, -1769762262059595894, 'identifier', 'MedicinalProductPackaged');
INSERT INTO public.hfj_spidx_identity VALUES (374, 1815195733462597226, '_profile', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (375, 2813097068797023441, 'component-value-quantity', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (376, -6751730767644877072, '_id:of-type', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (377, 1043662620932010634, '_profile', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (378, 8663165993193529938, '_id', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (379, -7143300552925705902, 'description', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (380, -9001951581294007441, 'component-code', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (381, 7042854345129478717, 'context-type:of-type', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (382, 3222319922956078430, '_profile', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (383, -2117428012517664771, '_lastUpdated', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (384, 928315508562614984, '_tag', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (385, 1930453267351734194, '_security:of-type', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (386, 7650522432870170964, 'onset-date', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (387, -8475884509695991683, 'action', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (388, 8674313455496583307, 'effective', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (389, 5472221568752158025, 'predecessor', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (390, -9141631366162375601, '_id', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (391, -4959033441274218903, '_id:of-type', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (392, -5231091499773263516, 'jurisdiction:of-type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (393, 9055218183852468960, 'status', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (394, -4610903970136823204, '_tag:of-type', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (395, -6510162892827699084, 'topic:of-type', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (396, -4217124604247702748, 'component-data-absent-reason', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (397, -4658912786533972898, 'altid', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (398, 5029620721527793321, 'patient', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (399, -2164259403829978360, '_security', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (400, -6401775237493835094, '_id:of-type', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (401, 7514514955275102443, 'organization', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (402, -6830880778331079674, 'request', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (403, 1030063728518341174, 'version:of-type', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (404, 5829411873271765940, '_lastUpdated', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (405, -9206109904305422614, '_security', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (406, -75437940949424182, 'encounter', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (407, -2803359719047244527, 'timestamp', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (408, 1152449910153585527, 'security-label:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (409, -5505042700833200246, 'link', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (410, -6066562458961101821, 'category', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (411, -6663622363493391267, '_source', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (412, -6192627623751712720, 'status', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (413, 6503538687575583627, 'instantiates-uri', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (414, 7124466681675235056, 'date', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (415, -8838429504250768542, 'site', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (416, -4112806194239350785, 'identifier:of-type', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (417, -381158878962040063, '_tag:of-type', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (418, -40618262086202962, 'type:of-type', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (419, -5910000115170465630, 'patient', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (420, -6584762238273986647, '_source', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (421, 6078630968718773772, '_profile', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (422, -3168782872321936387, 'account', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (423, -6421737985096372263, 'jurisdiction', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (424, -3247809165420221653, '_tag:of-type', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (425, -4822971913963753259, 'publisher', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (426, 5025158104759528084, '_profile', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (427, 676975771994384414, 'version', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (428, -5168960371889642235, 'medication', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (429, -7007875721319427108, 'target-disease:of-type', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (430, -1645562038228650176, '_tag:of-type', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (431, 8353223099430813441, '_id', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (432, 6827925954527266588, '_lastUpdated', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (433, -2770606928383515470, 'kind', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (434, -1277468945029992822, 'security-service:of-type', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (435, 5003487708805370474, 'kind:of-type', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (436, 4882767999479689769, '_tag', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (437, 4851677924361081287, '_security', 'SubstanceSpecification');
INSERT INTO public.hfj_spidx_identity VALUES (438, -595656504018863094, 'status', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (439, 313981564462261494, 'subdetail-udi', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (440, -63694537589302753, 'publisher', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (441, 6665679997429223145, '_security:of-type', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (442, -6145890556075368221, 'identifier', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (443, -7085142396413195375, '_security:of-type', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (444, -3275805653348210589, 'device', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (445, 3921159557754634281, 'subject', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (446, 6749585889705212394, '_id', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (447, -2814975325213481192, '_source', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (448, -5235515866143816754, '_security:of-type', 'MedicinalProductInteraction');
INSERT INTO public.hfj_spidx_identity VALUES (449, 353488174990907862, '_source', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (450, -7967313359593892616, 'version:of-type', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (451, 98223305672698772, 'status:of-type', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (452, -5962832523839950062, 'context-quantity', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (453, -4652927015009101714, 'supplement', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (454, -6820539148965652542, 'context-type:of-type', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (455, 8696363578663459786, 'dose-status', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (456, -4215459521187885559, 'version', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (457, 5178193581768055581, '_security:of-type', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (458, 744429128765260965, 'procedure-udi', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (459, -8350080280369134441, '_id:of-type', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (460, 5606350388372648267, 'status', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (461, 769923470700568731, '_id:of-type', 'SubstanceReferenceInformation');
INSERT INTO public.hfj_spidx_identity VALUES (462, -5067372159316333190, 'target:of-type', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (463, -6420653225762330814, 'topic:of-type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (464, -90223512666696277, '_id:of-type', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (465, -1273164770320086643, 'context-quantity', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (466, 3063098815331713318, 'context-type:of-type', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (467, -2453474315511220794, 'category:of-type', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (468, 2519375281902683517, '_id:of-type', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (469, 7290028227084566173, '_profile', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (470, -6375645204559168536, '_source', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (471, 6819744404352236502, 'supplements', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (472, -4917588712407353880, 'identifier', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (473, -7537924011629602867, '_tag', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (474, -5792478782827277190, 'start', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (475, -4170922398562785906, '_security:of-type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (476, -1281156671899552405, 'managing-entity', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (477, -3602571406591596002, 'agent', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (478, -8172393470999261704, 'url', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (479, -3220135936911583339, '_tag:of-type', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (480, -455395404369386574, 'birthdate', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (481, 1400670882567002893, '_profile', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (482, 2863708964241658438, 'context-type', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (483, -5028858164037778239, 'status', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (484, -7696948377463088716, '_security', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (485, 3958412281770008849, '_tag', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (486, 8936106284749470848, '_profile', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (487, 513580787492719009, '_id', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (488, -2846234419338379328, 'component-data-absent-reason:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (489, -5635072648409203980, '_lastUpdated', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (490, -1597275184074401973, 'identifier', 'EnrollmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (491, -100788724837579362, 'parent', 'DeviceDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (492, 7762341225649470251, '_security:of-type', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (493, 1424439470203709176, 'type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (494, 1582667864618338666, 'identifier', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (495, -7315999236718913075, 'component', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (496, 7238408787501979787, 'date', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (497, 935830480878797434, '_tag:of-type', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (498, 2700129653413588808, 'id-type', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (499, 4259844997393679895, 'clinical-status:of-type', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (500, 7710165599370854542, '_tag:of-type', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (501, -7362258092033674331, 'category', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (502, -8353495410778547416, 'patient', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (503, -6140159707496603307, '_tag', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (504, 3143519397114534070, 'enterer', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (505, 119933305325641492, 'target-disease', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (506, 3336048891381803012, 'status:of-type', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (507, -8446917958222688268, 'subject', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (508, -7393004165912298498, 'identifier:of-type', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (509, -7273869863529845853, '_id', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (510, 8721632803737011027, 'status:of-type', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (511, -4459903356459091300, 'keyword:of-type', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (512, -7287363187858373164, 'context-quantity', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (513, 4047597109624005041, 'version:of-type', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (514, -8804877624405007990, '_id:of-type', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (515, 1939936443534777348, 'classification-type:of-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (516, -2690579252840400877, 'identifier', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (517, 1590949468262593963, '_tag:of-type', 'OperationOutcome');
INSERT INTO public.hfj_spidx_identity VALUES (518, 8491913195557678013, 'url', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (519, 576376762459355, 'code:of-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (520, 371148684254150644, '_tag:of-type', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (521, -8912776495399419600, 'telecom:of-type', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (522, -358652145769398928, '_id:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (523, -6327123690835397709, '_security:of-type', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (524, 6264296974198323316, '_profile', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (525, -7006743804769086169, 'instantiates-uri', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (526, -6357353044024306398, 'identifier:of-type', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (527, 7732772475369838403, 'phonetic', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (528, -1009090886127635854, 'subject', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (529, -2524160766646944461, 'version:of-type', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (530, -8779592238733069274, '_id', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (531, 4847735085441125926, '_id', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (532, -7595206788286244526, '_security', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (533, 4103501230705355572, '_id:of-type', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (534, 7242057024515567958, 'location', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (535, -4334192107424058189, 'patient', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (536, -6569287734650595488, 'base-path:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (537, 5060976353311533603, 'successor', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (538, 2040343757438675115, '_source', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (539, 8597243977014798653, 'site', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (540, 6686661083058523708, 'operational-status', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (541, -3911482699399797062, 'name', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (542, 4542724447110263727, 'primary-organization', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (543, -2728415472518641823, 'subject', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (544, -8581543324949426700, 'body-site', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (545, -7084836439982555794, '_id', 'SubstancePolymer');
INSERT INTO public.hfj_spidx_identity VALUES (546, 4980953371026965605, 'author', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (547, 8105104190160015933, 'context', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (548, -6531967638941169961, 'identifier', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (549, 5594753894906718227, 'publisher', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (550, 3618704560406393259, 'abatement-date', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (551, 8632642753171585960, 'result', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (552, -2652676965866220602, 'source', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (553, -3073553357781091080, '_source', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (554, 5776879827537904169, 'patient', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (555, -493414190343827708, 'context-quantity', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (556, 4133873500006977056, 'totalgross', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (557, -1049879100077826548, 'issued', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (558, -2591848138589987488, 'identifier', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (559, 1759663523742937359, 'email:of-type', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (560, -5966192676598707574, 'identifier:of-type', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (561, -2526436175960976812, '_tag', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (562, 1426355472440386149, '_tag', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (563, 4751824290203164539, '_source', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (564, 4883621205396889681, '_tag:of-type', 'CatalogEntry');
INSERT INTO public.hfj_spidx_identity VALUES (565, -4940688274865944890, '_id:of-type', 'SubstanceNucleicAcid');
INSERT INTO public.hfj_spidx_identity VALUES (566, -2269877340079306997, 'reaction-date', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (567, -2639500012378533040, 'context:of-type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (568, 5644547926780039264, 'payload-type:of-type', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (569, -5096897494882258359, 'procedure-udi', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (570, -1396476700924862900, '_lastUpdated', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (571, 7453839853008810714, 'date', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (572, -60123048832619641, '_id', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (573, -6105187872659613962, '_security:of-type', 'Binary');
INSERT INTO public.hfj_spidx_identity VALUES (574, 1440553709229998046, 'endpoint', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (575, 7919372641922860549, 'occurrence', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (576, -3232190349689742787, '_security:of-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (577, 1367545373299840289, 'format', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (578, 8567743332568819436, 'identifier:of-type', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (579, 4438603792037756228, 'version:of-type', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (580, -5843264824652795879, 'active:of-type', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (581, -1563590024057018952, 'identifier', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (582, 2499918021133404325, 'context-type:of-type', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (583, -8376643988063307371, 'identifier:of-type', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (584, -3922308625957648460, 'patient', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (585, -8677924671597440431, 'jurisdiction:of-type', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (586, 1215325075072310347, 'content-type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (587, 8024238063820800769, 'service-category:of-type', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (588, -661759073258094195, '_security', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (589, 4673747689755662551, '_security:of-type', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (590, -535792811993591483, 'url', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (591, -5069989440451602101, '_id:of-type', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (592, 5383548974604860492, 'target-uri', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (593, 4453853484432005469, '_tag:of-type', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (594, 7950092731789055319, 'author', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (595, -8959071849004939417, '_tag', 'SubstanceReferenceInformation');
INSERT INTO public.hfj_spidx_identity VALUES (596, 8687883956087583006, 'type:of-type', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (597, -832109865476554833, 'type', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (598, -2352515982402188922, '_profile', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (599, -228708630524356752, '_source', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (600, 2411495650276086395, '_id', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (601, -2388903356335236960, 'period', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (602, -1551694114868890974, 'status:of-type', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (603, 8363191882629455792, 'focus', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (604, 1207555045015645526, 'identifier', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (605, -6814103647240267864, 'container', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (606, 4034115402151335134, 'type', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (607, -5425992675473794568, '_tag', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (608, 5665235224838203348, '_profile', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (609, -4640350529333802438, 'relatedperson', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (610, -1493821640936408590, 'lot-number', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (611, -3889508379635120145, 'identifier:of-type', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (612, 3170998684222145379, 'subject', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (613, -5920796562655703787, '_lastUpdated', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (614, -3650737151610258199, 'focus', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (615, -4412133772592233473, 'description', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (616, 1243976229163215208, 'code', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (617, 4647258428880960987, '_tag:of-type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (618, -6985094435345494637, 'provider', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (619, -8858620394209886201, 'given', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (620, -8923882311074947273, 'status:of-type', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (621, 1847691737090836081, 'identifier:of-type', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (622, -8426378123290021596, 'identifier:of-type', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (623, -8370143357893449423, '_tag:of-type', 'MedicinalProductInteraction');
INSERT INTO public.hfj_spidx_identity VALUES (624, -3666662884224796796, '_id', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (625, 1305610379115506723, '_security', 'SubstanceReferenceInformation');
INSERT INTO public.hfj_spidx_identity VALUES (626, 3126809193038731716, '_id:of-type', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (627, 7031356761949119638, 'identifier:of-type', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (628, 7187171686763770274, 'medication', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (629, -4534542804251852721, 'priority', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (630, 6618549934020304752, 'address-use:of-type', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (631, 1259331523022891984, 'context:of-type', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (632, -9187005224887620915, 'period', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (633, 1648961995757669442, '_tag', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (634, -508473492684784133, '_security', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (635, 3769794328691553153, 'status:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (636, -4519122821034643726, '_id', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (637, -7410363933782559947, '_source', 'MedicinalProductIngredient');
INSERT INTO public.hfj_spidx_identity VALUES (638, -404193771225339424, 'version', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (639, 8393814078332236132, '_source', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (640, 7654499255290340464, 'status:of-type', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (641, -8966828919855790976, 'depends-on', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (642, 8483554560003128854, '_tag:of-type', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (643, 6443893465437414307, '_security:of-type', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (644, 4247479481889261504, 'encounter', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (645, 7019755890887865361, '_tag:of-type', 'SubstanceReferenceInformation');
INSERT INTO public.hfj_spidx_identity VALUES (646, 2537555154199137827, '_lastUpdated', 'BiologicallyDerivedProduct');
INSERT INTO public.hfj_spidx_identity VALUES (647, 908042652574837031, 'ext-context', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (648, 3430268310675744444, 'date', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (649, -4086845582824196390, '_security:of-type', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (650, -7238174463077619395, '_security', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (651, -3376233768585459392, '_security:of-type', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (652, 1799144504398936370, 'context:of-type', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (653, 755402319210366709, 'status', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (654, 8571909845909044634, '_profile', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (655, 3178985624453608667, 'gender', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (656, -8485402648401702611, '_id:of-type', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (657, 8342686924775695409, '_source', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (658, 289030074131924140, 'definition', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (659, 2478733284188716123, '_security', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (660, 1792779299762810197, 'collector', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (661, 8719148845438948213, 'classification', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (662, 8522440138593599994, 'context-type:of-type', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (663, -3412162481278919268, '_id', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (664, -3402141234739437569, 'policy', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (665, 6884677683667173476, 'url', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (666, -791631030947857427, '_tag:of-type', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (667, -5870876880279299342, 'verification-status:of-type', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (668, 5499763456069391440, 'subject', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (669, 7344721251589342664, 'composed-of', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (670, -7311004591203810683, '_tag', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (671, -7883221191030620583, '_tag:of-type', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (672, -7718846616667820321, '_tag', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (673, 3561543629419713007, '_lastUpdated', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (674, 6095759510477237317, '_security', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (675, -3971721425245579278, 'patient', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (676, 3315377994849116556, '_security:of-type', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (677, -2111303399990333807, '_security:of-type', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (678, -9090152517056010377, 'date', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (679, 3826871172178470634, 'status:of-type', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (680, -2949815103438440004, 'address-use', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (681, -6484604893279685276, '_tag:of-type', 'MedicinalProduct');
INSERT INTO public.hfj_spidx_identity VALUES (682, 7177040958523054643, '_source', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (683, 5432189149139707197, 'signature-type', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (684, -2572868012407452112, 'status:of-type', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (685, 8627217349270652588, 'series', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (686, 4062132757523000563, 'identifier:of-type', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (687, 3883964573624727032, 'relationship', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (688, -6804616154871301620, 'received', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (689, -1390017748732665865, '_tag:of-type', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (690, 1944491513853985910, 'problem', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (691, 6286363164196771830, 'class:of-type', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (692, 502701539407382731, 'depends-on', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (693, 4451875434085084679, 'category:of-type', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (694, 2894862980132627617, 'url', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (695, -8768126417703470074, '_security:of-type', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (696, -2194395584585733258, 'immunization-event', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (697, -3235366075337316414, 'url', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (698, 5522578400213304792, '_source', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (699, -5751767925745379178, '_lastUpdated', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (700, 980964113210810155, 'email', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (701, 4501800649284748761, 'title', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (702, -6555260529010205634, '_tag', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (703, 240490227062045296, 'code', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (704, -3473310511014918224, 'component-code:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (705, 8023458482972692063, 'sender', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (706, 8989976317826463357, 'status:of-type', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (707, -4531781398222438239, 'status', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (708, -5007809971794408701, '_tag', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (709, -3701847838131467176, 'service-type:of-type', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (710, 7604846197241128626, '_tag:of-type', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (711, -5453583524408491478, '_tag', 'SubstanceNucleicAcid');
INSERT INTO public.hfj_spidx_identity VALUES (712, -3245765720867306937, 'status', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (713, -8710981181514275067, 'subject', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (714, -245426557807249319, 'status:of-type', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (715, -1412636875901809807, '_lastUpdated', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (716, 5637561810342968323, 'status', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (717, -5809552752588882552, '_id:of-type', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (718, -2342819115428358011, '_source', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (719, 3368144519323868974, 'date', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (720, 1790657056449694604, 'address-postalcode', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (721, 3114285582609588194, '_security', 'MedicinalProduct');
INSERT INTO public.hfj_spidx_identity VALUES (722, 5100320651147761260, '_id', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (723, -6393076403936417105, 'code:of-type', 'SubstanceSpecification');
INSERT INTO public.hfj_spidx_identity VALUES (724, -2766478614504954354, '_security:of-type', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (725, -4735749715483096069, 'predecessor', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (726, -8366573467168887149, 'sex', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (727, -1894749622384761085, 'device-name', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (728, -7281487519395893210, 'agent-type:of-type', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (729, -2510841239956622240, '_source', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (730, 446455193246720391, 'status:of-type', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (731, 6594312782155689905, 'death-date', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (732, -7918791155451598557, 'address', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (733, -1321389353550742585, 'created', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (734, -7032209101055018319, 'context-type:of-type', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (735, 2995987906000250022, 'status', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (736, -967327261051721852, 'target-system', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (737, 4487223215488520816, 'jurisdiction:of-type', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (738, -8382224671151634850, 'domain', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (739, 3540220952603320799, '_security:of-type', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (740, 6265927334698768125, 'identifier', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (741, 5341749921688361204, '_security:of-type', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (742, 7488842530131555463, 'description', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (743, 3376907869397642498, '_security:of-type', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (744, -3874001666954397328, 'title', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (745, -2508356475003906596, 'type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (746, 5544020926130844332, '_id', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (747, -5143631590934696262, '_profile', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (748, -6891920331577193467, 'version:of-type', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (749, -7205797378443405739, 'type:of-type', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (750, 3762804554753701128, 'ingredient-code:of-type', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (751, -1381444559833226458, 'insurer', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (752, -7538173544701048304, '_lastUpdated', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (753, 1111663866958548488, '_lastUpdated', 'SubstanceSourceMaterial');
INSERT INTO public.hfj_spidx_identity VALUES (754, 2778350961768699605, 'status:of-type', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (755, 7900500921257292682, 'derived-from', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (756, 3917106746330892574, '_security', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (757, 3711069677387532830, '_id', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (758, -5298721861351488844, '_security', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (759, -6418735715275717098, '_tag:of-type', 'EnrollmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (760, 6468814608641713772, 'resource-profile', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (761, -1122717784495193957, '_security', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (762, -2218138310540033896, 'value-date', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (763, 7823287789367021646, 'name', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (764, 8768443372922627975, 'context', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (765, 5153445369975836864, 'context', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (766, 7324619153358846943, '_id', 'OperationOutcome');
INSERT INTO public.hfj_spidx_identity VALUES (767, 3406945976918687209, 'action:of-type', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (768, -5225733123797295152, 'address-country', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (769, -9161155455489687346, 'address', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (770, -3259682371471078422, 'risk:of-type', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (771, 7570904768412969875, 'identifier:of-type', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (772, -9111142589934779828, '_lastUpdated', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (773, -7604801661232317572, 'category', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (774, 2638003160532934722, 'quantity', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (775, -7108941411843338503, 'subject', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (776, -5145374560231324, 'active:of-type', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (777, -7999838306773384353, 'patient', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (778, 5805567289409271325, 'type', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (779, 7820559382828902754, 'context-type', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (780, -6303753023954877687, 'context:of-type', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (781, 1960870693810304855, '_security:of-type', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (782, 4942239603680008950, 'date', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (783, -1373010638003915532, '_security:of-type', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (784, -4031136933131256980, 'identifier', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (785, -63494183618696816, '_tag:of-type', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (786, 2101702466563656586, 'authoredon', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (787, -5754651428344658297, '_source', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (788, -8447520236772781289, '_security:of-type', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (789, 7919895159599324145, 'service-type', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (790, -8991779452240943245, '_id:of-type', 'Linkage');
INSERT INTO public.hfj_spidx_identity VALUES (791, -902156260689906301, 'identifier', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (792, -1243663352241331710, 'identifier:of-type', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (793, -6737993173616041971, 'ingredient', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (794, 8610423254153694132, 'when', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (795, 4313275169953045419, 'source-cost', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (796, -492466925336554882, 'status:of-type', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (797, -4364992811380357950, 'jurisdiction', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (798, 476728049009783681, '_source', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (799, -5783083508439950949, 'date', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (800, -2891289766040777762, 'description', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (801, 3778890820113986473, '_security', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (802, -2547125234800185883, '_tag', 'MedicinalProductInteraction');
INSERT INTO public.hfj_spidx_identity VALUES (803, -3918493248016715632, 'evaluated-resource', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (804, 2710349717196887210, 'variant-start', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (805, 1977078433375260795, 'description', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (806, -3981080244468290213, 'organization', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (807, -8656618365771428963, 'type:of-type', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (808, 798092542927454160, 'patient', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (809, -2234078217558748257, 'identifier:of-type', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (810, 4302111919228669675, 'care-team', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (811, 7892250044873784928, '_profile', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (812, -1895552564481002634, '_security', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (813, 2952117595575108505, 'title', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (814, 1748069574617058994, 'country:of-type', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (815, -5397019046378708211, 'identifier:of-type', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (816, 542806244659371363, 'identifier:of-type', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (817, 2647841033774115160, 'version', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (818, -2462948286108507821, 'identifier:of-type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (819, -5318759759621909688, 'related-id:of-type', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (820, -148832212365232756, 'depends-on', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (821, 1396470224709522763, 'description', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (822, 8357330862374554300, 'characteristic', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (823, 2106885645919713375, 'code:of-type', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (824, -3274208602996131693, 'context-type:of-type', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (825, 5485337760077842598, 'location', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (826, -5436859658811647495, '_source', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (827, -8232390468663371305, '_tag', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (828, -4141170503154737258, 'status', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (829, -6386242645093200941, 'enterer', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (830, 6827110815791142311, '_lastUpdated', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (831, 5565381217893923526, 'global', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (832, 5747222422287391096, 'successor', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (833, 5722531199097848192, '_id', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (834, -5844979193887622206, 'address-state', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (835, 6489036249891843324, 'status', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (836, 6196003181247985437, '_tag:of-type', 'VerificationResult');
INSERT INTO public.hfj_spidx_identity VALUES (837, 1214060454568726710, '_lastUpdated', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (838, -1102710741679803027, '_source', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (839, 325532401298448551, 'status:of-type', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (840, -365423119953708392, 'status', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (841, 2970530765070686512, '_id', 'MedicinalProductManufactured');
INSERT INTO public.hfj_spidx_identity VALUES (842, -2318980486344591976, 'detail-udi', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (843, -6379414665666746630, 'recipient', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (844, -9121729934756253199, 'dose-status:of-type', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (845, -3691006522684631615, 'event', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (846, -5474204637063710652, 'version:of-type', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (847, -8798624610763859807, '_source', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (848, 2336485274800222294, 'insurance', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (849, -8606479544285694094, 'participant', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (850, -5844527471547110885, 'status:of-type', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (851, 1749752045480884790, 'monograph', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (852, 5641157695482254300, 'date', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (853, 1497651528998993426, '_source', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (854, 4279173773122115092, 'type:of-type', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (855, -8425778834844480645, 'achievement-status:of-type', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (856, -4762204580784855825, 'subject', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (857, 623219401856543082, '_profile', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (858, -2739442084339559011, 'identifier', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (859, -3226328907018370328, 'based-on', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (860, 2084085574734141456, 'address-postalcode', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (861, -83277455773039578, 'title', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (862, -4190895479432005256, '_source', 'Binary');
INSERT INTO public.hfj_spidx_identity VALUES (863, 4667086086289743971, 'identifier:of-type', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (864, 6799557750757151616, '_source', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (865, -6698742422740777158, 'date', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (866, -9186058769778365942, 'agent-type', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (867, -6774682007692172817, '_id:of-type', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (868, 1647954829610702831, 'reason-given:of-type', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (869, 3945184857652006956, '_id', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (870, 3657407394476142345, 'identifier:of-type', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (871, -1816992668056343856, '_tag:of-type', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (872, -8225531386971806088, 'publisher', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (873, 411771229534588039, 'name', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (874, -4663653132651618284, '_source', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (875, 4683357616458304206, '_profile', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (876, -4190021860804397323, 'specialty', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (877, -403429004058896887, 'publisher', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (878, -1037881135558997745, 'phone', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (879, 2886255575291796873, 'classification:of-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (880, 5072717691856391342, 'status', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (881, 1324508339131036459, 'composed-of', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (882, 8301354550085589327, 'base', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (883, 8371005337933244078, '_source', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (884, -861062309858738946, '_profile', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (885, -2722048029494979052, '_source', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (886, 4395062441681727261, '_profile', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (887, 7816336274724611101, '_security:of-type', 'SubstancePolymer');
INSERT INTO public.hfj_spidx_identity VALUES (888, 8701548736646516520, '_profile', 'VerificationResult');
INSERT INTO public.hfj_spidx_identity VALUES (889, -2979074112215295852, '_tag:of-type', 'BiologicallyDerivedProduct');
INSERT INTO public.hfj_spidx_identity VALUES (890, -4324512443743670587, 'date', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (891, 5936158115644958626, 'date', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (892, -696120458469301134, '_tag:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (893, 3790326151367620155, '_tag:of-type', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (894, -2621272519179622444, '_profile', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (895, 5430574377377780796, 'specialty:of-type', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (896, 8680247753669202171, '_lastUpdated', 'DeviceDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (897, -6801847743668069290, 'status:of-type', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (898, 4353716610021740371, 'security-label:of-type', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (899, -868668643554550536, 'container:of-type', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (900, -3249935819184475941, 'type', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (901, -698635331685652513, '_security:of-type', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (902, 1039276402076075811, '_tag:of-type', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (903, 8962973454119367831, 'name', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (904, -5893452790848625385, 'phone', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (905, -6209687198557697987, '_security:of-type', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (906, -5033444473108256429, '_security:of-type', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (907, -2556055691808183326, '_id', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (908, -2513553126542625333, 'url', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (909, 8765447052213967494, 'email', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (910, -703018801546735247, 'partof', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (911, -6748279258599347292, 'code:of-type', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (912, 2538742587384592085, 'location', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (913, -3401401632434615422, 'intent', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (914, -6874109182678042240, '_id', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (915, -6551284011736109816, 'phone', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (916, 4733555605772781716, 'subject', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (917, -1901136387361512731, 'value-quantity', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (918, 5592161769359503724, '_id:of-type', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (919, 6041642595587679137, 'status', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (920, -5023286825623740174, 'status', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (921, -806104632781609018, 'category:of-type', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (922, -8899386554312350603, '_security:of-type', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (923, 81712704093935889, '_id', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (924, -3268133788819522138, 'relation', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (925, -7755272501088609035, '_security:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (926, 2439341562186490438, '_profile', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (927, 6437717643673054331, 'derived-from', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (928, -5078231106369146922, 'code:of-type', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (929, 6760406800648167005, 'instantiates-uri', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (930, 1669491199093822351, 'title', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (931, 5625790965800621127, 'url', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (932, 5253218639713234325, '_security:of-type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (933, 4481700999436737013, '_tag:of-type', 'MedicinalProductContraindication');
INSERT INTO public.hfj_spidx_identity VALUES (934, -1888089928531743671, 'category:of-type', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (935, -4861153304999331077, 'category:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (936, -7847923449115789649, 'category:of-type', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (937, 5922613814608925235, '_tag:of-type', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (938, 1182429838723637570, 'code:of-type', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (939, -6324479810628999926, 'appointment-type', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (940, 3186290087110182089, '_source', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (941, -6621060052901953961, 'device', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (942, 5872938070585416215, 'context', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (943, -1737959923580014358, 'context-type:of-type', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (944, -4801271753189066734, 'status', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (945, 8345947573944341158, '_security:of-type', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (946, -4587939427177392714, '_lastUpdated', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (947, 8116588415728069035, 'event-date', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (948, -4910051255115921215, 'accession:of-type', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (949, -1941946866667951190, '_security', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (950, 7911149855771926453, 'part-status', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (951, -2015499991926065747, 'encounter', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (952, -6990531314565529962, 'target-disease:of-type', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (953, 3908479557383636547, '_id:of-type', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (954, -221628568765110522, 'status', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (955, -1022160029747286787, '_security', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (956, 8941090499325155935, 'signer', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (957, 189680740478742324, '_tag:of-type', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (958, -3566260669240193050, '_security:of-type', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (959, -7705010796377597180, 'author', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (960, 2406590883842161436, 'identifier', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (961, 6430919144842395780, '_security', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (962, 8377831643334149405, 'status:of-type', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (963, 6937383058627105278, '_security', 'MedicinalProductIndication');
INSERT INTO public.hfj_spidx_identity VALUES (964, -456279748204876664, 'status:of-type', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (965, -7359190244195362230, 'manufacturer', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (966, 670980741863812380, 'instantiates-canonical', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (967, 6542023447906529546, '_tag', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (968, -1214330671957558954, '_tag:of-type', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (969, 3449503203699518449, 'publisher', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (970, 222985356387471952, 'active:of-type', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (971, 8599146410385697587, 'category:of-type', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (972, -2853212976451920023, 'context:of-type', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (973, 2208978950835091514, 'patient', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (974, -4840460642697694159, 'identifier:of-type', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (975, 356042175033835925, 'role', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (976, 6964183405525426848, '_security', 'MedicinalProductUndesirableEffect');
INSERT INTO public.hfj_spidx_identity VALUES (977, -3123277383212027602, 'version:of-type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (978, 3011325913564394786, '_profile', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (979, 429707964459671257, '_profile', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (980, -4876704328548104798, 'specialty:of-type', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (981, 7974081456021189288, 'title', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (982, -4730598767061021262, '_source', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (983, -3843849165723113676, 'category', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (984, -8326059995836558954, '_id', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (985, -4703261050420173447, 'identifier', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (986, 2752582491809950388, 'criteria', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (987, 6299808946914546916, 'appointment-type:of-type', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (988, -8872827062471840501, '_id', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (989, -6555434045197445874, '_id:of-type', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (990, -5250431141652778319, '_tag', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (991, 2866755025754698848, '_tag:of-type', 'MedicinalProductPackaged');
INSERT INTO public.hfj_spidx_identity VALUES (992, -1870209502437693707, 'part-of', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (993, 7448103060868324752, '_tag:of-type', 'MedicinalProductIndication');
INSERT INTO public.hfj_spidx_identity VALUES (994, 775736323040509418, '_id', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (995, 870960126296460778, 'output-profile', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (996, -2758078210818454600, 'performer', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (997, 4567441024859271767, '_id', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (998, 781330883849964625, '_tag', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (999, 5531697912600564037, 'identifier', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (1000, -7615397448617424746, '_source', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (1001, -6053400263966901082, 'role:of-type', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (1002, -5274191386448171958, 'authored', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1003, 3656462738139649973, 'identifier', 'DeviceDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1004, -6494620163792605256, 'encounter', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1005, 6743558387156522670, 'activity-code', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1006, 7795585127668740426, 'subject', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (1007, 7387927142643481746, 'context-type:of-type', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1008, 6062936395727933115, 'address-country', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1009, 8757228258741831515, '_security:of-type', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (1010, -146589618869088575, 'identifier:of-type', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1011, -3158996576096328918, 'combo-value-concept', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1012, 6163711124349647528, 'address-state', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (1013, -422747925027804860, 'account', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (1014, -4741500821362321128, 'item', 'Linkage');
INSERT INTO public.hfj_spidx_identity VALUES (1015, 8121692190197089853, '_id', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1016, 4216269378428867559, 'url', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (1017, -3014983636207943915, 'topic:of-type', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (1018, 8067620329223386439, 'vaccine-type', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (1019, -3147188080387594445, 'status', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1020, -4739351616880841326, 'subject', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1021, -7940336355078970158, 'predecessor', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (1022, -1895078293851469353, '_id:of-type', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (1023, -8683013147411145937, 'effective', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1024, -6068907008032669496, '_source', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1025, 2099983495858681678, '_id:of-type', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (1026, 7638564307595925148, 'patient', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (1027, -8383652098458716944, 'jurisdiction:of-type', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (1028, 894880374865758631, 'identifier:of-type', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (1029, -7825356242755368883, '_source', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1030, -1386143636651062851, 'subject', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1031, 8028461285625306032, 'supplier', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (1032, -4258540163648052784, 'source-cost:of-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (1033, 7247900978786246052, 'context', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1034, -4707459272251579459, '_id:of-type', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1035, -1379138208015105105, 'jurisdiction', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1036, 927609873590894747, 'container-identifier:of-type', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (1037, 2564241820916132774, 'code:of-type', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (1038, -7507619559213238827, 'gender:of-type', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (1039, 6007450203907189573, 'patient', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (1040, 6849332121472790733, 'status', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (1041, -4445898542632835099, '_tag:of-type', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (1042, 4277916704661740625, 'patient', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1043, 8409806796034149589, '_id:of-type', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (1044, 3287600355474887827, 'identifier:of-type', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (1045, 7495760564396632359, 'status:of-type', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1046, 2046381532064728439, '_tag:of-type', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (1047, 2808772521322014887, '_security:of-type', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1048, 2993925251903659209, 'encounter', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1049, -3139072319323770391, 'topic:of-type', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1050, -8222019506099019206, 'lifecycle-status:of-type', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (1051, -2365536552365934955, 'successor', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1052, 7942712429500225575, '_lastUpdated', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (1053, -4366406564768624512, '_id', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (1054, -8706058351038562281, 'effective', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1055, -1411333178826958238, '_tag', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (1056, 6090494304821935118, 'context:of-type', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1057, 9185258400476390283, 'jurisdiction', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (1058, -7995795662889006491, 'date', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (1059, 7623672263434527736, 'language', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (1060, -7710575633673949062, '_id:of-type', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (1061, 475211126537319370, 'payload', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (1062, 1873388670680624896, 'provider', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (1063, 1349118615849796319, 'severity:of-type', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (1064, -1305023345547141863, 'identifier', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (1065, -6621292486915895519, '_security:of-type', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (1066, -8450546357497898761, 'scope', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (1067, -4523403632791779562, 'code', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (1068, -1474565176675432809, 'identifier:of-type', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1069, -5338473298757326271, '_id:of-type', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (1070, -3839403135569345911, 'date', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1071, -4241474359299313807, '_tag', 'ObservationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1072, 4199833399790873595, 'category', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1073, -4572158830941821546, 'version:of-type', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1074, -8056123647524465290, 'system:of-type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1075, 1861964572950826485, 'telecom', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (1076, 1870943555104641456, 'finding-code', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (1077, 6156082256930231522, 'finding-ref', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (1078, -4820771899738745511, '_id:of-type', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1079, 8244584553161602449, 'expiry', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (1080, 452327815793167418, '_profile', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1081, -8905201215612131031, '_tag', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1082, -68259497704137101, 'entered-date', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (1083, -4410179957801130976, 'date', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1084, 6172000877927369737, 'active', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (1085, 6175720128260116958, 'use:of-type', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1086, 8598163173560205715, 'status', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1087, -3794013850369369589, 'description', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (1088, 2918302884398150899, 'publisher', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (1089, -7882423632382752951, '_tag:of-type', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (1090, -7829581300972420255, 'view:of-type', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (1091, -1817570477204841870, 'email:of-type', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1092, 2132924312005374237, 'jurisdiction:of-type', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1093, 8624980275357698842, 'status', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1094, 1105544043928739527, 'status:of-type', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (1095, -6793158075126424567, '_security:of-type', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1096, 5821739766421324785, '_lastUpdated', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (1097, 876261837178040956, 'type:of-type', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (1098, 2782507456973361794, 'disposition', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1099, -8846462777729104530, '_tag', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1100, 3966374773421329943, 'created', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (1101, 71747827190859184, 'identifier:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1102, -7108383090128507636, 'system', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1103, 7957360475406867233, 'patient', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (1104, -717164188456695874, '_lastUpdated', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (1105, -6846124980979989619, 'code', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (1106, 650156863811740370, '_source', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (1107, -167230829151371516, 'location:of-type', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (1108, 594058100064545003, '_id', 'MedicinalProductPackaged');
INSERT INTO public.hfj_spidx_identity VALUES (1109, 9040686243278935811, '_source', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1110, 2446448079880435428, 'effective-time', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (1111, 3420808526898528284, '_tag:of-type', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1112, 3530229920320513927, 'device', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1113, -7155555513389631626, 'description', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1114, 2460630035728343771, '_profile', 'DeviceUseStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1115, -5592835659097563747, 'type', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (1116, -7102258108857459493, '_id', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1117, -723421044783867572, 'specialty:of-type', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (1118, -8797297086750074901, '_security', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (1119, -726519008853411879, 'content-mode:of-type', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1120, -7623001853295396767, '_security:of-type', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1121, -1514021606869567060, '_source', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (1122, 540225261274662350, '_security', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1123, 5710536554213139720, 'status', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (1124, 2347988274592814040, '_profile', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1125, -3324136393298942869, 'seriousness:of-type', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1126, 562039850248781431, 'based-on', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1127, 1834260200972104257, 'description', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (1128, -7440031571293777139, '_lastUpdated', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (1129, 3490635439805994580, 'identifier', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1130, -2241604081768652452, 'status:of-type', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1131, 6020871177262364841, 'version', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1132, 7679174288910549569, 'status', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1133, 6523174276129409030, 'identifier:of-type', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (1134, -4358727483038128787, '_profile', 'MedicinalProductIngredient');
INSERT INTO public.hfj_spidx_identity VALUES (1135, -7533179358561765384, '_source', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (1136, 8245722596313453725, '_lastUpdated', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1137, -5055807811477763545, 'jurisdiction', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (1138, -603091197822204773, '_id:of-type', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1139, -5239383350047463457, '_id:of-type', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (1140, 6597106544213426591, 'site', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (1141, -3392186806166768588, '_tag:of-type', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (1142, -4068492563507085652, 'status', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (1143, -6751899651568592376, 'period', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (1144, 1083797987026518293, '_id:of-type', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (1145, -8944087917930441458, 'name', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1146, -97930077067592100, 'identifier', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (1147, 8684975351490829657, 'clinical-status', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (1148, 1658353376278895581, 'target-code', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (1149, -1180286697785026793, '_id', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1150, -1038240387447855982, 'identifier', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (1151, -7956347216209576044, '_profile', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1152, 4479340915795703146, 'identifier', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (1153, 2259460231769846003, 'identifier', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1154, 1221063092395815542, '_source', 'MedicinalProductInteraction');
INSERT INTO public.hfj_spidx_identity VALUES (1155, -6927850978292672616, 'requester', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1156, 4841487231760255512, 'effective', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (1157, 2929054092766028495, '_tag', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1158, 3247884929351652374, 'depends-on', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1159, -5890497987094617447, '_source', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (1160, 7492835799581051220, '_tag', 'MedicinalProduct');
INSERT INTO public.hfj_spidx_identity VALUES (1161, 7887336173616992518, '_lastUpdated', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1162, -1191355959233248962, '_tag', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (1163, -1937217248572002643, 'version', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1164, 6602512624930583906, '_lastUpdated', 'ObservationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1165, -3617841625704580808, 'instantiates-canonical', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (1166, 1211975215697807212, 'jurisdiction', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (1167, -5196505226049289039, '_profile', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1168, 6711689353158949768, 'resource:of-type', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1169, 9218473996403473132, '_tag:of-type', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (1170, 7429345036472040669, '_security', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (1171, -6842443163685093015, 'date', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (1172, -7604661791286717989, 'view', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (1173, 1222860490492074735, '_security', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (1174, -8241508291513061877, '_security', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (1175, -7355283063190651292, 'version', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1176, -5555801628348895207, 'service-type', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (1177, -661076528834529427, 'altid:of-type', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1178, 601358164066955540, '_tag', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (1179, 1736395113140776167, 'body-site:of-type', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (1180, -3100882887059157010, '_id:of-type', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1181, -3001579794359655465, 'policy-holder', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (1182, -4116713402074363447, 'identifier:of-type', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (1183, -3473916189346485183, 'endpoint', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1184, 5902919537265317159, 'account', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (1185, 1704636322722521000, '_tag:of-type', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (1186, -3394729947537715735, 'base:of-type', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (1187, -6353480526720143612, 'subject', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (1188, -3301536609209043380, 'status:of-type', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (1189, -7874714840001549658, '_tag:of-type', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (1190, 2383598442623454773, '_id:of-type', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (1191, 4067327717878292109, 'item', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (1192, 3133296063067499223, 'jurisdiction', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1193, -2328739385918313129, 'category:of-type', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (1194, -2826489077040426915, 'date', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (1195, 7252898370112079941, 'category', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (1196, 7480241983186134187, 'jurisdiction:of-type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (1197, 7053067767849079696, 'identifier:of-type', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (1198, -3862775918407988966, 'source-code', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (1199, 6667745522921960230, 'occurrence', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1200, 715230447379811804, 'code', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (1201, -4182371258845201966, '_id', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1202, 3823031487403693784, 'topic', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (1203, -1076119302160565759, 'container:of-type', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (1204, -3034198445410264878, '_id:of-type', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (1205, 1908909826702171935, 'replaces', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1206, 3938187104014769618, 'patient', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1207, 741790565726241276, 'context-type', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (1208, -8879900064733890723, '_security', 'Parameters');
INSERT INTO public.hfj_spidx_identity VALUES (1209, 4221307647986160966, 'context', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (1210, -7905852990808426431, 'intended-performertype:of-type', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1211, -7250774607705040349, '_source', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (1212, 565376780390194530, 'subject', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (1213, 1866990690664645834, 'event:of-type', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (1214, 3883922453079224051, '_profile', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (1215, 5428025133800141890, 'identifier', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1216, -959223768495510512, '_source', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (1217, 1435445512813809478, '_security', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (1218, -1582770634122592439, 'context', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1219, 2929207385677660662, 'address', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (1220, 7710897720613170196, '_security', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (1221, 9109420285996063890, '_security:of-type', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (1222, -4352907834658995496, 'telecom', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (1223, 5309074045093354524, 'identifier:of-type', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1224, -7868269350956294073, '_id:of-type', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1225, 5527072208589276586, 'topic', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1226, -7509358589933745905, 'prior-request', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1227, 1841670573071061508, 'identifier:of-type', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1228, -4823058030971790177, 'kind:of-type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1229, 6810181908461203555, '_profile', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (1230, -526149951279971929, 'successor', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1231, 4193662681232524865, '_tag:of-type', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (1232, -6425538677723366231, 'jurisdiction:of-type', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (1233, 3203330158019036058, 'focus', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1234, -5197610581676551658, '_id:of-type', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1235, 4782416729833843321, 'method', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1236, -6606502151661909918, '_tag:of-type', 'SubstanceSourceMaterial');
INSERT INTO public.hfj_spidx_identity VALUES (1237, -309773134824192095, '_source', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1238, 4606538046458125917, 'address-city', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (1239, -37298670846829351, 'active:of-type', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1240, 811861439001905498, 'intent:of-type', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1241, -3742220816821922666, 'relationship', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1242, -995186329173666301, '_lastUpdated', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1243, -4425099562593947375, 'target', 'VerificationResult');
INSERT INTO public.hfj_spidx_identity VALUES (1244, -8177273816781996307, 'name', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (1245, 4851661110318228252, 'encounter', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1246, -3049097393652509379, '_security', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (1247, -3226270168244902835, '_tag:of-type', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (1248, 4693307354852039663, 'specimen', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1249, 6731055717055432662, 'intent:of-type', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (1250, 1928096072754056685, 'code:of-type', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1251, -8137150157062553329, 'subject', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (1252, 8724148749425466493, 'identifier:of-type', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (1253, 3579757008206944412, '_lastUpdated', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (1254, -6214835965498046936, 'parent', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1255, 3235268117437116493, 'publisher', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1256, -3189552513274917897, 'lifecycle-status', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (1257, 8146440896265764633, '_tag:of-type', 'DeviceDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1258, 5767574921927677256, 'version', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1259, -9140473331622310891, '_security:of-type', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (1260, -4499218204755892091, 'kind:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1261, 5110465640876908968, 'encounter', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (1262, 5005596964607326660, 'subject', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (1263, -3514060203768659066, '_tag', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (1264, 8642239772359390454, '_id', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1265, -3983267980838225465, 'intent', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (1266, -7621975649525552247, '_security:of-type', 'SubstanceProtein');
INSERT INTO public.hfj_spidx_identity VALUES (1267, -6447982966700770219, '_profile', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1268, -184660210692412648, 'code', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (1269, 6793168998135255818, 'category:of-type', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1270, 7379736371888172125, '_source', 'SubstanceReferenceInformation');
INSERT INTO public.hfj_spidx_identity VALUES (1271, -6722423696624704653, 'practitioner', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (1272, -4589508511315771141, 'encounter', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (1273, 6240302738857768922, 'code', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (1274, -9060658722623097822, 'status:of-type', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1275, -3056077347365414944, 'vaccine-code:of-type', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (1276, -4206635562620166309, '_source', 'EnrollmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1277, -8730308640295886730, '_security', 'MedicinalProductPackaged');
INSERT INTO public.hfj_spidx_identity VALUES (1278, 7282323812955530976, 'patient', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1279, -1892923772783555149, '_id:of-type', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (1280, -5194046705485704495, '_tag:of-type', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (1281, 4188723724985015902, '_source', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (1282, -3019238092389497426, '_tag:of-type', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (1283, -2138381039918530244, '_id:of-type', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (1284, -5031810552862220069, '_id:of-type', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (1285, 2962363223935436157, '_security', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (1286, -7937427946632325211, '_id:of-type', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (1287, 628982799839222165, 'type', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (1288, 4248695900543328642, 'status', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1289, 4456491998693935897, '_id', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (1290, 5653617079789306822, '_tag:of-type', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1291, 6889197610170718475, '_source', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1292, 7929261850199738424, 'category:of-type', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (1293, -7494564946360915287, 'status:of-type', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (1294, 4014436756803389037, 'active:of-type', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (1295, 5247847184787287691, 'birthdate', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (1296, -505122241748101416, 'type', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (1297, -8470822002362503164, 'category', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1298, -5156403783335593466, 'depends-on', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (1299, 6128770061648404417, 'identifier', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (1300, 4326104118078123035, '_lastUpdated', 'MedicinalProductManufactured');
INSERT INTO public.hfj_spidx_identity VALUES (1301, -8140920061329174658, '_source', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1302, -3337781109289559787, '_tag', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1303, -9200344685290294598, 'requestor', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (1304, -2160399059928612115, 'code:of-type', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (1305, -7451166445319085880, 'practitioner', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (1306, -4318400447123264170, '_tag:of-type', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1307, -6483236742209085806, '_profile', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (1308, -2535043574812268170, 'category', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1309, 1076992179053763018, 'status', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1310, 7547706556698198152, 'context:of-type', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1311, 5181021086142211677, 'priority:of-type', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (1312, -7360436172370427477, 'instantiates-canonical', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1313, -4019454638761650831, '_tag:of-type', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (1314, 2157754435287087058, 'status', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (1315, -8819125712470908160, 'telecom:of-type', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (1316, -2127827714251451750, '_id', 'Linkage');
INSERT INTO public.hfj_spidx_identity VALUES (1317, -1580941806369081130, 'part-of', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (1318, -2508641840240920901, 'publisher', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1319, 7041288560286531631, 'status:of-type', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (1320, 5735290874467337460, 'type:of-type', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (1321, 6607839571166689133, '_profile', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (1322, -9014649967592434246, '_id:of-type', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (1323, 8258027583114800592, 'authority', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (1324, 4933367333834141511, 'sex:of-type', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (1325, -7476510397921415478, 'context-type', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (1326, -8238979307569012435, 'context', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1327, -6408163159329172452, 'status:of-type', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (1328, 1996395441217740714, '_lastUpdated', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (1329, -7329550241329808518, 'action', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (1330, -1766164809011894531, 'publisher', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1331, 6469240879811138018, 'patient', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1332, 9033724312305832713, '_id:of-type', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (1333, 3099632116661473793, 'type', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (1334, -7326955530264074477, 'version', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (1335, 8802081664564077777, '_id', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (1336, 2686119544202920518, 'context-type', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1337, 3656038545028369548, 'version:of-type', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1338, -38281107952864720, '_profile', 'SubstanceSourceMaterial');
INSERT INTO public.hfj_spidx_identity VALUES (1339, 6715757442591302584, 'status', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (1340, 6372404845200071454, 'jurisdiction:of-type', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1341, 7281040606877590225, 'status', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (1342, 110533026097594599, 'phonetic', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (1343, 4101227021854182444, 'entity', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (1344, 1982277557682071193, 'gender:of-type', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (1345, -6529482579366598977, 'identifier', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (1346, -4147077437116604940, 'identifier', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (1347, 3109786589672809939, 'event', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (1348, 5528165050819771804, 'identifier', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1349, -8780504534765315288, 'actor', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (1350, 2760244623761462746, '_tag', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (1351, -4958802616822422185, 'payload:of-type', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (1352, 4870407012216456267, 'entity-type', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1353, -6754819913400251037, '_tag', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (1354, -3663574695732282391, 'status:of-type', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1355, -1938008862508718860, 'requestor', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1356, -967790226095459004, 'type:of-type', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (1357, 5062938422483906175, 'provider', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (1358, -4196362133128796502, '_security', 'EnrollmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1359, -1620392135187865217, 'supporting-info', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (1360, 5240221591227735106, 'address-use', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1361, 685684592464891544, '_id:of-type', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (1362, -1671578344039094898, 'telecom:of-type', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (1363, 2182352976535527574, 'encounter', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (1364, -6044840917671988465, 'instantiates', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (1365, -5475324212927533132, '_lastUpdated', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (1366, 8853864069814164007, 'jurisdiction', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1367, 1154104388732068766, 'ingredient-code', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (1368, -5232836309769012135, 'item-udi', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (1369, 2436573689663309352, 'condition', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1370, -7084356680250155683, 'identifier:of-type', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1371, 377578532882297732, '_security:of-type', 'SubstanceReferenceInformation');
INSERT INTO public.hfj_spidx_identity VALUES (1372, 1831592608068252634, 'collected', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (1373, 5841433770600556490, 'active', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (1374, -2322174666404939928, 'date', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (1375, -7736260930809274828, 'status', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (1376, -248819834639193031, 'patient', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1377, 243388913926497037, 'authored-on', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (1378, -7956366539930480733, 'context-quantity', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (1379, -3437448228334772395, '_profile', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (1380, 3634606283340556783, 'parent', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (1381, 3030547419999076484, 'context', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1382, -1935939545497343041, 'identifier', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1383, 3307262606585302054, '_source', 'Parameters');
INSERT INTO public.hfj_spidx_identity VALUES (1384, 6613433961872969329, '_security:of-type', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (1385, 1835346346620180165, '_tag', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (1386, 6250971469613992130, 'jurisdiction:of-type', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (1387, -7523658269648981636, 'date', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (1388, 7391540692562626275, 'status:of-type', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (1389, 5389946246577983631, '_tag:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1390, -4958728551188528852, 'priority', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (1391, -3160807528656612072, 'name', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1392, 739549209205648055, 'episode-of-care', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (1393, -4501797696612853351, '_source', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1394, -5386471049747282367, 'version', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1395, 5601265886148623612, 'reason:of-type', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1396, 7146764264607482608, 'jurisdiction', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1397, -7015684294136740396, '_security:of-type', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1398, -8229485816018003165, 'abstract:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1399, -366817714945390585, 'organization', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (1400, 7364709936085598267, '_security', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (1401, -5110248794867673532, 'participant', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (1402, -6160812571730641486, '_tag', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (1403, -4303579068959379805, '_security', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1404, -8082682353897381932, '_source', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1405, 7612437993647735605, 'patient', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1406, 2482650569831690077, 'patient', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (1407, 7564577279473521069, 'response', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (1408, -8628577454373167804, '_source', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (1409, -5025612591984669414, '_id', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1410, -5709780511353405485, 'address-use', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (1411, 123682819940570799, 'date', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1412, 9196053279665499276, '_id:of-type', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1413, -5024420424449422168, 'model', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (1414, -6469476799241732820, '_id', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (1415, -3601140494058287609, 'description', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1416, 8309857292888832003, '_id:of-type', 'SubstanceSourceMaterial');
INSERT INTO public.hfj_spidx_identity VALUES (1417, -6561015860553468789, 'request:of-type', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1418, 3557635654334986190, '_profile', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1419, 3999116991141352521, 'patient', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (1420, -1195778563110738523, '_tag:of-type', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (1421, 8993182466024057883, 'title', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1422, -1508298598744204445, 'identifier', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1423, -2101472089738558057, '_security', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (1424, 4546567105370520071, 'service-category', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (1425, 9057465446496305774, '_security:of-type', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1426, -8092878935732694172, 'source', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1427, -4073225858310562720, 'status', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (1428, -1639842323899963996, 'priority:of-type', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (1429, 6104506896987605773, 'subject-type', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (1430, -1985725302698424634, '_id', 'MedicinalProductIngredient');
INSERT INTO public.hfj_spidx_identity VALUES (1431, 4797232205988198884, 'version', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1432, -3178374070884739281, '_profile', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (1433, -4634788572138818684, 'requisition', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1434, -4541602019686336440, 'derived-from', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1435, -6306802860969761819, 'created', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (1436, 3174903363959382505, 'series', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1437, -6559389208073207003, 'bodysite', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1438, 2484839802806274108, 'subject', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (1439, -8227099049538634631, '_lastUpdated', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1440, -5359063124784580757, 'title', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1441, 5173294741466996876, '_tag', 'OperationOutcome');
INSERT INTO public.hfj_spidx_identity VALUES (1442, -7142621430316548285, 'status', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (1443, 6493147452628296166, 'status', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (1444, 2888751494336095385, 'jurisdiction:of-type', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (1445, 7518682881197045256, 'status', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (1446, -6909251895272109455, 'organization', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (1447, 4925792809268023105, '_source', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (1448, -7799708338974237083, 'modality', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (1449, -5497492401776183239, 'status', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (1450, -8744386985669649255, 'title', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1451, -8086506897647866855, '_security:of-type', 'MedicinalProductContraindication');
INSERT INTO public.hfj_spidx_identity VALUES (1452, -7952466873952727774, '_security', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1453, -2331048752408143939, 'datetime', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (1454, -5222814270764569684, 'identifier:of-type', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (1455, 9164775296431503020, 'status', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1456, 6845925278904932668, '_tag', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1457, -4434613643765412259, '_tag:of-type', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1458, 6069637555155042401, '_tag', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1459, 1120967789957649874, '_id', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (1460, -8135886022972688519, '_security', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1461, -2165455592836601495, 'jurisdiction:of-type', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1462, -5020608093006279899, '_id:of-type', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (1463, -5612198438777190428, 'patient', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (1464, 3679632569969024172, '_lastUpdated', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1465, 170810687696831533, 'address-state', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (1466, -5965489183024194189, 'jurisdiction', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (1467, -2985729069439309772, '_id', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (1468, 7396408662331738656, 'description', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1469, 7452608035177761588, 'address-state', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (1470, -7971098860531087598, 'date', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (1471, -2139898527190831712, 'context-type:of-type', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (1472, 4760426445431446213, 'name', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (1473, 7767978048884548288, 'status:of-type', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1474, 2204588994849709181, '_tag', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (1475, 4682955841724770954, 'type:of-type', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1476, -5333920280147027322, '_lastUpdated', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (1477, -4977484560265914954, '_lastUpdated', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (1478, 7848594347163185132, 'target-code:of-type', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (1479, 8680554728769599085, 'practitioner', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (1480, 3374072609444510364, 'category:of-type', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (1481, -7370363907340624887, '_id:of-type', 'CatalogEntry');
INSERT INTO public.hfj_spidx_identity VALUES (1482, 5184711205721403797, '_id:of-type', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (1483, 2137590003676627660, 'intent:of-type', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1484, 7375858673047561080, 'status', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1485, -7710851833717728437, '_id:of-type', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (1486, -997269592191182894, '_tag:of-type', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (1487, 1184327941381221698, '_source', 'MedicinalProductUndesirableEffect');
INSERT INTO public.hfj_spidx_identity VALUES (1488, 7448279173913075044, 'version:of-type', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (1489, -3773092788703240663, 'jurisdiction:of-type', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1490, 5314416852992023450, 'identifier:of-type', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (1491, 8838121889630038012, 'code:of-type', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1492, 6674288641474450528, '_id', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (1493, -8314543857016071546, '_tag', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1494, 7606241272870523305, '_profile', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1495, 4698704089475094466, 'subject', 'MedicinalProductUndesirableEffect');
INSERT INTO public.hfj_spidx_identity VALUES (1496, 2235717190927555028, 'identifier:of-type', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (1497, -526804402491736927, 'context-type', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1498, -6134929761693356523, '_id', 'SubstanceNucleicAcid');
INSERT INTO public.hfj_spidx_identity VALUES (1499, -399162755665208960, 'context-quantity', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1500, 3080620254150346984, 'payload-type', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (1501, 7531694127156246540, 'identifier:of-type', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (1502, -5050325534206418261, 'requester', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1503, -6228956876521263639, '_security', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (1504, -1963038713893752547, 'factor-override', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (1505, 1217526789322816957, '_profile', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (1506, -33276300903881559, 'location', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1507, -7763392465173209109, 'status:of-type', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1508, -7500490670012978849, '_tag', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (1509, -8165632881475271009, 'context', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1510, -7382384644359571170, '_lastUpdated', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1511, -520124187347837319, 'context-type', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1512, 5813061263909918032, 'endpoint', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (1513, 3195918785605199087, '_security:of-type', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1514, 8833445568414868483, 'code:of-type', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (1515, 1701442614548697614, '_security:of-type', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (1516, -2802472564197170091, '_lastUpdated', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (1517, -2742242010959805069, '_tag:of-type', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (1518, 5608203098617898505, '_id:of-type', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1519, -4803584720521453278, '_tag', 'MedicinalProductPackaged');
INSERT INTO public.hfj_spidx_identity VALUES (1520, -3813989424877483179, 'code', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (1521, -778487521650788127, '_security:of-type', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (1522, -7611099661720677377, '_id:of-type', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (1523, -691667255188125675, '_id:of-type', 'MedicinalProduct');
INSERT INTO public.hfj_spidx_identity VALUES (1524, 1621811419552177403, 'created', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (1525, 4649560424085494986, '_id:of-type', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1526, -5850132853112971988, '_security:of-type', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (1527, 7672849404991010714, '_profile', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (1528, -2121507344028567141, '_tag', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (1529, 620099042933851747, 'part-of', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1530, -6141102911348634665, 'result:of-type', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (1531, 1871339368023305319, 'encounter', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1532, 4047459346537943653, '_id', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (1533, 5801154513541150893, '_id', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1534, 7580620960797014817, 'target-disease:of-type', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (1535, 6325613586720990340, 'identifier', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (1536, -9034986128598831476, '_profile', 'EnrollmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1537, 1006023638760909445, 'use', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (1538, 1519597904913842527, 'part-of', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1539, 8864003150523291565, 'code', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (1540, 5264111522529110857, 'name-language:of-type', 'MedicinalProduct');
INSERT INTO public.hfj_spidx_identity VALUES (1541, -2491898612940035877, '_source', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (1542, 7637727243658583470, 'address-use', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (1543, 797614261352664292, '_lastUpdated', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (1544, -6277597917023553102, 'verification-status', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (1545, 4746049587531076018, 'location', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (1546, -2805616182897054706, '_id:of-type', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (1547, -2697340703628043317, 'identifier', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1548, -8644524652321619670, 'context-quantity', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1549, -5065169552351929434, '_tag:of-type', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1550, -3181575028718058683, 'identifier', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1551, -6378357614947614309, '_tag:of-type', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1552, 1807887067665182042, 'intent:of-type', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (1553, 7190055248217588304, 'patient', 'DeviceUseStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1554, -3555080082523785220, 'phone:of-type', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (1555, -7335574529118041413, 'date', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1556, -2888244792531496365, 'location', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (1557, -2439107890725084210, 'participant', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (1558, -9113137769389662345, '_id:of-type', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (1559, 3552703562668414112, '_source', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (1560, 5489185839442772648, 'context-type:of-type', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1561, -3384133136946119800, 'enterer', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (1562, -4468387728176172474, '_tag:of-type', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1563, -51841806506470879, '_id', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1564, -3194143038059722975, 'status:of-type', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (1565, -8773664605662909376, '_tag', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (1566, -7002266390892294969, '_security', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (1567, -1721214006109202821, 'identifier', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (1568, -5474921133926196530, 'evidence:of-type', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (1569, -81804739953470974, 'previous', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (1570, -8995502318831157945, 'email:of-type', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (1571, -2881126215441558391, '_id', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (1572, -6739078897343036029, '_security', 'Binary');
INSERT INTO public.hfj_spidx_identity VALUES (1573, 1200550355046452992, '_id', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (1574, -2485494004246085032, 'identifier', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (1575, -5691520955464472306, '_source', 'MedicinalProductPackaged');
INSERT INTO public.hfj_spidx_identity VALUES (1576, 8621134032969178683, '_id', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (1577, -5500736511020459669, 'topic', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (1578, -4772473274000597984, 'status:of-type', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (1579, -5341569979678812171, '_lastUpdated', 'CatalogEntry');
INSERT INTO public.hfj_spidx_identity VALUES (1580, 5115389576517168989, 'email:of-type', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (1581, 7297422532243906064, 'part-status', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1582, -8700046520426257360, 'version:of-type', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (1583, -7071468453885335853, 'severity', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1584, -8919653564792358065, 'depends-on', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1585, 8724447649060701706, '_tag:of-type', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1586, 9134110494671527928, '_tag:of-type', 'SubstanceSpecification');
INSERT INTO public.hfj_spidx_identity VALUES (1587, -3008866932305159947, 'group-identifier', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (1588, 8804097535499960129, 'requester', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1589, 812664572186527196, '_tag:of-type', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (1590, -3157423440799042597, '_lastUpdated', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (1591, -9221337947569068311, 'value:of-type', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (1592, 8135390229814025685, 'email', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1593, 2286204739459910066, '_profile', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (1594, -5418801393024900603, 'context-type', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1595, 2316246905728209964, '_security:of-type', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1596, 5143000616690685871, 'status', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (1597, -3660290329866263634, '_security:of-type', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (1598, -7742374290884827926, 'subject', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (1599, -8568906258507863434, 'service', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (1600, 5483828897292919596, '_tag', 'MedicinalProductUndesirableEffect');
INSERT INTO public.hfj_spidx_identity VALUES (1601, -387660344414352997, 'jurisdiction', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (1602, -5313265834462175388, 'related-id', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (1603, 9122105257919956134, 'member', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (1604, -964169525356185150, '_lastUpdated', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1605, -4714491418136621409, 'identifier:of-type', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (1606, -3654957526316464476, 'identifier', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (1607, 3951224567411296539, '_id:of-type', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1608, -5591976997836973705, '_source', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1609, -2707815647636233902, 'bodysite:of-type', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (1610, 4366071771053049001, 'route', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (1611, 8565729711188936729, '_security:of-type', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (1612, -6162950958925724209, 'outcome:of-type', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1613, 4949712230047330239, '_tag:of-type', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1614, 4519177223538170217, 'date', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (1615, -6007669436154623817, '_source', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (1616, 8310379557496175141, '_tag:of-type', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (1617, -1761513139249018075, 'service', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (1618, -7744261274762910600, 'subject', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (1619, -6074740334716281735, 'identifier', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (1620, -4230473017858443614, 'version:of-type', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1621, -389266350336106098, 'identifier:of-type', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1622, 4755241507306884417, '_id:of-type', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (1623, -3386578390057311480, '_lastUpdated', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (1624, -1683260071974593427, 'outcome:of-type', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1625, 5305565394337232472, 'status', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (1626, 1449909523981578752, 'value-string', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1627, -4294578826687983095, 'interpreter', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1628, 4808807461557045105, 'subject', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (1629, -6260906221968533790, 'address-country', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1630, 5278282324664244186, '_tag', 'MedicinalProductIngredient');
INSERT INTO public.hfj_spidx_identity VALUES (1631, -3768941053967929345, 'supported-profile', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1632, 1384059400138230337, '_security:of-type', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (1633, -5474949350581357756, 'responsibleparty', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (1634, -8417443870000747245, 'intent', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1635, -9067341704401427339, '_id', 'EnrollmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1636, -6869113732058791511, '_lastUpdated', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (1637, 8224585045285618959, '_security:of-type', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1638, 3655456393457449441, 'date', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (1639, -2243684955071374540, 'identifier', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (1640, 2665009876400509941, 'setting', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (1641, 1475858253711970555, '_tag:of-type', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1642, 1307992553295414517, 'category', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (1643, -3658377225387076475, 'url', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1644, 5519733196997003242, 'status', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1645, -4485701151501643365, 'near', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (1646, 4039170381363931875, 'topic', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (1647, -3603231012011581886, 'status', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1648, -4569689765598810409, 'status', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (1649, -1225639354128740935, '_security:of-type', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (1650, 2548198646749600893, '_lastUpdated', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (1651, -2600447079809969975, 'location', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1652, 8843927916074771793, 'topic:of-type', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (1653, -5176242382621014807, '_tag:of-type', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (1654, -6480246842126436539, 'care-manager', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (1655, -8314812587879811752, '_security', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1656, -4402170614703441785, 'recorder', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (1657, 2608583890074648834, 'description', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (1658, 8108869102769161094, 'type:of-type', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1659, 8773879773440925638, 'substance-reference', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (1660, -6232352482713345033, 'class-value', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (1661, 4400083668656880465, 'family', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (1662, 835063419677541970, 'reason-code:of-type', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (1663, -819211368990137711, '_tag:of-type', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1664, -1439110534476391846, 'reason-reference', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (1665, 4919199071108462378, '_id', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (1666, 7039464120771898271, '_source', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (1667, 7191344693725520387, '_profile', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (1668, -5817172573448782937, 'active', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (1669, 105511333399788874, 'context-quantity', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1670, 3901929707544634412, 'context-type:of-type', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1671, 4288321313040489040, '_id:of-type', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1672, 5577670208375753402, 'code', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1673, -5383598019680361736, 'jurisdiction:of-type', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1674, -4793138834506833897, 'receiver', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (1675, -2189194866414285095, '_source', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1676, 5436942939694296042, '_security', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (1677, -3618704863878464075, 'type', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1678, -681854660008408731, 'specialty', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (1679, -1650728023753043200, 'actual', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (1680, -1442251135571618183, '_source', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (1681, -6721691542978275713, '_source', 'SubstanceSpecification');
INSERT INTO public.hfj_spidx_identity VALUES (1682, 4226981867500517808, '_security:of-type', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (1683, 2437038954454136118, '_lastUpdated', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (1684, -5578616958909277398, 'status:of-type', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (1685, 4113755401587897647, 'status:of-type', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (1686, 8568533517766291385, '_lastUpdated', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (1687, -9101173603882286864, '_profile', 'MedicinalProductContraindication');
INSERT INTO public.hfj_spidx_identity VALUES (1688, -3733883290744741468, 'start', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1689, -6093118174910039236, 'status:of-type', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (1690, 6495618651740502778, '_source', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1691, 9167768776708121477, 'has-member', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1692, -1207529384264153791, 'status', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (1693, 5253951912500014350, '_security', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (1694, 7928033690592026302, 'date', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (1695, -7690425134383032316, 'composed-of', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1696, -1640005977125101952, '_security:of-type', 'ObservationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1697, 6327665179572735776, '_lastUpdated', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1698, -1658630215642147451, 'identifier', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (1699, 8159245159118284935, 'type', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (1700, -4743001284825241466, '_source', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (1701, 4278876218353239024, 'dependent', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (1702, 4293035508054124552, 'url', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1703, 5188782727197868544, 'based-on', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1704, 7986691576827188021, 'status:of-type', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (1705, 3231785604811889923, 'actual:of-type', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (1706, -1307810387723641440, 'category:of-type', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (1707, -7280838102049305172, 'patient', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (1708, 8156953906071771384, 'jurisdiction', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (1709, 3438935047667256417, '_security', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1710, 3802856343164294247, '_id', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (1711, 76616302361125380, 'part-of', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (1712, 4846847694785446440, 'category:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1713, 3179402219836613931, '_source', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1714, -344674070644421832, '_security:of-type', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (1715, -3615709768686648457, 'encounter', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (1716, 3251550574940244700, 'payment-status', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (1717, -4828794211013125729, 'event', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1718, -5685405257563730285, 'gender', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1719, 6714188565746066648, '_profile', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (1720, -2029842265750577556, '_profile', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (1721, 5191083821198438828, '_id:of-type', 'MedicinalProductManufactured');
INSERT INTO public.hfj_spidx_identity VALUES (1722, 2703542758095872100, 'period', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (1723, 7257452564261060164, '_lastUpdated', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (1724, -8320308925988058055, 'ingredient', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (1725, 5508656797359112493, '_profile', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1726, -1910398692308412111, 'address', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (1727, -5495639859280672173, 'description', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (1728, 2148115944345436560, '_security:of-type', 'MedicinalProductUndesirableEffect');
INSERT INTO public.hfj_spidx_identity VALUES (1729, 5815527362611404476, 'type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (1730, -2223202056323442901, 'category', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (1731, -767148969604509502, 'study', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (1732, -2766865320289117553, 'encounter', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (1733, -3068467899757274886, '_profile', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (1734, -1103914243308006096, 'recipient', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (1735, 1714698937291944766, 'evidence', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (1736, 1668772305306904326, '_security', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (1737, -917223604744496563, 'date', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (1738, 7436237393740432830, '_profile', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (1739, 7287169603855923108, 'outcome', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1740, 1882281173400846932, 'manifestation:of-type', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (1741, 134577244001428581, 'address-city', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1742, -846578668938135190, 'medication', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1743, 7432128934586736561, '_security:of-type', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (1744, 6982642323971476144, 'disposition', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1745, -5558218601009861088, 'context', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (1746, 7622300840389072634, 'encounter', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1747, -5170191947998482285, '_id', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (1748, 2395967823641064357, 'identifier', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (1749, 1593574824397433187, '_id', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1750, 591021888370848306, 'status:of-type', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (1751, 3418697669910435576, 'priority', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (1752, 8018912938784184074, 'window-end', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (1753, 1684493491436063376, '_security:of-type', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1754, -4354376250046983082, '_security', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1755, -4245051422783445745, 'reason-code', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (1756, -952171092911580765, '_tag:of-type', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (1757, 6509930271746420445, 'derived-from', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1758, -5088619874676464326, 'type:of-type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1759, 3988484741245643590, 'source', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (1760, 4807193021688484351, 'depends-on', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1761, 905091471324352835, '_id:of-type', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1762, 5131963379757230006, '_profile', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (1763, -9112632878366159131, '_source', 'VerificationResult');
INSERT INTO public.hfj_spidx_identity VALUES (1764, 555133297403166840, 'reporter', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (1765, 2336293524855048517, '_security:of-type', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (1766, 2131169205192071822, 'investigation', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (1767, 2147573961885405790, '_profile', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (1768, -7389343303464843191, 'provider', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (1769, -426483591525300702, 'context:of-type', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1770, -3424713410474432041, '_id', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1771, 6837431820403953161, '_security', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (1772, 6981740515349507184, 'address', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1773, -140122789585040628, 'monitoring-program-type:of-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (1774, -529771216363479839, '_id:of-type', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1775, 8143605179907270761, 'special-arrangement:of-type', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (1776, 1283541670308737394, 'title', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1777, 7292902785339584259, '_lastUpdated', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (1778, 6739175359048254769, 'code', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (1779, 6612881413486563364, 'recorder', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1780, -65938632773608081, 'code', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (1781, 2405025338185944367, 'category:of-type', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1782, 4738794504597290054, '_source', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1783, -5071573120861118527, 'effective', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1784, 5181688760532259409, 'action:of-type', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1785, -5745045530755497737, '_tag', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (1786, -8217196437528728058, 'topic', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1787, -2800906539108739108, 'insurer', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (1788, -3829677477481944082, '_source', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1789, -8235271962172560262, 'content-mode', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1790, 7839953633377350534, 'name', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (1791, 8862320090152494960, 'location:of-type', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1792, 5865387621386157791, '_id', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (1793, -8281636129262571901, '_security:of-type', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (1794, 5136376423413060182, '_tag:of-type', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (1795, -8097429212392091173, 'patient', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (1796, 6799935411153478157, 'context', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1797, 4806767798501132305, '_id:of-type', 'MedicinalProductUndesirableEffect');
INSERT INTO public.hfj_spidx_identity VALUES (1798, 6204872773802586651, 'subtype', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1799, 3982895881427762238, '_id', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (1800, 1109088448941610692, '_tag', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (1801, -9181477766525400310, 'instance', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1802, 504508910573934577, 'type:of-type', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (1803, 4377351360640375154, '_lastUpdated', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (1804, 1443064131323824280, 'source', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (1805, -5190087667171112954, '_id:of-type', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (1806, 4140231966966102233, 'performer', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1807, 4176245285869010432, 'insurer', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1808, -2594282199840981359, 'claim', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (1809, -4893908032049791333, 'identifier', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (1810, -896975707543263925, '_id:of-type', 'ObservationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1811, -3863126870651690919, '_security', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (1812, 7188337431071263116, 'contenttype', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (1813, 1829541250994516006, '_id:of-type', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (1814, 5896133050017316491, 'criticality:of-type', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (1815, -8648470329485045413, '_security:of-type', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (1816, 9000208975517887656, 'communication', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (1817, -4506773185130419719, 'identifier:of-type', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (1818, 7198288544097635114, 'reason-reference', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (1819, -3782743975003897737, 'last-date', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (1820, 2024629193067106051, 'characteristic:of-type', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (1821, -5875660355028144652, '_id:of-type', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (1822, -1829434065440286554, 'identifier', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (1823, 2506509373431539686, 'status-reason', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (1824, 409474430833606991, 'protocol', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1825, 7905886390165488723, '_tag:of-type', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1826, -5035058481543740702, 'identifier:of-type', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (1827, -5851787705755588119, 'context:of-type', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1828, -1572571451137304592, '_lastUpdated', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (1829, -946579633008347463, 'identifier', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1830, -5391864478109865072, 'code', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (1831, 6270458305202526141, 'description', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1832, 1422188072468204580, 'type', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (1833, -2664821525025458529, '_tag', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1834, -92776468937297945, 'context', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1835, -2828534892508295328, 'contact', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1836, 5982916867533243984, 'status:of-type', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1837, 3307560471345134225, '_source', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1838, 8495759344904314795, '_id', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1839, -1572690964090496947, 'owner', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (1840, 4618532322856932695, 'version', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (1841, -6939216299169611726, '_security', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1842, 3004822254933971631, '_security:of-type', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (1843, 5772620506404013298, 'agent-role', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (1844, 790652703750588220, '_lastUpdated', 'MedicinalProductIndication');
INSERT INTO public.hfj_spidx_identity VALUES (1845, -8928212006618654712, 'combo-code:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1846, -4783536945220181590, '_security:of-type', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1847, 4874724952951455037, '_tag:of-type', 'SubstancePolymer');
INSERT INTO public.hfj_spidx_identity VALUES (1848, 4582647641526745562, '_tag', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (1849, -8110667645343404615, 'condition', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (1850, 4378641116274134061, '_id:of-type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1851, -4614499711738210611, '_source', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (1852, -8562069712827124888, 'predecessor', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1853, -2053529563462701901, 'status', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (1854, 3768139374055992524, '_tag', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1855, -8496464853755619857, '_security', 'SubstanceSourceMaterial');
INSERT INTO public.hfj_spidx_identity VALUES (1856, -3695201290184789297, 'recipient', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (1857, -5205605523194088672, 'context-type:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1858, 7690060726791474908, 'context-quantity', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (1859, -2077596379165548657, 'telecom', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (1860, -7318559546915530578, '_id', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (1861, -6347175833721652642, '_tag', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1862, -6725317755162106637, 'type:of-type', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1863, 8660507112765262574, '_lastUpdated', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1864, 6311605914357191841, 'source', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1865, 169013658991060380, '_id:of-type', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (1866, 2578521237299074870, '_id:of-type', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1867, 1950384363035057563, 'context-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1868, -6936828997610729451, '_lastUpdated', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1869, -7505004629958993707, 'clinical-status:of-type', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (1870, 4546917466381343812, 'organization', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (1871, 8694956613023627343, '_tag:of-type', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (1872, -7413078953728850604, 'status:of-type', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1873, 4505768536863444299, 'performer-actor', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (1874, 2705558237013058454, 'composition', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (1875, 4727206074668340582, 'tester', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (1876, 657153380785198222, 'identifier:of-type', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1877, 1860304641685878246, 'intent:of-type', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1878, 677169958291755813, 'composed-of', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (1879, -3995464527048949114, 'reason-code:of-type', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (1880, 904255688738159272, 'identifier', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1881, -1330715139021869617, '_lastUpdated', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (1882, -6651085038821793675, 'type', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (1883, 376209136481763568, '_security:of-type', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (1884, 4648031753770566714, '_lastUpdated', 'Binary');
INSERT INTO public.hfj_spidx_identity VALUES (1885, -5399618521038154585, '_source', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (1886, -7449670289460133126, 'context-type:of-type', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1887, -8288665694062442182, 'testscript-capability', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (1888, 3208180093468269605, 'identifier:of-type', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (1889, -72764169588671452, '_id:of-type', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (1890, -552304711735623574, '_security', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (1891, -5958286289856046914, '_tag:of-type', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (1892, 4020413901600723147, '_profile', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (1893, -3300356835677295233, 'name', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (1894, 6270412161444485956, '_lastUpdated', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (1895, -7427589199986439290, '_id:of-type', 'MedicinalProductIngredient');
INSERT INTO public.hfj_spidx_identity VALUES (1896, 4535113350512487110, '_tag', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (1897, 1383855778447502368, 'status', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (1898, -5017685900751494914, 'category:of-type', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (1899, 2706342513280342500, 'patient', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (1900, -2585791854321273622, '_lastUpdated', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1901, -3677085933454141912, 'type:of-type', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (1902, 7494376251236465550, 'date', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (1903, 5762770164779709979, 'version:of-type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (1904, -7593224451864714715, 'code', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (1905, 6315896011488964006, 'context', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (1906, 7140280316607820026, 'description', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1907, 2128270506666246156, '_id:of-type', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (1908, 5283560827256509176, '_security:of-type', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1909, -2750689578767172236, 'formula:of-type', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (1910, 2241230720681662842, 'manufacturer', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (1911, 4959477588773191913, 'context:of-type', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (1912, -5401372675908109020, 'context-type', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1913, 3369049562219595855, '_id', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (1914, 4224566715471495988, '_security', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (1915, -7366148698741121320, 'address-city', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (1916, -1418010421391889538, '_id:of-type', 'Binary');
INSERT INTO public.hfj_spidx_identity VALUES (1917, 7589194519770529314, 'schedule', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (1918, -868454508702792979, 'system', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1919, 1314287140458181081, 'organization', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (1920, -2037564297801088460, 'patient', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (1921, -8385908960242133835, 'purpose', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (1922, -7741164771259501717, 'context-type', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (1923, 5359632135242796440, 'status:of-type', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (1924, -6055935734032459261, 'status:of-type', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1925, -206099685784574678, '_id:of-type', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (1926, 1143465206129690927, '_security:of-type', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (1927, -1569692162637954777, 'version:of-type', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (1928, 2234813910095981358, 'encounter', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (1929, -6295945642969080093, 'agent-name', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (1930, 3302553200328757049, 'jurisdiction', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1931, -1435878463377364781, 'publisher', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1932, -1143071853032191878, 'reason-not-given:of-type', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (1933, -5624759617202906213, 'identifier', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1934, -3201974523335439556, 'content-type:of-type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (1935, -3314287898649999851, '_tag:of-type', 'MedicinalProductIngredient');
INSERT INTO public.hfj_spidx_identity VALUES (1936, 8335378615172236703, 'description', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1937, 3997973987376809138, '_security:of-type', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (1938, -4995174903006334420, 'route:of-type', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (1939, -6061152363913281603, 'request', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1940, -2419028459884870082, 'medium:of-type', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (1941, -8235926109848862139, 'other', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (1942, -1363775158781377871, 'endpoint', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (1943, 8752804976019515921, '_id', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1944, -5590393685699285790, 'conclusion', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (1945, 1551814103896106589, '_tag', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (1946, 8275625422291065646, 'patient', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (1947, 27484213834106628, '_id', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1948, 6664161203764791865, 'deceased:of-type', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (1949, 5446814359444737588, 'status', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (1950, 1648452175982794645, '_id', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1951, 1852977721818166288, 'patient', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (1952, -4617274031993192613, '_id', 'MedicinalProductIndication');
INSERT INTO public.hfj_spidx_identity VALUES (1953, 3840830735402004756, '_lastUpdated', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1954, 759758505620344098, '_id', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1955, 6680245760131929351, 'name', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (1956, 1207755179829512737, '_source', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (1957, -4770494681199938348, 'service-category', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (1958, 6665041820221205057, 'identifier:of-type', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1959, -2011731209292661007, '_security', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (1960, -268242294435725228, 'context-type:of-type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1961, 8318712175371799399, 'intent:of-type', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1962, -2593747694995646588, 'date', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1963, 4592234170619824979, '_source', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1964, 4530314232593997252, 'context', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1965, -2068568209557972549, 'type', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (1966, 8989108607381797121, 'priority:of-type', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1967, 3608440848856338348, 'formula', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (1968, 1767988213140401583, 'attester', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (1969, -2015495565053870491, 'lot-number', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (1970, 6190813489776420012, 'encounter', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (1971, -3637676619823239216, 'context-type', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (1972, -8503223077225132086, '_security', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (1973, 2798529434703108120, '_security:of-type', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (1974, 3037064521379691897, 'context:of-type', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1975, 4273303982712212294, 'code', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (1976, 112204499481699496, '_profile', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (1977, 5378918534239733702, 'code', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (1978, -937428041773362469, '_tag:of-type', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (1979, 488472710739129879, '_id', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (1980, -1355256589096116580, '_security', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (1981, 7488785096623697755, 'based-on', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (1982, -8016560848161038266, '_tag', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1983, 251448910447217605, '_lastUpdated', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (1984, 4035325378505640038, '_id:of-type', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (1985, -8850991107532023902, 'group-identifier:of-type', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (1986, 3084483952575526442, '_lastUpdated', 'MedicinalProductIngredient');
INSERT INTO public.hfj_spidx_identity VALUES (1987, -3532424473517220370, 'relatesto', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (1988, 598543940944005898, 'date', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (1989, -3088487587626559947, '_tag:of-type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1990, 6209303896661737870, 'address-state', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (1991, -2700872915802763426, 'identifier:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (1992, -8818685333176468926, 'part-of', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (1993, -3796825346506434856, 'location', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (1994, -4837052605276332642, 'phonetic', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (1995, -7671745695498552477, 'type:of-type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (1996, -8465784575568676131, '_id:of-type', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (1997, 2255293283549704696, 'code', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (1998, 945886210573103552, 'payment-status:of-type', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (1999, -8508262125610194975, 'type', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2000, -7551185124862800644, 'patient', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2001, 2828591330438792102, 'status:of-type', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (2002, 8884575947829106278, '_tag:of-type', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2003, 8630051408121741831, '_id', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (2004, 4905455311041143908, 'context', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2005, 4376783820369108750, '_id:of-type', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (2006, -1404605561563042151, 'context', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (2007, -7139789220468970400, '_lastUpdated', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2008, -2527444248898035413, 'identifier:of-type', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (2009, 4529308070871738405, '_id', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (2010, -8269109444847106267, '_id:of-type', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (2011, -4517880139150322872, 'general-practitioner', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (2012, 2595472287370185871, '_profile', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (2013, -2414432486947800946, '_tag:of-type', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (2014, 2142834930954017470, '_tag', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2015, -1464771765727849117, 'version', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (2016, -7565301855465296245, '_id', 'SubstanceSourceMaterial');
INSERT INTO public.hfj_spidx_identity VALUES (2017, 5283548746741910582, 'replaces', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2018, -1352864004526098082, 'date', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2019, -5590244379753040651, '_security', 'MedicinalProductInteraction');
INSERT INTO public.hfj_spidx_identity VALUES (2020, -3928508575193576378, '_source', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (2021, 4460938391250816169, 'successor', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2022, 7177223691333345277, 'destination-uri', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (2023, -6624663816096475239, 'status', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (2024, -3503255391454821494, 'condition', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (2025, 244673438693328098, '_security:of-type', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (2026, -9208284524139093953, 'family', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (2027, 2009941689455924721, 'subject', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (2028, -6724983663102233041, 'jurisdiction:of-type', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (2029, -1694951968869529475, 'request', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2030, -8017046556640511045, 'event', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2031, -4030091633737135669, 'reason-reference', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (2032, 1629995108554753144, '_lastUpdated', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2033, 7765483524441642153, 'type', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (2034, 6819163144189824684, '_security:of-type', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (2035, -1001287415589454379, '_security:of-type', 'CatalogEntry');
INSERT INTO public.hfj_spidx_identity VALUES (2036, 8860880580078776282, '_source', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2037, -1105209866081050052, '_security', 'OperationOutcome');
INSERT INTO public.hfj_spidx_identity VALUES (2038, 1376901099483701471, 'patient', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (2039, -3529820315498281009, '_security', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (2040, 7301587770237270397, 'role', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (2041, 1009154895418743261, 'length', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (2042, -2434481915788574015, '_source', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2043, 7979202262741009183, 'characteristic', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (2044, 5180398849986505922, 'diagnosis', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (2045, 6562129103244996030, 'subject-type:of-type', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (2046, 2795467764543341913, 'status:of-type', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (2047, -7980186104055265756, '_tag', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2048, -2586382759613078344, 'performer', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (2049, 7660778714293749125, 'information', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (2050, 671783701284097057, 'owned-by', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2051, 1890111280578815737, '_source', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2052, 4222590078347672549, 'instance', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2053, -6166002671110349511, '_security:of-type', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (2054, 6809314513827217312, 'program:of-type', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (2055, -1606026877511670093, 'identifier', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (2056, -7832557877188168470, '_tag', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2057, 2023644491791257406, '_tag', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (2058, 5768715772784530727, '_id', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (2059, -6561503722993157373, 'code', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (2060, -809549337329952277, '_tag', 'MedicinalProductIndication');
INSERT INTO public.hfj_spidx_identity VALUES (2061, -4491089555711677592, 'type:of-type', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (2062, -4192537295309154416, 'category', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (2063, -4067264457122549511, 'udi-di', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (2064, -2090179406538290113, 'category:of-type', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2065, 8622244076909933148, 'date', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (2066, 5644589177526262411, '_tag', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (2067, 3686451076158659200, '_id:of-type', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (2068, -3370031561502196814, '_id:of-type', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (2069, -4631429213856198705, 'monograph-type:of-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (2070, 740528658987215398, 'context-type:of-type', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (2071, 2970078391081095841, '_security:of-type', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (2072, 5509705517230027391, 'specialty', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (2073, -7455418209889019441, 'price-override', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (2074, 3828742017525676287, '_lastUpdated', 'SubstanceSpecification');
INSERT INTO public.hfj_spidx_identity VALUES (2075, -2889521223007644162, 'context-type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (2076, -8870326599441367809, 'identifier:of-type', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (2077, 7346229255687822538, '_security:of-type', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2078, -9056948256763705552, 'actuality:of-type', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2079, -9091330281044863372, 'description', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (2080, -4441088189498542793, '_lastUpdated', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (2081, 8528820096670509013, '_tag:of-type', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (2082, 7527190206806026474, 'name', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2083, 3454992065383998088, '_id', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (2084, -2317638910987009507, 'context-type', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (2085, -7742159117295966653, 'derived-from', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2086, -676898014927988794, 'status:of-type', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (2087, 2073342328278662474, 'source', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (2088, 5592081589440346647, '_id:of-type', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (2089, 7237001343947833743, 'category:of-type', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (2090, 7508733223201896884, 'category:of-type', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2091, 1442426062855045992, '_security:of-type', 'VerificationResult');
INSERT INTO public.hfj_spidx_identity VALUES (2092, -6624824199325720520, 'url', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (2093, -5400179370328338743, 'description', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (2094, -691380495838488320, '_security:of-type', 'EnrollmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2095, -938653150695278080, 'code:of-type', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (2096, 3723982091877037308, 'dependson', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (2097, 3990249177973178853, 'status:of-type', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (2098, -6044007395089919454, '_source', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (2099, 3006472421398796762, 'performer', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2100, 3998293049907215407, 'url', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (2101, 5326026089840033446, 'prescriber', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (2102, -3727564638886091614, 'description', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2103, -4501781415766792620, 'participant-type:of-type', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (2104, 8481614671213152241, 'context', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (2105, 5953445008674992499, 'requester', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (2106, -6264058779743608539, 'reason-code', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (2107, 7088574974779640563, 'patient', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (2108, 4501474634224272818, 'status', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2109, 136380788937885801, 'status:of-type', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (2110, 6516152656262509637, '_security', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2111, 2687982752733169310, 'facility', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2112, 6678669787253307889, 'identifier', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (2113, 4851184841073903753, 'device', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2114, 8445775774871878270, 'identifier:of-type', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (2115, 5610829721792485971, 'description', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (2116, 4261661085350803126, 'class', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (2117, 2855891467291056040, '_id:of-type', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (2118, -6389769226276016095, 'description', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2119, -4794410561121622104, 'patient', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2120, -7801194533316968864, 'status', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (2121, 6265686586059249424, '_lastUpdated', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (2122, -9161902430457350726, 'status:of-type', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (2123, 6889849449059132403, '_id', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (2124, -6549612339527942056, 'clinical-status', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (2125, -7388069517977525389, 'derived-from', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (2126, -8312840817747219757, 'abatement-age', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (2127, 8641522882192142626, '_profile', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2128, 6528727643142217630, '_id:of-type', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (2129, 424789685167538255, 'destination', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (2130, -4346598491489922154, 'patient', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (2131, -9190192470980034589, 'code:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2132, -2175887273988367464, 'name', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2133, -6985175525003338311, 'effective', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (2134, -1068480103807561771, 'identifier:of-type', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (2135, 5319215916298566398, 'destination', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (2136, -5999690393759880336, '_tag', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (2137, 6646685751811024911, '_id:of-type', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2138, -8185640948904666565, 'code:of-type', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (2139, 2064005440999524592, 'identifier', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2140, -782757189598328614, 'identifier:of-type', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (2141, -814620698560131331, 'security-label', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (2142, -1254955689101345914, 'agent-role', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2143, 5802485604063432397, 'version:of-type', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (2144, 3812430261190830058, 'publisher', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2145, 8268341719099630877, 'identifier:of-type', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (2146, 375557761192906079, 'status:of-type', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2147, -7906581139662763605, '_source', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (2148, 5647767753066896611, 'identifier:of-type', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (2149, 3492929173061663274, '_lastUpdated', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (2150, 1160022394658804790, 'name', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2151, 1714567192589185256, '_security', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2152, -4545924554099612862, '_profile', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2153, 6750478300795704399, '_profile', 'OperationOutcome');
INSERT INTO public.hfj_spidx_identity VALUES (2154, -1351183229971135714, '_tag', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (2155, 6541010055008918805, 'jurisdiction:of-type', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (2156, -5909075866416464026, 'related', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (2157, 2712795257983941135, 'stage', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (2158, 4856473860410701732, 'identifier', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (2159, -8370170337846482467, '_profile', 'Linkage');
INSERT INTO public.hfj_spidx_identity VALUES (2160, -3280308104568815291, 'group-identifier:of-type', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (2161, -5829226531075050755, 'context-type', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (2162, -3040735454135030303, 'patient', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (2163, 8344336061510547748, 'achievement-status', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (2164, -2764366773073495052, 'identifier', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (2165, -9028110851435831380, 'status', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (2166, -3374299128015744508, '_security:of-type', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (2167, -8657490577762712433, '_id', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (2168, 900833729887469554, 'location', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (2169, -987069410008623282, 'email:of-type', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (2170, 4639725745724755939, '_id:of-type', 'SubstancePolymer');
INSERT INTO public.hfj_spidx_identity VALUES (2171, 7797542675870553237, 'sender', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2172, 4440741087916346428, '_id', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (2173, 3111314031538966849, 'value', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (2174, -6592759567497693575, 'status', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (2175, -4904242348029210549, 'context:of-type', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2176, 686329783062350236, 'based-on', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (2177, 331348922720089239, '_profile', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (2178, 2339363468787124261, 'context:of-type', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (2179, -2388969352089995813, 'date', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (2180, 4029279727832955453, 'name', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2181, -5274284719103715885, '_tag', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (2182, -759374345252051806, 'modality:of-type', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (2183, 4238105744015413138, 'confidentiality:of-type', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (2184, 6906937665580230962, 'identifier:of-type', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2185, 8730165578784122054, '_profile', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2186, 1913770799434413142, 'stage:of-type', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (2187, -3774388204444172120, 'performer', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (2188, -9017678026377998633, '_id', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2189, -3300719910214757014, 'predecessor', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (2190, 8394007005180337668, 'address-country', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (2191, 7236300805658457870, 'combo-value-quantity', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2192, 6667586687559433260, 'date', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2193, 8795290993795840666, 'active:of-type', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (2194, 1704647578015420912, 'reason-code:of-type', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (2195, 6990424265304986000, '_source', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (2196, -1802721542871810273, '_tag:of-type', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (2197, -8417110071485617156, 'composed-of', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (2198, -1512672217954579686, '_id', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (2199, -3385550085648264947, 'context-quantity', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (2200, 6070316350439084298, 'phonetic', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (2201, 2792615968911658280, '_security:of-type', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2202, 820685236980238004, '_id', 'DeviceUseStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2203, 7832254081747166103, 'status', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (2204, 5546706183205294056, 'identifier:of-type', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (2205, -5789760067935635411, '_lastUpdated', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (2206, -8385678100973311816, '_security:of-type', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (2207, 2582276059212591951, 'identifier', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (2208, 4004101489382067740, 'code', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (2209, -7372693719654166959, '_security', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2210, 5893940930765639439, '_security', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2541, -9071178369873725816, '_tag', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2211, -5727408486356390817, '_tag:of-type', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2212, 587534003194039626, 'focus', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (2213, -806517979015989109, '_id', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (2214, 8445539953215560832, 'predecessor', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2215, 4691740931926766227, 'jurisdiction', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2216, -2287851845385365415, 'title', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2217, 5483414316669852311, 'address', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (2218, 7857497867082385603, 'subject', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (2219, 3753135968840584856, 'target', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (2220, 8123831910759199453, 'occurrence', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (2221, 4930377553605053603, 'code:of-type', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (2222, 5621623650247861409, '_tag:of-type', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (2223, -4082761391631530032, 'status:of-type', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2224, -4796190102557410916, 'format:of-type', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2225, -3174907129012598050, 'date', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (2226, -897547928321677346, 'security-service', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2227, -1894329799594853162, 'status', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2228, 385157973818654308, '_tag', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (2229, 3270458359621941203, 'severity', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (2230, -6883756583702498226, 'ingredient-code', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (2231, 3635316176400826850, '_profile', 'ObservationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2232, -7885456868076937980, 'custodian', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (2233, 9073720570380043841, '_source', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2234, 5990789052079092594, '_security', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (2235, -2881664074369840343, 'related-id', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (2236, -9118995218722668793, '_id:of-type', 'Parameters');
INSERT INTO public.hfj_spidx_identity VALUES (2237, -4489515845292175203, '_source', 'MedicinalProductContraindication');
INSERT INTO public.hfj_spidx_identity VALUES (2238, -7667271382582826076, 'intent', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (2239, -2202621046525917586, 'name', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2240, -4923788415909785474, 'publisher', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2241, 8327524938431519456, 'encounter', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (2242, 8501946297219705868, '_lastUpdated', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2243, -1478408830821814852, '_id:of-type', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (2244, -9081345047307394415, '_tag:of-type', 'Linkage');
INSERT INTO public.hfj_spidx_identity VALUES (2245, -4708220780269403008, '_tag', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2246, 705350155262882981, 'identifier:of-type', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (2247, 9089561809221813008, 'doseform:of-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (2248, -8862717201009374637, '_source', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (2249, 8649350346269593336, 'agent-role:of-type', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2250, -1701872344455940044, '_profile', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (2251, 6552330658470371869, '_lastUpdated', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2252, 7479000017046860270, '_tag', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (2253, 3239733882745014301, 'verification-status', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (2254, -1218141868038030579, 'part-of', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2255, 4406333232770409260, '_id:of-type', 'MedicinalProductIndication');
INSERT INTO public.hfj_spidx_identity VALUES (2256, 3498895891820569145, '_security', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (2257, 1374217571832329820, '_source', 'ObservationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2258, 8453670480609707299, '_tag', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2259, 7978921535089583583, '_id:of-type', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (2260, 3008135696175906941, 'category', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (2261, 7053661612401500982, '_id:of-type', 'MedicinalProductContraindication');
INSERT INTO public.hfj_spidx_identity VALUES (2262, -3894233582576134935, '_security', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (2263, -7005263569007524745, 'identifier:of-type', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (2264, -5096156711463983033, '_id', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (2265, 1672770964001560726, 'identifier:of-type', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2266, -8945658993415130381, 'vaccine-code', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (2267, 737815453624505866, '_lastUpdated', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (2268, 9055779174353718566, 'name', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (2269, 6553756610876866473, 'identifier:of-type', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (2270, -3885413751293784453, '_security', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (2271, 2174082537219871192, '_security:of-type', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (2272, 2360496421194598651, '_lastUpdated', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (2273, -5655131439792101560, 'service-category:of-type', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (2274, 7692698125846215100, 'context-type', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (2275, -5511045311807083906, '_id', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (2276, -8193390373564293855, 'version', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2277, -3912163105412874338, '_tag:of-type', 'ObservationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2278, 7711001610241844416, 'sponsor', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2279, 1818722131666542603, 'method', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (2280, 6542766199300835340, 'care-team', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (2281, -5517401774101642108, '_source', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (2282, -4875291959694412367, 'identifier:of-type', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2283, 3348695041365774239, 'code', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (2284, 7302787690533122944, 'manufacturer', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (2285, 6486109558181984690, '_id:of-type', 'OperationOutcome');
INSERT INTO public.hfj_spidx_identity VALUES (2286, 6350698714561349191, '_id', 'DeviceDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2287, -5933110975561747899, '_profile', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2288, -1528706508034340415, 'status', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (2289, -3899907572790656540, 'address-use:of-type', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (2290, 8360676562399334648, '_lastUpdated', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (2291, -2783627692070576262, '_lastUpdated', 'MedicinalProductUndesirableEffect');
INSERT INTO public.hfj_spidx_identity VALUES (2292, -2582254223612945185, '_security', 'MedicinalProductManufactured');
INSERT INTO public.hfj_spidx_identity VALUES (2293, 6765779373317662345, 'address-state', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2294, 2853810023513044258, '_id', 'MedicinalProductContraindication');
INSERT INTO public.hfj_spidx_identity VALUES (2295, -8646681186601379962, 'identifier:of-type', 'MedicinalProduct');
INSERT INTO public.hfj_spidx_identity VALUES (2296, -3039853059721594413, '_profile', 'SubstanceReferenceInformation');
INSERT INTO public.hfj_spidx_identity VALUES (2297, 448365032967212102, 'identifier', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (2298, 6807496515841984602, '_profile', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (2299, 3194488161178006578, 'device', 'DeviceUseStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2300, -1868325757675494182, 'identifier:of-type', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (2301, -4050962749628959932, '_security', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (2302, -4362434499305499847, 'patient', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (2303, 8616005194267831202, 'business-status', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (2304, -5696709209698450805, '_tag', 'Linkage');
INSERT INTO public.hfj_spidx_identity VALUES (2305, 3769386031641559528, 'title', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (2306, -8373549474269483076, 'type:of-type', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (2307, 5216351264060946908, '_tag:of-type', 'Binary');
INSERT INTO public.hfj_spidx_identity VALUES (2308, -1151173737432682387, '_id:of-type', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (2309, -7250429315697702081, 'bodysite:of-type', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2310, -6842618630532723106, '_profile', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (2311, 1142610086203790987, 'address-postalcode', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (2312, 170578447015505573, 'type', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2313, -4692400101472672815, '_security:of-type', 'Parameters');
INSERT INTO public.hfj_spidx_identity VALUES (2314, -959925700227533393, 'related-id:of-type', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (2315, 4889092177614882005, 'dicom-class', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2316, -3616381758255163309, 'context-type:of-type', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2317, -4791854353313579166, '_profile', 'MedicinalProduct');
INSERT INTO public.hfj_spidx_identity VALUES (2318, -6349355711120317444, '_tag', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2319, -2440056725511648271, 'identifier:of-type', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (2320, 9086449837555602321, 'identifier:of-type', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (2321, 5545859830503723266, 'context', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (2322, -1078496703716923675, '_tag', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2323, 3285871619883262846, '_id', 'SubstanceSpecification');
INSERT INTO public.hfj_spidx_identity VALUES (2324, -8861399621690064322, '_source', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2325, 5933037722134048367, 'date', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (2326, -4953347588672081062, 'name', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (2327, -3759466497487333865, 'reason-not-given', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (2328, 2601041439140791248, '_lastUpdated', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (2329, 2225358539118904209, 'classification-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (2330, 6280065832998392040, '_id:of-type', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (2331, -3502934598277839254, 'intended-dispenser', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2332, -6062178428473867660, '_source', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (2333, -1245207687771223304, '_tag:of-type', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (2334, 7734448762217204393, 'type', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (2335, 8990728747668949217, 'keyword', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2336, -7571102558782883401, '_tag', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (2337, 3167748692366720936, '_profile', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (2338, -7523520297697231326, 'item', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (2339, -1578820418010741323, 'date', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (2340, 3285241501055894318, 'context-quantity', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (2341, 5780364238007462031, 'patient', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (2342, -1555981980705898747, '_tag:of-type', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (2343, -594035759038639600, 'name', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2344, -4940572808761537965, 'monitoring-program-name:of-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (2345, 1244696966632426998, 'performer-type:of-type', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2346, -1148702818636904795, 'disposition', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (2347, 8098330441495805706, '_id', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2348, -2920830692186926210, '_profile', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2349, -5287492376500197933, 'publisher', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (2350, 2904528718514275107, 'organization', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (2351, -1360012929987471208, 'owner', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (2352, -5705888140617440601, '_id:of-type', 'EnrollmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2353, -8922398186127370862, '_tag', 'MedicinalProductContraindication');
INSERT INTO public.hfj_spidx_identity VALUES (2354, -480783591769212251, 'target-disease', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (2355, 2220023169053118950, '_security:of-type', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2356, 7532135439619254157, '_id:of-type', 'VerificationResult');
INSERT INTO public.hfj_spidx_identity VALUES (2357, -1399372714175952193, '_profile', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (2358, 1688410079211400461, 'outcome', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2359, 2494877603216601681, 'target', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (2360, 2216554888807683679, '_profile', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2361, 1083076355705782713, 'active:of-type', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (2362, -6224820438041516966, 'status:of-type', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (2363, 3839884885908687291, 'name', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (2364, 3578771879141171993, '_id', 'MedicinalProductInteraction');
INSERT INTO public.hfj_spidx_identity VALUES (2365, 2844485772334975594, '_security:of-type', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (2366, 4800906660769585780, 'abstract', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2367, 4569845298444651582, 'event:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (2368, -784294710684863877, '_tag', 'CatalogEntry');
INSERT INTO public.hfj_spidx_identity VALUES (2369, -7872311696654346672, 'context-type', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (2370, 8182620679731930527, '_profile', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2371, 1964869817630639407, 'telecom', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2372, 2817066266609047850, 'gender', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (2373, 8750806567525362651, 'address-use:of-type', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (2374, 3421567446114913173, 'resultingcondition', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2375, -2133049025040451189, 'service-category', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (2376, -7722489586054380352, '_tag', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (2377, 3147941213942719372, 'part-status:of-type', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (2378, 4531544810330440632, '_id', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2379, 2953578851061267481, '_security:of-type', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2380, -3505581971519356634, 'language:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (2381, -4366272193682632131, 'address-postalcode', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (2382, -790684971133676984, '_id:of-type', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (2383, 7996981289053746870, 'code:of-type', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (2384, -8665535774162534601, '_lastUpdated', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2385, 3583136414507814812, 'participant-role', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (2386, -8983134034089313995, '_id', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (2387, 7134552956748581406, 'jurisdiction', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2388, -7856290051404535931, 'window-start', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (2389, 6898512424189141138, 'context-quantity', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2390, -5645701548824832341, '_lastUpdated', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2391, 7336253474053248114, 'payee', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (2392, 8962042095363619987, 'successor', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (2393, -5318474236079471687, 'email', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (2394, -4761276146857330362, 'identifier', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (2395, 7441540388155531827, '_tag', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2396, 4724109360207641571, '_profile', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2397, -8040314502141969211, 'parent', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (2398, -4592900556204709125, 'outcome', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2399, -5848995977744445581, 'jurisdiction:of-type', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2400, 3562147416477723325, 'patient', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (2401, -7510307591146273185, 'context', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (2402, 588280233723377662, 'identifier:of-type', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (2403, -5452450395669306687, '_lastUpdated', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (2404, -7262346329637873103, '_profile', 'BiologicallyDerivedProduct');
INSERT INTO public.hfj_spidx_identity VALUES (2405, 7238730361976469892, '_id:of-type', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (2406, 3239733822319361801, '_id', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (2407, -7150789287521759442, 'value-concept:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2408, -4837238279117499515, 'route', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (2409, -8812497221011129026, 'entity-role:of-type', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2410, 461077578072196709, '_id:of-type', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2411, -4648511011734594870, '_source', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (2412, 2623193157769707333, 'conclusion:of-type', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (2413, -4062993987057475974, 'title', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (2414, 620990822594052930, 'status:of-type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2415, 2962015495993695466, 'identifier', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (2416, -7129972656150573880, 'mode', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2417, -1936750169923461013, '_profile', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (2418, -3317974677251002540, 'status:of-type', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (2419, -5352920721982601811, 'category:of-type', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2420, 5598246875386526649, 'identifier', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (2421, 4506098114908405108, '_security:of-type', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (2422, 3776912734612393409, 'type:of-type', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2423, 6374658699260239467, 'derivation', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2424, -3350689941831378661, 'context-quantity', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2425, -238284706312598366, '_tag:of-type', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (2426, -5838245798327955918, 'activity-date', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2427, 438640271049435797, 'identifier:of-type', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2428, -7971219131014804603, '_profile', 'MedicinalProductManufactured');
INSERT INTO public.hfj_spidx_identity VALUES (2429, -4118237532600977624, 'code', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (2430, -4496260809813492973, 'focus:of-type', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2431, -5860558630717189875, 'subject', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (2432, 3642154410330762218, 'accession', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (2433, 842778713258384600, '_security', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2434, 1232753403635987814, 'exclude', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (2435, -6078225481953782974, '_id', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2436, 6929171386055845018, 'status', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2437, -7201637919238321379, 'supplement:of-type', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (2438, -600769180185160063, 'url', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (2439, 184247469321534598, 'replaces', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2440, 992249362741346110, '_tag:of-type', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (2441, 1344306046504614769, 'source-uri', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (2442, 3146114796691013620, 'identifier:of-type', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (2443, -5305324927652504138, 'version', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2444, 7723661555023131606, 'identifier:of-type', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (2445, -8916077558291081457, 'subject', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2446, 8227169212128131784, '_id:of-type', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (2447, 2466403893674150317, 'status:of-type', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (2448, 6580949229122734676, 'status:of-type', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (2449, -5577085749082077875, 'component-value-concept', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2450, 4920921274994621922, 'started', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2451, -3259250335745521202, 'version', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (2452, -8740845074355767675, 'issued', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (2453, 1584414370225601038, 'status', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (2454, 5068828084232153060, 'definition', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (2455, 3891312111684864839, 'identifier', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (2456, 5033129802948610549, 'period', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (2457, -5634375366775780028, '_id', 'VerificationResult');
INSERT INTO public.hfj_spidx_identity VALUES (2458, 7292782829637884718, '_security', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (2459, 1976517285425517381, '_tag:of-type', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (2460, -62941838348874803, 'specimen', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2461, -7904889141215819161, 'fhirversion:of-type', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2462, -1847342867874292025, '_id', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (2463, -235781104821942960, '_tag', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2464, 2696508933554766369, 'service-type:of-type', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (2465, -8972835394480303911, 'active', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (2466, -2375008618750562265, 'agent', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (2467, -7172387862561109494, '_security', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2468, 3616025988603172589, 'context-type:of-type', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2469, -5575923958171628729, 'effective', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (2470, 4520745253412996910, '_lastUpdated', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (2471, 7919018908973487955, '_profile', 'CatalogEntry');
INSERT INTO public.hfj_spidx_identity VALUES (2472, -5118813975556535140, 'empty-reason', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (2473, 6682525227801523776, 'data', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (2474, -110427161222848860, '_id', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2475, -4231869210564285839, '_tag:of-type', 'MedicinalProductManufactured');
INSERT INTO public.hfj_spidx_identity VALUES (2476, 3645658676446720566, 'instantiates-canonical', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (2477, 4047644765584506107, 'context:of-type', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2478, 6835111133051671626, 'publisher', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2479, 3568619927436895806, 'measure', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (2480, -697279818969279814, 'version', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2481, -1381375255049373426, '_id:of-type', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (2482, -9053802086105039425, '_id', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (2483, -2911393490255495834, '_tag', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (2484, 3749081529008949596, 'modality', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2485, -5758206263406371365, '_security', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (2486, 1544286964373540162, '_security', 'MedicinalProductIngredient');
INSERT INTO public.hfj_spidx_identity VALUES (2487, -1282722301984002545, 'identifier', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (2488, 4162995020356590617, '_id', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (2489, -5577743628077233336, '_tag', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2490, 1921450485079793957, 'identifier', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2491, 1874900746778785977, '_tag', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (2492, -2939637482974219083, '_tag', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (2493, 7975638813040678331, '_lastUpdated', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (2494, 5070903461060016509, 'holder', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (2495, -5758322510084051391, 'context-type:of-type', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (2496, 1541657813570246082, '_tag', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (2497, 5980468786150659262, '_profile', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (2498, 2295642967317365995, 'type:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (2499, -8654971442618574489, 'context', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2500, 8716029507057368037, 'title', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (2501, -1555667218860553259, 'context-quantity', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2502, 4873918810551816624, '_tag:of-type', 'SubstanceProtein');
INSERT INTO public.hfj_spidx_identity VALUES (2503, -1493732337362878797, 'url', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (2504, -8325029876773786323, '_id:of-type', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2505, -8559286232743893120, '_tag:of-type', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2506, 4293778638255755329, 'status:of-type', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (2507, -6855538074577614256, '_lastUpdated', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (2508, -3520191432273808321, 'performer-type', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2509, 6279686776882747468, '_source', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (2510, 2484617155321763832, '_tag', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (2511, 8453997165379163159, '_tag', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (2512, -5503381643091628475, 'priority', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2513, -384272686325728130, 'subject', 'MedicinalProductIndication');
INSERT INTO public.hfj_spidx_identity VALUES (2514, -4556781742107424981, 'item-udi', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (2515, 4758199950651315464, '_source', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (2516, -6990983917964109290, 'probability', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (2517, 1949879495333569203, 'context-quantity', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2518, 7172635409433400898, 'encounter', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (2519, 1633902626927092339, '_tag', 'EnrollmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2520, 2084934596212639165, 'date', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (2521, 5477175399767389998, 'status:of-type', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (2522, -5393221270561457308, 'method:of-type', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (2523, -8953342588285553740, 'patient', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (2524, 7683119570604217389, 'subject', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (2525, -3927652369927734742, 'status:of-type', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2526, -7770398327175736257, 'identifier', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (2527, 5043138425935142456, 'status:of-type', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2528, -461938228570498225, 'coverage', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (2529, 7018367934942971595, 'request', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2530, -6010160643727589598, '_profile', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2531, 7123610501614241975, '_profile', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (2532, 978691354525022887, '_lastUpdated', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2533, 970209216709245966, '_profile', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (2534, 470733314845253160, '_security:of-type', 'SubstanceNucleicAcid');
INSERT INTO public.hfj_spidx_identity VALUES (2535, -188600366289834560, '_tag:of-type', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2536, 1172947253421129674, 'format', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2537, 7243334756459413692, 'status', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2538, -3097136907852151955, 'name', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2539, -7809075582002924368, '_source', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (2540, 1763792806071534012, 'context-type', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2542, 127721462619803427, 'identifier:of-type', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2543, -6608216272166058452, 'jurisdiction:of-type', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2544, 1427214794147667484, 'reason', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2545, 8958602025976889847, '_security', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (2546, 8614567881896807266, 'period', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2547, -4597034399758633650, '_source', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (2548, 2346056659612480378, 'combo-data-absent-reason:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2549, 7906585891972701098, 'context', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (2550, 8371044503139702489, '_security:of-type', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (2551, 7870639424662981910, '_security', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (2552, 6884644658463189745, 'identifier', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (2553, 1520973913022910496, 'dicom-class:of-type', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2554, -2508264957694303297, 'code', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2555, -6850586982502674347, '_security:of-type', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (2556, -4648376384753144929, '_profile', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (2557, 5792553246891864385, 'address-country', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (2558, 5564942256377179255, 'consentor', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (2559, -5058145102995542704, 'characteristic:of-type', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (2560, 2807671158913618751, '_id', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (2561, -852909860367269203, 'performer', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (2562, -3661022844547360542, 'version:of-type', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2563, -435356474063794616, '_tag', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2564, 5710843329323157596, 'relation:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (2565, 7378518383767413, '_security:of-type', 'SubstanceSourceMaterial');
INSERT INTO public.hfj_spidx_identity VALUES (2566, 3898630221609249517, 'identifier', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2567, 7550498064275302819, 'effective', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (2568, -3108660685975746935, 'performer', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (2569, -4466729837576991858, 'identifier', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (2570, 8725436375140357961, 'performer-function', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (2571, 1356666638489359608, '_security', 'Linkage');
INSERT INTO public.hfj_spidx_identity VALUES (2572, -4583277203801750906, '_id:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2573, -6846469987471078579, '_tag:of-type', 'DeviceUseStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2574, -2232179926760307573, '_source', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (2575, 6875299719628298264, 'product', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (2576, -4787760018618356908, '_security:of-type', 'DeviceUseStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2577, 1710965491944190191, 'subject', 'DeviceUseStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2578, -1370213729642341259, '_id', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (2579, 4551017474323066346, 'date', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (2580, -1067789910361401690, 'author', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (2581, 2445804024334440331, 'experimental', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (2582, -4907564625771784289, '_security', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2583, -9100964286435932441, '_tag:of-type', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (2584, -7010505203134820320, 'url', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2585, -2331384486494737099, '_security', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2586, -4164598614172502886, 'chromosome:of-type', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (2587, -1404138105461832662, '_id:of-type', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (2588, 5592880273844860290, 'scope:of-type', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (2589, 5600942611061105300, 'status', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (2590, 470127977153293946, 'code:of-type', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (2591, -8909254903019147123, 'status:of-type', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (2592, -6334242713561951765, '_id:of-type', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (2593, 9211528921481926518, 'connection-type', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (2594, -5654402821563870320, 'reason-code', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (2595, 7773562470295187578, 'context:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2596, 8060269155575531753, 'context-type:of-type', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (2597, 335282966749523413, '_source', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2598, -1075576609285682137, 'title', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (2599, 3417011855973727973, '_tag', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (2600, 5531855824676438164, 'encounter', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2601, -2450707010609107880, 'date', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2602, 6857684876262546270, 'business-status:of-type', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (2603, -1832974811126248884, 'priority', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2604, 6340446857564089401, 'context', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (2605, -3674247462538079300, '_source', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (2606, 1686360047600686866, '_tag', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (2607, -7527386399095712796, 'outcome', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (2608, -8035669579245651312, '_security:of-type', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (2609, -1217492677830939227, 'identifier:of-type', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2610, -1269355853241899173, 'publisher', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (2611, 8430199194796896646, 'request', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (2612, 6136204395983172816, 'title', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (2613, 7706748079092111533, 'jurisdiction:of-type', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2614, -3752377101563836002, 'identifier:of-type', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (2615, 3981550010579884690, '_security', 'BiologicallyDerivedProduct');
INSERT INTO public.hfj_spidx_identity VALUES (2616, 4307587570063664190, '_id', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (2617, -2394089537770217177, 'identifier:of-type', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (2618, -458174139121067099, 'referenceseqid:of-type', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (2619, -1938218125953059896, 'identifier:of-type', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (2620, -6723887974794731886, '_tag', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (2621, -2762443304663151661, '_id:of-type', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (2622, -6120471851387155601, '_tag', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (2623, -3060464184189054109, 'identifier:of-type', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2624, -1619630364192815383, 'context:of-type', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (2625, 1605032466266762613, 'format:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (2626, 590871825875436694, '_lastUpdated', 'MedicinalProductInteraction');
INSERT INTO public.hfj_spidx_identity VALUES (2627, -7979434102167157882, '_tag', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (2628, -2920837483512951378, 'context-quantity', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (2629, 926389354358689583, 'jurisdiction:of-type', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (2630, -4283552593089474394, 'route:of-type', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (2631, -7570086637329084375, 'requester', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2632, -2388702279851591176, 'combo-data-absent-reason', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2633, 3730244091575143079, 'oraldiet:of-type', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (2634, -6953772359554930725, 'description', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2635, -5047284467633115749, 'status', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2636, -62586896315742042, 'context', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (2637, -5327383647552934857, '_security:of-type', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (2638, 4314295467967389900, 'context-quantity', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (2639, 6885422854923035536, 'sender', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (2640, -4751660982186030155, '_lastUpdated', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (2641, -5435569579727275734, 'description', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (2642, -3574780377203239139, '_id:of-type', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (2643, -7488905539860005977, 'relationship:of-type', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (2644, 4654636308021228082, 'identifier:of-type', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (2645, 7137530111331174089, '_tag:of-type', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (2646, 3572436058343567869, 'name', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (2647, -8941961918250607906, '_id:of-type', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (2648, 1716047578978908906, 'whenhandedover', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (2649, -3366634478229072458, 'patient', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (2650, 4446940854791715903, 'actor', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (2651, 8343316925295632936, 'actuality', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2652, -5022838056022723340, 'service-category', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (2653, -7202327945205166737, 'identifier', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2654, -2891566313751791647, '_lastUpdated', 'EnrollmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2655, -1337618362273196479, '_security', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (2656, -992785850743049351, '_tag:of-type', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (2657, 514999221094045041, 'entity-role', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2658, 8183372665343444570, 'encounter', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2659, 5334410600204275930, 'composed-of', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (2660, -5463463947260340346, 'context:of-type', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (2661, -5941071501079642055, '_security:of-type', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2662, 5603047900076237727, '_id:of-type', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (2663, -4460147159919518356, 'effective', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (2664, 5267946238073137059, '_security:of-type', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (2665, 7650270531092300813, '_tag:of-type', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (2666, -1183401373661243684, '_profile', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (2667, -4911362230845576916, 'identifier', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (2668, -104739567958961340, 'morphology', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (2669, -8434364785528656801, 'chromosome', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (2670, -4017614296823259204, 'identifier:of-type', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (2671, 4227393925689419601, 'status', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2672, -4333301683530731131, 'author', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2673, 3805437868772588945, 'phonetic', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (2674, 7154813624350323728, '_security:of-type', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2675, 4085246992032078536, 'identifier:of-type', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (2676, -19298689706393365, 'monograph-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (2677, -5652541816707298186, '_id:of-type', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2678, -9068094672056592275, 'section:of-type', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (2679, 4328772776875996976, 'active', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (2680, -7903897167986912740, '_tag', 'DeviceUseStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2681, 8583031498544022492, 'encounter', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (2682, -3632415291354007072, '_tag:of-type', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2683, -5165957368923279823, 'onset-age', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (2684, -6975886693064673709, 'status', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2685, -5772896839942170965, 'description', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (2686, -2134842531664227971, 'severity:of-type', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2687, -6550025071684842427, '_tag', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (2688, 7341849036432944614, '_profile', 'MedicinalProductInteraction');
INSERT INTO public.hfj_spidx_identity VALUES (2689, -6923151722779284563, '_id:of-type', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (2690, -7560983687605893595, 'status:of-type', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (2691, 343671705737475943, 'target', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (2692, 8277324605632240319, 'date', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (2693, -7938336001437547061, '_tag:of-type', 'Parameters');
INSERT INTO public.hfj_spidx_identity VALUES (2694, -1660725710856922428, 'phone', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (2695, -6045307196695809003, '_security', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2696, 7359384510380730913, 'status:of-type', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2697, -8957200329839015834, '_id:of-type', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2698, 3453043024492019896, 'prescription', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (2699, -9080371614434666186, '_profile', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2700, 7191970245603678855, 'target-species', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (2701, -7544787266453811810, '_security:of-type', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2702, -4030142704000799899, '_profile', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (2703, -8560571630746663093, 'related-ref', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (2704, 9141137842738190842, 'composed-of', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2705, -7557152142241538783, 'identifier:of-type', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (2706, -6664142911550452158, 'kind', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2707, 413890700406464325, '_profile', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2708, 5237006991358859403, 'status', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2709, 8843979454577253427, 'context-quantity', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (2710, 6719160847948132017, 'identifier', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (2711, 4329419150240452127, 'operator', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (2712, -6576717507119291674, '_lastUpdated', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (2713, 1909264377646145627, '_tag:of-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (2714, 6399480554659820276, '_security', 'SubstanceProtein');
INSERT INTO public.hfj_spidx_identity VALUES (2715, 8119381128270246954, '_security', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (2716, 3019237821390545242, '_security:of-type', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2717, 3637896834776112093, 'event:of-type', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2718, 6060902398875061726, 'contact', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (2719, -6123093423227196446, '_profile', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2720, -6395353298200521551, 'url', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (2721, -8391708100498054829, 'url', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (2722, -5782771202159113644, '_source', 'MedicinalProduct');
INSERT INTO public.hfj_spidx_identity VALUES (2723, -6017887071325069183, 'type', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (2724, -3754207957036384277, 'type:of-type', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (2725, 6749336798200694198, 'location-period', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (2726, 617845033449440906, '_lastUpdated', 'MedicinalProduct');
INSERT INTO public.hfj_spidx_identity VALUES (2727, -8812336260436495311, 'url', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2728, -8460645256447370364, 'identifier', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (2729, -1196327380991073985, 'version', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (2730, -1277404574051649530, 'source', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (2731, 784044747950251966, 'type', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (2732, -8214651158124572215, 'referrer', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2733, -8133808671734070015, 'date', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (2734, 1119429634752354023, '_source', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2735, -4844024982684462201, 'subject', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2736, -6005432630673092605, '_id:of-type', 'MedicinalProductPackaged');
INSERT INTO public.hfj_spidx_identity VALUES (2737, -5839217098502972142, '_id', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2738, -3797166750319360602, 'identifier', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (2739, 747898576837299095, '_tag', 'Binary');
INSERT INTO public.hfj_spidx_identity VALUES (2740, -8470600574246888889, 'publisher', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (2741, 8671803946416329800, 'asserter', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (2742, 5089555105816360811, '_tag:of-type', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (2743, 5849995232105230727, '_id', 'MedicinalProductUndesirableEffect');
INSERT INTO public.hfj_spidx_identity VALUES (2744, 7639956189168845631, 'active', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (2745, 6387720453751859020, 'code', 'SubstanceSpecification');
INSERT INTO public.hfj_spidx_identity VALUES (2746, -9007026716997405342, 'context-type', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2747, -3764994897284224891, 'subject', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (2748, -8014330366603927121, 'role:of-type', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (2749, -9153320563056337837, '_tag:of-type', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (2750, 9074773387844112475, '_tag', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (2751, -3136447175260606420, '_tag', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (2752, -7074156619550089335, 'value-concept', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2753, 8016907005205394399, 'date', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (2754, 2009512099478279744, '_security:of-type', 'MedicinalProductIngredient');
INSERT INTO public.hfj_spidx_identity VALUES (2755, -6705271778348845746, '_source', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2756, 4910143859234350134, 'identifier', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (2757, -5257803308649170656, 'supporting-info', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (2758, 4948573730493347674, 'fhirversion', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2759, 7802146918552638000, 'severity', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (2760, -6331570714292220666, 'enterer', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (2761, -9137367114810904595, 'status:of-type', 'EnrollmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2762, -1958383525232026549, 'category', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2763, -5699258759972588807, '_security', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2764, -901953555742078994, 'name', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2765, -5857521406921028266, 'status', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (2766, -2815956200210640444, 'identifier:of-type', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (2767, -3441416145892499109, '_tag:of-type', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (2768, -2976777439753493888, '_lastUpdated', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (2769, 3815976207983080036, '_lastUpdated', 'Linkage');
INSERT INTO public.hfj_spidx_identity VALUES (2770, -6247340457438550448, 'country', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (2771, 705863531511231982, 'status:of-type', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (2772, -6080885586173061723, 'class-type:of-type', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (2773, -2394789541368909036, 'address-use', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2774, -5320559725805335419, 'udi-carrier', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (2775, 5458734256169518248, '_tag', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (2776, 3651203577707872186, '_profile', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2777, -644587144141787528, 'jurisdiction', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (2778, 1839511505743111365, 'name', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2779, -3806931360234459290, 'identifier', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (2780, 3729490075262672236, '_profile', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (2781, 6653670207205380151, '_tag:of-type', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2782, 7302265087408670778, '_security:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2783, -177834431287470089, '_lastUpdated', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2784, -2750662220042437869, '_tag:of-type', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (2785, 7175345541481706785, 'service-type', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (2786, 3742800883152274414, 'relationship:of-type', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (2787, -3680176571139852104, '_id:of-type', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2788, -4382613697893860701, 'status:of-type', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2789, -7523318819260266545, '_profile', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (2790, -126923615065000158, 'status:of-type', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2791, -4520998728668144211, 'status', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (2792, 2558239798702840119, 'context-type', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2793, 6065483414736594816, 'patient', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2794, -8758926806243161887, 'code', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2795, 1852907893096634628, '_lastUpdated', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (2796, -5391286680964648351, 'language:of-type', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2797, 6593366417380227440, 'description', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (2798, -7157341042979373918, 'version:of-type', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (2799, 894839656461656324, 'identifier', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2800, 334568963589947244, '_id:of-type', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2801, -4166037406434504313, '_lastUpdated', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (2802, 5719839522658798675, '_security', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (2803, 3730072799052261259, 'code', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2804, 6210521554369049778, 'title', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2805, 7326872404042053477, '_tag:of-type', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (2806, -483111192819187277, 'recipient', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2807, -623649399254278001, '_lastUpdated', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (2808, -5287612057792831612, '_id:of-type', 'SubstanceSpecification');
INSERT INTO public.hfj_spidx_identity VALUES (2809, -1401361889073670313, 'jurisdiction', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (2810, 4813129501796234598, 'expansion', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (2811, -8955290767107995880, '_profile', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2812, -4105344836006972358, '_tag', 'Parameters');
INSERT INTO public.hfj_spidx_identity VALUES (2813, 2666962593076890679, 'version', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2814, -4617564538508928987, 'context-type:of-type', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (2815, -914835178463166882, '_id', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (2816, 6061112488911676437, 'name', 'MedicinalProduct');
INSERT INTO public.hfj_spidx_identity VALUES (2817, -5905120952086453731, '_id:of-type', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (2818, 8575205997464409406, 'phone', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (2819, 8758736695008879421, 'organization', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (2820, 8841881183395939622, '_tag:of-type', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (2821, 9041293924391896535, 'use:of-type', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (2822, 6609501169488334100, '_security:of-type', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (2823, -2166507594213906549, 'activity-code:of-type', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2824, -1861143809276991332, 'instantiates-uri', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2825, -3068131014538161821, '_profile', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2826, 4762737757386146946, '_source', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2827, 2917871457774162221, '_profile', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (2828, 640390211181969746, 'authored', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2829, -7884846117505534775, 'encounter', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (2830, 9071845944931677079, '_id', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (2831, -6324541389031131724, '_lastUpdated', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (2832, 6233617965983343348, '_profile', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (2833, -3375200814151888297, 'birthdate', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (2834, -8772741182945055460, '_id:of-type', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (2835, -4824762892486985615, 'category:of-type', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2836, -627991002466808826, 'title', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (2837, -721183091372302419, '_profile', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (2838, -2308046253921364184, '_source', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (2839, 6692290005045799702, '_id', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2840, 6341451337843281364, 'derived-from', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2841, 8456385801893113619, 'patient', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (2842, -2698007237298694021, '_profile', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (2843, 7096071854628374365, '_tag:of-type', 'SubstanceNucleicAcid');
INSERT INTO public.hfj_spidx_identity VALUES (2844, -7554564179838378436, '_source', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (2845, 8528467852089923849, '_lastUpdated', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2846, 7205958723857717725, '_security', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (2847, 1296007170171003660, '_tag', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (2848, 1074146199253067468, 'support', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (2849, -3477308217095165590, 'context-type', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (2850, -2439234795099365977, 'status', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2851, -1070948631158123809, 'identifier:of-type', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2852, 2943755954119626025, 'status', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (2853, -4838341131168722564, 'guide', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2854, -1547233673068967717, 'identifier', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (2855, 4997617732140239277, 'address-postalcode', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (2856, 8292812163002518059, 'ingredient-code:of-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (2857, -1598834124857548474, '_id', 'MedicinalProduct');
INSERT INTO public.hfj_spidx_identity VALUES (2858, -9189392292234825993, 'site:of-type', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2859, -1241104121564739274, '_security', 'DeviceDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2860, 5378998310938045310, 'lot-number:of-type', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (2861, 1447375055578790434, '_tag', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (2862, -8717524160775631959, 'version', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (2863, 398824487938412372, '_tag:of-type', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (2864, -2873284677080631361, 'publisher', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2865, 5898146535012759844, 'method:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2866, -1793520710062262459, 'onset', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (2867, -6221400547077281836, '_id', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2868, -391921877339949182, '_id', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2869, 8911045908509664810, '_lastUpdated', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (2870, -1672615982290354949, '_tag', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (2871, -1575415002568401616, 'name', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (2872, 4191777391433561591, '_lastUpdated', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (2873, 7941073856412647769, '_id', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (2874, -6071358197803453709, '_tag', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (2875, -4592279846569896733, 'derivation:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2876, 4721616213983700031, '_lastUpdated', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (2877, -5422216072866316314, 'context:of-type', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (2878, 3167581822543946195, 'instantiates-uri', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (2879, 5696676387344027007, 'title', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2880, -3034413125748652999, 'medium:of-type', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2881, -5936487695752278475, 'publisher', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (2882, 6374939521012144690, '_source', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (2883, 3212232722817178157, '_id', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (2884, -7113469410702714101, 'source-uri', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (2885, 2206442174201669167, 'network', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (2886, -6078509505433551399, 'status:of-type', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (2887, -3383584317801254314, '_lastUpdated', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2888, 8980150345646479341, 'entity-name', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (2889, 6337181609312850776, '_security:of-type', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2890, -7622695593222048240, '_security', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (2891, -5733405259670117460, 'additive:of-type', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (2892, 299334417702881924, '_security', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2893, -2192589365980723738, 'identifier', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (2894, -3455840248275653869, 'instantiates-canonical', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (2895, 2926838810781943309, 'testscript', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (2896, 6585471592180276006, 'language:of-type', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (2897, 8690568747397601161, '_id:of-type', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (2898, -8857505150862023719, 'combo-value-concept:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2899, -3311702337693430752, '_security', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (2900, 345950003833922160, '_lastUpdated', 'DeviceUseStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2901, 4931604527064809911, 'category', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2902, 2750671042445299157, '_tag', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (2903, -7608279883187820328, 'code:of-type', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (2904, 3290181497172819758, 'status', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2905, 84422673707376682, '_lastUpdated', 'MedicinalProductPackaged');
INSERT INTO public.hfj_spidx_identity VALUES (2906, 7456897156892505488, '_lastUpdated', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (2907, 2908130654835491193, 'date', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (2908, -1955262693550312486, 'patient', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (2909, -2413917051257022842, 'id-type:of-type', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (2910, 550052250982830122, 'individual', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (2911, 753469414330677752, 'context-quantity', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2912, 1962261003020108523, '_lastUpdated', 'SubstancePolymer');
INSERT INTO public.hfj_spidx_identity VALUES (2913, -6532240145570608795, 'title', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2914, 1510663587974803858, 'identifier:of-type', 'EnrollmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2915, 7549220199953325010, 'active:of-type', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (2916, -6074968274114716392, 'status:of-type', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (2917, 2060457114969341788, 'context-quantity', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (2918, 2537793105362532726, '_source', 'SubstancePolymer');
INSERT INTO public.hfj_spidx_identity VALUES (2919, -4708209488838618406, 'detail-udi', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (2920, -6885007613446480106, '_id', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (2921, -7969825282528174469, 'code', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2922, 5403823769665574294, 'monitoring-program-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (2923, -2231268110563611002, '_id', 'Parameters');
INSERT INTO public.hfj_spidx_identity VALUES (2924, 5006909661764633221, 'jurisdiction', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2925, -1417481395085711473, 'site:of-type', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (2926, 7193588858044311327, '_source', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (2927, -8785613051561383142, 'instantiates-uri', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2928, -8944578641804214615, 'intent', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2929, -7767023308211155074, 'subject', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (2930, 4838516341174177181, '_source', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (2931, -6446240483458993240, 'communication:of-type', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (2932, -336550520491014518, 'topic', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2933, -897061424193232819, '_security:of-type', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2934, 527454707621136681, 'identifier', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (2935, -3062974663708220934, 'part-of', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2936, 4045322339177618004, 'address-use:of-type', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (2937, -3916981602437818560, 'code', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (2938, -7386696309867283219, 'successor', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (2939, -485452638256818498, '_lastUpdated', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2940, -5519987869630406430, 'specialty', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (2941, -4318623365520905112, 'jurisdiction:of-type', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2942, -6516253428361932169, 'beneficiary', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (2943, 6844123726752201379, '_source', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (2944, 7001889285610424179, 'identifier', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (2945, -4758310518077977397, 'bodysite', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (2946, -1496241380510889677, '_security', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (2947, -7876916411385915634, 'status', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (2948, 8728968309190998463, 'identifier', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (2949, -718885837303102383, '_tag:of-type', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (2950, -2527017214264031321, 'base', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2951, 986495442592192480, '_id', 'SubstanceProtein');
INSERT INTO public.hfj_spidx_identity VALUES (2952, -3321769802413150839, 'context-type', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (2953, 4703054181912359366, 'title', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2954, 5645572374441873979, '_tag:of-type', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (2955, 7499602058555372192, 'reason-given', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (2956, -4997355145029929146, 'coverage-area', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (2957, -7242121776961130021, 'type:of-type', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (2958, 3545511966528775314, '_security:of-type', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (2959, -7754027454338178342, 'context-type:of-type', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2960, 2272653030936563442, 'context', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2961, -4483642944611199145, '_lastUpdated', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2962, 623246202595886302, 'status', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (2963, 374209932610089558, '_profile', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (2964, -8410321033034837474, '_lastUpdated', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2965, -7865113277619797879, '_source', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (2966, -3110830305822750120, 'based-on', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (2967, 6414276012858200200, 'use', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2968, -111409958853048469, 'version', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (2969, -8055140496302937197, 'context-type:of-type', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2970, -6194746700436836347, '_security', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2971, -5060586897744783251, 'status', 'MedicinalProductAuthorization');
INSERT INTO public.hfj_spidx_identity VALUES (2972, 5516360775550748081, 'date', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (2973, -2969428703661510476, '_profile', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (2974, 8417796750095004614, 'patient', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (2975, -7698248712295083011, 'identifier:of-type', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (2976, 2963387347033974179, 'created', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (2977, -3853728255387800833, 'vaccine-type:of-type', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (2978, -5220670929944572456, '_profile', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (2979, 3364895484367962728, '_security:of-type', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (2980, 6117817796978964753, '_lastUpdated', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2981, 2233468339845750446, '_profile', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (2982, -1179317728726071093, 'subject', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (2983, -3084131495015891177, '_lastUpdated', 'OperationOutcome');
INSERT INTO public.hfj_spidx_identity VALUES (2984, -6539233839593596439, 'context:of-type', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2985, -6513700584002525846, '_source', 'MedicinalProductIndication');
INSERT INTO public.hfj_spidx_identity VALUES (2986, -8597380404522842283, 'source', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (2987, -695310588091608412, 'specialty:of-type', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (2988, -4642227206444895708, 'status', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2989, -1450137430765618785, 'context-type', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (2990, 6730079220145768316, '_tag', 'SpecimenDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2991, 8366377428291786680, 'status:of-type', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (2992, 1574738064104183168, '_id', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (2993, -7496866971715093294, 'context', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (2994, -8680316134203976236, 'whenprepared', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (2995, 2114214083504748349, 'path:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (2996, -1800858021602959408, 'datewritten', 'VisionPrescription');
INSERT INTO public.hfj_spidx_identity VALUES (2997, -8957542852655326170, 'date', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (2998, -3448386936421354893, '_security', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (2999, -7184001139408660403, 'version:of-type', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3000, 4100916324497073395, 'created', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (3001, -8933801854277041642, '_security', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (3002, 3310202459045154532, 'identifier:of-type', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (3003, 5978531480962169854, 'performer', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (3004, -2734741743898143547, 'identifier:of-type', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (3005, 7807280865845882922, 'manufacturer', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (3006, 2485670775486507516, 'subject', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (3007, 4330098296049476985, '_lastUpdated', 'Parameters');
INSERT INTO public.hfj_spidx_identity VALUES (3008, -3178999308804815621, '_security:of-type', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (3009, 5047329801862359834, '_tag', 'SubstanceSourceMaterial');
INSERT INTO public.hfj_spidx_identity VALUES (3010, -6931832691240491112, '_id', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (3011, -2563706883337538902, '_id', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (3012, 3383632653940871966, 'patient', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (3013, -690598069991778349, '_lastUpdated', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3014, -342392335410653079, '_source', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (3015, 6334682813455086072, 'subject', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (3016, 7864618078274464336, '_security', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (3017, -7299222608249470623, 'identifier', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (3018, -1445565461184841215, '_source', 'DeviceDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3019, -7382219245521441492, '_tag:of-type', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (3020, 8843210077643414697, 'email', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (3021, 8600028005973676159, '_security:of-type', 'BiologicallyDerivedProduct');
INSERT INTO public.hfj_spidx_identity VALUES (3022, 3422013345479592754, 'modified', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (3023, 2906159699296209747, 'topic', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (3024, 4726193866808115617, '_tag:of-type', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (3025, 5245000776887490403, 'kind', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3026, 622491159554097926, 'composed-of', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3027, 1591310278345484463, '_tag', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (3028, -4479564287463475662, '_tag:of-type', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (3029, -2031311743440724603, 'address-postalcode', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (3030, 6429732838602484109, 'description', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (3031, -8952776717455195482, 'subject', 'MedicinalProductPackaged');
INSERT INTO public.hfj_spidx_identity VALUES (3032, 5589615715618849484, 'type:of-type', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (3033, 4868736490388207056, 'performer', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (3034, 2029543524977351580, 'valueset', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3035, -2597548613046819094, '_id', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (3036, 8955622092735531112, 'effective', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (3037, -3352025973067613991, 'authored-on', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3038, -4798658926812029013, 'name', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (3039, -6340208251548485460, '_profile', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (3040, 8204491729236555051, 'title', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (3041, -8385655772535333242, 'context-quantity', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3042, 1419642431583692446, '_security', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3043, -1388612581068609345, 'category', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (3044, -5110883459604682577, 'name', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3045, 7344446979652699499, '_id:of-type', 'MedicinalProductInteraction');
INSERT INTO public.hfj_spidx_identity VALUES (3046, 6760318975668302955, 'jurisdiction', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (3047, 6725803928006842724, '_id:of-type', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (3048, 4854704850342860292, 'actor', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (3049, 626061985208954997, 'address-city', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (3050, -1282513330818573044, 'status:of-type', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3051, 4710582863993304330, '_security:of-type', 'MedicinalProductManufactured');
INSERT INTO public.hfj_spidx_identity VALUES (3052, 4791593058213719596, '_lastUpdated', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (3053, 1251032245792432199, 'connection-type:of-type', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (3054, 8036764948033403216, '_source', 'DeviceUseStatement');
INSERT INTO public.hfj_spidx_identity VALUES (3055, 252467510991445143, '_lastUpdated', 'GuidanceResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3056, -3429479558507577503, 'created', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (3057, -8488778841889548864, 'version:of-type', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (3058, -6787756895313311545, 'expiration-date', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (3059, 615066670521900427, '_security', 'SubstancePolymer');
INSERT INTO public.hfj_spidx_identity VALUES (3060, 7747067782259884451, '_id', 'CatalogEntry');
INSERT INTO public.hfj_spidx_identity VALUES (3061, 1265667577509027335, 'code:of-type', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (3062, 8674288048968158724, 'identifier', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (3063, 4578485139395328040, '_source', 'SubstanceProtein');
INSERT INTO public.hfj_spidx_identity VALUES (3064, 8669171798117320014, 'patient', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3065, 3025060767088336982, 'identifier:of-type', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (3066, -6876529011723171302, '_security', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (3067, 1617825456310495603, '_profile', 'SubstanceNucleicAcid');
INSERT INTO public.hfj_spidx_identity VALUES (3068, 7157721138536458932, 'publisher', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (3069, -7312238802389065066, 'instantiates-uri', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3070, 6972123695576351484, 'payor', 'Coverage');
INSERT INTO public.hfj_spidx_identity VALUES (3071, -1736292989344606691, '_id:of-type', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (3072, -7990575238887244982, 'identifier', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3073, 7423754453374570538, 'identifier:of-type', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (3074, -5964180000446173356, 'identifier:of-type', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (3075, -3187099441118826216, 'derived-from', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (3076, -7931873357669484274, 'name', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (3077, -4082773750105051027, 'reference', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (3078, -3018588086273512134, '_lastUpdated', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (3079, 5077257112073515266, 'category', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (3080, 823674259000284444, 'author', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (3081, -8313542302320001140, 'identifier:of-type', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (3082, -5690998103979678771, 'date', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (3083, 2327960100967120187, '_id:of-type', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3084, -2407390558571403683, '_lastUpdated', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (3085, 2424257885885996866, 'subject', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (3086, 8099407063402012045, '_lastUpdated', 'MedicinalProductContraindication');
INSERT INTO public.hfj_spidx_identity VALUES (3087, 1350206537362277524, 'patient', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (3088, 6130090947818214110, '_security', 'CatalogEntry');
INSERT INTO public.hfj_spidx_identity VALUES (3089, 571085915009693548, '_id', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (3090, 6975669834493341201, '_security:of-type', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (3091, -2487613717211278916, 'jurisdiction', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3092, 4755028037173430000, 'basedon', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (3093, 6989360765145400476, 'input-profile', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3094, 2342827000610257454, 'patient', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (3095, -9198279080420692823, '_security:of-type', 'SubstanceSpecification');
INSERT INTO public.hfj_spidx_identity VALUES (3096, 5804745658401380093, '_id', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (3097, -4386029925895524995, 'type:of-type', 'DeviceDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3098, -7881125283615651634, '_source', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (3099, 3538213272813844763, 'version', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (3100, -2039907849484936613, '_id', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (3101, 9130442678283361586, 'performer-function:of-type', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (3102, 8020467491269303794, 'identifier:of-type', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (3103, -5488852205393371491, '_id', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (3104, 5542242007482125258, '_tag', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (3105, 6575750285344101238, 'context', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (3106, 1723283121395802789, '_lastUpdated', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (3107, -853488818679562968, 'date', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (3108, 9091812828370030922, 'resource:of-type', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (3109, 2818930906997316605, '_profile', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (3110, -8602589509065980200, '_profile', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (3111, 1152694421329635544, 'instantiates-canonical', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3112, 7228625988268570125, 'medium', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (3113, 3211994147765914288, '_tag', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (3114, 1163146707975313118, '_tag:of-type', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3115, -1072705387052826985, 'data-absent-reason:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (3116, -7946007074914479529, 'component-value-concept:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (3117, 2621343532367150291, 'jurisdiction', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (3118, 7800164061692026614, 'predecessor', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3119, 7136276081082490248, 'identifier:of-type', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (3120, -6675551683886307401, '_source', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (3121, -5220338095032471481, '_lastUpdated', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (3122, -3067445165058996014, 'payee', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (3123, -5765287347491665612, 'context:of-type', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (3124, 6758747856609098946, 'performer', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (3125, 3567606715229686459, 'publisher', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3126, -2597055954246486474, 'endpoint', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (3127, -8647385030136590432, 'specimen', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (3128, 8612606763367918784, '_security:of-type', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (3129, -3495131716629480567, 'subject', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (3130, -1924310779451849144, 'specialty', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (3131, 3532661605140313557, '_lastUpdated', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (3132, -8352436803966958698, '_tag', 'SupplyDelivery');
INSERT INTO public.hfj_spidx_identity VALUES (3133, -8012849975226389418, 'source-system', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (3134, 8994346059274094828, 'identifier', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (3135, 3059239311560501278, 'assessor', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (3136, -4766242423128804865, 'risk', 'RiskAssessment');
INSERT INTO public.hfj_spidx_identity VALUES (3137, -8817726248735954047, 'patient', 'ClinicalImpression');
INSERT INTO public.hfj_spidx_identity VALUES (3138, 7887930959992863451, 'topic:of-type', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3139, 681418118188514961, 'version', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3140, -376623067299125996, '_tag:of-type', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3141, 6992620449788033819, 'subject', 'ChargeItem');
INSERT INTO public.hfj_spidx_identity VALUES (3142, -2872764304802685173, 'version', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (3143, -4653325667123102078, 'effective', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (3144, 1072766057149947292, 'patient', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (3145, 3755646410285029486, 'supplier', 'SupplyRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3146, -4194948972362704528, 'response-id', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (3147, 6197697827681979536, '_tag:of-type', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (3148, -8375101963294645957, 'identifier', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (3149, -3775695746838422170, 'url', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (3150, -7079662275710729112, '_tag:of-type', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (3151, 5081784706928165961, '_security', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (3152, 7894559767946741943, 'based-on', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (3153, 3534728467670265553, 'value', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (3154, 8110413877963880339, '_id:of-type', 'SubstanceProtein');
INSERT INTO public.hfj_spidx_identity VALUES (3155, -5301731948004987810, 'version', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (3156, 455178913238236237, 'status:of-type', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3157, 4347126225905500404, 'telecom:of-type', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (3158, -7091838574933724328, 'status:of-type', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (3159, 5495387049784267904, '_tag', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (3160, -830131249624279738, 'type', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (3161, -1808132413950182279, 'intent', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3162, 9101726830098669716, 'publisher', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (3163, 5125849871159332901, '_source', 'Linkage');
INSERT INTO public.hfj_spidx_identity VALUES (3164, -3921125931998351705, 'context', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3165, 3203368147716319080, 'identifier:of-type', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (3166, 6091350997691955319, 'identifier:of-type', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (3167, 7263202988822129679, 'telecom:of-type', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (3168, 4686432987672642872, '_security', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (3169, -4114961995232918301, '_tag', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (3170, 437711414923653822, '_security', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (3171, -5110716027199403747, 'administered-by', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (3172, -1953552083869529895, 'phone:of-type', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (3173, 8934512075862736792, '_security:of-type', 'PaymentReconciliation');
INSERT INTO public.hfj_spidx_identity VALUES (3174, -8897074533716604742, 'version:of-type', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3175, -5350401510453590942, '_security:of-type', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (3176, -2830809394128781005, 'deceased', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (3177, -8564843570168797681, '_profile', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (3178, -6557894227449407741, '_security', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (3179, -7129752479882329468, 'ext-context:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3180, -4616511943229830386, 'address-use:of-type', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (3181, -8792339703412847188, 'version:of-type', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (3182, -146723788690289214, 'participant-role:of-type', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (3183, 4910646820811754705, 'group-identifier', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (3184, -3795114390399761750, '_tag', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (3185, -4203538131906875826, 'status:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3186, 6622515652814072871, '_tag', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (3187, -4623494577167358637, 'jurisdiction', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3188, -2549432096118881768, '_tag', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (3189, -8884093132046832531, 'jurisdiction:of-type', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (3190, 847077245421034822, 'entry', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (3191, 7529253067725663767, 'identifier:of-type', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (3192, -1064597013504861459, '_security:of-type', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (3193, -7657395181973106752, 'entity-type:of-type', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (3194, 2046505410021777050, '_profile', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (3195, 8153266817606161367, 'subject', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3196, 3370137540637489521, 'intended-performer', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3197, 4791352551089578647, '_security', 'ChargeItemDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3198, 9074638708426563208, 'code:of-type', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (3199, 1095580711543178710, 'address-city', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (3200, -1546567342898056555, '_id:of-type', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3201, -5421723963145662461, 'predecessor', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (3202, -1347620304209293112, '_security', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (3203, 3809956560508084526, 'context-quantity', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (3204, 7366301234977186530, 'date', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (3205, -5927391154554382364, '_profile', 'Binary');
INSERT INTO public.hfj_spidx_identity VALUES (3206, -4339853749507677647, '_tag', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (3207, -661602492357315878, 'patient', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (3208, 7663571762199731092, '_id:of-type', 'DeviceDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3209, -4198754461454028833, '_security', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (3210, 9019147040403395485, 'care-team', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (3211, 2219613785338431767, 'identifier', 'Schedule');
INSERT INTO public.hfj_spidx_identity VALUES (3212, -7692464466468547283, '_tag:of-type', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (3213, -773192634382500836, '_id:of-type', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (3214, 4054625633907709468, '_security', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3215, 3962678247368344893, '_lastUpdated', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (3216, 3375936092543579594, 'status', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3217, -5095944257548056118, 'category:of-type', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (3218, 1648685554531908745, 'additive', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (3219, -5429104328341201206, '_security', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (3220, -7321197015975595838, '_id', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (3221, -4094325250114559132, '_security:of-type', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (3222, 8680692679819427882, '_id', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (3223, -1306686769252559935, '_tag', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3224, -3467218240721955028, 'patient', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (3225, -4884845688914144368, 'patient', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (3226, -6675340033975478912, '_security', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (3227, 1460405943134614510, 'patient', 'Flag');
INSERT INTO public.hfj_spidx_identity VALUES (3228, -941625376563692405, 'start-date', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (3229, -437640356992062629, '_id:of-type', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (3230, 436331707038548463, 'context:of-type', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3231, -2545624264981282190, 'description', 'DocumentManifest');
INSERT INTO public.hfj_spidx_identity VALUES (3232, 4042085764187559256, 'identifier', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (3233, -3924939656696649566, 'location', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3234, -8283059856771643677, 'subject', 'MedicinalProductInteraction');
INSERT INTO public.hfj_spidx_identity VALUES (3235, 4446870524271279382, 'based-on', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3236, 7065819788676111755, 'identifier:of-type', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (3237, 2639582813651880986, '_profile', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (3238, -4439480975542776646, 'referenceseqid', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (3239, 4488183522360139906, 'responsible', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (3240, 2328132743180072956, 'name', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (3241, -1322995935722566518, 'requisition:of-type', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3242, 8244615686823396977, 'location', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (3243, 4294295137554787195, '_security', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (3244, -915700845825383100, '_profile', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (3245, -2931077204635055349, 'receiver', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (3246, 1075026555376354720, '_security', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (3247, 4725875481453010800, 'resource', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3248, -6678347997290685108, '_tag:of-type', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (3249, 5886636021811195671, '_lastUpdated', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (3250, 4927499237968390398, '_tag', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (3251, 9195496198067132226, '_lastUpdated', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (3252, -4510179490467463339, 'identifier:of-type', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3253, 1660379902767901160, '_security', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3254, 1228251855174209325, 'response-id:of-type', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (3255, 8326452624729339885, '_profile', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (3256, 5417058838903101873, '_security:of-type', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3257, -9036862735926397045, 'type:of-type', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (3258, 4359518126378466699, 'gender', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (3259, -2587494882245303384, 'name-language', 'MedicinalProduct');
INSERT INTO public.hfj_spidx_identity VALUES (3260, 8670011141581856968, 'context-type', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (3261, -1575406001252496924, 'combo-code', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (3262, -5682847540586814726, 'category', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (3263, -3008794118817470702, '_id', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (3264, 33509527209988, '_id:of-type', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3265, 6186366877925088193, 'description', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3266, 9088245732512512411, 'version', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (3267, -8269296085798668200, 'patient', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (3268, -5157420274587823328, 'mode:of-type', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (3269, -3745857819665935218, 'status:of-type', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (3270, -6874224362355092562, 'code', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (3271, 4725768503767174182, 'provider', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3272, -2143575484988727765, '_lastUpdated', 'SubstanceNucleicAcid');
INSERT INTO public.hfj_spidx_identity VALUES (3273, 2281012381309077031, 'context:of-type', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (3274, -3445014151577205251, '_security', 'VerificationResult');
INSERT INTO public.hfj_spidx_identity VALUES (3275, 8594323086659414128, 'performer:of-type', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (3276, -1057953195490934630, 'contact:of-type', 'Subscription');
INSERT INTO public.hfj_spidx_identity VALUES (3277, -5332393198436948982, 'created', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3278, 9073533398129002331, 'identifier', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (3279, 8325090369599749181, 'operational-status:of-type', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (3280, 3265439711333814760, '_source', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (3281, -7986868520679264190, 'entity', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (3282, 4777301789255809185, 'medium', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3283, -2506376979161932640, '_source', 'CatalogEntry');
INSERT INTO public.hfj_spidx_identity VALUES (3284, -999807999908265728, 'telecom', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (3285, 933402287729384719, '_profile', 'MedicinalProductIndication');
INSERT INTO public.hfj_spidx_identity VALUES (3286, -4391784620707472979, '_tag', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (3287, -779312604066983210, 'url', 'RiskEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (3288, 7645350114385943870, 'source', 'Linkage');
INSERT INTO public.hfj_spidx_identity VALUES (3289, -7056355613317342792, 'title', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (3290, -1022753802631378084, '_profile', 'Parameters');
INSERT INTO public.hfj_spidx_identity VALUES (3291, 8836563773276038469, '_id', 'SubstanceReferenceInformation');
INSERT INTO public.hfj_spidx_identity VALUES (3292, -3773743285677735601, '_tag:of-type', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (3293, -2108143607337968621, 'status:of-type', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (3294, -4201261535681406172, 'category', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (3295, 4207815796278310008, '_lastUpdated', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (3296, 4735545567498214665, 'status:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (3297, 7950932091597560163, 'source-reference', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (3298, -7180112270373705725, 'identified', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (3299, 8648714155554332488, 'identifier', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (3300, -5108284777460296274, '_security:of-type', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3301, 8044228009032633996, '_security:of-type', 'MedicinalProductIndication');
INSERT INTO public.hfj_spidx_identity VALUES (3302, -1412529549446353807, 'requester', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3303, -1936777539197151127, '_source', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (3304, 5085572920337140333, '_security:of-type', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (3305, -3867836923952805009, 'questionnaire', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3306, -3814627748709500477, 'context', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (3307, -6338030716006204643, 'language', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (3308, 7190568740809727611, 'identifier', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (3309, -5569648832767985407, '_security:of-type', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3310, 161876085380915428, 'identifier', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (3311, -9014647623434996762, '_source', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (3312, -5389145682897467195, 'subject', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (3313, 6476166280354784420, 'address-use', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (3314, -3837635801531558602, 'appointment-type:of-type', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (3315, 5795618745455026671, 'identifier', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3316, -2070928296349202526, 'period', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (3317, 577791237698857678, 'address-city', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (3318, -2863923906667821322, '_security', 'DeviceUseStatement');
INSERT INTO public.hfj_spidx_identity VALUES (3319, -2305227288741901702, 'verification-status:of-type', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (3320, 6167940700870910569, '_source', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3321, -6420445644754970244, 'related-ref', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (3322, 8355317129637477139, 'encounter', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (3323, 1933478777749991264, '_tag', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (3324, 3192277497900687465, '_id', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (3325, -386288831237820886, '_source', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (3326, -1424179417776396561, '_lastUpdated', 'VerificationResult');
INSERT INTO public.hfj_spidx_identity VALUES (3327, 202824522441848683, 'keyword', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (3328, -3252812809889666815, 'phonetic', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (3329, 8556124307659571895, 'phone:of-type', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (3330, -2073535363360859760, 'recorded-date', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (3331, 3574592759528361338, '_tag', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3332, -234753116106867483, '_profile', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (3333, -201526113087985197, 'results-interpreter', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (3334, 2876078039957792310, '_source', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3335, -8236197956304722143, 'identifier:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (3336, 4867204633424391835, 'topic', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3337, -3674277354177339037, 'security-label', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (3338, 8020078502178294036, '_security', 'CommunicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3339, 4430268129043428078, 'facility', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (3340, -2809863225484289685, 'status', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (3341, -1068944668394100943, '_profile', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (3342, -59786626947673980, 'series:of-type', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (3343, 5860556011736665489, '_security', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (3344, -6536055924007953825, 'date', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (3345, -3149335193496450906, 'evidence-detail', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (3346, -5901094976040575610, '_lastUpdated', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (3347, 1084193465164165224, 'request', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (3348, -5325353339877437016, 'topic', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3349, 8126253771173455036, 'special-arrangement', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (3350, -3902439958074362310, '_tag:of-type', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (3351, -4477022854740663140, 'context-quantity', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (3352, 75392882946339629, 'status', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (3353, 662538013567360727, '_tag:of-type', 'PaymentNotice');
INSERT INTO public.hfj_spidx_identity VALUES (3354, 78983042310271555, 'based-on', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (3355, -7279573408336270827, 'asserter', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (3356, -7481656247825601465, 'status', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3357, -3750940233137341557, 'title', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3358, -479026162469548185, 'name', 'HealthcareService');
INSERT INTO public.hfj_spidx_identity VALUES (3359, -4831584909955520007, 'experimental', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3360, 8695167686019962396, 'address-use:of-type', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (3361, -7040853573430902972, '_tag:of-type', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (3362, 1829495698687008370, 'instance:of-type', 'ImagingStudy');
INSERT INTO public.hfj_spidx_identity VALUES (3363, -510812266121874158, 'identifier:of-type', 'DeviceDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3364, -4092756275342567693, '_id:of-type', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (3365, -4104998468460010316, '_lastUpdated', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (3366, 3305056681699752095, 'description', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (3367, -6455018769336700412, 'substance', 'AdverseEvent');
INSERT INTO public.hfj_spidx_identity VALUES (3368, -6315546283665799629, '_lastUpdated', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (3369, -5574939372260148888, '_profile', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3370, 6795091020510600460, 'jurisdiction', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (3371, -5663494544550205034, 'context', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3372, -3309062475095785843, '_lastUpdated', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (3373, -8837703508189998018, 'topic:of-type', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3374, -5308877520493424965, 'authored', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3375, 1160764062591008793, '_profile', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (3376, 8331545941077189297, 'depends-on', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (3377, 5303992830628017724, '_tag', 'SubstancePolymer');
INSERT INTO public.hfj_spidx_identity VALUES (3378, -5531727979671556590, 'issued', 'TestReport');
INSERT INTO public.hfj_spidx_identity VALUES (3379, 5099951916665761693, 'status', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (3380, 7454381022105049993, 'target-date', 'Goal');
INSERT INTO public.hfj_spidx_identity VALUES (3381, -7954033786934933072, 'media', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (3382, 3131907980075666767, '_security', 'MedicinalProductContraindication');
INSERT INTO public.hfj_spidx_identity VALUES (3383, 5823321487340048133, 'container', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (3384, -1870083920032190779, '_security', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (3385, -177129513520427687, 'title', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3386, -2734182304678814260, 'variant-end', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (3387, -7309244172355434619, '_profile', 'Medication');
INSERT INTO public.hfj_spidx_identity VALUES (3388, -7922318042807003791, 'phone:of-type', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (3389, -7061397084126507402, '_security:of-type', 'NutritionOrder');
INSERT INTO public.hfj_spidx_identity VALUES (3390, -5928124344209283335, 'identifier:of-type', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3391, -830369872792147632, 'identifier', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (3392, -5559709572072746196, 'date', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (3393, 3277376859087961791, 'successor', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3394, -3363688513414654282, 'group-identifier', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3395, -7496493541457966233, 'gender:of-type', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (3396, 2834087348067369440, 'code', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3397, -4109368151468103714, '_id:of-type', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3398, 1671862879260362760, 'url', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (3399, -6027921678034716286, 'url', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (3400, 2401219716109953414, '_tag', 'BiologicallyDerivedProduct');
INSERT INTO public.hfj_spidx_identity VALUES (3401, -4824056373082521471, '_source', 'MedicinalProductManufactured');
INSERT INTO public.hfj_spidx_identity VALUES (3402, -6941595911303322969, 'jurisdiction', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (3403, -4498745660244989105, 'code:of-type', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (3404, -549029437503406953, 'name', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3405, -7505439946886088432, 'address-use', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (3406, 6202160766075379127, '_security', 'GraphDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3407, -5646212779915489753, '_tag', 'Account');
INSERT INTO public.hfj_spidx_identity VALUES (3408, -5107704525304043152, 'group-identifier:of-type', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3409, -6259439021051533501, 'based-on', 'CarePlan');
INSERT INTO public.hfj_spidx_identity VALUES (3410, -1072850784415315669, 'derived-from', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (3411, 7901946269844400610, 'subdetail-udi', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (3412, -4320486700644744912, 'body-site', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (3413, 333388339446734064, 'jurisdiction', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (3414, 8387418887488657418, 'identifier', 'DeviceUseStatement');
INSERT INTO public.hfj_spidx_identity VALUES (3415, 5178419496037218256, '_security:of-type', 'MedicationAdministration');
INSERT INTO public.hfj_spidx_identity VALUES (3416, -803565490392841043, 'instantiates-canonical', 'FamilyMemberHistory');
INSERT INTO public.hfj_spidx_identity VALUES (3417, -3972405609785148324, 'identifier:of-type', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (3418, -7300253931016271114, 'date', 'CapabilityStatement');
INSERT INTO public.hfj_spidx_identity VALUES (3419, -4116676772289889211, 'predecessor', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3420, -7728455439988712111, '_security', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (3421, 8325793321355056566, 'status', 'CoverageEligibilityResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3422, 6691258560486415509, 'reaction', 'Immunization');
INSERT INTO public.hfj_spidx_identity VALUES (3423, -1388003653690250743, 'principalinvestigator', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (3424, -4787823569163130626, 'jurisdiction:of-type', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3425, -8814887570961523610, 'context:of-type', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (3426, 7420887625480512431, '_security:of-type', 'Claim');
INSERT INTO public.hfj_spidx_identity VALUES (3427, -1568345287307607341, 'signature-type:of-type', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (3428, -4485257618494788158, 'status', 'EnrollmentRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3429, -4652999515925491380, 'context-type', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (3430, 6435003499945283827, 'composed-of', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3431, -6154932711781217144, 'type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3432, -6948460790890660453, '_id', 'Composition');
INSERT INTO public.hfj_spidx_identity VALUES (3433, 4396689516878186344, '_profile', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (3434, -7881401192382262022, 'email:of-type', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (3435, -3990899826321915335, 'jurisdiction:of-type', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (3436, -3551447612886209907, 'identifier', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (3437, -5748789583377936715, 'appointment-type', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (3438, 8766045824105472404, 'publisher', 'ImplementationGuide');
INSERT INTO public.hfj_spidx_identity VALUES (3439, -6648318519569715251, '_lastUpdated', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (3440, -7313512353899770354, 'patient', 'Device');
INSERT INTO public.hfj_spidx_identity VALUES (3441, 3043703955381107143, '_id', 'DiagnosticReport');
INSERT INTO public.hfj_spidx_identity VALUES (3442, 8243984068255903092, 'target-species:of-type', 'MedicinalProductPharmaceutical');
INSERT INTO public.hfj_spidx_identity VALUES (3443, -837159307896014207, 'author', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (3444, 8325114203247566193, 'category:of-type', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (3445, 1126135550640136114, 'implicated', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (3446, -2994369545816597645, 'version:of-type', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3447, -6642276270230891200, 'type', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (3448, -4305922167978169580, 'purpose:of-type', 'Consent');
INSERT INTO public.hfj_spidx_identity VALUES (3449, -3506522668499616008, 'publisher', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (3450, -5401611196399154356, 'status', 'EnrollmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3451, -1173354941707688224, '_lastUpdated', 'MedicationStatement');
INSERT INTO public.hfj_spidx_identity VALUES (3452, -553343052740527634, '_tag:of-type', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (3453, -8459930391957279542, 'message', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (3454, 2063278839324487099, '_id', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (3455, -3717935488761988855, 'source-code:of-type', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (3456, 5348075196378821309, 'name', 'Evidence');
INSERT INTO public.hfj_spidx_identity VALUES (3457, -7676985818803787357, 'data-absent-reason', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (3458, -6760790489365601079, 'status:of-type', 'Procedure');
INSERT INTO public.hfj_spidx_identity VALUES (3459, 5581260758240686367, '_profile', 'SubstanceProtein');
INSERT INTO public.hfj_spidx_identity VALUES (3460, -4697323098381415349, '_security:of-type', 'DeviceDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3461, -640578669654510537, '_source', 'MessageHeader');
INSERT INTO public.hfj_spidx_identity VALUES (3462, -3112749452302492570, '_tag', 'AppointmentResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3463, 5083402735298398241, 'patient', 'Invoice');
INSERT INTO public.hfj_spidx_identity VALUES (3464, -3752946362701101026, 'specialty', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (3465, -2826985097957767965, '_security:of-type', 'Endpoint');
INSERT INTO public.hfj_spidx_identity VALUES (3466, 1527025278393257777, 'sent', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (3467, 6599981669543003186, 'status', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (3468, 5724995545230197379, 'publisher', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3469, -2688472420561419020, 'practitioner', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (3470, 7270092434932005086, 'jurisdiction:of-type', 'TestScript');
INSERT INTO public.hfj_spidx_identity VALUES (3471, -7838724505934006305, '_lastUpdated', 'SubstanceProtein');
INSERT INTO public.hfj_spidx_identity VALUES (3472, -6911999180723868995, '_lastUpdated', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (3473, 4080029244737234813, 'type', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (3474, -4538696605191225108, 'monitoring-program-name', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (3475, -1654703185803905379, 'jurisdiction:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3476, 6813534479720706375, 'status:of-type', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (3477, 7261311235877393461, 'derived-from', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (3478, 3527312735301517689, '_id:of-type', 'Communication');
INSERT INTO public.hfj_spidx_identity VALUES (3479, -6018662478495839585, '_security', 'MeasureReport');
INSERT INTO public.hfj_spidx_identity VALUES (3480, -9053251719850715338, 'date', 'ResearchDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3481, 4096142866652982794, '_tag', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3482, -258140567555717970, '_tag:of-type', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (3483, 1498205453567258546, 'phone:of-type', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (3484, 236584477309646985, '_profile', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (3485, -1538598162160423650, 'code:of-type', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (3486, -2255168762124441277, 'identifier', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (3487, 6936016752287278344, 'version:of-type', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (3488, 8789757724535539786, 'authenticator', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (3489, -3339571080739240642, 'context:of-type', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (3490, -192392211290717597, 'participating-organization', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (3491, 4514621203647593317, '_tag:of-type', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (3492, 8059978313084077027, 'identifier:of-type', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3493, -935257385285476299, 'identifier:of-type', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (3494, 33357134676491868, '_tag:of-type', 'ImmunizationRecommendation');
INSERT INTO public.hfj_spidx_identity VALUES (3495, 5200953218008388748, 'title', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3496, -4711237482668797195, '_source', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (3497, 1549862878873664338, 'effective', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3498, 8974780063204341235, '_security:of-type', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (3499, -1673889972454302487, '_profile', 'SubstanceSpecification');
INSERT INTO public.hfj_spidx_identity VALUES (3500, 2060117187929570320, '_security:of-type', 'PlanDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3501, 6584867233982101255, 'category', 'AllergyIntolerance');
INSERT INTO public.hfj_spidx_identity VALUES (3502, 1117960878077413697, '_security', 'EventDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3503, -5283293049045559767, 'empty-reason:of-type', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (3504, 4450235250462698835, 'identifier', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (3505, 1855104117777041574, 'doseform', 'MedicationKnowledge');
INSERT INTO public.hfj_spidx_identity VALUES (3506, 3238679631810808150, 'agent-role:of-type', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (3507, 6578508548977579897, 'status:of-type', 'CompartmentDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3508, -6952816229597827955, 'focus', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3509, 4348299873406530458, 'patient', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (3510, -3881538845824623274, 'service-type', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (3511, 6864254753371633057, 'slot', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (3512, -4278061335209425410, 'jurisdiction', 'Questionnaire');
INSERT INTO public.hfj_spidx_identity VALUES (3513, -8747094015953991704, '_profile', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (3514, -246527281149175618, '_source', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (3515, 3790823506396071602, 'identifier', 'MedicinalProduct');
INSERT INTO public.hfj_spidx_identity VALUES (3516, -3080148298717841303, 'context-quantity', 'TerminologyCapabilities');
INSERT INTO public.hfj_spidx_identity VALUES (3517, 9095802695390811369, '_profile', 'ValueSet');
INSERT INTO public.hfj_spidx_identity VALUES (3518, 8691475343416383359, 'derived-from', 'ActivityDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3519, -913134423328501678, 'url', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3520, 8349822865253816295, 'status:of-type', 'ResearchElementDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3521, -3738812568438795548, 'date', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (3522, -3097001790497935480, '_id:of-type', 'InsurancePlan');
INSERT INTO public.hfj_spidx_identity VALUES (3523, -2482571848059374637, 'identifier', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (3524, -4461770577092569831, '_security:of-type', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (3525, 4474486695088475201, '_source', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (3526, 1308280081804933636, 'link', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (3527, 3575448297271116328, '_security', 'DeviceMetric');
INSERT INTO public.hfj_spidx_identity VALUES (3528, 8875694752456982506, 'version', 'CodeSystem');
INSERT INTO public.hfj_spidx_identity VALUES (3529, -1751097233758809056, 'category', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3530, 6430584161761236073, 'service-provider', 'Encounter');
INSERT INTO public.hfj_spidx_identity VALUES (3531, 900988441683446422, 'requestor', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3532, -5243082657816342377, 'base-path', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3533, 3960367433070856345, '_tag', 'Condition');
INSERT INTO public.hfj_spidx_identity VALUES (3534, 237576698171350006, 'authored', 'RequestGroup');
INSERT INTO public.hfj_spidx_identity VALUES (3535, -2348552296471335871, 'context', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (3536, -7947193218643885485, 'context-quantity', 'Library');
INSERT INTO public.hfj_spidx_identity VALUES (3537, 453388137489365836, 'address-use:of-type', 'Patient');
INSERT INTO public.hfj_spidx_identity VALUES (3538, 6386383713919181450, 'instance:of-type', 'OperationDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3539, -6699144830560949070, '_id', 'Appointment');
INSERT INTO public.hfj_spidx_identity VALUES (3540, 8197845761969619551, 'target-disease', 'ImmunizationEvaluation');
INSERT INTO public.hfj_spidx_identity VALUES (3541, 5851890850227059154, 'container-identifier', 'Substance');
INSERT INTO public.hfj_spidx_identity VALUES (3542, -3941939790209885669, '_tag', 'QuestionnaireResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3543, 8604541594026123247, '_source', 'OperationOutcome');
INSERT INTO public.hfj_spidx_identity VALUES (3544, -362305089661462881, 'type', 'DeviceDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3545, 9053228768598094617, '_source', 'Slot');
INSERT INTO public.hfj_spidx_identity VALUES (3546, 7232164241993723264, 'status:of-type', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (3547, -3762522373361758771, 'version:of-type', 'EvidenceVariable');
INSERT INTO public.hfj_spidx_identity VALUES (3548, -4712680536415507436, 'patient', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3549, -8426540132265884581, 'exclude:of-type', 'Group');
INSERT INTO public.hfj_spidx_identity VALUES (3550, -4316943109777761631, '_tag', 'SubstanceProtein');
INSERT INTO public.hfj_spidx_identity VALUES (3551, -448126187381279930, 'identifier:of-type', 'ConceptMap');
INSERT INTO public.hfj_spidx_identity VALUES (3552, 8617300324836848703, '_source', 'MolecularSequence');
INSERT INTO public.hfj_spidx_identity VALUES (3553, -732828467973894344, '_profile', 'MedicinalProductUndesirableEffect');
INSERT INTO public.hfj_spidx_identity VALUES (3554, -6704496684590151771, '_id', 'DetectedIssue');
INSERT INTO public.hfj_spidx_identity VALUES (3555, -1404962941475077043, 'phone', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (3556, 9684505820786371, '_tag:of-type', 'AuditEvent');
INSERT INTO public.hfj_spidx_identity VALUES (3557, -8812176195096156352, '_id:of-type', 'EpisodeOfCare');
INSERT INTO public.hfj_spidx_identity VALUES (3558, -5150758215756701061, 'code:of-type', 'DeviceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3559, -7941779180978714972, '_profile', 'CareTeam');
INSERT INTO public.hfj_spidx_identity VALUES (3560, 2803594006903607109, '_tag:of-type', 'MedicinalProductUndesirableEffect');
INSERT INTO public.hfj_spidx_identity VALUES (3561, -1417309351508211264, 'patient', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (3562, -6934776834540610083, 'recorded', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (3563, 387807586595864093, 'telecom', 'Practitioner');
INSERT INTO public.hfj_spidx_identity VALUES (3564, -5943038544627834147, 'url', 'ExampleScenario');
INSERT INTO public.hfj_spidx_identity VALUES (3565, 5178819190435052846, 'code:of-type', 'List');
INSERT INTO public.hfj_spidx_identity VALUES (3566, -5342635945694389725, '_source', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (3567, -629338070489336718, 'identifier:of-type', 'MedicinalProductPackaged');
INSERT INTO public.hfj_spidx_identity VALUES (3568, -5029086985315939791, 'morphology:of-type', 'BodyStructure');
INSERT INTO public.hfj_spidx_identity VALUES (3569, -5891289220862410937, 'identifier:of-type', 'Media');
INSERT INTO public.hfj_spidx_identity VALUES (3570, 2607455977788091255, '_id', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (3571, 1619751191010842193, '_tag', 'MessageDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3572, 3229719758485800694, '_id:of-type', 'StructureMap');
INSERT INTO public.hfj_spidx_identity VALUES (3573, -2891191730095216114, '_id', 'BiologicallyDerivedProduct');
INSERT INTO public.hfj_spidx_identity VALUES (3574, 5126665621011078479, 'status:of-type', 'CoverageEligibilityRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3575, 855225084942431309, 'jurisdiction:of-type', 'Measure');
INSERT INTO public.hfj_spidx_identity VALUES (3576, -8451739140477281049, '_security', 'Person');
INSERT INTO public.hfj_spidx_identity VALUES (3577, 2525880897772363567, 'type:of-type', 'Specimen');
INSERT INTO public.hfj_spidx_identity VALUES (3578, -2072790464183405452, 'address', 'RelatedPerson');
INSERT INTO public.hfj_spidx_identity VALUES (3579, -674403302382500221, '_security:of-type', 'Observation');
INSERT INTO public.hfj_spidx_identity VALUES (3580, 6545504395342028958, '_lastUpdated', 'Contract');
INSERT INTO public.hfj_spidx_identity VALUES (3581, -2842585423321635857, '_id', 'MedicationDispense');
INSERT INTO public.hfj_spidx_identity VALUES (3582, 1492680642950120570, 'status:of-type', 'ResearchStudy');
INSERT INTO public.hfj_spidx_identity VALUES (3583, 7376007314674238933, 'url', 'EffectEvidenceSynthesis');
INSERT INTO public.hfj_spidx_identity VALUES (3584, -8774681921799593303, 'type:of-type', 'Bundle');
INSERT INTO public.hfj_spidx_identity VALUES (3585, 8312409197213934379, 'status', 'ExplanationOfBenefit');
INSERT INTO public.hfj_spidx_identity VALUES (3586, -7202555450723993941, '_tag', 'VerificationResult');
INSERT INTO public.hfj_spidx_identity VALUES (3587, 5055570997958252769, '_security:of-type', 'OperationOutcome');
INSERT INTO public.hfj_spidx_identity VALUES (3588, -6083162430115477943, '_source', 'Basic');
INSERT INTO public.hfj_spidx_identity VALUES (3589, -3695619611883272624, 'partof', 'Location');
INSERT INTO public.hfj_spidx_identity VALUES (3590, 3402563415088162708, 'code:of-type', 'ServiceRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3591, 4019864491555405058, 'intended-performertype', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3592, -8735850012146028188, '_profile', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3593, 7903048640376656606, '_tag', 'Provenance');
INSERT INTO public.hfj_spidx_identity VALUES (3594, -3494895683081205605, 'path', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3595, -3376943927693763889, '_security:of-type', 'PractitionerRole');
INSERT INTO public.hfj_spidx_identity VALUES (3596, -3285200137186233197, 'service', 'OrganizationAffiliation');
INSERT INTO public.hfj_spidx_identity VALUES (3597, 998465525041425850, 'priority:of-type', 'Task');
INSERT INTO public.hfj_spidx_identity VALUES (3598, -2650506098983636623, 'experimental:of-type', 'StructureDefinition');
INSERT INTO public.hfj_spidx_identity VALUES (3599, -5718307470046113384, '_source', 'MedicationRequest');
INSERT INTO public.hfj_spidx_identity VALUES (3600, -6965096218343956878, 'payment-date', 'ClaimResponse');
INSERT INTO public.hfj_spidx_identity VALUES (3601, -5012105588700278333, '_security', 'ResearchSubject');
INSERT INTO public.hfj_spidx_identity VALUES (3602, 2283772109401425456, 'identifier', 'Organization');
INSERT INTO public.hfj_spidx_identity VALUES (3603, -1621943171043343906, 'date', 'SearchParameter');
INSERT INTO public.hfj_spidx_identity VALUES (3604, -2811867580884279379, 'setting:of-type', 'DocumentReference');
INSERT INTO public.hfj_spidx_identity VALUES (3605, 5409002169401161295, 'subject', 'MedicinalProductContraindication');
INSERT INTO public.hfj_spidx_identity VALUES (3606, -7525280164927538223, '_profile', 'NamingSystem');
INSERT INTO public.hfj_spidx_identity VALUES (3607, -2369123478521686029, 'identifier', 'DocumentManifest');


--
-- TOC entry 4648 (class 0 OID 19830)
-- Dependencies: 325
-- Data for Name: hfj_spidx_number; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4649 (class 0 OID 19835)
-- Dependencies: 326
-- Data for Name: hfj_spidx_quantity; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4650 (class 0 OID 19842)
-- Dependencies: 327
-- Data for Name: hfj_spidx_quantity_nrml; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4651 (class 0 OID 19849)
-- Dependencies: 328
-- Data for Name: hfj_spidx_string; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hfj_spidx_string VALUES (1000, NULL, NULL, -3911482699399797062, false, 'name', 1000, 'Organization', NULL, -2158092060392662036, 3620784778229117197, 'Prueba', 'PRUEBA');
INSERT INTO public.hfj_spidx_string VALUES (1001, NULL, NULL, 110533026097594599, false, 'phonetic', 1000, 'Organization', NULL, -8350828864266454440, -1560021078508241414, 'Prueba', 'PRUEBA');
INSERT INTO public.hfj_spidx_string VALUES (1002, NULL, NULL, 1555763355647208697, false, 'name', 1001, 'Location', NULL, 9097289094382956402, -7163906653713356382, 'Prueba Norte', 'PRUEBA NORTE');
INSERT INTO public.hfj_spidx_string VALUES (1003, NULL, NULL, -479026162469548185, false, 'name', 1002, 'HealthcareService', NULL, 6293866073844717908, 5051644611872808953, 'Consulta Medicina General', 'CONSULTA MEDICINA GENERAL');
INSERT INTO public.hfj_spidx_string VALUES (1004, NULL, NULL, -5555801628348895207, false, 'service-type', 1002, 'HealthcareService', NULL, 2825340265172769171, 8023349736090110429, 'Medicina General', 'MEDICINA GENERAL');
INSERT INTO public.hfj_spidx_string VALUES (1005, NULL, NULL, 1555763355647208697, false, 'name', 1003, 'Location', NULL, 218263772933462056, -7163906653713356382, 'Prueba Sur', 'PRUEBA SUR');
INSERT INTO public.hfj_spidx_string VALUES (1051, NULL, NULL, 110533026097594599, false, 'phonetic', 1051, 'Organization', NULL, -4697257499879513396, -1560021078508241414, 'Pruebas', 'PRUEBAS');
INSERT INTO public.hfj_spidx_string VALUES (1052, NULL, NULL, -3911482699399797062, false, 'name', 1051, 'Organization', NULL, 5862252626083003873, 3620784778229117197, 'Pruebas', 'PRUEBAS');
INSERT INTO public.hfj_spidx_string VALUES (1053, NULL, NULL, 1555763355647208697, false, 'name', 1052, 'Location', NULL, 615156367630835545, -7163906653713356382, 'Pruebas Noroccidente', 'PRUEBAS NOROCCIDENTE');
INSERT INTO public.hfj_spidx_string VALUES (1054, NULL, NULL, 110533026097594599, false, 'phonetic', 1053, 'Organization', NULL, -7625617106109699673, -1560021078508241414, 'Acme', 'ACME');
INSERT INTO public.hfj_spidx_string VALUES (1055, NULL, NULL, -3911482699399797062, false, 'name', 1053, 'Organization', NULL, -7967900439608741321, 3620784778229117197, 'Acme', 'ACME');
INSERT INTO public.hfj_spidx_string VALUES (1056, NULL, NULL, 1555763355647208697, false, 'name', 1054, 'Location', NULL, 1960495447030898596, -7163906653713356382, 'Norte', 'NORTE');
INSERT INTO public.hfj_spidx_string VALUES (1057, NULL, NULL, 110533026097594599, false, 'phonetic', 1055, 'Organization', NULL, 5175635337660243418, -1560021078508241414, 'prueba 25', 'PRUEBA 25');
INSERT INTO public.hfj_spidx_string VALUES (1058, NULL, NULL, -3911482699399797062, false, 'name', 1055, 'Organization', NULL, -2980077269778714435, 3620784778229117197, 'prueba 25', 'PRUEBA 25');
INSERT INTO public.hfj_spidx_string VALUES (1059, NULL, NULL, 1555763355647208697, false, 'name', 1056, 'Location', NULL, -2058358780221977089, -7163906653713356382, 'Pruebas Sur', 'PRUEBAS SUR');
INSERT INTO public.hfj_spidx_string VALUES (1060, NULL, NULL, -479026162469548185, false, 'name', 1057, 'HealthcareService', NULL, -2143737659068838555, 5051644611872808953, 'yyyyyy', 'YYYYYY');
INSERT INTO public.hfj_spidx_string VALUES (1061, NULL, NULL, -5555801628348895207, false, 'service-type', 1057, 'HealthcareService', NULL, 5046028605520995131, 8023349736090110429, 'Medicina Familiar', 'MEDICINA FAMILIAR');
INSERT INTO public.hfj_spidx_string VALUES (1062, NULL, NULL, 110533026097594599, false, 'phonetic', 1058, 'Organization', NULL, -8928251039080161138, -1560021078508241414, 'Prueba2455', 'PRUEBA2455');
INSERT INTO public.hfj_spidx_string VALUES (1063, NULL, NULL, -3911482699399797062, false, 'name', 1058, 'Organization', NULL, 174383345316602384, 3620784778229117197, 'Prueba2455', 'PRUEBA2455');
INSERT INTO public.hfj_spidx_string VALUES (1064, NULL, NULL, 1555763355647208697, false, 'name', 1059, 'Location', NULL, 5782717641380604682, -7163906653713356382, 'Prueba Clase', 'PRUEBA CLASE');
INSERT INTO public.hfj_spidx_string VALUES (1065, NULL, NULL, -5555801628348895207, false, 'service-type', 1060, 'HealthcareService', NULL, -4559284959426592162, 8023349736090110429, 'Pediatria', 'PEDIATRIA');
INSERT INTO public.hfj_spidx_string VALUES (1066, NULL, NULL, -479026162469548185, false, 'name', 1060, 'HealthcareService', NULL, 7437875695552167767, 5051644611872808953, 'Mediprueba', 'MEDIPRUEBA');


--
-- TOC entry 4652 (class 0 OID 19856)
-- Dependencies: 329
-- Data for Name: hfj_spidx_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hfj_spidx_token VALUES (1000, NULL, NULL, 2283772109401425456, false, 'identifier', 1000, 'Organization', NULL, 3418714644749230738, -1854840547955953455, 3112725267404668394, 'https://acme.com/ips/nit', '57766565666');
INSERT INTO public.hfj_spidx_token VALUES (1001, NULL, NULL, -7000960520703644624, false, 'active', 1000, 'Organization', NULL, 8789270121204505530, 7220834943283573058, 6353589021560678678, NULL, 'true');
INSERT INTO public.hfj_spidx_token VALUES (1002, NULL, NULL, 623246202595886302, false, 'status', 1001, 'Location', NULL, 4554489645481690690, 7460270922997062730, 2918137205964839970, 'http://hl7.org/fhir/location-status', 'active');
INSERT INTO public.hfj_spidx_token VALUES (1003, NULL, NULL, -7376849905152195732, false, 'active', 1002, 'HealthcareService', NULL, -5307683032323586538, -6678603555620166398, 553186271591399727, NULL, 'true');
INSERT INTO public.hfj_spidx_token VALUES (1004, NULL, NULL, 623246202595886302, false, 'status', 1003, 'Location', NULL, 4554489645481690690, 7460270922997062730, 2918137205964839970, 'http://hl7.org/fhir/location-status', 'active');
INSERT INTO public.hfj_spidx_token VALUES (1051, NULL, NULL, 2283772109401425456, false, 'identifier', 1051, 'Organization', NULL, 3418714644749230738, -221858881737976628, 195831659044232253, 'https://acme.com/ips/nit', '67677667-1');
INSERT INTO public.hfj_spidx_token VALUES (1052, NULL, NULL, -7000960520703644624, false, 'active', 1051, 'Organization', NULL, 8789270121204505530, 7220834943283573058, 6353589021560678678, NULL, 'true');
INSERT INTO public.hfj_spidx_token VALUES (1053, NULL, NULL, 623246202595886302, false, 'status', 1052, 'Location', NULL, 4554489645481690690, 7460270922997062730, 2918137205964839970, 'http://hl7.org/fhir/location-status', 'active');
INSERT INTO public.hfj_spidx_token VALUES (1054, NULL, NULL, -7000960520703644624, false, 'active', 1053, 'Organization', NULL, 8789270121204505530, 7220834943283573058, 6353589021560678678, NULL, 'true');
INSERT INTO public.hfj_spidx_token VALUES (1055, NULL, NULL, 2283772109401425456, false, 'identifier', 1053, 'Organization', NULL, 3418714644749230738, 5112815175849876948, 814416113974782318, 'https://acme.com/ips/nit', '565565556-1');
INSERT INTO public.hfj_spidx_token VALUES (1056, NULL, NULL, 623246202595886302, false, 'status', 1054, 'Location', NULL, 4554489645481690690, 7460270922997062730, 2918137205964839970, 'http://hl7.org/fhir/location-status', 'active');
INSERT INTO public.hfj_spidx_token VALUES (1057, NULL, NULL, -7000960520703644624, false, 'active', 1055, 'Organization', NULL, 8789270121204505530, 7220834943283573058, 6353589021560678678, NULL, 'true');
INSERT INTO public.hfj_spidx_token VALUES (1058, NULL, NULL, 2283772109401425456, false, 'identifier', 1055, 'Organization', NULL, 3418714644749230738, -7379545461265893200, 3409545288223827793, 'https://acme.com/ips/nit', '656565656556');
INSERT INTO public.hfj_spidx_token VALUES (1059, NULL, NULL, 623246202595886302, false, 'status', 1056, 'Location', NULL, 4554489645481690690, 7460270922997062730, 2918137205964839970, 'http://hl7.org/fhir/location-status', 'active');
INSERT INTO public.hfj_spidx_token VALUES (1060, NULL, NULL, -7376849905152195732, false, 'active', 1057, 'HealthcareService', NULL, -5307683032323586538, -6678603555620166398, 553186271591399727, NULL, 'true');
INSERT INTO public.hfj_spidx_token VALUES (1061, NULL, NULL, -7000960520703644624, false, 'active', 1058, 'Organization', NULL, 8789270121204505530, 7220834943283573058, 6353589021560678678, NULL, 'true');
INSERT INTO public.hfj_spidx_token VALUES (1062, NULL, NULL, 2283772109401425456, false, 'identifier', 1058, 'Organization', NULL, 3418714644749230738, -2619648177656338696, -7016613510159388853, 'https://acme.com/ips/nit', '656656665-8');
INSERT INTO public.hfj_spidx_token VALUES (1063, NULL, NULL, 623246202595886302, false, 'status', 1059, 'Location', NULL, 4554489645481690690, 7460270922997062730, 2918137205964839970, 'http://hl7.org/fhir/location-status', 'active');
INSERT INTO public.hfj_spidx_token VALUES (1064, NULL, NULL, -7376849905152195732, false, 'active', 1060, 'HealthcareService', NULL, -5307683032323586538, -6678603555620166398, 553186271591399727, NULL, 'true');


--
-- TOC entry 4653 (class 0 OID 19863)
-- Dependencies: 330
-- Data for Name: hfj_spidx_uri; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4654 (class 0 OID 19870)
-- Dependencies: 331
-- Data for Name: hfj_subscription_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4655 (class 0 OID 19875)
-- Dependencies: 332
-- Data for Name: hfj_tag_def; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4607 (class 0 OID 19476)
-- Dependencies: 284
-- Data for Name: historial_cambios_cita; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4569 (class 0 OID 18982)
-- Dependencies: 246
-- Data for Name: ips; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ips VALUES (1, 'Prueba', 'PRUEBA EPS', '57766565666', '655775557', '', '675567765', '', NULL, true, '1000', '1', '2026-04-30 01:04:35.187734', '2026-04-30 01:04:33.523954', NULL);
INSERT INTO public.ips VALUES (2, 'Pruebas', 'PRUEBAS EPS LTDA', '67677667-1', '', 'Calle falsa 123', '7111111', '', NULL, true, '1051', '1', '2026-05-02 13:22:43.525067', '2026-05-02 13:22:41.315251', NULL);
INSERT INTO public.ips VALUES (3, 'Acme', 'ACME SALUD EPS LTDA', '565565556-1', '', 'CALLE FALSA 123', '37111111', '', NULL, true, '1053', '1', '2026-05-02 13:53:36.629147', '2026-05-02 13:53:36.113505', NULL);
INSERT INTO public.ips VALUES (4, 'prueba 25', 'Pruebas eps', '656565656556', '', '', '67565575', '', NULL, true, '1055', '1', '2026-05-04 15:12:04.054506', '2026-05-04 15:12:02.020823', NULL);
INSERT INTO public.ips VALUES (5, 'Prueba2455', 'Pruebas', '656656665-8', '', '', '', '', NULL, true, '1058', '1', '2026-05-04 16:26:54.480699', '2026-05-04 16:26:54.006435', NULL);


--
-- TOC entry 4609 (class 0 OID 19496)
-- Dependencies: 286
-- Data for Name: lista_espera; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4563 (class 0 OID 18948)
-- Dependencies: 240
-- Data for Name: modalidades_atencion; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4551 (class 0 OID 18886)
-- Dependencies: 228
-- Data for Name: motivos_cancelacion; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4656 (class 0 OID 19882)
-- Dependencies: 333
-- Data for Name: mpi_link; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4657 (class 0 OID 19887)
-- Dependencies: 334
-- Data for Name: mpi_link_aud; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4567 (class 0 OID 18967)
-- Dependencies: 244
-- Data for Name: municipios; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4611 (class 0 OID 19544)
-- Dependencies: 288
-- Data for Name: notificaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4658 (class 0 OID 19892)
-- Dependencies: 335
-- Data for Name: npm_package; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4659 (class 0 OID 19899)
-- Dependencies: 336
-- Data for Name: npm_package_ver; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4660 (class 0 OID 19906)
-- Dependencies: 337
-- Data for Name: npm_package_ver_res; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4591 (class 0 OID 19209)
-- Dependencies: 268
-- Data for Name: pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4577 (class 0 OID 19066)
-- Dependencies: 254
-- Data for Name: permisos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4587 (class 0 OID 19153)
-- Dependencies: 264
-- Data for Name: profesionales; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4595 (class 0 OID 19262)
-- Dependencies: 272
-- Data for Name: reglas_duracion_cita; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4605 (class 0 OID 19460)
-- Dependencies: 282
-- Data for Name: respuestas_cita; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4579 (class 0 OID 19078)
-- Dependencies: 256
-- Data for Name: rol_permiso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4545 (class 0 OID 18854)
-- Dependencies: 222
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles VALUES (1, 'ADMIN', 'Administrador', 'Usuario administrador del sistema', true);


--
-- TOC entry 4589 (class 0 OID 19176)
-- Dependencies: 266
-- Data for Name: roles_profesional; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4573 (class 0 OID 19013)
-- Dependencies: 250
-- Data for Name: sedes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sedes VALUES (1, 1, 'Prueba Norte', '62747455-1', NULL, NULL, NULL, NULL, true, '1001', '1', '2026-04-30 01:07:45.218818', '2026-04-30 01:07:44.828501', NULL);
INSERT INTO public.sedes VALUES (2, 1, 'Prueba Sur', '345343466-2', NULL, NULL, NULL, NULL, true, '1003', '1', '2026-04-30 03:52:32.470079', '2026-04-30 03:52:32.190497', NULL);
INSERT INTO public.sedes VALUES (3, 2, 'Pruebas Noroccidente', '52353227', '83773878873', NULL, 'Callefalsa 123', '3710000', true, '1052', '1', '2026-05-02 13:24:13.160617', '2026-05-02 13:24:12.88853', NULL);
INSERT INTO public.sedes VALUES (4, 3, 'Norte', '572572475435743-2', NULL, NULL, 'Calle falsa 234', '37100000', true, '1054', '1', '2026-05-02 13:54:29.441337', '2026-05-02 13:54:29.315698', NULL);
INSERT INTO public.sedes VALUES (5, 4, 'Pruebas Sur', '863653685', NULL, NULL, NULL, NULL, true, '1056', '1', '2026-05-04 15:14:47.176739', '2026-05-04 15:14:46.837716', NULL);
INSERT INTO public.sedes VALUES (6, 5, 'Prueba Clase', '562563426346534', '75757575757', NULL, NULL, NULL, true, '1059', '1', '2026-05-04 16:27:53.004223', '2026-05-04 16:27:52.906646', NULL);


--
-- TOC entry 4585 (class 0 OID 19125)
-- Dependencies: 262
-- Data for Name: servicios_salud; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.servicios_salud VALUES (1, 1, 1, 1, 'Consulta Medicina General', 'pruebas', true, '1002', '1', '2026-04-30 02:38:21.436077', '2026-04-30 02:38:21.112422', NULL);
INSERT INTO public.servicios_salud VALUES (2, 4, 5, 3, 'yyyyyy', NULL, true, '1057', '1', '2026-05-04 15:16:09.882691', '2026-05-04 15:16:08.695151', NULL);
INSERT INTO public.servicios_salud VALUES (3, 5, 6, 2, 'Mediprueba', NULL, true, '1060', '1', '2026-05-04 16:29:03.495864', '2026-05-04 16:29:03.389402', NULL);


--
-- TOC entry 4581 (class 0 OID 19097)
-- Dependencies: 258
-- Data for Name: sesiones_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4543 (class 0 OID 18844)
-- Dependencies: 220
-- Data for Name: sexos_biologicos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4561 (class 0 OID 18938)
-- Dependencies: 238
-- Data for Name: tipos_consulta; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4539 (class 0 OID 18824)
-- Dependencies: 216
-- Data for Name: tipos_documento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4661 (class 0 OID 19913)
-- Dependencies: 338
-- Data for Name: trm_codesystem; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4662 (class 0 OID 19918)
-- Dependencies: 339
-- Data for Name: trm_codesystem_ver; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4663 (class 0 OID 19923)
-- Dependencies: 340
-- Data for Name: trm_concept; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4664 (class 0 OID 19930)
-- Dependencies: 341
-- Data for Name: trm_concept_desig; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4665 (class 0 OID 19937)
-- Dependencies: 342
-- Data for Name: trm_concept_map; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4666 (class 0 OID 19944)
-- Dependencies: 343
-- Data for Name: trm_concept_map_group; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4667 (class 0 OID 19951)
-- Dependencies: 344
-- Data for Name: trm_concept_map_grp_element; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4668 (class 0 OID 19958)
-- Dependencies: 345
-- Data for Name: trm_concept_map_grp_elm_tgt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4669 (class 0 OID 19965)
-- Dependencies: 346
-- Data for Name: trm_concept_pc_link; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4670 (class 0 OID 19970)
-- Dependencies: 347
-- Data for Name: trm_concept_property; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4671 (class 0 OID 19977)
-- Dependencies: 348
-- Data for Name: trm_valueset; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4672 (class 0 OID 19986)
-- Dependencies: 349
-- Data for Name: trm_valueset_c_designation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4673 (class 0 OID 19993)
-- Dependencies: 350
-- Data for Name: trm_valueset_concept; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4575 (class 0 OID 19036)
-- Dependencies: 252
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuarios VALUES (1, NULL, NULL, 1, 'Administrador', 'Sistema', 'admin@acme.com', 'admin', '$2b$10$fa9BjS1jcvposYrKbGCPWuc2klkhr/ovDBj4EWmLBU4d.Cu4Rn0Pu', true, '2026-05-04 16:26:16.17919', '2026-04-29 19:16:40.225199', NULL);


--
-- TOC entry 4767 (class 0 OID 0)
-- Dependencies: 273
-- Name: agendas_id_agenda_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.agendas_id_agenda_seq', 1, false);


--
-- TOC entry 4768 (class 0 OID 0)
-- Dependencies: 247
-- Name: aseguradoras_id_aseguradora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aseguradoras_id_aseguradora_seq', 1, false);


--
-- TOC entry 4769 (class 0 OID 0)
-- Dependencies: 289
-- Name: auditoria_id_auditoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auditoria_id_auditoria_seq', 1, false);


--
-- TOC entry 4770 (class 0 OID 0)
-- Dependencies: 277
-- Name: bloqueos_agenda_id_bloqueo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bloqueos_agenda_id_bloqueo_seq', 1, false);


--
-- TOC entry 4771 (class 0 OID 0)
-- Dependencies: 223
-- Name: canales_atencion_id_canal_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.canales_atencion_id_canal_seq', 1, false);


--
-- TOC entry 4772 (class 0 OID 0)
-- Dependencies: 279
-- Name: citas_id_cita_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.citas_id_cita_seq', 1, false);


--
-- TOC entry 4773 (class 0 OID 0)
-- Dependencies: 269
-- Name: coberturas_paciente_id_cobertura_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.coberturas_paciente_id_cobertura_seq', 1, false);


--
-- TOC entry 4774 (class 0 OID 0)
-- Dependencies: 291
-- Name: cola_sincronizacion_fhir_id_sync_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cola_sincronizacion_fhir_id_sync_seq', 1, false);


--
-- TOC entry 4775 (class 0 OID 0)
-- Dependencies: 275
-- Name: cupos_id_cupo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cupos_id_cupo_seq', 1, false);


--
-- TOC entry 4776 (class 0 OID 0)
-- Dependencies: 241
-- Name: departamentos_id_departamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departamentos_id_departamento_seq', 1, false);


--
-- TOC entry 4777 (class 0 OID 0)
-- Dependencies: 259
-- Name: especialidades_id_especialidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.especialidades_id_especialidad_seq', 4, true);


--
-- TOC entry 4778 (class 0 OID 0)
-- Dependencies: 231
-- Name: estados_agenda_id_estado_agenda_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estados_agenda_id_estado_agenda_seq', 1, false);


--
-- TOC entry 4779 (class 0 OID 0)
-- Dependencies: 225
-- Name: estados_cita_id_estado_cita_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estados_cita_id_estado_cita_seq', 1, false);


--
-- TOC entry 4780 (class 0 OID 0)
-- Dependencies: 229
-- Name: estados_cobertura_id_estado_cobertura_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estados_cobertura_id_estado_cobertura_seq', 1, false);


--
-- TOC entry 4781 (class 0 OID 0)
-- Dependencies: 233
-- Name: estados_cupo_id_estado_cupo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estados_cupo_id_estado_cupo_seq', 1, false);


--
-- TOC entry 4782 (class 0 OID 0)
-- Dependencies: 235
-- Name: estados_sincronizacion_fhir_id_estado_sincronizacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estados_sincronizacion_fhir_id_estado_sincronizacion_seq', 1, false);


--
-- TOC entry 4783 (class 0 OID 0)
-- Dependencies: 217
-- Name: generos_id_genero_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.generos_id_genero_seq', 1, false);


--
-- TOC entry 4784 (class 0 OID 0)
-- Dependencies: 283
-- Name: historial_cambios_cita_id_historial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historial_cambios_cita_id_historial_seq', 1, false);


--
-- TOC entry 4785 (class 0 OID 0)
-- Dependencies: 245
-- Name: ips_id_ips_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ips_id_ips_seq', 5, true);


--
-- TOC entry 4786 (class 0 OID 0)
-- Dependencies: 285
-- Name: lista_espera_id_lista_espera_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lista_espera_id_lista_espera_seq', 1, false);


--
-- TOC entry 4787 (class 0 OID 0)
-- Dependencies: 239
-- Name: modalidades_atencion_id_modalidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.modalidades_atencion_id_modalidad_seq', 1, false);


--
-- TOC entry 4788 (class 0 OID 0)
-- Dependencies: 227
-- Name: motivos_cancelacion_id_motivo_cancelacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.motivos_cancelacion_id_motivo_cancelacion_seq', 1, false);


--
-- TOC entry 4789 (class 0 OID 0)
-- Dependencies: 243
-- Name: municipios_id_municipio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.municipios_id_municipio_seq', 1, false);


--
-- TOC entry 4790 (class 0 OID 0)
-- Dependencies: 287
-- Name: notificaciones_id_notificacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notificaciones_id_notificacion_seq', 1, false);


--
-- TOC entry 4791 (class 0 OID 0)
-- Dependencies: 267
-- Name: pacientes_id_paciente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pacientes_id_paciente_seq', 1, false);


--
-- TOC entry 4792 (class 0 OID 0)
-- Dependencies: 253
-- Name: permisos_id_permiso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permisos_id_permiso_seq', 1, false);


--
-- TOC entry 4793 (class 0 OID 0)
-- Dependencies: 263
-- Name: profesionales_id_profesional_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profesionales_id_profesional_seq', 1, false);


--
-- TOC entry 4794 (class 0 OID 0)
-- Dependencies: 271
-- Name: reglas_duracion_cita_id_regla_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reglas_duracion_cita_id_regla_seq', 1, false);


--
-- TOC entry 4795 (class 0 OID 0)
-- Dependencies: 281
-- Name: respuestas_cita_id_respuesta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.respuestas_cita_id_respuesta_seq', 1, false);


--
-- TOC entry 4796 (class 0 OID 0)
-- Dependencies: 255
-- Name: rol_permiso_id_rol_permiso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rol_permiso_id_rol_permiso_seq', 1, false);


--
-- TOC entry 4797 (class 0 OID 0)
-- Dependencies: 221
-- Name: roles_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_rol_seq', 1, true);


--
-- TOC entry 4798 (class 0 OID 0)
-- Dependencies: 265
-- Name: roles_profesional_id_rol_profesional_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_profesional_id_rol_profesional_seq', 1, false);


--
-- TOC entry 4799 (class 0 OID 0)
-- Dependencies: 249
-- Name: sedes_id_sede_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sedes_id_sede_seq', 6, true);


--
-- TOC entry 4800 (class 0 OID 0)
-- Dependencies: 351
-- Name: seq_blkexcol_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_blkexcol_pid', 1, false);


--
-- TOC entry 4801 (class 0 OID 0)
-- Dependencies: 352
-- Name: seq_blkexcolfile_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_blkexcolfile_pid', 1, false);


--
-- TOC entry 4802 (class 0 OID 0)
-- Dependencies: 353
-- Name: seq_blkexjob_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_blkexjob_pid', 1, false);


--
-- TOC entry 4803 (class 0 OID 0)
-- Dependencies: 354
-- Name: seq_blkimjob_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_blkimjob_pid', 1, false);


--
-- TOC entry 4804 (class 0 OID 0)
-- Dependencies: 355
-- Name: seq_blkimjobfile_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_blkimjobfile_pid', 1, false);


--
-- TOC entry 4805 (class 0 OID 0)
-- Dependencies: 356
-- Name: seq_cncpt_map_grp_elm_tgt_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_cncpt_map_grp_elm_tgt_pid', 1, false);


--
-- TOC entry 4806 (class 0 OID 0)
-- Dependencies: 357
-- Name: seq_codesystem_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_codesystem_pid', 1, false);


--
-- TOC entry 4807 (class 0 OID 0)
-- Dependencies: 358
-- Name: seq_codesystemver_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_codesystemver_pid', 1, false);


--
-- TOC entry 4808 (class 0 OID 0)
-- Dependencies: 359
-- Name: seq_concept_desig_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_concept_desig_pid', 1, false);


--
-- TOC entry 4809 (class 0 OID 0)
-- Dependencies: 360
-- Name: seq_concept_map_group_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_concept_map_group_pid', 1, false);


--
-- TOC entry 4810 (class 0 OID 0)
-- Dependencies: 361
-- Name: seq_concept_map_grp_elm_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_concept_map_grp_elm_pid', 1, false);


--
-- TOC entry 4811 (class 0 OID 0)
-- Dependencies: 362
-- Name: seq_concept_map_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_concept_map_pid', 1, false);


--
-- TOC entry 4812 (class 0 OID 0)
-- Dependencies: 363
-- Name: seq_concept_pc_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_concept_pc_pid', 1, false);


--
-- TOC entry 4813 (class 0 OID 0)
-- Dependencies: 364
-- Name: seq_concept_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_concept_pid', 1, false);


--
-- TOC entry 4814 (class 0 OID 0)
-- Dependencies: 365
-- Name: seq_concept_prop_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_concept_prop_pid', 1, false);


--
-- TOC entry 4815 (class 0 OID 0)
-- Dependencies: 366
-- Name: seq_empi_link_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_empi_link_id', 1, false);


--
-- TOC entry 4816 (class 0 OID 0)
-- Dependencies: 367
-- Name: seq_forcedid_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_forcedid_id', 1, false);


--
-- TOC entry 4817 (class 0 OID 0)
-- Dependencies: 368
-- Name: seq_hfj_revinfo; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_hfj_revinfo', 1, false);


--
-- TOC entry 4818 (class 0 OID 0)
-- Dependencies: 369
-- Name: seq_historytag_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_historytag_id', 1000, false);


--
-- TOC entry 4819 (class 0 OID 0)
-- Dependencies: 370
-- Name: seq_idxcmbtoknu_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_idxcmbtoknu_id', 1000, false);


--
-- TOC entry 4820 (class 0 OID 0)
-- Dependencies: 371
-- Name: seq_idxcmpstruniq_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_idxcmpstruniq_id', 1000, false);


--
-- TOC entry 4821 (class 0 OID 0)
-- Dependencies: 372
-- Name: seq_npm_pack; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_npm_pack', 1, false);


--
-- TOC entry 4822 (class 0 OID 0)
-- Dependencies: 373
-- Name: seq_npm_packver; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_npm_packver', 1, false);


--
-- TOC entry 4823 (class 0 OID 0)
-- Dependencies: 374
-- Name: seq_npm_packverres; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_npm_packverres', 1, false);


--
-- TOC entry 4824 (class 0 OID 0)
-- Dependencies: 375
-- Name: seq_res_reindex_job; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_res_reindex_job', 1, false);


--
-- TOC entry 4825 (class 0 OID 0)
-- Dependencies: 376
-- Name: seq_reslink_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_reslink_id', 1100, true);


--
-- TOC entry 4826 (class 0 OID 0)
-- Dependencies: 377
-- Name: seq_resource_history_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_resource_history_id', 1100, true);


--
-- TOC entry 4827 (class 0 OID 0)
-- Dependencies: 378
-- Name: seq_resource_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_resource_id', 1100, true);


--
-- TOC entry 4828 (class 0 OID 0)
-- Dependencies: 379
-- Name: seq_resource_type; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_resource_type', 198, true);


--
-- TOC entry 4829 (class 0 OID 0)
-- Dependencies: 380
-- Name: seq_resparmpresent_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_resparmpresent_id', 1000, false);


--
-- TOC entry 4830 (class 0 OID 0)
-- Dependencies: 381
-- Name: seq_restag_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_restag_id', 1000, false);


--
-- TOC entry 4831 (class 0 OID 0)
-- Dependencies: 382
-- Name: seq_search; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_search', 101, true);


--
-- TOC entry 4832 (class 0 OID 0)
-- Dependencies: 383
-- Name: seq_search_inc; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_search_inc', 1, false);


--
-- TOC entry 4833 (class 0 OID 0)
-- Dependencies: 384
-- Name: seq_search_res; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_search_res', 101, true);


--
-- TOC entry 4834 (class 0 OID 0)
-- Dependencies: 385
-- Name: seq_spidx_coords; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_spidx_coords', 1000, false);


--
-- TOC entry 4835 (class 0 OID 0)
-- Dependencies: 386
-- Name: seq_spidx_date; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_spidx_date', 1000, false);


--
-- TOC entry 4836 (class 0 OID 0)
-- Dependencies: 387
-- Name: seq_spidx_identity; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_spidx_identity', 3607, true);


--
-- TOC entry 4837 (class 0 OID 0)
-- Dependencies: 388
-- Name: seq_spidx_number; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_spidx_number', 1000, false);


--
-- TOC entry 4838 (class 0 OID 0)
-- Dependencies: 389
-- Name: seq_spidx_quantity; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_spidx_quantity', 1000, false);


--
-- TOC entry 4839 (class 0 OID 0)
-- Dependencies: 390
-- Name: seq_spidx_quantity_nrml; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_spidx_quantity_nrml', 1000, false);


--
-- TOC entry 4840 (class 0 OID 0)
-- Dependencies: 391
-- Name: seq_spidx_string; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_spidx_string', 1100, true);


--
-- TOC entry 4841 (class 0 OID 0)
-- Dependencies: 392
-- Name: seq_spidx_token; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_spidx_token', 1100, true);


--
-- TOC entry 4842 (class 0 OID 0)
-- Dependencies: 393
-- Name: seq_spidx_uri; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_spidx_uri', 1000, false);


--
-- TOC entry 4843 (class 0 OID 0)
-- Dependencies: 394
-- Name: seq_subscription_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_subscription_id', 1, false);


--
-- TOC entry 4844 (class 0 OID 0)
-- Dependencies: 395
-- Name: seq_tagdef_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_tagdef_id', 1, false);


--
-- TOC entry 4845 (class 0 OID 0)
-- Dependencies: 396
-- Name: seq_valueset_c_dsgntn_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_valueset_c_dsgntn_pid', 1, false);


--
-- TOC entry 4846 (class 0 OID 0)
-- Dependencies: 397
-- Name: seq_valueset_concept_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_valueset_concept_pid', 1, false);


--
-- TOC entry 4847 (class 0 OID 0)
-- Dependencies: 398
-- Name: seq_valueset_pid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_valueset_pid', 1, false);


--
-- TOC entry 4848 (class 0 OID 0)
-- Dependencies: 261
-- Name: servicios_salud_id_servicio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servicios_salud_id_servicio_seq', 3, true);


--
-- TOC entry 4849 (class 0 OID 0)
-- Dependencies: 257
-- Name: sesiones_usuario_id_sesion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sesiones_usuario_id_sesion_seq', 1, false);


--
-- TOC entry 4850 (class 0 OID 0)
-- Dependencies: 219
-- Name: sexos_biologicos_id_sexo_biologico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sexos_biologicos_id_sexo_biologico_seq', 1, false);


--
-- TOC entry 4851 (class 0 OID 0)
-- Dependencies: 237
-- Name: tipos_consulta_id_tipo_consulta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipos_consulta_id_tipo_consulta_seq', 1, false);


--
-- TOC entry 4852 (class 0 OID 0)
-- Dependencies: 215
-- Name: tipos_documento_id_tipo_documento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipos_documento_id_tipo_documento_seq', 1, false);


--
-- TOC entry 4853 (class 0 OID 0)
-- Dependencies: 251
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 1, true);


--
-- TOC entry 3977 (class 2606 OID 19309)
-- Name: agendas agendas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agendas
    ADD CONSTRAINT agendas_pkey PRIMARY KEY (id_agenda);


--
-- TOC entry 3910 (class 2606 OID 19011)
-- Name: aseguradoras aseguradoras_nit_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aseguradoras
    ADD CONSTRAINT aseguradoras_nit_key UNIQUE (nit);


--
-- TOC entry 3912 (class 2606 OID 19009)
-- Name: aseguradoras aseguradoras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aseguradoras
    ADD CONSTRAINT aseguradoras_pkey PRIMARY KEY (id_aseguradora);


--
-- TOC entry 4011 (class 2606 OID 19573)
-- Name: auditoria auditoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria
    ADD CONSTRAINT auditoria_pkey PRIMARY KEY (id_auditoria);


--
-- TOC entry 3987 (class 2606 OID 19370)
-- Name: bloqueos_agenda bloqueos_agenda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bloqueos_agenda
    ADD CONSTRAINT bloqueos_agenda_pkey PRIMARY KEY (id_bloqueo);


--
-- TOC entry 4019 (class 2606 OID 19641)
-- Name: bt2_job_instance bt2_job_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bt2_job_instance
    ADD CONSTRAINT bt2_job_instance_pkey PRIMARY KEY (id);


--
-- TOC entry 4022 (class 2606 OID 19648)
-- Name: bt2_work_chunk bt2_work_chunk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bt2_work_chunk
    ADD CONSTRAINT bt2_work_chunk_pkey PRIMARY KEY (id);


--
-- TOC entry 3861 (class 2606 OID 18874)
-- Name: canales_atencion canales_atencion_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canales_atencion
    ADD CONSTRAINT canales_atencion_codigo_key UNIQUE (codigo);


--
-- TOC entry 3863 (class 2606 OID 18872)
-- Name: canales_atencion canales_atencion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canales_atencion
    ADD CONSTRAINT canales_atencion_pkey PRIMARY KEY (id_canal);


--
-- TOC entry 3989 (class 2606 OID 19393)
-- Name: citas citas_id_cupo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_id_cupo_key UNIQUE (id_cupo);


--
-- TOC entry 3991 (class 2606 OID 19391)
-- Name: citas citas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_pkey PRIMARY KEY (id_cita);


--
-- TOC entry 3967 (class 2606 OID 19245)
-- Name: coberturas_paciente coberturas_paciente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coberturas_paciente
    ADD CONSTRAINT coberturas_paciente_pkey PRIMARY KEY (id_cobertura);


--
-- TOC entry 4015 (class 2606 OID 19592)
-- Name: cola_sincronizacion_fhir cola_sincronizacion_fhir_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cola_sincronizacion_fhir
    ADD CONSTRAINT cola_sincronizacion_fhir_pkey PRIMARY KEY (id_sync);


--
-- TOC entry 3982 (class 2606 OID 19343)
-- Name: cupos cupos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupos
    ADD CONSTRAINT cupos_pkey PRIMARY KEY (id_cupo);


--
-- TOC entry 3897 (class 2606 OID 18965)
-- Name: departamentos departamentos_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamentos
    ADD CONSTRAINT departamentos_codigo_key UNIQUE (codigo);


--
-- TOC entry 3899 (class 2606 OID 18963)
-- Name: departamentos departamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamentos
    ADD CONSTRAINT departamentos_pkey PRIMARY KEY (id_departamento);


--
-- TOC entry 3939 (class 2606 OID 19121)
-- Name: especialidades especialidades_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidades
    ADD CONSTRAINT especialidades_codigo_key UNIQUE (codigo);


--
-- TOC entry 3941 (class 2606 OID 19123)
-- Name: especialidades especialidades_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidades
    ADD CONSTRAINT especialidades_nombre_key UNIQUE (nombre);


--
-- TOC entry 3943 (class 2606 OID 19119)
-- Name: especialidades especialidades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidades
    ADD CONSTRAINT especialidades_pkey PRIMARY KEY (id_especialidad);


--
-- TOC entry 3877 (class 2606 OID 18916)
-- Name: estados_agenda estados_agenda_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_agenda
    ADD CONSTRAINT estados_agenda_codigo_key UNIQUE (codigo);


--
-- TOC entry 3879 (class 2606 OID 18914)
-- Name: estados_agenda estados_agenda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_agenda
    ADD CONSTRAINT estados_agenda_pkey PRIMARY KEY (id_estado_agenda);


--
-- TOC entry 3865 (class 2606 OID 18884)
-- Name: estados_cita estados_cita_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_cita
    ADD CONSTRAINT estados_cita_codigo_key UNIQUE (codigo);


--
-- TOC entry 3867 (class 2606 OID 18882)
-- Name: estados_cita estados_cita_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_cita
    ADD CONSTRAINT estados_cita_pkey PRIMARY KEY (id_estado_cita);


--
-- TOC entry 3873 (class 2606 OID 18906)
-- Name: estados_cobertura estados_cobertura_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_cobertura
    ADD CONSTRAINT estados_cobertura_codigo_key UNIQUE (codigo);


--
-- TOC entry 3875 (class 2606 OID 18904)
-- Name: estados_cobertura estados_cobertura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_cobertura
    ADD CONSTRAINT estados_cobertura_pkey PRIMARY KEY (id_estado_cobertura);


--
-- TOC entry 3881 (class 2606 OID 18926)
-- Name: estados_cupo estados_cupo_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_cupo
    ADD CONSTRAINT estados_cupo_codigo_key UNIQUE (codigo);


--
-- TOC entry 3883 (class 2606 OID 18924)
-- Name: estados_cupo estados_cupo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_cupo
    ADD CONSTRAINT estados_cupo_pkey PRIMARY KEY (id_estado_cupo);


--
-- TOC entry 3885 (class 2606 OID 18936)
-- Name: estados_sincronizacion_fhir estados_sincronizacion_fhir_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_sincronizacion_fhir
    ADD CONSTRAINT estados_sincronizacion_fhir_codigo_key UNIQUE (codigo);


--
-- TOC entry 3887 (class 2606 OID 18934)
-- Name: estados_sincronizacion_fhir estados_sincronizacion_fhir_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_sincronizacion_fhir
    ADD CONSTRAINT estados_sincronizacion_fhir_pkey PRIMARY KEY (id_estado_sincronizacion);


--
-- TOC entry 3849 (class 2606 OID 18842)
-- Name: generos generos_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generos
    ADD CONSTRAINT generos_codigo_key UNIQUE (codigo);


--
-- TOC entry 3851 (class 2606 OID 18840)
-- Name: generos generos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generos
    ADD CONSTRAINT generos_pkey PRIMARY KEY (id_genero);


--
-- TOC entry 4026 (class 2606 OID 19655)
-- Name: hfj_binary_storage_blob hfj_binary_storage_blob_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_binary_storage_blob
    ADD CONSTRAINT hfj_binary_storage_blob_pkey PRIMARY KEY (blob_id);


--
-- TOC entry 4028 (class 2606 OID 19660)
-- Name: hfj_blk_export_colfile hfj_blk_export_colfile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_blk_export_colfile
    ADD CONSTRAINT hfj_blk_export_colfile_pkey PRIMARY KEY (pid);


--
-- TOC entry 4030 (class 2606 OID 19667)
-- Name: hfj_blk_export_collection hfj_blk_export_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_blk_export_collection
    ADD CONSTRAINT hfj_blk_export_collection_pkey PRIMARY KEY (pid);


--
-- TOC entry 4032 (class 2606 OID 19674)
-- Name: hfj_blk_export_job hfj_blk_export_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_blk_export_job
    ADD CONSTRAINT hfj_blk_export_job_pkey PRIMARY KEY (pid);


--
-- TOC entry 4037 (class 2606 OID 19681)
-- Name: hfj_blk_import_job hfj_blk_import_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_blk_import_job
    ADD CONSTRAINT hfj_blk_import_job_pkey PRIMARY KEY (pid);


--
-- TOC entry 4041 (class 2606 OID 19688)
-- Name: hfj_blk_import_jobfile hfj_blk_import_jobfile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_blk_import_jobfile
    ADD CONSTRAINT hfj_blk_import_jobfile_pkey PRIMARY KEY (pid);


--
-- TOC entry 4044 (class 2606 OID 19694)
-- Name: hfj_forced_id hfj_forced_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_forced_id
    ADD CONSTRAINT hfj_forced_id_pkey PRIMARY KEY (pid);


--
-- TOC entry 4046 (class 2606 OID 19699)
-- Name: hfj_history_tag hfj_history_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_history_tag
    ADD CONSTRAINT hfj_history_tag_pkey PRIMARY KEY (pid);


--
-- TOC entry 4051 (class 2606 OID 19706)
-- Name: hfj_idx_cmb_tok_nu hfj_idx_cmb_tok_nu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_idx_cmb_tok_nu
    ADD CONSTRAINT hfj_idx_cmb_tok_nu_pkey PRIMARY KEY (pid);


--
-- TOC entry 4056 (class 2606 OID 19713)
-- Name: hfj_idx_cmp_string_uniq hfj_idx_cmp_string_uniq_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_idx_cmp_string_uniq
    ADD CONSTRAINT hfj_idx_cmp_string_uniq_pkey PRIMARY KEY (pid);


--
-- TOC entry 4061 (class 2606 OID 19718)
-- Name: hfj_partition hfj_partition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_partition
    ADD CONSTRAINT hfj_partition_pkey PRIMARY KEY (part_id);


--
-- TOC entry 4065 (class 2606 OID 19725)
-- Name: hfj_res_identifier_pt_uniq hfj_res_identifier_pt_uniq_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_identifier_pt_uniq
    ADD CONSTRAINT hfj_res_identifier_pt_uniq_pkey PRIMARY KEY (ident_system_pid, ident_value);


--
-- TOC entry 4067 (class 2606 OID 19732)
-- Name: hfj_res_link hfj_res_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_link
    ADD CONSTRAINT hfj_res_link_pkey PRIMARY KEY (pid);


--
-- TOC entry 4072 (class 2606 OID 19737)
-- Name: hfj_res_param_present hfj_res_param_present_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_param_present
    ADD CONSTRAINT hfj_res_param_present_pkey PRIMARY KEY (pid);


--
-- TOC entry 4076 (class 2606 OID 19742)
-- Name: hfj_res_reindex_job hfj_res_reindex_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_reindex_job
    ADD CONSTRAINT hfj_res_reindex_job_pkey PRIMARY KEY (pid);


--
-- TOC entry 4078 (class 2606 OID 19749)
-- Name: hfj_res_search_url hfj_res_search_url_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_search_url
    ADD CONSTRAINT hfj_res_search_url_pkey PRIMARY KEY (res_search_url, partition_id);


--
-- TOC entry 4082 (class 2606 OID 19756)
-- Name: hfj_res_system hfj_res_system_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_system
    ADD CONSTRAINT hfj_res_system_pkey PRIMARY KEY (pid);


--
-- TOC entry 4086 (class 2606 OID 19761)
-- Name: hfj_res_tag hfj_res_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_tag
    ADD CONSTRAINT hfj_res_tag_pkey PRIMARY KEY (pid);


--
-- TOC entry 4092 (class 2606 OID 19768)
-- Name: hfj_res_ver hfj_res_ver_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_ver
    ADD CONSTRAINT hfj_res_ver_pkey PRIMARY KEY (pid);


--
-- TOC entry 4100 (class 2606 OID 19775)
-- Name: hfj_res_ver_prov hfj_res_ver_prov_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_ver_prov
    ADD CONSTRAINT hfj_res_ver_prov_pkey PRIMARY KEY (res_ver_pid);


--
-- TOC entry 4113 (class 2606 OID 19787)
-- Name: hfj_resource_modified hfj_resource_modified_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_resource_modified
    ADD CONSTRAINT hfj_resource_modified_pkey PRIMARY KEY (res_id, resource_type, res_ver);


--
-- TOC entry 4105 (class 2606 OID 19780)
-- Name: hfj_resource hfj_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_resource
    ADD CONSTRAINT hfj_resource_pkey PRIMARY KEY (res_id);


--
-- TOC entry 4115 (class 2606 OID 19792)
-- Name: hfj_resource_type hfj_resource_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_resource_type
    ADD CONSTRAINT hfj_resource_type_pkey PRIMARY KEY (res_type_id);


--
-- TOC entry 4119 (class 2606 OID 19797)
-- Name: hfj_revinfo hfj_revinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_revinfo
    ADD CONSTRAINT hfj_revinfo_pkey PRIMARY KEY (rev);


--
-- TOC entry 4128 (class 2606 OID 19809)
-- Name: hfj_search_include hfj_search_include_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_search_include
    ADD CONSTRAINT hfj_search_include_pkey PRIMARY KEY (pid);


--
-- TOC entry 4121 (class 2606 OID 19804)
-- Name: hfj_search hfj_search_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_search
    ADD CONSTRAINT hfj_search_pkey PRIMARY KEY (pid);


--
-- TOC entry 4130 (class 2606 OID 19814)
-- Name: hfj_search_result hfj_search_result_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_search_result
    ADD CONSTRAINT hfj_search_result_pkey PRIMARY KEY (pid);


--
-- TOC entry 4134 (class 2606 OID 19819)
-- Name: hfj_spidx_coords hfj_spidx_coords_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_coords
    ADD CONSTRAINT hfj_spidx_coords_pkey PRIMARY KEY (sp_id);


--
-- TOC entry 4139 (class 2606 OID 19824)
-- Name: hfj_spidx_date hfj_spidx_date_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_date
    ADD CONSTRAINT hfj_spidx_date_pkey PRIMARY KEY (sp_id);


--
-- TOC entry 4146 (class 2606 OID 19829)
-- Name: hfj_spidx_identity hfj_spidx_identity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_identity
    ADD CONSTRAINT hfj_spidx_identity_pkey PRIMARY KEY (sp_identity_id);


--
-- TOC entry 4150 (class 2606 OID 19834)
-- Name: hfj_spidx_number hfj_spidx_number_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_number
    ADD CONSTRAINT hfj_spidx_number_pkey PRIMARY KEY (sp_id);


--
-- TOC entry 4160 (class 2606 OID 19848)
-- Name: hfj_spidx_quantity_nrml hfj_spidx_quantity_nrml_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_quantity_nrml
    ADD CONSTRAINT hfj_spidx_quantity_nrml_pkey PRIMARY KEY (sp_id);


--
-- TOC entry 4154 (class 2606 OID 19841)
-- Name: hfj_spidx_quantity hfj_spidx_quantity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_quantity
    ADD CONSTRAINT hfj_spidx_quantity_pkey PRIMARY KEY (sp_id);


--
-- TOC entry 4166 (class 2606 OID 19855)
-- Name: hfj_spidx_string hfj_spidx_string_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_string
    ADD CONSTRAINT hfj_spidx_string_pkey PRIMARY KEY (sp_id);


--
-- TOC entry 4172 (class 2606 OID 19862)
-- Name: hfj_spidx_token hfj_spidx_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_token
    ADD CONSTRAINT hfj_spidx_token_pkey PRIMARY KEY (sp_id);


--
-- TOC entry 4179 (class 2606 OID 19869)
-- Name: hfj_spidx_uri hfj_spidx_uri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_uri
    ADD CONSTRAINT hfj_spidx_uri_pkey PRIMARY KEY (sp_id);


--
-- TOC entry 4184 (class 2606 OID 19874)
-- Name: hfj_subscription_stats hfj_subscription_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_subscription_stats
    ADD CONSTRAINT hfj_subscription_stats_pkey PRIMARY KEY (pid);


--
-- TOC entry 4188 (class 2606 OID 19881)
-- Name: hfj_tag_def hfj_tag_def_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_tag_def
    ADD CONSTRAINT hfj_tag_def_pkey PRIMARY KEY (tag_id);


--
-- TOC entry 4001 (class 2606 OID 19484)
-- Name: historial_cambios_cita historial_cambios_cita_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_cambios_cita
    ADD CONSTRAINT historial_cambios_cita_pkey PRIMARY KEY (id_historial);


--
-- TOC entry 4035 (class 2606 OID 20005)
-- Name: hfj_blk_export_job idx_blkex_job_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_blk_export_job
    ADD CONSTRAINT idx_blkex_job_id UNIQUE (job_id);


--
-- TOC entry 4039 (class 2606 OID 20007)
-- Name: hfj_blk_import_job idx_blkim_job_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_blk_import_job
    ADD CONSTRAINT idx_blkim_job_id UNIQUE (job_id);


--
-- TOC entry 4225 (class 2606 OID 20115)
-- Name: trm_codesystem_ver idx_codesystem_and_ver; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_codesystem_ver
    ADD CONSTRAINT idx_codesystem_and_ver UNIQUE (codesystem_pid, cs_version_id);


--
-- TOC entry 4229 (class 2606 OID 20119)
-- Name: trm_concept idx_concept_cs_code; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept
    ADD CONSTRAINT idx_concept_cs_code UNIQUE (codesystem_pid, codeval);


--
-- TOC entry 4240 (class 2606 OID 20124)
-- Name: trm_concept_map idx_concept_map_url; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_map
    ADD CONSTRAINT idx_concept_map_url UNIQUE (url, ver);


--
-- TOC entry 4219 (class 2606 OID 20111)
-- Name: trm_codesystem idx_cs_codesystem; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_codesystem
    ADD CONSTRAINT idx_cs_codesystem UNIQUE (code_system_uri);


--
-- TOC entry 4194 (class 2606 OID 20098)
-- Name: mpi_link idx_empi_person_tgt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT idx_empi_person_tgt UNIQUE (person_pid, target_pid);


--
-- TOC entry 4148 (class 2606 OID 20066)
-- Name: hfj_spidx_identity idx_hash_identity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_identity
    ADD CONSTRAINT idx_hash_identity UNIQUE (hash_identity);


--
-- TOC entry 4059 (class 2606 OID 20017)
-- Name: hfj_idx_cmp_string_uniq idx_idxcmpstruniq_string; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_idx_cmp_string_uniq
    ADD CONSTRAINT idx_idxcmpstruniq_string UNIQUE (idx_string);


--
-- TOC entry 4202 (class 2606 OID 20100)
-- Name: npm_package idx_pack_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npm_package
    ADD CONSTRAINT idx_pack_id UNIQUE (package_id);


--
-- TOC entry 4208 (class 2606 OID 20104)
-- Name: npm_package_ver idx_packver; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npm_package_ver
    ADD CONSTRAINT idx_packver UNIQUE (package_id, version_id);


--
-- TOC entry 4063 (class 2606 OID 20019)
-- Name: hfj_partition idx_part_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_partition
    ADD CONSTRAINT idx_part_name UNIQUE (part_name);


--
-- TOC entry 4111 (class 2606 OID 20047)
-- Name: hfj_resource idx_res_type_fhir_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_resource
    ADD CONSTRAINT idx_res_type_fhir_id UNIQUE (res_type, fhir_id);


--
-- TOC entry 4117 (class 2606 OID 20049)
-- Name: hfj_resource_type idx_res_type_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_resource_type
    ADD CONSTRAINT idx_res_type_name UNIQUE (res_type);


--
-- TOC entry 4049 (class 2606 OID 20011)
-- Name: hfj_history_tag idx_reshisttag_tagid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_history_tag
    ADD CONSTRAINT idx_reshisttag_tagid UNIQUE (res_ver_pid, tag_id);


--
-- TOC entry 4084 (class 2606 OID 20028)
-- Name: hfj_res_system idx_resident_sys; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_system
    ADD CONSTRAINT idx_resident_sys UNIQUE (system_url);


--
-- TOC entry 4090 (class 2606 OID 20032)
-- Name: hfj_res_tag idx_restag_tagid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_tag
    ADD CONSTRAINT idx_restag_tagid UNIQUE (res_id, tag_id);


--
-- TOC entry 4097 (class 2606 OID 20038)
-- Name: hfj_res_ver idx_resver_id_ver; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_ver
    ADD CONSTRAINT idx_resver_id_ver UNIQUE (res_id, res_ver);


--
-- TOC entry 4125 (class 2606 OID 20053)
-- Name: hfj_search idx_search_uuid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_search
    ADD CONSTRAINT idx_search_uuid UNIQUE (search_uuid);


--
-- TOC entry 4132 (class 2606 OID 20056)
-- Name: hfj_search_result idx_searchres_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_search_result
    ADD CONSTRAINT idx_searchres_order UNIQUE (search_pid, search_order);


--
-- TOC entry 4186 (class 2606 OID 20090)
-- Name: hfj_subscription_stats idx_subsc_resid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_subscription_stats
    ADD CONSTRAINT idx_subsc_resid UNIQUE (res_id);


--
-- TOC entry 4265 (class 2606 OID 20137)
-- Name: trm_valueset idx_valueset_url; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_valueset
    ADD CONSTRAINT idx_valueset_url UNIQUE (url, ver);


--
-- TOC entry 4273 (class 2606 OID 20141)
-- Name: trm_valueset_concept idx_vs_concept_cscd; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_valueset_concept
    ADD CONSTRAINT idx_vs_concept_cscd UNIQUE (valueset_pid, system_url, codeval);


--
-- TOC entry 4275 (class 2606 OID 20143)
-- Name: trm_valueset_concept idx_vs_concept_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_valueset_concept
    ADD CONSTRAINT idx_vs_concept_order UNIQUE (valueset_pid, valueset_order);


--
-- TOC entry 3906 (class 2606 OID 18993)
-- Name: ips ips_nit_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ips
    ADD CONSTRAINT ips_nit_key UNIQUE (nit);


--
-- TOC entry 3908 (class 2606 OID 18991)
-- Name: ips ips_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ips
    ADD CONSTRAINT ips_pkey PRIMARY KEY (id_ips);


--
-- TOC entry 4005 (class 2606 OID 19507)
-- Name: lista_espera lista_espera_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lista_espera
    ADD CONSTRAINT lista_espera_pkey PRIMARY KEY (id_lista_espera);


--
-- TOC entry 3893 (class 2606 OID 18956)
-- Name: modalidades_atencion modalidades_atencion_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modalidades_atencion
    ADD CONSTRAINT modalidades_atencion_codigo_key UNIQUE (codigo);


--
-- TOC entry 3895 (class 2606 OID 18954)
-- Name: modalidades_atencion modalidades_atencion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modalidades_atencion
    ADD CONSTRAINT modalidades_atencion_pkey PRIMARY KEY (id_modalidad);


--
-- TOC entry 3869 (class 2606 OID 18896)
-- Name: motivos_cancelacion motivos_cancelacion_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motivos_cancelacion
    ADD CONSTRAINT motivos_cancelacion_codigo_key UNIQUE (codigo);


--
-- TOC entry 3871 (class 2606 OID 18894)
-- Name: motivos_cancelacion motivos_cancelacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motivos_cancelacion
    ADD CONSTRAINT motivos_cancelacion_pkey PRIMARY KEY (id_motivo_cancelacion);


--
-- TOC entry 4200 (class 2606 OID 19891)
-- Name: mpi_link_aud mpi_link_aud_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mpi_link_aud
    ADD CONSTRAINT mpi_link_aud_pkey PRIMARY KEY (rev, pid);


--
-- TOC entry 4198 (class 2606 OID 19886)
-- Name: mpi_link mpi_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT mpi_link_pkey PRIMARY KEY (pid);


--
-- TOC entry 3901 (class 2606 OID 18972)
-- Name: municipios municipios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipios
    ADD CONSTRAINT municipios_pkey PRIMARY KEY (id_municipio);


--
-- TOC entry 4009 (class 2606 OID 19553)
-- Name: notificaciones notificaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT notificaciones_pkey PRIMARY KEY (id_notificacion);


--
-- TOC entry 4204 (class 2606 OID 19898)
-- Name: npm_package npm_package_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npm_package
    ADD CONSTRAINT npm_package_pkey PRIMARY KEY (pid);


--
-- TOC entry 4210 (class 2606 OID 19905)
-- Name: npm_package_ver npm_package_ver_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npm_package_ver
    ADD CONSTRAINT npm_package_ver_pkey PRIMARY KEY (pid);


--
-- TOC entry 4215 (class 2606 OID 19912)
-- Name: npm_package_ver_res npm_package_ver_res_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npm_package_ver_res
    ADD CONSTRAINT npm_package_ver_res_pkey PRIMARY KEY (pid);


--
-- TOC entry 3963 (class 2606 OID 19219)
-- Name: pacientes pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_pkey PRIMARY KEY (id_paciente);


--
-- TOC entry 3929 (class 2606 OID 19076)
-- Name: permisos permisos_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permisos_codigo_key UNIQUE (codigo);


--
-- TOC entry 3931 (class 2606 OID 19074)
-- Name: permisos permisos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permisos_pkey PRIMARY KEY (id_permiso);


--
-- TOC entry 3953 (class 2606 OID 19162)
-- Name: profesionales profesionales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesionales
    ADD CONSTRAINT profesionales_pkey PRIMARY KEY (id_profesional);


--
-- TOC entry 3955 (class 2606 OID 19164)
-- Name: profesionales profesionales_tarjeta_profesional_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesionales
    ADD CONSTRAINT profesionales_tarjeta_profesional_key UNIQUE (tarjeta_profesional);


--
-- TOC entry 3973 (class 2606 OID 19270)
-- Name: reglas_duracion_cita reglas_duracion_cita_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reglas_duracion_cita
    ADD CONSTRAINT reglas_duracion_cita_pkey PRIMARY KEY (id_regla);


--
-- TOC entry 3999 (class 2606 OID 19469)
-- Name: respuestas_cita respuestas_cita_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas_cita
    ADD CONSTRAINT respuestas_cita_pkey PRIMARY KEY (id_respuesta);


--
-- TOC entry 3933 (class 2606 OID 19083)
-- Name: rol_permiso rol_permiso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol_permiso
    ADD CONSTRAINT rol_permiso_pkey PRIMARY KEY (id_rol_permiso);


--
-- TOC entry 3857 (class 2606 OID 18864)
-- Name: roles roles_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_codigo_key UNIQUE (codigo);


--
-- TOC entry 3859 (class 2606 OID 18862)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_rol);


--
-- TOC entry 3958 (class 2606 OID 19185)
-- Name: roles_profesional roles_profesional_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_profesional
    ADD CONSTRAINT roles_profesional_pkey PRIMARY KEY (id_rol_profesional);


--
-- TOC entry 3916 (class 2606 OID 19022)
-- Name: sedes sedes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sedes
    ADD CONSTRAINT sedes_pkey PRIMARY KEY (id_sede);


--
-- TOC entry 3947 (class 2606 OID 19134)
-- Name: servicios_salud servicios_salud_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios_salud
    ADD CONSTRAINT servicios_salud_pkey PRIMARY KEY (id_servicio);


--
-- TOC entry 3937 (class 2606 OID 19106)
-- Name: sesiones_usuario sesiones_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sesiones_usuario
    ADD CONSTRAINT sesiones_usuario_pkey PRIMARY KEY (id_sesion);


--
-- TOC entry 3853 (class 2606 OID 18852)
-- Name: sexos_biologicos sexos_biologicos_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sexos_biologicos
    ADD CONSTRAINT sexos_biologicos_codigo_key UNIQUE (codigo);


--
-- TOC entry 3855 (class 2606 OID 18850)
-- Name: sexos_biologicos sexos_biologicos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sexos_biologicos
    ADD CONSTRAINT sexos_biologicos_pkey PRIMARY KEY (id_sexo_biologico);


--
-- TOC entry 3889 (class 2606 OID 18946)
-- Name: tipos_consulta tipos_consulta_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_consulta
    ADD CONSTRAINT tipos_consulta_codigo_key UNIQUE (codigo);


--
-- TOC entry 3891 (class 2606 OID 18944)
-- Name: tipos_consulta tipos_consulta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_consulta
    ADD CONSTRAINT tipos_consulta_pkey PRIMARY KEY (id_tipo_consulta);


--
-- TOC entry 3845 (class 2606 OID 18832)
-- Name: tipos_documento tipos_documento_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_documento
    ADD CONSTRAINT tipos_documento_codigo_key UNIQUE (codigo);


--
-- TOC entry 3847 (class 2606 OID 18830)
-- Name: tipos_documento tipos_documento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_documento
    ADD CONSTRAINT tipos_documento_pkey PRIMARY KEY (id_tipo_documento);


--
-- TOC entry 4221 (class 2606 OID 19917)
-- Name: trm_codesystem trm_codesystem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_codesystem
    ADD CONSTRAINT trm_codesystem_pkey PRIMARY KEY (pid);


--
-- TOC entry 4227 (class 2606 OID 19922)
-- Name: trm_codesystem_ver trm_codesystem_ver_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_codesystem_ver
    ADD CONSTRAINT trm_codesystem_ver_pkey PRIMARY KEY (pid);


--
-- TOC entry 4237 (class 2606 OID 19936)
-- Name: trm_concept_desig trm_concept_desig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_desig
    ADD CONSTRAINT trm_concept_desig_pkey PRIMARY KEY (pid);


--
-- TOC entry 4245 (class 2606 OID 19950)
-- Name: trm_concept_map_group trm_concept_map_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_map_group
    ADD CONSTRAINT trm_concept_map_group_pkey PRIMARY KEY (pid);


--
-- TOC entry 4249 (class 2606 OID 19957)
-- Name: trm_concept_map_grp_element trm_concept_map_grp_element_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_map_grp_element
    ADD CONSTRAINT trm_concept_map_grp_element_pkey PRIMARY KEY (pid);


--
-- TOC entry 4253 (class 2606 OID 19964)
-- Name: trm_concept_map_grp_elm_tgt trm_concept_map_grp_elm_tgt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_map_grp_elm_tgt
    ADD CONSTRAINT trm_concept_map_grp_elm_tgt_pkey PRIMARY KEY (pid);


--
-- TOC entry 4242 (class 2606 OID 19943)
-- Name: trm_concept_map trm_concept_map_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_map
    ADD CONSTRAINT trm_concept_map_pkey PRIMARY KEY (pid);


--
-- TOC entry 4258 (class 2606 OID 19969)
-- Name: trm_concept_pc_link trm_concept_pc_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_pc_link
    ADD CONSTRAINT trm_concept_pc_link_pkey PRIMARY KEY (pid);


--
-- TOC entry 4233 (class 2606 OID 19929)
-- Name: trm_concept trm_concept_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept
    ADD CONSTRAINT trm_concept_pkey PRIMARY KEY (pid);


--
-- TOC entry 4262 (class 2606 OID 19976)
-- Name: trm_concept_property trm_concept_property_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_property
    ADD CONSTRAINT trm_concept_property_pkey PRIMARY KEY (pid);


--
-- TOC entry 4271 (class 2606 OID 19992)
-- Name: trm_valueset_c_designation trm_valueset_c_designation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_valueset_c_designation
    ADD CONSTRAINT trm_valueset_c_designation_pkey PRIMARY KEY (pid);


--
-- TOC entry 4277 (class 2606 OID 19999)
-- Name: trm_valueset_concept trm_valueset_concept_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_valueset_concept
    ADD CONSTRAINT trm_valueset_concept_pkey PRIMARY KEY (pid);


--
-- TOC entry 4267 (class 2606 OID 19985)
-- Name: trm_valueset trm_valueset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_valueset
    ADD CONSTRAINT trm_valueset_pkey PRIMARY KEY (pid);


--
-- TOC entry 3903 (class 2606 OID 18974)
-- Name: municipios uq_municipio_departamento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipios
    ADD CONSTRAINT uq_municipio_departamento UNIQUE (id_departamento, nombre);


--
-- TOC entry 3965 (class 2606 OID 19221)
-- Name: pacientes uq_paciente_documento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT uq_paciente_documento UNIQUE (id_tipo_documento, numero_documento);


--
-- TOC entry 3960 (class 2606 OID 19187)
-- Name: roles_profesional uq_profesional_servicio_sede; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_profesional
    ADD CONSTRAINT uq_profesional_servicio_sede UNIQUE (id_profesional, id_sede, id_servicio);


--
-- TOC entry 3975 (class 2606 OID 19272)
-- Name: reglas_duracion_cita uq_regla_duracion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reglas_duracion_cita
    ADD CONSTRAINT uq_regla_duracion UNIQUE (id_ips, id_aseguradora, id_tipo_consulta, id_modalidad, id_especialidad);


--
-- TOC entry 3935 (class 2606 OID 19085)
-- Name: rol_permiso uq_rol_permiso; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol_permiso
    ADD CONSTRAINT uq_rol_permiso UNIQUE (id_rol, id_permiso);


--
-- TOC entry 3918 (class 2606 OID 19024)
-- Name: sedes uq_sede_ips_identificador; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sedes
    ADD CONSTRAINT uq_sede_ips_identificador UNIQUE (id_ips, identificador);


--
-- TOC entry 3949 (class 2606 OID 19136)
-- Name: servicios_salud uq_servicio_sede; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios_salud
    ADD CONSTRAINT uq_servicio_sede UNIQUE (id_sede, nombre);


--
-- TOC entry 3923 (class 2606 OID 19047)
-- Name: usuarios usuarios_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);


--
-- TOC entry 3925 (class 2606 OID 19045)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 3927 (class 2606 OID 19049)
-- Name: usuarios usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 4222 (class 1259 OID 20113)
-- Name: fk_codesysver_cs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_codesysver_cs_id ON public.trm_codesystem_ver USING btree (codesystem_pid);


--
-- TOC entry 4223 (class 1259 OID 20112)
-- Name: fk_codesysver_res_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_codesysver_res_id ON public.trm_codesystem_ver USING btree (res_id);


--
-- TOC entry 4234 (class 1259 OID 20120)
-- Name: fk_conceptdesig_concept; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_conceptdesig_concept ON public.trm_concept_desig USING btree (concept_pid);


--
-- TOC entry 4235 (class 1259 OID 20121)
-- Name: fk_conceptdesig_csv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_conceptdesig_csv ON public.trm_concept_desig USING btree (cs_ver_pid);


--
-- TOC entry 4259 (class 1259 OID 20133)
-- Name: fk_conceptprop_concept; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_conceptprop_concept ON public.trm_concept_property USING btree (concept_pid);


--
-- TOC entry 4260 (class 1259 OID 20134)
-- Name: fk_conceptprop_csv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_conceptprop_csv ON public.trm_concept_property USING btree (cs_ver_pid);


--
-- TOC entry 4190 (class 1259 OID 20094)
-- Name: fk_empi_link_target; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_empi_link_target ON public.mpi_link USING btree (target_pid);


--
-- TOC entry 4211 (class 1259 OID 20106)
-- Name: fk_npm_packverres_packver; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_npm_packverres_packver ON public.npm_package_ver_res USING btree (packver_pid);


--
-- TOC entry 4205 (class 1259 OID 20101)
-- Name: fk_npm_pkv_pkg; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_npm_pkv_pkg ON public.npm_package_ver USING btree (package_pid);


--
-- TOC entry 4206 (class 1259 OID 20102)
-- Name: fk_npm_pkv_resid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_npm_pkv_resid ON public.npm_package_ver USING btree (binary_res_id);


--
-- TOC entry 4212 (class 1259 OID 20107)
-- Name: fk_npm_pkvr_resid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_npm_pkvr_resid ON public.npm_package_ver_res USING btree (binary_res_id);


--
-- TOC entry 4126 (class 1259 OID 20054)
-- Name: fk_searchinc_search; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_searchinc_search ON public.hfj_search_include USING btree (search_pid);


--
-- TOC entry 4246 (class 1259 OID 20127)
-- Name: fk_tcmgelement_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_tcmgelement_group ON public.trm_concept_map_grp_element USING btree (concept_map_group_pid);


--
-- TOC entry 4250 (class 1259 OID 20129)
-- Name: fk_tcmgetarget_element; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_tcmgetarget_element ON public.trm_concept_map_grp_elm_tgt USING btree (concept_map_grp_elm_pid);


--
-- TOC entry 4243 (class 1259 OID 20125)
-- Name: fk_tcmgroup_conceptmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_tcmgroup_conceptmap ON public.trm_concept_map_group USING btree (concept_map_pid);


--
-- TOC entry 4254 (class 1259 OID 20130)
-- Name: fk_term_conceptpc_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_term_conceptpc_child ON public.trm_concept_pc_link USING btree (child_pid);


--
-- TOC entry 4255 (class 1259 OID 20132)
-- Name: fk_term_conceptpc_cs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_term_conceptpc_cs ON public.trm_concept_pc_link USING btree (codesystem_pid);


--
-- TOC entry 4256 (class 1259 OID 20131)
-- Name: fk_term_conceptpc_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_term_conceptpc_parent ON public.trm_concept_pc_link USING btree (parent_pid);


--
-- TOC entry 4268 (class 1259 OID 20138)
-- Name: fk_trm_valueset_concept_pid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_trm_valueset_concept_pid ON public.trm_valueset_c_designation USING btree (valueset_concept_pid);


--
-- TOC entry 4269 (class 1259 OID 20139)
-- Name: fk_trm_vscd_vs_pid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_trm_vscd_vs_pid ON public.trm_valueset_c_designation USING btree (valueset_pid);


--
-- TOC entry 4216 (class 1259 OID 20109)
-- Name: fk_trmcodesystem_curver; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_trmcodesystem_curver ON public.trm_codesystem USING btree (current_version_pid);


--
-- TOC entry 4217 (class 1259 OID 20108)
-- Name: fk_trmcodesystem_res; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_trmcodesystem_res ON public.trm_codesystem USING btree (res_id);


--
-- TOC entry 4238 (class 1259 OID 20122)
-- Name: fk_trmconceptmap_res; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_trmconceptmap_res ON public.trm_concept_map USING btree (res_id);


--
-- TOC entry 4263 (class 1259 OID 20135)
-- Name: fk_trmvalueset_res; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_trmvalueset_res ON public.trm_valueset USING btree (res_id);


--
-- TOC entry 3978 (class 1259 OID 19616)
-- Name: idx_agendas_fechas; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_agendas_fechas ON public.agendas USING btree (fecha_inicio, fecha_fin);


--
-- TOC entry 3979 (class 1259 OID 19614)
-- Name: idx_agendas_ips_sede_servicio; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_agendas_ips_sede_servicio ON public.agendas USING btree (id_ips, id_sede, id_servicio);


--
-- TOC entry 3980 (class 1259 OID 19615)
-- Name: idx_agendas_profesional; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_agendas_profesional ON public.agendas USING btree (id_profesional);


--
-- TOC entry 4012 (class 1259 OID 19631)
-- Name: idx_auditoria_tabla; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auditoria_tabla ON public.auditoria USING btree (tabla_afectada, id_registro_afectado);


--
-- TOC entry 4013 (class 1259 OID 19630)
-- Name: idx_auditoria_usuario_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auditoria_usuario_fecha ON public.auditoria USING btree (id_usuario, fecha);


--
-- TOC entry 4033 (class 1259 OID 20003)
-- Name: idx_blkex_exptime; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_blkex_exptime ON public.hfj_blk_export_job USING btree (exp_time);


--
-- TOC entry 4042 (class 1259 OID 20008)
-- Name: idx_blkim_jobfile_jobid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_blkim_jobfile_jobid ON public.hfj_blk_import_jobfile USING btree (job_pid);


--
-- TOC entry 4020 (class 1259 OID 20000)
-- Name: idx_bt2ji_ct; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bt2ji_ct ON public.bt2_job_instance USING btree (create_time);


--
-- TOC entry 4023 (class 1259 OID 20001)
-- Name: idx_bt2wc_ii_seq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bt2wc_ii_seq ON public.bt2_work_chunk USING btree (instance_id, seq);


--
-- TOC entry 4024 (class 1259 OID 20002)
-- Name: idx_bt2wc_ii_si_s_seq_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bt2wc_ii_si_s_seq_id ON public.bt2_work_chunk USING btree (instance_id, tgt_step_id, stat, seq, id);


--
-- TOC entry 3992 (class 1259 OID 19625)
-- Name: idx_citas_canal; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_citas_canal ON public.citas USING btree (id_canal);


--
-- TOC entry 3993 (class 1259 OID 19624)
-- Name: idx_citas_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_citas_estado ON public.citas USING btree (id_estado_cita);


--
-- TOC entry 3994 (class 1259 OID 19620)
-- Name: idx_citas_ips; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_citas_ips ON public.citas USING btree (id_ips);


--
-- TOC entry 3995 (class 1259 OID 19621)
-- Name: idx_citas_paciente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_citas_paciente ON public.citas USING btree (id_paciente);


--
-- TOC entry 3996 (class 1259 OID 19622)
-- Name: idx_citas_profesional_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_citas_profesional_fecha ON public.citas USING btree (id_profesional, fecha_inicio);


--
-- TOC entry 3997 (class 1259 OID 19623)
-- Name: idx_citas_sede_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_citas_sede_fecha ON public.citas USING btree (id_sede, fecha_inicio);


--
-- TOC entry 4247 (class 1259 OID 20126)
-- Name: idx_cncpt_map_grp_cd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cncpt_map_grp_cd ON public.trm_concept_map_grp_element USING btree (source_code);


--
-- TOC entry 4251 (class 1259 OID 20128)
-- Name: idx_cncpt_mp_grp_elm_tgt_cd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cncpt_mp_grp_elm_tgt_cd ON public.trm_concept_map_grp_elm_tgt USING btree (target_code);


--
-- TOC entry 3968 (class 1259 OID 19611)
-- Name: idx_coberturas_aseguradora; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_coberturas_aseguradora ON public.coberturas_paciente USING btree (id_aseguradora);


--
-- TOC entry 3969 (class 1259 OID 19612)
-- Name: idx_coberturas_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_coberturas_estado ON public.coberturas_paciente USING btree (id_estado_cobertura);


--
-- TOC entry 3970 (class 1259 OID 19610)
-- Name: idx_coberturas_paciente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_coberturas_paciente ON public.coberturas_paciente USING btree (id_paciente);


--
-- TOC entry 4230 (class 1259 OID 20116)
-- Name: idx_concept_indexstatus; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_concept_indexstatus ON public.trm_concept USING btree (index_status);


--
-- TOC entry 4231 (class 1259 OID 20117)
-- Name: idx_concept_updated; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_concept_updated ON public.trm_concept USING btree (concept_updated);


--
-- TOC entry 3983 (class 1259 OID 19617)
-- Name: idx_cupos_agenda; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cupos_agenda ON public.cupos USING btree (id_agenda);


--
-- TOC entry 3984 (class 1259 OID 19619)
-- Name: idx_cupos_bloqueo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cupos_bloqueo ON public.cupos USING btree (bloqueado_hasta);


--
-- TOC entry 3985 (class 1259 OID 19618)
-- Name: idx_cupos_estado_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cupos_estado_fecha ON public.cupos USING btree (id_estado_cupo, fecha_inicio);


--
-- TOC entry 4191 (class 1259 OID 20093)
-- Name: idx_empi_gr_tgt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_empi_gr_tgt ON public.mpi_link USING btree (golden_resource_pid, target_pid);


--
-- TOC entry 4192 (class 1259 OID 20092)
-- Name: idx_empi_match_tgt_ver; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_empi_match_tgt_ver ON public.mpi_link USING btree (match_result, target_pid, version);


--
-- TOC entry 4195 (class 1259 OID 20095)
-- Name: idx_empi_tgt_mr_ls; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_empi_tgt_mr_ls ON public.mpi_link USING btree (target_type, match_result, link_source);


--
-- TOC entry 4196 (class 1259 OID 20096)
-- Name: idx_empi_tgt_mr_score; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_empi_tgt_mr_score ON public.mpi_link USING btree (target_type, match_result, score);


--
-- TOC entry 4016 (class 1259 OID 19632)
-- Name: idx_fhir_estado_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fhir_estado_fecha ON public.cola_sincronizacion_fhir USING btree (id_estado_sincronizacion, fecha_creacion);


--
-- TOC entry 4017 (class 1259 OID 19633)
-- Name: idx_fhir_recurso_referencia; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fhir_recurso_referencia ON public.cola_sincronizacion_fhir USING btree (tipo_recurso, nombre_tabla_origen, id_referencia);


--
-- TOC entry 4052 (class 1259 OID 20013)
-- Name: idx_idxcmbtoknu_hashc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idxcmbtoknu_hashc ON public.hfj_idx_cmb_tok_nu USING btree (hash_complete, res_id, partition_id);


--
-- TOC entry 4053 (class 1259 OID 20014)
-- Name: idx_idxcmbtoknu_res; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idxcmbtoknu_res ON public.hfj_idx_cmb_tok_nu USING btree (res_id);


--
-- TOC entry 4054 (class 1259 OID 20012)
-- Name: idx_idxcmbtoknu_str; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idxcmbtoknu_str ON public.hfj_idx_cmb_tok_nu USING btree (idx_string);


--
-- TOC entry 4057 (class 1259 OID 20015)
-- Name: idx_idxcmpstruniq_resource; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idxcmpstruniq_resource ON public.hfj_idx_cmp_string_uniq USING btree (res_id);


--
-- TOC entry 3904 (class 1259 OID 19598)
-- Name: idx_ips_nit; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ips_nit ON public.ips USING btree (nit);


--
-- TOC entry 4002 (class 1259 OID 19626)
-- Name: idx_lista_espera_ips_servicio; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lista_espera_ips_servicio ON public.lista_espera USING btree (id_ips, id_servicio);


--
-- TOC entry 4003 (class 1259 OID 19627)
-- Name: idx_lista_espera_paciente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lista_espera_paciente ON public.lista_espera USING btree (id_paciente);


--
-- TOC entry 4006 (class 1259 OID 19628)
-- Name: idx_notificaciones_cita; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notificaciones_cita ON public.notificaciones USING btree (id_cita);


--
-- TOC entry 4007 (class 1259 OID 19629)
-- Name: idx_notificaciones_enviada; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notificaciones_enviada ON public.notificaciones USING btree (enviada);


--
-- TOC entry 3961 (class 1259 OID 19609)
-- Name: idx_pacientes_documento; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pacientes_documento ON public.pacientes USING btree (id_tipo_documento, numero_documento);


--
-- TOC entry 4213 (class 1259 OID 20105)
-- Name: idx_packverres_url; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_packverres_url ON public.npm_package_ver_res USING btree (canonical_url);


--
-- TOC entry 3950 (class 1259 OID 19607)
-- Name: idx_profesionales_documento; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profesionales_documento ON public.profesionales USING btree (id_tipo_documento, numero_documento);


--
-- TOC entry 3951 (class 1259 OID 19606)
-- Name: idx_profesionales_especialidad; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profesionales_especialidad ON public.profesionales USING btree (id_especialidad);


--
-- TOC entry 3971 (class 1259 OID 19613)
-- Name: idx_reglas_duracion_busqueda; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reglas_duracion_busqueda ON public.reglas_duracion_cita USING btree (id_ips, id_aseguradora, id_tipo_consulta, id_modalidad, id_especialidad);


--
-- TOC entry 4106 (class 1259 OID 20042)
-- Name: idx_res_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_date ON public.hfj_resource USING btree (res_updated);


--
-- TOC entry 4107 (class 1259 OID 20043)
-- Name: idx_res_fhir_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_fhir_id ON public.hfj_resource USING btree (fhir_id);


--
-- TOC entry 4108 (class 1259 OID 20045)
-- Name: idx_res_resid_updated; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_resid_updated ON public.hfj_resource USING btree (res_id, res_updated, partition_id);


--
-- TOC entry 4087 (class 1259 OID 20029)
-- Name: idx_res_tag_res_tag; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_tag_res_tag ON public.hfj_res_tag USING btree (res_id, tag_id, partition_id);


--
-- TOC entry 4088 (class 1259 OID 20030)
-- Name: idx_res_tag_tag_res; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_tag_tag_res ON public.hfj_res_tag USING btree (tag_id, res_id, partition_id);


--
-- TOC entry 4109 (class 1259 OID 20044)
-- Name: idx_res_type_del_updated; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_type_del_updated ON public.hfj_resource USING btree (res_type, res_deleted_at, res_updated, partition_id, res_id);


--
-- TOC entry 4047 (class 1259 OID 20009)
-- Name: idx_reshisttag_resid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reshisttag_resid ON public.hfj_history_tag USING btree (res_id);


--
-- TOC entry 4073 (class 1259 OID 20024)
-- Name: idx_resparmpresent_hashpres; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_resparmpresent_hashpres ON public.hfj_res_param_present USING btree (hash_presence);


--
-- TOC entry 4074 (class 1259 OID 20023)
-- Name: idx_resparmpresent_resid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_resparmpresent_resid ON public.hfj_res_param_present USING btree (res_id);


--
-- TOC entry 4079 (class 1259 OID 20025)
-- Name: idx_ressearchurl_res; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ressearchurl_res ON public.hfj_res_search_url USING btree (res_id);


--
-- TOC entry 4080 (class 1259 OID 20026)
-- Name: idx_ressearchurl_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ressearchurl_time ON public.hfj_res_search_url USING btree (created_time);


--
-- TOC entry 4093 (class 1259 OID 20035)
-- Name: idx_resver_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_resver_date ON public.hfj_res_ver USING btree (res_updated, res_id);


--
-- TOC entry 4094 (class 1259 OID 20034)
-- Name: idx_resver_id_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_resver_id_date ON public.hfj_res_ver USING btree (res_id, res_updated);


--
-- TOC entry 4095 (class 1259 OID 20036)
-- Name: idx_resver_id_src_uri; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_resver_id_src_uri ON public.hfj_res_ver USING btree (source_uri, res_id, partition_id);


--
-- TOC entry 4098 (class 1259 OID 20033)
-- Name: idx_resver_type_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_resver_type_date ON public.hfj_res_ver USING btree (res_type, res_updated, res_id);


--
-- TOC entry 4101 (class 1259 OID 20040)
-- Name: idx_resverprov_requestid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_resverprov_requestid ON public.hfj_res_ver_prov USING btree (request_id);


--
-- TOC entry 4102 (class 1259 OID 20041)
-- Name: idx_resverprov_res_pid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_resverprov_res_pid ON public.hfj_res_ver_prov USING btree (res_pid);


--
-- TOC entry 4103 (class 1259 OID 20039)
-- Name: idx_resverprov_sourceuri; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_resverprov_sourceuri ON public.hfj_res_ver_prov USING btree (source_uri);


--
-- TOC entry 4068 (class 1259 OID 20020)
-- Name: idx_rl_src; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rl_src ON public.hfj_res_link USING btree (src_resource_id);


--
-- TOC entry 4069 (class 1259 OID 20022)
-- Name: idx_rl_srcpath_tgturl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rl_srcpath_tgturl ON public.hfj_res_link USING btree (src_path, target_resource_url, partition_id, src_resource_id);


--
-- TOC entry 4070 (class 1259 OID 20021)
-- Name: idx_rl_tgt_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rl_tgt_v2 ON public.hfj_res_link USING btree (target_resource_id, src_path, src_resource_id, target_resource_type, partition_id);


--
-- TOC entry 3956 (class 1259 OID 19608)
-- Name: idx_roles_profesional_busqueda; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_roles_profesional_busqueda ON public.roles_profesional USING btree (id_ips, id_sede, id_servicio, id_profesional);


--
-- TOC entry 4122 (class 1259 OID 20051)
-- Name: idx_search_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_search_created ON public.hfj_search USING btree (created);


--
-- TOC entry 4123 (class 1259 OID 20050)
-- Name: idx_search_restype_hashs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_search_restype_hashs ON public.hfj_search USING btree (resource_type, search_query_string_hash, created);


--
-- TOC entry 3913 (class 1259 OID 19600)
-- Name: idx_sedes_identificador; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sedes_identificador ON public.sedes USING btree (identificador);


--
-- TOC entry 3914 (class 1259 OID 19599)
-- Name: idx_sedes_ips; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sedes_ips ON public.sedes USING btree (id_ips);


--
-- TOC entry 3944 (class 1259 OID 19605)
-- Name: idx_servicios_especialidad; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_servicios_especialidad ON public.servicios_salud USING btree (id_especialidad);


--
-- TOC entry 3945 (class 1259 OID 19604)
-- Name: idx_servicios_ips_sede; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_servicios_ips_sede ON public.servicios_salud USING btree (id_ips, id_sede);


--
-- TOC entry 4135 (class 1259 OID 20057)
-- Name: idx_sp_coords_hash_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_coords_hash_v2 ON public.hfj_spidx_coords USING btree (hash_identity, sp_latitude, sp_longitude, res_id, partition_id);


--
-- TOC entry 4136 (class 1259 OID 20059)
-- Name: idx_sp_coords_resid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_coords_resid ON public.hfj_spidx_coords USING btree (res_id);


--
-- TOC entry 4137 (class 1259 OID 20058)
-- Name: idx_sp_coords_updated; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_coords_updated ON public.hfj_spidx_coords USING btree (sp_updated);


--
-- TOC entry 4140 (class 1259 OID 20061)
-- Name: idx_sp_date_hash_high_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_date_hash_high_v2 ON public.hfj_spidx_date USING btree (hash_identity, sp_value_high, res_id, partition_id);


--
-- TOC entry 4141 (class 1259 OID 20060)
-- Name: idx_sp_date_hash_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_date_hash_v2 ON public.hfj_spidx_date USING btree (hash_identity, sp_value_low, sp_value_high, res_id, partition_id);


--
-- TOC entry 4142 (class 1259 OID 20063)
-- Name: idx_sp_date_ord_hash_high_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_date_ord_hash_high_v2 ON public.hfj_spidx_date USING btree (hash_identity, sp_value_high_date_ordinal, res_id, partition_id);


--
-- TOC entry 4143 (class 1259 OID 20062)
-- Name: idx_sp_date_ord_hash_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_date_ord_hash_v2 ON public.hfj_spidx_date USING btree (hash_identity, sp_value_low_date_ordinal, sp_value_high_date_ordinal, res_id, partition_id);


--
-- TOC entry 4144 (class 1259 OID 20064)
-- Name: idx_sp_date_resid_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_date_resid_v2 ON public.hfj_spidx_date USING btree (res_id, hash_identity, sp_value_low, sp_value_high, sp_value_low_date_ordinal, sp_value_high_date_ordinal, partition_id);


--
-- TOC entry 4151 (class 1259 OID 20067)
-- Name: idx_sp_number_hash_val_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_number_hash_val_v2 ON public.hfj_spidx_number USING btree (hash_identity, sp_value, res_id, partition_id);


--
-- TOC entry 4152 (class 1259 OID 20068)
-- Name: idx_sp_number_resid_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_number_resid_v2 ON public.hfj_spidx_number USING btree (res_id, hash_identity, sp_value, partition_id);


--
-- TOC entry 4161 (class 1259 OID 20075)
-- Name: idx_sp_qnty_nrml_hash_sysun_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_qnty_nrml_hash_sysun_v2 ON public.hfj_spidx_quantity_nrml USING btree (hash_identity_sys_units, sp_value, res_id, partition_id);


--
-- TOC entry 4162 (class 1259 OID 20074)
-- Name: idx_sp_qnty_nrml_hash_un_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_qnty_nrml_hash_un_v2 ON public.hfj_spidx_quantity_nrml USING btree (hash_identity_and_units, sp_value, res_id, partition_id);


--
-- TOC entry 4163 (class 1259 OID 20073)
-- Name: idx_sp_qnty_nrml_hash_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_qnty_nrml_hash_v2 ON public.hfj_spidx_quantity_nrml USING btree (hash_identity, sp_value, res_id, partition_id);


--
-- TOC entry 4164 (class 1259 OID 20076)
-- Name: idx_sp_qnty_nrml_resid_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_qnty_nrml_resid_v2 ON public.hfj_spidx_quantity_nrml USING btree (res_id, hash_identity, hash_identity_sys_units, hash_identity_and_units, sp_value, partition_id);


--
-- TOC entry 4155 (class 1259 OID 20071)
-- Name: idx_sp_quantity_hash_sysun_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_quantity_hash_sysun_v2 ON public.hfj_spidx_quantity USING btree (hash_identity_sys_units, sp_value, res_id, partition_id);


--
-- TOC entry 4156 (class 1259 OID 20070)
-- Name: idx_sp_quantity_hash_un_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_quantity_hash_un_v2 ON public.hfj_spidx_quantity USING btree (hash_identity_and_units, sp_value, res_id, partition_id);


--
-- TOC entry 4157 (class 1259 OID 20069)
-- Name: idx_sp_quantity_hash_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_quantity_hash_v2 ON public.hfj_spidx_quantity USING btree (hash_identity, sp_value, res_id, partition_id);


--
-- TOC entry 4158 (class 1259 OID 20072)
-- Name: idx_sp_quantity_resid_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_quantity_resid_v2 ON public.hfj_spidx_quantity USING btree (res_id, hash_identity, hash_identity_sys_units, hash_identity_and_units, sp_value, partition_id);


--
-- TOC entry 4167 (class 1259 OID 20079)
-- Name: idx_sp_string_hash_exct_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_string_hash_exct_v2 ON public.hfj_spidx_string USING btree (hash_exact, res_id, partition_id);


--
-- TOC entry 4168 (class 1259 OID 20077)
-- Name: idx_sp_string_hash_ident_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_string_hash_ident_v2 ON public.hfj_spidx_string USING btree (hash_identity, res_id, partition_id);


--
-- TOC entry 4169 (class 1259 OID 20078)
-- Name: idx_sp_string_hash_nrm_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_string_hash_nrm_v2 ON public.hfj_spidx_string USING btree (hash_norm_prefix, sp_value_normalized, res_id, partition_id);


--
-- TOC entry 4170 (class 1259 OID 20080)
-- Name: idx_sp_string_resid_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_string_resid_v2 ON public.hfj_spidx_string USING btree (res_id, hash_norm_prefix, partition_id);


--
-- TOC entry 4173 (class 1259 OID 20082)
-- Name: idx_sp_token_hash_s_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_token_hash_s_v2 ON public.hfj_spidx_token USING btree (hash_sys, res_id, partition_id);


--
-- TOC entry 4174 (class 1259 OID 20083)
-- Name: idx_sp_token_hash_sv_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_token_hash_sv_v2 ON public.hfj_spidx_token USING btree (hash_sys_and_value, res_id, partition_id);


--
-- TOC entry 4175 (class 1259 OID 20081)
-- Name: idx_sp_token_hash_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_token_hash_v2 ON public.hfj_spidx_token USING btree (hash_identity, sp_system, sp_value, res_id, partition_id);


--
-- TOC entry 4176 (class 1259 OID 20084)
-- Name: idx_sp_token_hash_v_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_token_hash_v_v2 ON public.hfj_spidx_token USING btree (hash_value, res_id, partition_id);


--
-- TOC entry 4177 (class 1259 OID 20085)
-- Name: idx_sp_token_resid_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_token_resid_v2 ON public.hfj_spidx_token USING btree (res_id, hash_sys_and_value, hash_value, hash_sys, hash_identity, partition_id);


--
-- TOC entry 4180 (class 1259 OID 20088)
-- Name: idx_sp_uri_coords; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_uri_coords ON public.hfj_spidx_uri USING btree (res_id);


--
-- TOC entry 4181 (class 1259 OID 20087)
-- Name: idx_sp_uri_hash_identity_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_uri_hash_identity_v2 ON public.hfj_spidx_uri USING btree (hash_identity, sp_uri, res_id, partition_id);


--
-- TOC entry 4182 (class 1259 OID 20086)
-- Name: idx_sp_uri_hash_uri_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sp_uri_hash_uri_v2 ON public.hfj_spidx_uri USING btree (hash_uri, res_id, partition_id);


--
-- TOC entry 4189 (class 1259 OID 20091)
-- Name: idx_tag_def_tp_cd_sys; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tag_def_tp_cd_sys ON public.hfj_tag_def USING btree (tag_type, tag_code, tag_system, tag_id, tag_version, tag_user_selected);


--
-- TOC entry 3919 (class 1259 OID 19602)
-- Name: idx_usuarios_ips; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_ips ON public.usuarios USING btree (id_ips);


--
-- TOC entry 3920 (class 1259 OID 19601)
-- Name: idx_usuarios_rol; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_rol ON public.usuarios USING btree (id_rol);


--
-- TOC entry 3921 (class 1259 OID 19603)
-- Name: idx_usuarios_sede; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_sede ON public.usuarios USING btree (id_sede);


--
-- TOC entry 4308 (class 2606 OID 19330)
-- Name: agendas agendas_id_estado_agenda_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agendas
    ADD CONSTRAINT agendas_id_estado_agenda_fkey FOREIGN KEY (id_estado_agenda) REFERENCES public.estados_agenda(id_estado_agenda);


--
-- TOC entry 4309 (class 2606 OID 19310)
-- Name: agendas agendas_id_ips_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agendas
    ADD CONSTRAINT agendas_id_ips_fkey FOREIGN KEY (id_ips) REFERENCES public.ips(id_ips);


--
-- TOC entry 4310 (class 2606 OID 19325)
-- Name: agendas agendas_id_profesional_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agendas
    ADD CONSTRAINT agendas_id_profesional_fkey FOREIGN KEY (id_profesional) REFERENCES public.profesionales(id_profesional);


--
-- TOC entry 4311 (class 2606 OID 19315)
-- Name: agendas agendas_id_sede_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agendas
    ADD CONSTRAINT agendas_id_sede_fkey FOREIGN KEY (id_sede) REFERENCES public.sedes(id_sede);


--
-- TOC entry 4312 (class 2606 OID 19320)
-- Name: agendas agendas_id_servicio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agendas
    ADD CONSTRAINT agendas_id_servicio_fkey FOREIGN KEY (id_servicio) REFERENCES public.servicios_salud(id_servicio);


--
-- TOC entry 4343 (class 2606 OID 19574)
-- Name: auditoria auditoria_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria
    ADD CONSTRAINT auditoria_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4316 (class 2606 OID 19371)
-- Name: bloqueos_agenda bloqueos_agenda_id_agenda_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bloqueos_agenda
    ADD CONSTRAINT bloqueos_agenda_id_agenda_fkey FOREIGN KEY (id_agenda) REFERENCES public.agendas(id_agenda);


--
-- TOC entry 4317 (class 2606 OID 19376)
-- Name: bloqueos_agenda bloqueos_agenda_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bloqueos_agenda
    ADD CONSTRAINT bloqueos_agenda_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4318 (class 2606 OID 19409)
-- Name: citas citas_id_aseguradora_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_id_aseguradora_fkey FOREIGN KEY (id_aseguradora) REFERENCES public.aseguradoras(id_aseguradora);


--
-- TOC entry 4319 (class 2606 OID 19439)
-- Name: citas citas_id_canal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_id_canal_fkey FOREIGN KEY (id_canal) REFERENCES public.canales_atencion(id_canal);


--
-- TOC entry 4320 (class 2606 OID 19404)
-- Name: citas citas_id_cobertura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_id_cobertura_fkey FOREIGN KEY (id_cobertura) REFERENCES public.coberturas_paciente(id_cobertura);


--
-- TOC entry 4321 (class 2606 OID 19414)
-- Name: citas citas_id_cupo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_id_cupo_fkey FOREIGN KEY (id_cupo) REFERENCES public.cupos(id_cupo);


--
-- TOC entry 4322 (class 2606 OID 19434)
-- Name: citas citas_id_estado_cita_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_id_estado_cita_fkey FOREIGN KEY (id_estado_cita) REFERENCES public.estados_cita(id_estado_cita);


--
-- TOC entry 4323 (class 2606 OID 19394)
-- Name: citas citas_id_ips_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_id_ips_fkey FOREIGN KEY (id_ips) REFERENCES public.ips(id_ips);


--
-- TOC entry 4324 (class 2606 OID 19449)
-- Name: citas citas_id_modalidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_id_modalidad_fkey FOREIGN KEY (id_modalidad) REFERENCES public.modalidades_atencion(id_modalidad);


--
-- TOC entry 4325 (class 2606 OID 19454)
-- Name: citas citas_id_motivo_cancelacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_id_motivo_cancelacion_fkey FOREIGN KEY (id_motivo_cancelacion) REFERENCES public.motivos_cancelacion(id_motivo_cancelacion);


--
-- TOC entry 4326 (class 2606 OID 19399)
-- Name: citas citas_id_paciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_id_paciente_fkey FOREIGN KEY (id_paciente) REFERENCES public.pacientes(id_paciente);


--
-- TOC entry 4327 (class 2606 OID 19424)
-- Name: citas citas_id_profesional_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_id_profesional_fkey FOREIGN KEY (id_profesional) REFERENCES public.profesionales(id_profesional);


--
-- TOC entry 4328 (class 2606 OID 19429)
-- Name: citas citas_id_sede_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_id_sede_fkey FOREIGN KEY (id_sede) REFERENCES public.sedes(id_sede);


--
-- TOC entry 4329 (class 2606 OID 19419)
-- Name: citas citas_id_servicio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_id_servicio_fkey FOREIGN KEY (id_servicio) REFERENCES public.servicios_salud(id_servicio);


--
-- TOC entry 4330 (class 2606 OID 19444)
-- Name: citas citas_id_tipo_consulta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_id_tipo_consulta_fkey FOREIGN KEY (id_tipo_consulta) REFERENCES public.tipos_consulta(id_tipo_consulta);


--
-- TOC entry 4300 (class 2606 OID 19251)
-- Name: coberturas_paciente coberturas_paciente_id_aseguradora_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coberturas_paciente
    ADD CONSTRAINT coberturas_paciente_id_aseguradora_fkey FOREIGN KEY (id_aseguradora) REFERENCES public.aseguradoras(id_aseguradora);


--
-- TOC entry 4301 (class 2606 OID 19256)
-- Name: coberturas_paciente coberturas_paciente_id_estado_cobertura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coberturas_paciente
    ADD CONSTRAINT coberturas_paciente_id_estado_cobertura_fkey FOREIGN KEY (id_estado_cobertura) REFERENCES public.estados_cobertura(id_estado_cobertura);


--
-- TOC entry 4302 (class 2606 OID 19246)
-- Name: coberturas_paciente coberturas_paciente_id_paciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coberturas_paciente
    ADD CONSTRAINT coberturas_paciente_id_paciente_fkey FOREIGN KEY (id_paciente) REFERENCES public.pacientes(id_paciente);


--
-- TOC entry 4344 (class 2606 OID 19593)
-- Name: cola_sincronizacion_fhir cola_sincronizacion_fhir_id_estado_sincronizacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cola_sincronizacion_fhir
    ADD CONSTRAINT cola_sincronizacion_fhir_id_estado_sincronizacion_fkey FOREIGN KEY (id_estado_sincronizacion) REFERENCES public.estados_sincronizacion_fhir(id_estado_sincronizacion);


--
-- TOC entry 4313 (class 2606 OID 19344)
-- Name: cupos cupos_id_agenda_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupos
    ADD CONSTRAINT cupos_id_agenda_fkey FOREIGN KEY (id_agenda) REFERENCES public.agendas(id_agenda);


--
-- TOC entry 4314 (class 2606 OID 19349)
-- Name: cupos cupos_id_estado_cupo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupos
    ADD CONSTRAINT cupos_id_estado_cupo_fkey FOREIGN KEY (id_estado_cupo) REFERENCES public.estados_cupo(id_estado_cupo);


--
-- TOC entry 4315 (class 2606 OID 19354)
-- Name: cupos cupos_id_usuario_bloqueo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupos
    ADD CONSTRAINT cupos_id_usuario_bloqueo_fkey FOREIGN KEY (id_usuario_bloqueo) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4347 (class 2606 OID 20202)
-- Name: hfj_blk_export_collection fk_blkexcol_job; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_blk_export_collection
    ADD CONSTRAINT fk_blkexcol_job FOREIGN KEY (job_pid) REFERENCES public.hfj_blk_export_job(pid);


--
-- TOC entry 4346 (class 2606 OID 20197)
-- Name: hfj_blk_export_colfile fk_blkexcolfile_collect; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_blk_export_colfile
    ADD CONSTRAINT fk_blkexcolfile_collect FOREIGN KEY (collection_pid) REFERENCES public.hfj_blk_export_collection(pid);


--
-- TOC entry 4348 (class 2606 OID 20207)
-- Name: hfj_blk_import_jobfile fk_blkimjobfile_job; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_blk_import_jobfile
    ADD CONSTRAINT fk_blkimjobfile_job FOREIGN KEY (job_pid) REFERENCES public.hfj_blk_import_job(pid);


--
-- TOC entry 4345 (class 2606 OID 20192)
-- Name: bt2_work_chunk fk_bt2wc_instance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bt2_work_chunk
    ADD CONSTRAINT fk_bt2wc_instance FOREIGN KEY (instance_id) REFERENCES public.bt2_job_instance(id);


--
-- TOC entry 4377 (class 2606 OID 20352)
-- Name: trm_codesystem_ver fk_codesysver_cs_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_codesystem_ver
    ADD CONSTRAINT fk_codesysver_cs_id FOREIGN KEY (codesystem_pid) REFERENCES public.trm_codesystem(pid);


--
-- TOC entry 4378 (class 2606 OID 20357)
-- Name: trm_codesystem_ver fk_codesysver_res_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_codesystem_ver
    ADD CONSTRAINT fk_codesysver_res_id FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4379 (class 2606 OID 20362)
-- Name: trm_concept fk_concept_pid_cs_pid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept
    ADD CONSTRAINT fk_concept_pid_cs_pid FOREIGN KEY (codesystem_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- TOC entry 4380 (class 2606 OID 20372)
-- Name: trm_concept_desig fk_conceptdesig_concept; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_desig
    ADD CONSTRAINT fk_conceptdesig_concept FOREIGN KEY (concept_pid) REFERENCES public.trm_concept(pid);


--
-- TOC entry 4381 (class 2606 OID 20367)
-- Name: trm_concept_desig fk_conceptdesig_csv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_desig
    ADD CONSTRAINT fk_conceptdesig_csv FOREIGN KEY (cs_ver_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- TOC entry 4389 (class 2606 OID 20417)
-- Name: trm_concept_property fk_conceptprop_concept; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_property
    ADD CONSTRAINT fk_conceptprop_concept FOREIGN KEY (concept_pid) REFERENCES public.trm_concept(pid);


--
-- TOC entry 4390 (class 2606 OID 20412)
-- Name: trm_concept_property fk_conceptprop_csv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_property
    ADD CONSTRAINT fk_conceptprop_csv FOREIGN KEY (cs_ver_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- TOC entry 4367 (class 2606 OID 20302)
-- Name: mpi_link fk_empi_link_golden_resource; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT fk_empi_link_golden_resource FOREIGN KEY (golden_resource_pid) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4368 (class 2606 OID 20307)
-- Name: mpi_link fk_empi_link_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT fk_empi_link_person FOREIGN KEY (person_pid) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4369 (class 2606 OID 20312)
-- Name: mpi_link fk_empi_link_target; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT fk_empi_link_target FOREIGN KEY (target_pid) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4349 (class 2606 OID 20212)
-- Name: hfj_history_tag fk_historytag_history; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_history_tag
    ADD CONSTRAINT fk_historytag_history FOREIGN KEY (res_ver_pid) REFERENCES public.hfj_res_ver(pid);


--
-- TOC entry 4350 (class 2606 OID 20217)
-- Name: hfj_idx_cmb_tok_nu fk_idxcmbtoknu_res_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_idx_cmb_tok_nu
    ADD CONSTRAINT fk_idxcmbtoknu_res_id FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4351 (class 2606 OID 20222)
-- Name: hfj_idx_cmp_string_uniq fk_idxcmpstruniq_res_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_idx_cmp_string_uniq
    ADD CONSTRAINT fk_idxcmpstruniq_res_id FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4373 (class 2606 OID 20332)
-- Name: npm_package_ver_res fk_npm_packverres_packver; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npm_package_ver_res
    ADD CONSTRAINT fk_npm_packverres_packver FOREIGN KEY (packver_pid) REFERENCES public.npm_package_ver(pid);


--
-- TOC entry 4371 (class 2606 OID 20322)
-- Name: npm_package_ver fk_npm_pkv_pkg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npm_package_ver
    ADD CONSTRAINT fk_npm_pkv_pkg FOREIGN KEY (package_pid) REFERENCES public.npm_package(pid);


--
-- TOC entry 4372 (class 2606 OID 20327)
-- Name: npm_package_ver fk_npm_pkv_resid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npm_package_ver
    ADD CONSTRAINT fk_npm_pkv_resid FOREIGN KEY (binary_res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4374 (class 2606 OID 20337)
-- Name: npm_package_ver_res fk_npm_pkvr_resid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npm_package_ver_res
    ADD CONSTRAINT fk_npm_pkvr_resid FOREIGN KEY (binary_res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4352 (class 2606 OID 20227)
-- Name: hfj_res_link fk_reslink_source; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_link
    ADD CONSTRAINT fk_reslink_source FOREIGN KEY (src_resource_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4353 (class 2606 OID 20232)
-- Name: hfj_res_link fk_reslink_target; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_link
    ADD CONSTRAINT fk_reslink_target FOREIGN KEY (target_resource_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4356 (class 2606 OID 20247)
-- Name: hfj_res_ver fk_resource_history_resource; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_ver
    ADD CONSTRAINT fk_resource_history_resource FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4354 (class 2606 OID 20237)
-- Name: hfj_res_param_present fk_resparmpres_resid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_param_present
    ADD CONSTRAINT fk_resparmpres_resid FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4355 (class 2606 OID 20242)
-- Name: hfj_res_tag fk_restag_resource; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_tag
    ADD CONSTRAINT fk_restag_resource FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4357 (class 2606 OID 20252)
-- Name: hfj_res_ver_prov fk_resverprov_res_pid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_res_ver_prov
    ADD CONSTRAINT fk_resverprov_res_pid FOREIGN KEY (res_pid) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4358 (class 2606 OID 20257)
-- Name: hfj_search_include fk_searchinc_search; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_search_include
    ADD CONSTRAINT fk_searchinc_search FOREIGN KEY (search_pid) REFERENCES public.hfj_search(pid);


--
-- TOC entry 4360 (class 2606 OID 20267)
-- Name: hfj_spidx_date fk_sp_date_res; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_date
    ADD CONSTRAINT fk_sp_date_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4361 (class 2606 OID 20272)
-- Name: hfj_spidx_number fk_sp_number_res; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_number
    ADD CONSTRAINT fk_sp_number_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4362 (class 2606 OID 20277)
-- Name: hfj_spidx_quantity fk_sp_quantity_res; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_quantity
    ADD CONSTRAINT fk_sp_quantity_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4363 (class 2606 OID 20282)
-- Name: hfj_spidx_quantity_nrml fk_sp_quantitynm_res; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_quantity_nrml
    ADD CONSTRAINT fk_sp_quantitynm_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4365 (class 2606 OID 20292)
-- Name: hfj_spidx_token fk_sp_token_res; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_token
    ADD CONSTRAINT fk_sp_token_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4364 (class 2606 OID 20287)
-- Name: hfj_spidx_string fk_spidxstr_resource; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_string
    ADD CONSTRAINT fk_spidxstr_resource FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4384 (class 2606 OID 20387)
-- Name: trm_concept_map_grp_element fk_tcmgelement_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_map_grp_element
    ADD CONSTRAINT fk_tcmgelement_group FOREIGN KEY (concept_map_group_pid) REFERENCES public.trm_concept_map_group(pid);


--
-- TOC entry 4385 (class 2606 OID 20392)
-- Name: trm_concept_map_grp_elm_tgt fk_tcmgetarget_element; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_map_grp_elm_tgt
    ADD CONSTRAINT fk_tcmgetarget_element FOREIGN KEY (concept_map_grp_elm_pid) REFERENCES public.trm_concept_map_grp_element(pid);


--
-- TOC entry 4383 (class 2606 OID 20382)
-- Name: trm_concept_map_group fk_tcmgroup_conceptmap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_map_group
    ADD CONSTRAINT fk_tcmgroup_conceptmap FOREIGN KEY (concept_map_pid) REFERENCES public.trm_concept_map(pid);


--
-- TOC entry 4386 (class 2606 OID 20397)
-- Name: trm_concept_pc_link fk_term_conceptpc_child; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_pc_link
    ADD CONSTRAINT fk_term_conceptpc_child FOREIGN KEY (child_pid) REFERENCES public.trm_concept(pid);


--
-- TOC entry 4387 (class 2606 OID 20402)
-- Name: trm_concept_pc_link fk_term_conceptpc_cs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_pc_link
    ADD CONSTRAINT fk_term_conceptpc_cs FOREIGN KEY (codesystem_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- TOC entry 4388 (class 2606 OID 20407)
-- Name: trm_concept_pc_link fk_term_conceptpc_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_pc_link
    ADD CONSTRAINT fk_term_conceptpc_parent FOREIGN KEY (parent_pid) REFERENCES public.trm_concept(pid);


--
-- TOC entry 4392 (class 2606 OID 20427)
-- Name: trm_valueset_c_designation fk_trm_valueset_concept_pid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_valueset_c_designation
    ADD CONSTRAINT fk_trm_valueset_concept_pid FOREIGN KEY (valueset_concept_pid) REFERENCES public.trm_valueset_concept(pid);


--
-- TOC entry 4394 (class 2606 OID 20437)
-- Name: trm_valueset_concept fk_trm_valueset_pid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_valueset_concept
    ADD CONSTRAINT fk_trm_valueset_pid FOREIGN KEY (valueset_pid) REFERENCES public.trm_valueset(pid);


--
-- TOC entry 4393 (class 2606 OID 20432)
-- Name: trm_valueset_c_designation fk_trm_vscd_vs_pid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_valueset_c_designation
    ADD CONSTRAINT fk_trm_vscd_vs_pid FOREIGN KEY (valueset_pid) REFERENCES public.trm_valueset(pid);


--
-- TOC entry 4375 (class 2606 OID 20342)
-- Name: trm_codesystem fk_trmcodesystem_curver; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_codesystem
    ADD CONSTRAINT fk_trmcodesystem_curver FOREIGN KEY (current_version_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- TOC entry 4376 (class 2606 OID 20347)
-- Name: trm_codesystem fk_trmcodesystem_res; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_codesystem
    ADD CONSTRAINT fk_trmcodesystem_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4382 (class 2606 OID 20377)
-- Name: trm_concept_map fk_trmconceptmap_res; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_concept_map
    ADD CONSTRAINT fk_trmconceptmap_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4391 (class 2606 OID 20422)
-- Name: trm_valueset fk_trmvalueset_res; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trm_valueset
    ADD CONSTRAINT fk_trmvalueset_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4359 (class 2606 OID 20262)
-- Name: hfj_spidx_coords fkc97mpk37okwu8qvtceg2nh9vn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_coords
    ADD CONSTRAINT fkc97mpk37okwu8qvtceg2nh9vn FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4366 (class 2606 OID 20297)
-- Name: hfj_spidx_uri fkgxsreutymmfjuwdswv3y887do; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hfj_spidx_uri
    ADD CONSTRAINT fkgxsreutymmfjuwdswv3y887do FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- TOC entry 4370 (class 2606 OID 20317)
-- Name: mpi_link_aud fkkbqi6ie5cmr64rl4a1qbeury1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mpi_link_aud
    ADD CONSTRAINT fkkbqi6ie5cmr64rl4a1qbeury1 FOREIGN KEY (rev) REFERENCES public.hfj_revinfo(rev);


--
-- TOC entry 4332 (class 2606 OID 19485)
-- Name: historial_cambios_cita historial_cambios_cita_id_cita_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_cambios_cita
    ADD CONSTRAINT historial_cambios_cita_id_cita_fkey FOREIGN KEY (id_cita) REFERENCES public.citas(id_cita);


--
-- TOC entry 4333 (class 2606 OID 19490)
-- Name: historial_cambios_cita historial_cambios_cita_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_cambios_cita
    ADD CONSTRAINT historial_cambios_cita_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4279 (class 2606 OID 18994)
-- Name: ips ips_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ips
    ADD CONSTRAINT ips_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES public.municipios(id_municipio);


--
-- TOC entry 4334 (class 2606 OID 19508)
-- Name: lista_espera lista_espera_id_ips_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lista_espera
    ADD CONSTRAINT lista_espera_id_ips_fkey FOREIGN KEY (id_ips) REFERENCES public.ips(id_ips);


--
-- TOC entry 4335 (class 2606 OID 19538)
-- Name: lista_espera lista_espera_id_modalidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lista_espera
    ADD CONSTRAINT lista_espera_id_modalidad_fkey FOREIGN KEY (id_modalidad) REFERENCES public.modalidades_atencion(id_modalidad);


--
-- TOC entry 4336 (class 2606 OID 19513)
-- Name: lista_espera lista_espera_id_paciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lista_espera
    ADD CONSTRAINT lista_espera_id_paciente_fkey FOREIGN KEY (id_paciente) REFERENCES public.pacientes(id_paciente);


--
-- TOC entry 4337 (class 2606 OID 19528)
-- Name: lista_espera lista_espera_id_profesional_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lista_espera
    ADD CONSTRAINT lista_espera_id_profesional_fkey FOREIGN KEY (id_profesional) REFERENCES public.profesionales(id_profesional);


--
-- TOC entry 4338 (class 2606 OID 19523)
-- Name: lista_espera lista_espera_id_sede_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lista_espera
    ADD CONSTRAINT lista_espera_id_sede_fkey FOREIGN KEY (id_sede) REFERENCES public.sedes(id_sede);


--
-- TOC entry 4339 (class 2606 OID 19518)
-- Name: lista_espera lista_espera_id_servicio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lista_espera
    ADD CONSTRAINT lista_espera_id_servicio_fkey FOREIGN KEY (id_servicio) REFERENCES public.servicios_salud(id_servicio);


--
-- TOC entry 4340 (class 2606 OID 19533)
-- Name: lista_espera lista_espera_id_tipo_consulta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lista_espera
    ADD CONSTRAINT lista_espera_id_tipo_consulta_fkey FOREIGN KEY (id_tipo_consulta) REFERENCES public.tipos_consulta(id_tipo_consulta);


--
-- TOC entry 4278 (class 2606 OID 18975)
-- Name: municipios municipios_id_departamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipios
    ADD CONSTRAINT municipios_id_departamento_fkey FOREIGN KEY (id_departamento) REFERENCES public.departamentos(id_departamento);


--
-- TOC entry 4341 (class 2606 OID 19554)
-- Name: notificaciones notificaciones_id_cita_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT notificaciones_id_cita_fkey FOREIGN KEY (id_cita) REFERENCES public.citas(id_cita);


--
-- TOC entry 4342 (class 2606 OID 19559)
-- Name: notificaciones notificaciones_id_paciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT notificaciones_id_paciente_fkey FOREIGN KEY (id_paciente) REFERENCES public.pacientes(id_paciente);


--
-- TOC entry 4297 (class 2606 OID 19227)
-- Name: pacientes pacientes_id_genero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_id_genero_fkey FOREIGN KEY (id_genero) REFERENCES public.generos(id_genero);


--
-- TOC entry 4298 (class 2606 OID 19232)
-- Name: pacientes pacientes_id_sexo_biologico_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_id_sexo_biologico_fkey FOREIGN KEY (id_sexo_biologico) REFERENCES public.sexos_biologicos(id_sexo_biologico);


--
-- TOC entry 4299 (class 2606 OID 19222)
-- Name: pacientes pacientes_id_tipo_documento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_id_tipo_documento_fkey FOREIGN KEY (id_tipo_documento) REFERENCES public.tipos_documento(id_tipo_documento);


--
-- TOC entry 4291 (class 2606 OID 19170)
-- Name: profesionales profesionales_id_especialidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesionales
    ADD CONSTRAINT profesionales_id_especialidad_fkey FOREIGN KEY (id_especialidad) REFERENCES public.especialidades(id_especialidad);


--
-- TOC entry 4292 (class 2606 OID 19165)
-- Name: profesionales profesionales_id_tipo_documento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesionales
    ADD CONSTRAINT profesionales_id_tipo_documento_fkey FOREIGN KEY (id_tipo_documento) REFERENCES public.tipos_documento(id_tipo_documento);


--
-- TOC entry 4303 (class 2606 OID 19278)
-- Name: reglas_duracion_cita reglas_duracion_cita_id_aseguradora_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reglas_duracion_cita
    ADD CONSTRAINT reglas_duracion_cita_id_aseguradora_fkey FOREIGN KEY (id_aseguradora) REFERENCES public.aseguradoras(id_aseguradora);


--
-- TOC entry 4304 (class 2606 OID 19293)
-- Name: reglas_duracion_cita reglas_duracion_cita_id_especialidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reglas_duracion_cita
    ADD CONSTRAINT reglas_duracion_cita_id_especialidad_fkey FOREIGN KEY (id_especialidad) REFERENCES public.especialidades(id_especialidad);


--
-- TOC entry 4305 (class 2606 OID 19273)
-- Name: reglas_duracion_cita reglas_duracion_cita_id_ips_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reglas_duracion_cita
    ADD CONSTRAINT reglas_duracion_cita_id_ips_fkey FOREIGN KEY (id_ips) REFERENCES public.ips(id_ips);


--
-- TOC entry 4306 (class 2606 OID 19288)
-- Name: reglas_duracion_cita reglas_duracion_cita_id_modalidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reglas_duracion_cita
    ADD CONSTRAINT reglas_duracion_cita_id_modalidad_fkey FOREIGN KEY (id_modalidad) REFERENCES public.modalidades_atencion(id_modalidad);


--
-- TOC entry 4307 (class 2606 OID 19283)
-- Name: reglas_duracion_cita reglas_duracion_cita_id_tipo_consulta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reglas_duracion_cita
    ADD CONSTRAINT reglas_duracion_cita_id_tipo_consulta_fkey FOREIGN KEY (id_tipo_consulta) REFERENCES public.tipos_consulta(id_tipo_consulta);


--
-- TOC entry 4331 (class 2606 OID 19470)
-- Name: respuestas_cita respuestas_cita_id_cita_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas_cita
    ADD CONSTRAINT respuestas_cita_id_cita_fkey FOREIGN KEY (id_cita) REFERENCES public.citas(id_cita);


--
-- TOC entry 4285 (class 2606 OID 19091)
-- Name: rol_permiso rol_permiso_id_permiso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol_permiso
    ADD CONSTRAINT rol_permiso_id_permiso_fkey FOREIGN KEY (id_permiso) REFERENCES public.permisos(id_permiso);


--
-- TOC entry 4286 (class 2606 OID 19086)
-- Name: rol_permiso rol_permiso_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol_permiso
    ADD CONSTRAINT rol_permiso_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES public.roles(id_rol);


--
-- TOC entry 4293 (class 2606 OID 19193)
-- Name: roles_profesional roles_profesional_id_ips_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_profesional
    ADD CONSTRAINT roles_profesional_id_ips_fkey FOREIGN KEY (id_ips) REFERENCES public.ips(id_ips);


--
-- TOC entry 4294 (class 2606 OID 19188)
-- Name: roles_profesional roles_profesional_id_profesional_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_profesional
    ADD CONSTRAINT roles_profesional_id_profesional_fkey FOREIGN KEY (id_profesional) REFERENCES public.profesionales(id_profesional);


--
-- TOC entry 4295 (class 2606 OID 19198)
-- Name: roles_profesional roles_profesional_id_sede_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_profesional
    ADD CONSTRAINT roles_profesional_id_sede_fkey FOREIGN KEY (id_sede) REFERENCES public.sedes(id_sede);


--
-- TOC entry 4296 (class 2606 OID 19203)
-- Name: roles_profesional roles_profesional_id_servicio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_profesional
    ADD CONSTRAINT roles_profesional_id_servicio_fkey FOREIGN KEY (id_servicio) REFERENCES public.servicios_salud(id_servicio);


--
-- TOC entry 4280 (class 2606 OID 19025)
-- Name: sedes sedes_id_ips_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sedes
    ADD CONSTRAINT sedes_id_ips_fkey FOREIGN KEY (id_ips) REFERENCES public.ips(id_ips);


--
-- TOC entry 4281 (class 2606 OID 19030)
-- Name: sedes sedes_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sedes
    ADD CONSTRAINT sedes_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES public.municipios(id_municipio);


--
-- TOC entry 4288 (class 2606 OID 19147)
-- Name: servicios_salud servicios_salud_id_especialidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios_salud
    ADD CONSTRAINT servicios_salud_id_especialidad_fkey FOREIGN KEY (id_especialidad) REFERENCES public.especialidades(id_especialidad);


--
-- TOC entry 4289 (class 2606 OID 19137)
-- Name: servicios_salud servicios_salud_id_ips_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios_salud
    ADD CONSTRAINT servicios_salud_id_ips_fkey FOREIGN KEY (id_ips) REFERENCES public.ips(id_ips);


--
-- TOC entry 4290 (class 2606 OID 19142)
-- Name: servicios_salud servicios_salud_id_sede_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios_salud
    ADD CONSTRAINT servicios_salud_id_sede_fkey FOREIGN KEY (id_sede) REFERENCES public.sedes(id_sede);


--
-- TOC entry 4287 (class 2606 OID 19107)
-- Name: sesiones_usuario sesiones_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sesiones_usuario
    ADD CONSTRAINT sesiones_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4282 (class 2606 OID 19050)
-- Name: usuarios usuarios_id_ips_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_id_ips_fkey FOREIGN KEY (id_ips) REFERENCES public.ips(id_ips);


--
-- TOC entry 4283 (class 2606 OID 19060)
-- Name: usuarios usuarios_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES public.roles(id_rol);


--
-- TOC entry 4284 (class 2606 OID 19055)
-- Name: usuarios usuarios_id_sede_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_id_sede_fkey FOREIGN KEY (id_sede) REFERENCES public.sedes(id_sede);


-- Completed on 2026-05-05 18:40:38

--
-- PostgreSQL database dump complete
--

