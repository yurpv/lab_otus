--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-1.pgdg22.04+2)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-1.pgdg22.04+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: oc_accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_accounts (
    uid character varying(64) DEFAULT ''::character varying NOT NULL,
    data text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.oc_accounts OWNER TO postgres;

--
-- Name: oc_accounts_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_accounts_data (
    id bigint NOT NULL,
    uid character varying(64) NOT NULL,
    name character varying(64) NOT NULL,
    value character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.oc_accounts_data OWNER TO postgres;

--
-- Name: oc_accounts_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_accounts_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_accounts_data_id_seq OWNER TO postgres;

--
-- Name: oc_accounts_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_accounts_data_id_seq OWNED BY public.oc_accounts_data.id;


--
-- Name: oc_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_activity (
    activity_id bigint NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    type character varying(255) DEFAULT NULL::character varying,
    "user" character varying(64) DEFAULT NULL::character varying,
    affecteduser character varying(64) NOT NULL,
    app character varying(32) NOT NULL,
    subject character varying(255) NOT NULL,
    subjectparams text NOT NULL,
    message character varying(255) DEFAULT NULL::character varying,
    messageparams text,
    file character varying(4000) DEFAULT NULL::character varying,
    link character varying(4000) DEFAULT NULL::character varying,
    object_type character varying(255) DEFAULT NULL::character varying,
    object_id bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_activity OWNER TO postgres;

--
-- Name: oc_activity_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_activity_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_activity_activity_id_seq OWNER TO postgres;

--
-- Name: oc_activity_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_activity_activity_id_seq OWNED BY public.oc_activity.activity_id;


--
-- Name: oc_activity_mq; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_activity_mq (
    mail_id bigint NOT NULL,
    amq_timestamp integer DEFAULT 0 NOT NULL,
    amq_latest_send integer DEFAULT 0 NOT NULL,
    amq_type character varying(255) NOT NULL,
    amq_affecteduser character varying(64) NOT NULL,
    amq_appid character varying(32) NOT NULL,
    amq_subject character varying(255) NOT NULL,
    amq_subjectparams text,
    object_type character varying(255) DEFAULT NULL::character varying,
    object_id bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_activity_mq OWNER TO postgres;

--
-- Name: oc_activity_mq_mail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_activity_mq_mail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_activity_mq_mail_id_seq OWNER TO postgres;

--
-- Name: oc_activity_mq_mail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_activity_mq_mail_id_seq OWNED BY public.oc_activity_mq.mail_id;


--
-- Name: oc_addressbookchanges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_addressbookchanges (
    id bigint NOT NULL,
    uri character varying(255) DEFAULT NULL::character varying,
    synctoken integer DEFAULT 1 NOT NULL,
    addressbookid bigint NOT NULL,
    operation smallint NOT NULL,
    created_at integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_addressbookchanges OWNER TO postgres;

--
-- Name: oc_addressbookchanges_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_addressbookchanges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_addressbookchanges_id_seq OWNER TO postgres;

--
-- Name: oc_addressbookchanges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_addressbookchanges_id_seq OWNED BY public.oc_addressbookchanges.id;


--
-- Name: oc_addressbooks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_addressbooks (
    id bigint NOT NULL,
    principaluri character varying(255) DEFAULT NULL::character varying,
    displayname character varying(255) DEFAULT NULL::character varying,
    uri character varying(255) DEFAULT NULL::character varying,
    description character varying(255) DEFAULT NULL::character varying,
    synctoken integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.oc_addressbooks OWNER TO postgres;

--
-- Name: oc_addressbooks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_addressbooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_addressbooks_id_seq OWNER TO postgres;

--
-- Name: oc_addressbooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_addressbooks_id_seq OWNED BY public.oc_addressbooks.id;


--
-- Name: oc_appconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_appconfig (
    appid character varying(32) DEFAULT ''::character varying NOT NULL,
    configkey character varying(64) DEFAULT ''::character varying NOT NULL,
    configvalue text,
    type integer DEFAULT 2 NOT NULL,
    lazy smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_appconfig OWNER TO postgres;

--
-- Name: oc_appconfig_ex; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_appconfig_ex (
    id bigint NOT NULL,
    appid character varying(32) NOT NULL,
    configkey character varying(64) NOT NULL,
    configvalue text,
    sensitive smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_appconfig_ex OWNER TO postgres;

--
-- Name: oc_appconfig_ex_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_appconfig_ex_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_appconfig_ex_id_seq OWNER TO postgres;

--
-- Name: oc_appconfig_ex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_appconfig_ex_id_seq OWNED BY public.oc_appconfig_ex.id;


--
-- Name: oc_authorized_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_authorized_groups (
    id integer NOT NULL,
    group_id character varying(200) NOT NULL,
    class character varying(200) NOT NULL
);


ALTER TABLE public.oc_authorized_groups OWNER TO postgres;

--
-- Name: oc_authorized_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_authorized_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_authorized_groups_id_seq OWNER TO postgres;

--
-- Name: oc_authorized_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_authorized_groups_id_seq OWNED BY public.oc_authorized_groups.id;


--
-- Name: oc_authtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_authtoken (
    id bigint NOT NULL,
    uid character varying(64) DEFAULT ''::character varying NOT NULL,
    login_name character varying(255) DEFAULT ''::character varying NOT NULL,
    password text,
    name text DEFAULT ''::text NOT NULL,
    token character varying(200) DEFAULT ''::character varying NOT NULL,
    type smallint DEFAULT 0,
    remember smallint DEFAULT 0,
    last_activity integer DEFAULT 0,
    last_check integer DEFAULT 0,
    scope text,
    expires integer,
    private_key text,
    public_key text,
    version smallint DEFAULT 1 NOT NULL,
    password_invalid boolean DEFAULT false,
    password_hash character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_authtoken OWNER TO postgres;

--
-- Name: oc_authtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_authtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_authtoken_id_seq OWNER TO postgres;

--
-- Name: oc_authtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_authtoken_id_seq OWNED BY public.oc_authtoken.id;


--
-- Name: oc_bruteforce_attempts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_bruteforce_attempts (
    id bigint NOT NULL,
    action character varying(64) DEFAULT ''::character varying NOT NULL,
    occurred integer DEFAULT 0 NOT NULL,
    ip character varying(255) DEFAULT ''::character varying NOT NULL,
    subnet character varying(255) DEFAULT ''::character varying NOT NULL,
    metadata character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_bruteforce_attempts OWNER TO postgres;

--
-- Name: oc_bruteforce_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_bruteforce_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_bruteforce_attempts_id_seq OWNER TO postgres;

--
-- Name: oc_bruteforce_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_bruteforce_attempts_id_seq OWNED BY public.oc_bruteforce_attempts.id;


--
-- Name: oc_calendar_invitations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_calendar_invitations (
    id bigint NOT NULL,
    uid character varying(255) NOT NULL,
    recurrenceid character varying(255) DEFAULT NULL::character varying,
    attendee character varying(255) NOT NULL,
    organizer character varying(255) NOT NULL,
    sequence bigint,
    token character varying(60) NOT NULL,
    expiration bigint NOT NULL
);


ALTER TABLE public.oc_calendar_invitations OWNER TO postgres;

--
-- Name: oc_calendar_invitations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_calendar_invitations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_calendar_invitations_id_seq OWNER TO postgres;

--
-- Name: oc_calendar_invitations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_calendar_invitations_id_seq OWNED BY public.oc_calendar_invitations.id;


--
-- Name: oc_calendar_reminders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_calendar_reminders (
    id bigint NOT NULL,
    calendar_id bigint NOT NULL,
    object_id bigint NOT NULL,
    is_recurring smallint,
    uid character varying(255) NOT NULL,
    recurrence_id bigint,
    is_recurrence_exception smallint NOT NULL,
    event_hash character varying(255) NOT NULL,
    alarm_hash character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    is_relative smallint NOT NULL,
    notification_date bigint NOT NULL,
    is_repeat_based smallint NOT NULL
);


ALTER TABLE public.oc_calendar_reminders OWNER TO postgres;

--
-- Name: oc_calendar_reminders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_calendar_reminders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_calendar_reminders_id_seq OWNER TO postgres;

--
-- Name: oc_calendar_reminders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_calendar_reminders_id_seq OWNED BY public.oc_calendar_reminders.id;


--
-- Name: oc_calendar_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_calendar_resources (
    id bigint NOT NULL,
    backend_id character varying(64) DEFAULT NULL::character varying,
    resource_id character varying(64) DEFAULT NULL::character varying,
    email character varying(255) DEFAULT NULL::character varying,
    displayname character varying(255) DEFAULT NULL::character varying,
    group_restrictions character varying(4000) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_calendar_resources OWNER TO postgres;

--
-- Name: oc_calendar_resources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_calendar_resources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_calendar_resources_id_seq OWNER TO postgres;

--
-- Name: oc_calendar_resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_calendar_resources_id_seq OWNED BY public.oc_calendar_resources.id;


--
-- Name: oc_calendar_resources_md; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_calendar_resources_md (
    id bigint NOT NULL,
    resource_id bigint NOT NULL,
    key character varying(255) NOT NULL,
    value character varying(4000) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_calendar_resources_md OWNER TO postgres;

--
-- Name: oc_calendar_resources_md_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_calendar_resources_md_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_calendar_resources_md_id_seq OWNER TO postgres;

--
-- Name: oc_calendar_resources_md_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_calendar_resources_md_id_seq OWNED BY public.oc_calendar_resources_md.id;


--
-- Name: oc_calendar_rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_calendar_rooms (
    id bigint NOT NULL,
    backend_id character varying(64) DEFAULT NULL::character varying,
    resource_id character varying(64) DEFAULT NULL::character varying,
    email character varying(255) DEFAULT NULL::character varying,
    displayname character varying(255) DEFAULT NULL::character varying,
    group_restrictions character varying(4000) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_calendar_rooms OWNER TO postgres;

--
-- Name: oc_calendar_rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_calendar_rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_calendar_rooms_id_seq OWNER TO postgres;

--
-- Name: oc_calendar_rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_calendar_rooms_id_seq OWNED BY public.oc_calendar_rooms.id;


--
-- Name: oc_calendar_rooms_md; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_calendar_rooms_md (
    id bigint NOT NULL,
    room_id bigint NOT NULL,
    key character varying(255) NOT NULL,
    value character varying(4000) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_calendar_rooms_md OWNER TO postgres;

--
-- Name: oc_calendar_rooms_md_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_calendar_rooms_md_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_calendar_rooms_md_id_seq OWNER TO postgres;

--
-- Name: oc_calendar_rooms_md_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_calendar_rooms_md_id_seq OWNED BY public.oc_calendar_rooms_md.id;


--
-- Name: oc_calendarchanges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_calendarchanges (
    id bigint NOT NULL,
    uri character varying(255) DEFAULT NULL::character varying,
    synctoken integer DEFAULT 1 NOT NULL,
    calendarid bigint NOT NULL,
    operation smallint NOT NULL,
    calendartype integer DEFAULT 0 NOT NULL,
    created_at integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_calendarchanges OWNER TO postgres;

--
-- Name: oc_calendarchanges_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_calendarchanges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_calendarchanges_id_seq OWNER TO postgres;

--
-- Name: oc_calendarchanges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_calendarchanges_id_seq OWNED BY public.oc_calendarchanges.id;


--
-- Name: oc_calendarobjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_calendarobjects (
    id bigint NOT NULL,
    calendardata bytea,
    uri character varying(255) DEFAULT NULL::character varying,
    calendarid bigint NOT NULL,
    lastmodified integer,
    etag character varying(32) DEFAULT NULL::character varying,
    size bigint NOT NULL,
    componenttype character varying(8) DEFAULT NULL::character varying,
    firstoccurence bigint,
    lastoccurence bigint,
    uid character varying(255) DEFAULT NULL::character varying,
    classification integer DEFAULT 0,
    calendartype integer DEFAULT 0 NOT NULL,
    deleted_at integer
);


ALTER TABLE public.oc_calendarobjects OWNER TO postgres;

--
-- Name: oc_calendarobjects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_calendarobjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_calendarobjects_id_seq OWNER TO postgres;

--
-- Name: oc_calendarobjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_calendarobjects_id_seq OWNED BY public.oc_calendarobjects.id;


--
-- Name: oc_calendarobjects_props; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_calendarobjects_props (
    id bigint NOT NULL,
    calendarid bigint DEFAULT 0 NOT NULL,
    objectid bigint DEFAULT 0 NOT NULL,
    name character varying(64) DEFAULT NULL::character varying,
    parameter character varying(64) DEFAULT NULL::character varying,
    value character varying(255) DEFAULT NULL::character varying,
    calendartype integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_calendarobjects_props OWNER TO postgres;

--
-- Name: oc_calendarobjects_props_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_calendarobjects_props_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_calendarobjects_props_id_seq OWNER TO postgres;

--
-- Name: oc_calendarobjects_props_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_calendarobjects_props_id_seq OWNED BY public.oc_calendarobjects_props.id;


--
-- Name: oc_calendars; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_calendars (
    id bigint NOT NULL,
    principaluri character varying(255) DEFAULT NULL::character varying,
    displayname character varying(255) DEFAULT NULL::character varying,
    uri character varying(255) DEFAULT NULL::character varying,
    synctoken integer DEFAULT 1 NOT NULL,
    description character varying(255) DEFAULT NULL::character varying,
    calendarorder integer DEFAULT 0 NOT NULL,
    calendarcolor character varying(255) DEFAULT NULL::character varying,
    timezone text,
    components character varying(64) DEFAULT NULL::character varying,
    transparent smallint DEFAULT 0 NOT NULL,
    deleted_at integer
);


ALTER TABLE public.oc_calendars OWNER TO postgres;

--
-- Name: oc_calendars_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_calendars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_calendars_id_seq OWNER TO postgres;

--
-- Name: oc_calendars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_calendars_id_seq OWNED BY public.oc_calendars.id;


--
-- Name: oc_calendarsubscriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_calendarsubscriptions (
    id bigint NOT NULL,
    uri character varying(255) DEFAULT NULL::character varying,
    principaluri character varying(255) DEFAULT NULL::character varying,
    displayname character varying(100) DEFAULT NULL::character varying,
    refreshrate character varying(10) DEFAULT NULL::character varying,
    calendarorder integer DEFAULT 0 NOT NULL,
    calendarcolor character varying(255) DEFAULT NULL::character varying,
    striptodos smallint,
    stripalarms smallint,
    stripattachments smallint,
    lastmodified integer,
    synctoken integer DEFAULT 1 NOT NULL,
    source text
);


ALTER TABLE public.oc_calendarsubscriptions OWNER TO postgres;

--
-- Name: oc_calendarsubscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_calendarsubscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_calendarsubscriptions_id_seq OWNER TO postgres;

--
-- Name: oc_calendarsubscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_calendarsubscriptions_id_seq OWNED BY public.oc_calendarsubscriptions.id;


--
-- Name: oc_cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_cards (
    id bigint NOT NULL,
    addressbookid bigint DEFAULT 0 NOT NULL,
    carddata bytea,
    uri character varying(255) DEFAULT NULL::character varying,
    lastmodified bigint,
    etag character varying(32) DEFAULT NULL::character varying,
    size bigint NOT NULL,
    uid character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_cards OWNER TO postgres;

--
-- Name: oc_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_cards_id_seq OWNER TO postgres;

--
-- Name: oc_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_cards_id_seq OWNED BY public.oc_cards.id;


--
-- Name: oc_cards_properties; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_cards_properties (
    id bigint NOT NULL,
    addressbookid bigint DEFAULT 0 NOT NULL,
    cardid bigint DEFAULT 0 NOT NULL,
    name character varying(64) DEFAULT NULL::character varying,
    value character varying(255) DEFAULT NULL::character varying,
    preferred integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.oc_cards_properties OWNER TO postgres;

--
-- Name: oc_cards_properties_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_cards_properties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_cards_properties_id_seq OWNER TO postgres;

--
-- Name: oc_cards_properties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_cards_properties_id_seq OWNED BY public.oc_cards_properties.id;


--
-- Name: oc_circles_circle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_circles_circle (
    id integer NOT NULL,
    unique_id character varying(31) NOT NULL,
    name character varying(127) NOT NULL,
    display_name character varying(255) DEFAULT ''::character varying,
    sanitized_name character varying(127) DEFAULT ''::character varying,
    instance character varying(255) DEFAULT ''::character varying,
    config integer,
    source integer,
    settings text,
    description text,
    creation timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    contact_addressbook integer,
    contact_groupname character varying(127) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_circles_circle OWNER TO postgres;

--
-- Name: oc_circles_circle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_circles_circle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_circles_circle_id_seq OWNER TO postgres;

--
-- Name: oc_circles_circle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_circles_circle_id_seq OWNED BY public.oc_circles_circle.id;


--
-- Name: oc_circles_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_circles_event (
    token character varying(63) NOT NULL,
    instance character varying(255) NOT NULL,
    event text,
    result text,
    interface integer DEFAULT 0 NOT NULL,
    severity integer,
    retry integer,
    status integer,
    updated timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    creation bigint
);


ALTER TABLE public.oc_circles_event OWNER TO postgres;

--
-- Name: oc_circles_member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_circles_member (
    id integer NOT NULL,
    single_id character varying(31) DEFAULT NULL::character varying,
    circle_id character varying(31) NOT NULL,
    member_id character varying(31) DEFAULT NULL::character varying,
    user_id character varying(127) NOT NULL,
    user_type smallint DEFAULT 1 NOT NULL,
    instance character varying(255) DEFAULT ''::character varying,
    invited_by character varying(31) DEFAULT NULL::character varying,
    level smallint NOT NULL,
    status character varying(15) DEFAULT NULL::character varying,
    note text,
    cached_name character varying(255) DEFAULT ''::character varying,
    cached_update timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    contact_id character varying(127) DEFAULT NULL::character varying,
    contact_meta text,
    joined timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.oc_circles_member OWNER TO postgres;

--
-- Name: oc_circles_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_circles_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_circles_member_id_seq OWNER TO postgres;

--
-- Name: oc_circles_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_circles_member_id_seq OWNED BY public.oc_circles_member.id;


--
-- Name: oc_circles_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_circles_membership (
    circle_id character varying(31) NOT NULL,
    single_id character varying(31) NOT NULL,
    level integer NOT NULL,
    inheritance_first character varying(31) NOT NULL,
    inheritance_last character varying(31) NOT NULL,
    inheritance_depth integer NOT NULL,
    inheritance_path text NOT NULL
);


ALTER TABLE public.oc_circles_membership OWNER TO postgres;

--
-- Name: oc_circles_mount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_circles_mount (
    id integer NOT NULL,
    mount_id character varying(31) NOT NULL,
    circle_id character varying(31) NOT NULL,
    single_id character varying(31) NOT NULL,
    token character varying(63) DEFAULT NULL::character varying,
    parent integer,
    mountpoint text,
    mountpoint_hash character varying(64) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_circles_mount OWNER TO postgres;

--
-- Name: oc_circles_mount_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_circles_mount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_circles_mount_id_seq OWNER TO postgres;

--
-- Name: oc_circles_mount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_circles_mount_id_seq OWNED BY public.oc_circles_mount.id;


--
-- Name: oc_circles_mountpoint; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_circles_mountpoint (
    id integer NOT NULL,
    mount_id character varying(31) NOT NULL,
    single_id character varying(31) NOT NULL,
    mountpoint text,
    mountpoint_hash character varying(64) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_circles_mountpoint OWNER TO postgres;

--
-- Name: oc_circles_mountpoint_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_circles_mountpoint_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_circles_mountpoint_id_seq OWNER TO postgres;

--
-- Name: oc_circles_mountpoint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_circles_mountpoint_id_seq OWNED BY public.oc_circles_mountpoint.id;


--
-- Name: oc_circles_remote; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_circles_remote (
    id integer NOT NULL,
    type character varying(15) DEFAULT 'Unknown'::character varying NOT NULL,
    interface integer DEFAULT 0 NOT NULL,
    uid character varying(20) DEFAULT NULL::character varying,
    instance character varying(127) DEFAULT NULL::character varying,
    href character varying(254) DEFAULT NULL::character varying,
    item text,
    creation timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.oc_circles_remote OWNER TO postgres;

--
-- Name: oc_circles_remote_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_circles_remote_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_circles_remote_id_seq OWNER TO postgres;

--
-- Name: oc_circles_remote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_circles_remote_id_seq OWNED BY public.oc_circles_remote.id;


--
-- Name: oc_circles_share_lock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_circles_share_lock (
    id integer NOT NULL,
    item_id character varying(31) NOT NULL,
    circle_id character varying(31) NOT NULL,
    instance character varying(127) NOT NULL
);


ALTER TABLE public.oc_circles_share_lock OWNER TO postgres;

--
-- Name: oc_circles_share_lock_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_circles_share_lock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_circles_share_lock_id_seq OWNER TO postgres;

--
-- Name: oc_circles_share_lock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_circles_share_lock_id_seq OWNED BY public.oc_circles_share_lock.id;


--
-- Name: oc_circles_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_circles_token (
    id integer NOT NULL,
    share_id integer,
    circle_id character varying(31) DEFAULT NULL::character varying,
    single_id character varying(31) DEFAULT NULL::character varying,
    member_id character varying(31) DEFAULT NULL::character varying,
    token character varying(31) DEFAULT NULL::character varying,
    password character varying(127) DEFAULT NULL::character varying,
    accepted integer
);


ALTER TABLE public.oc_circles_token OWNER TO postgres;

--
-- Name: oc_circles_token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_circles_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_circles_token_id_seq OWNER TO postgres;

--
-- Name: oc_circles_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_circles_token_id_seq OWNED BY public.oc_circles_token.id;


--
-- Name: oc_collres_accesscache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_collres_accesscache (
    user_id character varying(64) NOT NULL,
    collection_id bigint DEFAULT 0 NOT NULL,
    resource_type character varying(64) DEFAULT ''::character varying NOT NULL,
    resource_id character varying(64) DEFAULT ''::character varying NOT NULL,
    access boolean DEFAULT false
);


ALTER TABLE public.oc_collres_accesscache OWNER TO postgres;

--
-- Name: oc_collres_collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_collres_collections (
    id bigint NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.oc_collres_collections OWNER TO postgres;

--
-- Name: oc_collres_collections_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_collres_collections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_collres_collections_id_seq OWNER TO postgres;

--
-- Name: oc_collres_collections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_collres_collections_id_seq OWNED BY public.oc_collres_collections.id;


--
-- Name: oc_collres_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_collres_resources (
    collection_id bigint NOT NULL,
    resource_type character varying(64) NOT NULL,
    resource_id character varying(64) NOT NULL
);


ALTER TABLE public.oc_collres_resources OWNER TO postgres;

--
-- Name: oc_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_comments (
    id bigint NOT NULL,
    parent_id bigint DEFAULT 0 NOT NULL,
    topmost_parent_id bigint DEFAULT 0 NOT NULL,
    children_count integer DEFAULT 0 NOT NULL,
    actor_type character varying(64) DEFAULT ''::character varying NOT NULL,
    actor_id character varying(64) DEFAULT ''::character varying NOT NULL,
    message text,
    verb character varying(64) DEFAULT NULL::character varying,
    creation_timestamp timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    latest_child_timestamp timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    object_type character varying(64) DEFAULT ''::character varying NOT NULL,
    object_id character varying(64) DEFAULT ''::character varying NOT NULL,
    reference_id character varying(64) DEFAULT NULL::character varying,
    reactions character varying(4000) DEFAULT NULL::character varying,
    expire_date timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    meta_data text DEFAULT ''::text
);


ALTER TABLE public.oc_comments OWNER TO postgres;

--
-- Name: oc_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_comments_id_seq OWNER TO postgres;

--
-- Name: oc_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_comments_id_seq OWNED BY public.oc_comments.id;


--
-- Name: oc_comments_read_markers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_comments_read_markers (
    user_id character varying(64) DEFAULT ''::character varying NOT NULL,
    object_type character varying(64) DEFAULT ''::character varying NOT NULL,
    object_id character varying(64) DEFAULT ''::character varying NOT NULL,
    marker_datetime timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.oc_comments_read_markers OWNER TO postgres;

--
-- Name: oc_dav_absence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_dav_absence (
    id integer NOT NULL,
    user_id character varying(64) NOT NULL,
    first_day character varying(10) NOT NULL,
    last_day character varying(10) NOT NULL,
    status character varying(100) NOT NULL,
    message text NOT NULL,
    replacement_user_id character varying(64) DEFAULT ''::character varying,
    replacement_user_display_name character varying(64) DEFAULT ''::character varying
);


ALTER TABLE public.oc_dav_absence OWNER TO postgres;

--
-- Name: oc_dav_absence_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_dav_absence_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_dav_absence_id_seq OWNER TO postgres;

--
-- Name: oc_dav_absence_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_dav_absence_id_seq OWNED BY public.oc_dav_absence.id;


--
-- Name: oc_dav_cal_proxy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_dav_cal_proxy (
    id bigint NOT NULL,
    owner_id character varying(64) NOT NULL,
    proxy_id character varying(64) NOT NULL,
    permissions integer
);


ALTER TABLE public.oc_dav_cal_proxy OWNER TO postgres;

--
-- Name: oc_dav_cal_proxy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_dav_cal_proxy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_dav_cal_proxy_id_seq OWNER TO postgres;

--
-- Name: oc_dav_cal_proxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_dav_cal_proxy_id_seq OWNED BY public.oc_dav_cal_proxy.id;


--
-- Name: oc_dav_shares; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_dav_shares (
    id bigint NOT NULL,
    principaluri character varying(255) DEFAULT NULL::character varying,
    type character varying(255) DEFAULT NULL::character varying,
    access smallint,
    resourceid bigint NOT NULL,
    publicuri character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_dav_shares OWNER TO postgres;

--
-- Name: oc_dav_shares_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_dav_shares_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_dav_shares_id_seq OWNER TO postgres;

--
-- Name: oc_dav_shares_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_dav_shares_id_seq OWNED BY public.oc_dav_shares.id;


--
-- Name: oc_direct_edit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_direct_edit (
    id bigint NOT NULL,
    editor_id character varying(64) NOT NULL,
    token character varying(64) NOT NULL,
    file_id bigint NOT NULL,
    user_id character varying(64) DEFAULT NULL::character varying,
    share_id bigint,
    "timestamp" bigint NOT NULL,
    accessed boolean DEFAULT false,
    file_path character varying(4000) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_direct_edit OWNER TO postgres;

--
-- Name: oc_direct_edit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_direct_edit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_direct_edit_id_seq OWNER TO postgres;

--
-- Name: oc_direct_edit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_direct_edit_id_seq OWNED BY public.oc_direct_edit.id;


--
-- Name: oc_directlink; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_directlink (
    id bigint NOT NULL,
    user_id character varying(64) DEFAULT NULL::character varying,
    file_id bigint NOT NULL,
    token character varying(60) DEFAULT NULL::character varying,
    expiration bigint NOT NULL
);


ALTER TABLE public.oc_directlink OWNER TO postgres;

--
-- Name: oc_directlink_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_directlink_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_directlink_id_seq OWNER TO postgres;

--
-- Name: oc_directlink_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_directlink_id_seq OWNED BY public.oc_directlink.id;


--
-- Name: oc_ex_apps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_apps (
    id bigint NOT NULL,
    appid character varying(32) NOT NULL,
    version character varying(32) NOT NULL,
    name character varying(64) NOT NULL,
    daemon_config_name character varying(64) DEFAULT '0'::character varying NOT NULL,
    port smallint NOT NULL,
    secret character varying(256) NOT NULL,
    status json NOT NULL,
    enabled smallint DEFAULT 0 NOT NULL,
    created_time bigint NOT NULL
);


ALTER TABLE public.oc_ex_apps OWNER TO postgres;

--
-- Name: oc_ex_apps_daemons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_apps_daemons (
    id bigint NOT NULL,
    name character varying(64) NOT NULL,
    display_name character varying(255) NOT NULL,
    accepts_deploy_id character varying(64) NOT NULL,
    protocol character varying(32) NOT NULL,
    host character varying(255) NOT NULL,
    deploy_config json NOT NULL
);


ALTER TABLE public.oc_ex_apps_daemons OWNER TO postgres;

--
-- Name: oc_ex_apps_daemons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_apps_daemons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_apps_daemons_id_seq OWNER TO postgres;

--
-- Name: oc_ex_apps_daemons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_apps_daemons_id_seq OWNED BY public.oc_ex_apps_daemons.id;


--
-- Name: oc_ex_apps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_apps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_apps_id_seq OWNER TO postgres;

--
-- Name: oc_ex_apps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_apps_id_seq OWNED BY public.oc_ex_apps.id;


--
-- Name: oc_ex_apps_routes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_apps_routes (
    id integer NOT NULL,
    appid character varying(32) NOT NULL,
    url character varying(512) NOT NULL,
    verb character varying(64) NOT NULL,
    access_level integer DEFAULT 0 NOT NULL,
    headers_to_exclude character varying(512) DEFAULT NULL::character varying,
    bruteforce_protection character varying(512) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_ex_apps_routes OWNER TO postgres;

--
-- Name: oc_ex_apps_routes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_apps_routes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_apps_routes_id_seq OWNER TO postgres;

--
-- Name: oc_ex_apps_routes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_apps_routes_id_seq OWNED BY public.oc_ex_apps_routes.id;


--
-- Name: oc_ex_event_handlers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_event_handlers (
    id bigint NOT NULL,
    appid character varying(32) NOT NULL,
    event_type character varying(32) NOT NULL,
    event_subtypes json NOT NULL,
    action_handler character varying(410) NOT NULL
);


ALTER TABLE public.oc_ex_event_handlers OWNER TO postgres;

--
-- Name: oc_ex_event_handlers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_event_handlers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_event_handlers_id_seq OWNER TO postgres;

--
-- Name: oc_ex_event_handlers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_event_handlers_id_seq OWNED BY public.oc_ex_event_handlers.id;


--
-- Name: oc_ex_occ_commands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_occ_commands (
    id bigint NOT NULL,
    appid character varying(32) NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(255) DEFAULT NULL::character varying,
    hidden smallint DEFAULT 0 NOT NULL,
    arguments json NOT NULL,
    options json NOT NULL,
    usages json NOT NULL,
    execute_handler character varying(410) NOT NULL
);


ALTER TABLE public.oc_ex_occ_commands OWNER TO postgres;

--
-- Name: oc_ex_occ_commands_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_occ_commands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_occ_commands_id_seq OWNER TO postgres;

--
-- Name: oc_ex_occ_commands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_occ_commands_id_seq OWNED BY public.oc_ex_occ_commands.id;


--
-- Name: oc_ex_settings_forms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_settings_forms (
    id bigint NOT NULL,
    appid character varying(32) NOT NULL,
    formid character varying(64) NOT NULL,
    scheme json NOT NULL
);


ALTER TABLE public.oc_ex_settings_forms OWNER TO postgres;

--
-- Name: oc_ex_settings_forms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_settings_forms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_settings_forms_id_seq OWNER TO postgres;

--
-- Name: oc_ex_settings_forms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_settings_forms_id_seq OWNED BY public.oc_ex_settings_forms.id;


--
-- Name: oc_ex_speech_to_text; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_speech_to_text (
    id bigint NOT NULL,
    appid character varying(32) NOT NULL,
    name character varying(64) NOT NULL,
    display_name character varying(64) NOT NULL,
    action_handler character varying(410) NOT NULL
);


ALTER TABLE public.oc_ex_speech_to_text OWNER TO postgres;

--
-- Name: oc_ex_speech_to_text_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_speech_to_text_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_speech_to_text_id_seq OWNER TO postgres;

--
-- Name: oc_ex_speech_to_text_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_speech_to_text_id_seq OWNED BY public.oc_ex_speech_to_text.id;


--
-- Name: oc_ex_speech_to_text_q; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_speech_to_text_q (
    id bigint NOT NULL,
    result text DEFAULT ''::text NOT NULL,
    error character varying(1024) DEFAULT ''::character varying NOT NULL,
    finished smallint DEFAULT 0 NOT NULL,
    created_time bigint NOT NULL
);


ALTER TABLE public.oc_ex_speech_to_text_q OWNER TO postgres;

--
-- Name: oc_ex_speech_to_text_q_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_speech_to_text_q_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_speech_to_text_q_id_seq OWNER TO postgres;

--
-- Name: oc_ex_speech_to_text_q_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_speech_to_text_q_id_seq OWNED BY public.oc_ex_speech_to_text_q.id;


--
-- Name: oc_ex_task_processing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_task_processing (
    id bigint NOT NULL,
    app_id character varying(32) NOT NULL,
    name character varying(64) NOT NULL,
    display_name character varying(64) NOT NULL,
    task_type character varying(64) NOT NULL,
    custom_task_type text,
    provider text NOT NULL
);


ALTER TABLE public.oc_ex_task_processing OWNER TO postgres;

--
-- Name: oc_ex_task_processing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_task_processing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_task_processing_id_seq OWNER TO postgres;

--
-- Name: oc_ex_task_processing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_task_processing_id_seq OWNED BY public.oc_ex_task_processing.id;


--
-- Name: oc_ex_text_processing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_text_processing (
    id bigint NOT NULL,
    appid character varying(32) NOT NULL,
    name character varying(64) NOT NULL,
    display_name character varying(64) NOT NULL,
    action_handler character varying(410) NOT NULL,
    task_type character varying(64) NOT NULL
);


ALTER TABLE public.oc_ex_text_processing OWNER TO postgres;

--
-- Name: oc_ex_text_processing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_text_processing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_text_processing_id_seq OWNER TO postgres;

--
-- Name: oc_ex_text_processing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_text_processing_id_seq OWNED BY public.oc_ex_text_processing.id;


--
-- Name: oc_ex_text_processing_q; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_text_processing_q (
    id bigint NOT NULL,
    result text DEFAULT ''::text NOT NULL,
    error character varying(1024) DEFAULT ''::character varying NOT NULL,
    finished smallint DEFAULT 0 NOT NULL,
    created_time bigint NOT NULL
);


ALTER TABLE public.oc_ex_text_processing_q OWNER TO postgres;

--
-- Name: oc_ex_text_processing_q_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_text_processing_q_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_text_processing_q_id_seq OWNER TO postgres;

--
-- Name: oc_ex_text_processing_q_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_text_processing_q_id_seq OWNED BY public.oc_ex_text_processing_q.id;


--
-- Name: oc_ex_translation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_translation (
    id bigint NOT NULL,
    appid character varying(32) NOT NULL,
    name character varying(64) NOT NULL,
    display_name character varying(64) NOT NULL,
    from_languages json NOT NULL,
    to_languages json NOT NULL,
    action_handler character varying(410) NOT NULL,
    action_detect_lang character varying(410) DEFAULT ''::character varying
);


ALTER TABLE public.oc_ex_translation OWNER TO postgres;

--
-- Name: oc_ex_translation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_translation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_translation_id_seq OWNER TO postgres;

--
-- Name: oc_ex_translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_translation_id_seq OWNED BY public.oc_ex_translation.id;


--
-- Name: oc_ex_translation_q; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_translation_q (
    id bigint NOT NULL,
    result text DEFAULT ''::text NOT NULL,
    error character varying(1024) DEFAULT ''::character varying NOT NULL,
    finished smallint DEFAULT 0 NOT NULL,
    created_time bigint NOT NULL
);


ALTER TABLE public.oc_ex_translation_q OWNER TO postgres;

--
-- Name: oc_ex_translation_q_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_translation_q_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_translation_q_id_seq OWNER TO postgres;

--
-- Name: oc_ex_translation_q_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_translation_q_id_seq OWNED BY public.oc_ex_translation_q.id;


--
-- Name: oc_ex_ui_files_actions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_ui_files_actions (
    id bigint NOT NULL,
    appid character varying(32) NOT NULL,
    name character varying(64) NOT NULL,
    display_name character varying(64) NOT NULL,
    mime text DEFAULT 'file'::text NOT NULL,
    permissions character varying(255) NOT NULL,
    "order" bigint DEFAULT 0 NOT NULL,
    icon character varying(255) DEFAULT ''::character varying,
    action_handler character varying(64) NOT NULL,
    version character varying(64) DEFAULT '1.0'::character varying NOT NULL
);


ALTER TABLE public.oc_ex_ui_files_actions OWNER TO postgres;

--
-- Name: oc_ex_ui_files_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_ui_files_actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_ui_files_actions_id_seq OWNER TO postgres;

--
-- Name: oc_ex_ui_files_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_ui_files_actions_id_seq OWNED BY public.oc_ex_ui_files_actions.id;


--
-- Name: oc_ex_ui_scripts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_ui_scripts (
    id bigint NOT NULL,
    appid character varying(32) NOT NULL,
    type character varying(16) NOT NULL,
    name character varying(32) NOT NULL,
    path character varying(410) NOT NULL,
    after_app_id character varying(32) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_ex_ui_scripts OWNER TO postgres;

--
-- Name: oc_ex_ui_scripts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_ui_scripts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_ui_scripts_id_seq OWNER TO postgres;

--
-- Name: oc_ex_ui_scripts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_ui_scripts_id_seq OWNED BY public.oc_ex_ui_scripts.id;


--
-- Name: oc_ex_ui_states; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_ui_states (
    id bigint NOT NULL,
    appid character varying(32) NOT NULL,
    type character varying(16) NOT NULL,
    name character varying(32) NOT NULL,
    key character varying(64) NOT NULL,
    value json NOT NULL
);


ALTER TABLE public.oc_ex_ui_states OWNER TO postgres;

--
-- Name: oc_ex_ui_states_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_ui_states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_ui_states_id_seq OWNER TO postgres;

--
-- Name: oc_ex_ui_states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_ui_states_id_seq OWNED BY public.oc_ex_ui_states.id;


--
-- Name: oc_ex_ui_styles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_ui_styles (
    id bigint NOT NULL,
    appid character varying(32) NOT NULL,
    type character varying(16) NOT NULL,
    name character varying(32) NOT NULL,
    path character varying(410) NOT NULL
);


ALTER TABLE public.oc_ex_ui_styles OWNER TO postgres;

--
-- Name: oc_ex_ui_styles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_ui_styles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_ui_styles_id_seq OWNER TO postgres;

--
-- Name: oc_ex_ui_styles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_ui_styles_id_seq OWNED BY public.oc_ex_ui_styles.id;


--
-- Name: oc_ex_ui_top_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ex_ui_top_menu (
    id bigint NOT NULL,
    appid character varying(32) NOT NULL,
    name character varying(32) NOT NULL,
    display_name character varying(32) NOT NULL,
    icon character varying(255) DEFAULT ''::character varying,
    admin_required smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_ex_ui_top_menu OWNER TO postgres;

--
-- Name: oc_ex_ui_top_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ex_ui_top_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ex_ui_top_menu_id_seq OWNER TO postgres;

--
-- Name: oc_ex_ui_top_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ex_ui_top_menu_id_seq OWNED BY public.oc_ex_ui_top_menu.id;


--
-- Name: oc_federated_reshares; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_federated_reshares (
    share_id bigint NOT NULL,
    remote_id character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.oc_federated_reshares OWNER TO postgres;

--
-- Name: oc_file_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_file_locks (
    id bigint NOT NULL,
    lock integer DEFAULT 0 NOT NULL,
    key character varying(64) NOT NULL,
    ttl integer DEFAULT '-1'::integer NOT NULL
);


ALTER TABLE public.oc_file_locks OWNER TO postgres;

--
-- Name: oc_file_locks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_file_locks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_file_locks_id_seq OWNER TO postgres;

--
-- Name: oc_file_locks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_file_locks_id_seq OWNED BY public.oc_file_locks.id;


--
-- Name: oc_filecache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_filecache (
    fileid bigint NOT NULL,
    storage bigint DEFAULT 0 NOT NULL,
    path character varying(4000) DEFAULT NULL::character varying,
    path_hash character varying(32) DEFAULT ''::character varying NOT NULL,
    parent bigint DEFAULT 0 NOT NULL,
    name character varying(250) DEFAULT NULL::character varying,
    mimetype bigint DEFAULT 0 NOT NULL,
    mimepart bigint DEFAULT 0 NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    mtime bigint DEFAULT 0 NOT NULL,
    storage_mtime bigint DEFAULT 0 NOT NULL,
    encrypted integer DEFAULT 0 NOT NULL,
    unencrypted_size bigint DEFAULT 0 NOT NULL,
    etag character varying(40) DEFAULT NULL::character varying,
    permissions integer DEFAULT 0,
    checksum character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_filecache OWNER TO postgres;

--
-- Name: oc_filecache_extended; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_filecache_extended (
    fileid bigint NOT NULL,
    metadata_etag character varying(40) DEFAULT NULL::character varying,
    creation_time bigint DEFAULT 0 NOT NULL,
    upload_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_filecache_extended OWNER TO postgres;

--
-- Name: oc_filecache_fileid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_filecache_fileid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_filecache_fileid_seq OWNER TO postgres;

--
-- Name: oc_filecache_fileid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_filecache_fileid_seq OWNED BY public.oc_filecache.fileid;


--
-- Name: oc_files_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_files_metadata (
    id bigint NOT NULL,
    file_id bigint NOT NULL,
    json text NOT NULL,
    sync_token character varying(15) NOT NULL,
    last_update timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.oc_files_metadata OWNER TO postgres;

--
-- Name: oc_files_metadata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_files_metadata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_files_metadata_id_seq OWNER TO postgres;

--
-- Name: oc_files_metadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_files_metadata_id_seq OWNED BY public.oc_files_metadata.id;


--
-- Name: oc_files_metadata_index; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_files_metadata_index (
    id bigint NOT NULL,
    file_id bigint NOT NULL,
    meta_key character varying(31) DEFAULT NULL::character varying,
    meta_value_string character varying(63) DEFAULT NULL::character varying,
    meta_value_int bigint
);


ALTER TABLE public.oc_files_metadata_index OWNER TO postgres;

--
-- Name: oc_files_metadata_index_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_files_metadata_index_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_files_metadata_index_id_seq OWNER TO postgres;

--
-- Name: oc_files_metadata_index_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_files_metadata_index_id_seq OWNED BY public.oc_files_metadata_index.id;


--
-- Name: oc_files_reminders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_files_reminders (
    id bigint NOT NULL,
    user_id character varying(64) NOT NULL,
    file_id bigint NOT NULL,
    due_date timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    notified boolean DEFAULT false
);


ALTER TABLE public.oc_files_reminders OWNER TO postgres;

--
-- Name: oc_files_reminders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_files_reminders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_files_reminders_id_seq OWNER TO postgres;

--
-- Name: oc_files_reminders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_files_reminders_id_seq OWNED BY public.oc_files_reminders.id;


--
-- Name: oc_files_trash; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_files_trash (
    auto_id bigint NOT NULL,
    id character varying(250) DEFAULT ''::character varying NOT NULL,
    "user" character varying(64) DEFAULT ''::character varying NOT NULL,
    "timestamp" character varying(12) DEFAULT ''::character varying NOT NULL,
    location character varying(512) DEFAULT ''::character varying NOT NULL,
    type character varying(4) DEFAULT NULL::character varying,
    mime character varying(255) DEFAULT NULL::character varying,
    deleted_by character varying(64) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_files_trash OWNER TO postgres;

--
-- Name: oc_files_trash_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_files_trash_auto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_files_trash_auto_id_seq OWNER TO postgres;

--
-- Name: oc_files_trash_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_files_trash_auto_id_seq OWNED BY public.oc_files_trash.auto_id;


--
-- Name: oc_files_versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_files_versions (
    id bigint NOT NULL,
    file_id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    size bigint NOT NULL,
    mimetype bigint NOT NULL,
    metadata json NOT NULL
);


ALTER TABLE public.oc_files_versions OWNER TO postgres;

--
-- Name: oc_files_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_files_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_files_versions_id_seq OWNER TO postgres;

--
-- Name: oc_files_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_files_versions_id_seq OWNED BY public.oc_files_versions.id;


--
-- Name: oc_flow_checks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_flow_checks (
    id integer NOT NULL,
    class character varying(256) DEFAULT ''::character varying NOT NULL,
    operator character varying(16) DEFAULT ''::character varying NOT NULL,
    value text,
    hash character varying(32) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_flow_checks OWNER TO postgres;

--
-- Name: oc_flow_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_flow_checks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_flow_checks_id_seq OWNER TO postgres;

--
-- Name: oc_flow_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_flow_checks_id_seq OWNED BY public.oc_flow_checks.id;


--
-- Name: oc_flow_operations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_flow_operations (
    id integer NOT NULL,
    class character varying(256) DEFAULT ''::character varying NOT NULL,
    name character varying(256) DEFAULT ''::character varying,
    checks text,
    operation text,
    entity character varying(256) DEFAULT 'OCA\WorkflowEngine\Entity\File'::character varying NOT NULL,
    events text DEFAULT '[]'::text NOT NULL
);


ALTER TABLE public.oc_flow_operations OWNER TO postgres;

--
-- Name: oc_flow_operations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_flow_operations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_flow_operations_id_seq OWNER TO postgres;

--
-- Name: oc_flow_operations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_flow_operations_id_seq OWNED BY public.oc_flow_operations.id;


--
-- Name: oc_flow_operations_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_flow_operations_scope (
    id bigint NOT NULL,
    operation_id integer DEFAULT 0 NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    value character varying(64) DEFAULT ''::character varying
);


ALTER TABLE public.oc_flow_operations_scope OWNER TO postgres;

--
-- Name: oc_flow_operations_scope_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_flow_operations_scope_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_flow_operations_scope_id_seq OWNER TO postgres;

--
-- Name: oc_flow_operations_scope_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_flow_operations_scope_id_seq OWNED BY public.oc_flow_operations_scope.id;


--
-- Name: oc_group_admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_group_admin (
    gid character varying(64) DEFAULT ''::character varying NOT NULL,
    uid character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_group_admin OWNER TO postgres;

--
-- Name: oc_group_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_group_user (
    gid character varying(64) DEFAULT ''::character varying NOT NULL,
    uid character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_group_user OWNER TO postgres;

--
-- Name: oc_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_groups (
    gid character varying(64) DEFAULT ''::character varying NOT NULL,
    displayname character varying(255) DEFAULT 'name'::character varying NOT NULL
);


ALTER TABLE public.oc_groups OWNER TO postgres;

--
-- Name: oc_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_jobs (
    id bigint NOT NULL,
    class character varying(255) DEFAULT ''::character varying NOT NULL,
    argument character varying(4000) DEFAULT ''::character varying NOT NULL,
    last_run integer DEFAULT 0,
    last_checked integer DEFAULT 0,
    reserved_at integer DEFAULT 0,
    execution_duration integer DEFAULT 0,
    argument_hash character varying(64) DEFAULT NULL::character varying,
    time_sensitive smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.oc_jobs OWNER TO postgres;

--
-- Name: oc_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_jobs_id_seq OWNER TO postgres;

--
-- Name: oc_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_jobs_id_seq OWNED BY public.oc_jobs.id;


--
-- Name: oc_known_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_known_users (
    id bigint NOT NULL,
    known_to character varying(255) NOT NULL,
    known_user character varying(255) NOT NULL
);


ALTER TABLE public.oc_known_users OWNER TO postgres;

--
-- Name: oc_known_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_known_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_known_users_id_seq OWNER TO postgres;

--
-- Name: oc_known_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_known_users_id_seq OWNED BY public.oc_known_users.id;


--
-- Name: oc_login_flow_v2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_login_flow_v2 (
    id bigint NOT NULL,
    "timestamp" bigint NOT NULL,
    started smallint DEFAULT 0 NOT NULL,
    poll_token character varying(255) NOT NULL,
    login_token character varying(255) NOT NULL,
    public_key text NOT NULL,
    private_key text NOT NULL,
    client_name character varying(255) NOT NULL,
    login_name character varying(255) DEFAULT NULL::character varying,
    server character varying(255) DEFAULT NULL::character varying,
    app_password character varying(1024) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_login_flow_v2 OWNER TO postgres;

--
-- Name: oc_login_flow_v2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_login_flow_v2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_login_flow_v2_id_seq OWNER TO postgres;

--
-- Name: oc_login_flow_v2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_login_flow_v2_id_seq OWNED BY public.oc_login_flow_v2.id;


--
-- Name: oc_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_migrations (
    app character varying(255) NOT NULL,
    version character varying(255) NOT NULL
);


ALTER TABLE public.oc_migrations OWNER TO postgres;

--
-- Name: oc_mimetypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_mimetypes (
    id bigint NOT NULL,
    mimetype character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_mimetypes OWNER TO postgres;

--
-- Name: oc_mimetypes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_mimetypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_mimetypes_id_seq OWNER TO postgres;

--
-- Name: oc_mimetypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_mimetypes_id_seq OWNED BY public.oc_mimetypes.id;


--
-- Name: oc_mounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_mounts (
    id bigint NOT NULL,
    storage_id bigint NOT NULL,
    root_id bigint NOT NULL,
    user_id character varying(64) NOT NULL,
    mount_point character varying(4000) NOT NULL,
    mount_id bigint,
    mount_provider_class character varying(128) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_mounts OWNER TO postgres;

--
-- Name: oc_mounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_mounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_mounts_id_seq OWNER TO postgres;

--
-- Name: oc_mounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_mounts_id_seq OWNED BY public.oc_mounts.id;


--
-- Name: oc_notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_notifications (
    notification_id integer NOT NULL,
    app character varying(32) NOT NULL,
    "user" character varying(64) NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL,
    object_type character varying(64) NOT NULL,
    object_id character varying(64) NOT NULL,
    subject character varying(64) NOT NULL,
    subject_parameters text,
    message character varying(64) DEFAULT NULL::character varying,
    message_parameters text,
    link character varying(4000) DEFAULT NULL::character varying,
    icon character varying(4000) DEFAULT NULL::character varying,
    actions text
);


ALTER TABLE public.oc_notifications OWNER TO postgres;

--
-- Name: oc_notifications_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_notifications_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_notifications_notification_id_seq OWNER TO postgres;

--
-- Name: oc_notifications_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_notifications_notification_id_seq OWNED BY public.oc_notifications.notification_id;


--
-- Name: oc_notifications_pushhash; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_notifications_pushhash (
    id integer NOT NULL,
    uid character varying(64) NOT NULL,
    token integer DEFAULT 0 NOT NULL,
    deviceidentifier character varying(128) NOT NULL,
    devicepublickey character varying(512) NOT NULL,
    devicepublickeyhash character varying(128) NOT NULL,
    pushtokenhash character varying(128) NOT NULL,
    proxyserver character varying(256) NOT NULL,
    apptype character varying(32) DEFAULT 'unknown'::character varying NOT NULL
);


ALTER TABLE public.oc_notifications_pushhash OWNER TO postgres;

--
-- Name: oc_notifications_pushhash_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_notifications_pushhash_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_notifications_pushhash_id_seq OWNER TO postgres;

--
-- Name: oc_notifications_pushhash_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_notifications_pushhash_id_seq OWNED BY public.oc_notifications_pushhash.id;


--
-- Name: oc_notifications_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_notifications_settings (
    id bigint NOT NULL,
    user_id character varying(64) NOT NULL,
    batch_time integer DEFAULT 0 NOT NULL,
    last_send_id bigint DEFAULT 0 NOT NULL,
    next_send_time integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_notifications_settings OWNER TO postgres;

--
-- Name: oc_notifications_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_notifications_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_notifications_settings_id_seq OWNER TO postgres;

--
-- Name: oc_notifications_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_notifications_settings_id_seq OWNED BY public.oc_notifications_settings.id;


--
-- Name: oc_oauth2_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_oauth2_access_tokens (
    id integer NOT NULL,
    token_id integer NOT NULL,
    client_id integer NOT NULL,
    hashed_code character varying(128) NOT NULL,
    encrypted_token character varying(786) NOT NULL,
    code_created_at bigint DEFAULT 0 NOT NULL,
    token_count bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_oauth2_access_tokens OWNER TO postgres;

--
-- Name: oc_oauth2_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_oauth2_access_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_oauth2_access_tokens_id_seq OWNER TO postgres;

--
-- Name: oc_oauth2_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_oauth2_access_tokens_id_seq OWNED BY public.oc_oauth2_access_tokens.id;


--
-- Name: oc_oauth2_clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_oauth2_clients (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    redirect_uri character varying(2000) NOT NULL,
    client_identifier character varying(64) NOT NULL,
    secret character varying(512) NOT NULL
);


ALTER TABLE public.oc_oauth2_clients OWNER TO postgres;

--
-- Name: oc_oauth2_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_oauth2_clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_oauth2_clients_id_seq OWNER TO postgres;

--
-- Name: oc_oauth2_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_oauth2_clients_id_seq OWNED BY public.oc_oauth2_clients.id;


--
-- Name: oc_open_local_editor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_open_local_editor (
    id bigint NOT NULL,
    user_id character varying(64) NOT NULL,
    path_hash character varying(64) NOT NULL,
    expiration_time bigint NOT NULL,
    token character varying(128) NOT NULL
);


ALTER TABLE public.oc_open_local_editor OWNER TO postgres;

--
-- Name: oc_open_local_editor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_open_local_editor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_open_local_editor_id_seq OWNER TO postgres;

--
-- Name: oc_open_local_editor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_open_local_editor_id_seq OWNED BY public.oc_open_local_editor.id;


--
-- Name: oc_photos_albums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_photos_albums (
    album_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    "user" character varying(255) NOT NULL,
    created bigint NOT NULL,
    location character varying(255) NOT NULL,
    last_added_photo bigint NOT NULL
);


ALTER TABLE public.oc_photos_albums OWNER TO postgres;

--
-- Name: oc_photos_albums_album_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_photos_albums_album_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_photos_albums_album_id_seq OWNER TO postgres;

--
-- Name: oc_photos_albums_album_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_photos_albums_album_id_seq OWNED BY public.oc_photos_albums.album_id;


--
-- Name: oc_photos_albums_collabs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_photos_albums_collabs (
    id bigint NOT NULL,
    album_id bigint NOT NULL,
    collaborator_id character varying(64) NOT NULL,
    collaborator_type integer NOT NULL
);


ALTER TABLE public.oc_photos_albums_collabs OWNER TO postgres;

--
-- Name: oc_photos_albums_collabs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_photos_albums_collabs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_photos_albums_collabs_id_seq OWNER TO postgres;

--
-- Name: oc_photos_albums_collabs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_photos_albums_collabs_id_seq OWNED BY public.oc_photos_albums_collabs.id;


--
-- Name: oc_photos_albums_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_photos_albums_files (
    album_file_id bigint NOT NULL,
    album_id bigint NOT NULL,
    file_id bigint NOT NULL,
    added bigint NOT NULL,
    owner character varying(64) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_photos_albums_files OWNER TO postgres;

--
-- Name: oc_photos_albums_files_album_file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_photos_albums_files_album_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_photos_albums_files_album_file_id_seq OWNER TO postgres;

--
-- Name: oc_photos_albums_files_album_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_photos_albums_files_album_file_id_seq OWNED BY public.oc_photos_albums_files.album_file_id;


--
-- Name: oc_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_preferences (
    userid character varying(64) DEFAULT ''::character varying NOT NULL,
    appid character varying(32) DEFAULT ''::character varying NOT NULL,
    configkey character varying(64) DEFAULT ''::character varying NOT NULL,
    configvalue text
);


ALTER TABLE public.oc_preferences OWNER TO postgres;

--
-- Name: oc_preferences_ex; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_preferences_ex (
    id bigint NOT NULL,
    userid character varying(64) NOT NULL,
    appid character varying(32) NOT NULL,
    configkey character varying(64) NOT NULL,
    configvalue text
);


ALTER TABLE public.oc_preferences_ex OWNER TO postgres;

--
-- Name: oc_preferences_ex_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_preferences_ex_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_preferences_ex_id_seq OWNER TO postgres;

--
-- Name: oc_preferences_ex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_preferences_ex_id_seq OWNED BY public.oc_preferences_ex.id;


--
-- Name: oc_privacy_admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_privacy_admins (
    id integer NOT NULL,
    displayname character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_privacy_admins OWNER TO postgres;

--
-- Name: oc_privacy_admins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_privacy_admins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_privacy_admins_id_seq OWNER TO postgres;

--
-- Name: oc_privacy_admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_privacy_admins_id_seq OWNED BY public.oc_privacy_admins.id;


--
-- Name: oc_profile_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_profile_config (
    id bigint NOT NULL,
    user_id character varying(64) NOT NULL,
    config text NOT NULL
);


ALTER TABLE public.oc_profile_config OWNER TO postgres;

--
-- Name: oc_profile_config_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_profile_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_profile_config_id_seq OWNER TO postgres;

--
-- Name: oc_profile_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_profile_config_id_seq OWNED BY public.oc_profile_config.id;


--
-- Name: oc_properties; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_properties (
    id bigint NOT NULL,
    userid character varying(64) DEFAULT ''::character varying NOT NULL,
    propertypath character varying(255) DEFAULT ''::character varying NOT NULL,
    propertyname character varying(255) DEFAULT ''::character varying NOT NULL,
    propertyvalue text NOT NULL,
    valuetype smallint DEFAULT 1
);


ALTER TABLE public.oc_properties OWNER TO postgres;

--
-- Name: oc_properties_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_properties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_properties_id_seq OWNER TO postgres;

--
-- Name: oc_properties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_properties_id_seq OWNED BY public.oc_properties.id;


--
-- Name: oc_ratelimit_entries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_ratelimit_entries (
    id bigint NOT NULL,
    hash character varying(128) NOT NULL,
    delete_after timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.oc_ratelimit_entries OWNER TO postgres;

--
-- Name: oc_ratelimit_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_ratelimit_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_ratelimit_entries_id_seq OWNER TO postgres;

--
-- Name: oc_ratelimit_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_ratelimit_entries_id_seq OWNED BY public.oc_ratelimit_entries.id;


--
-- Name: oc_reactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_reactions (
    id bigint NOT NULL,
    parent_id bigint NOT NULL,
    message_id bigint NOT NULL,
    actor_type character varying(64) DEFAULT ''::character varying NOT NULL,
    actor_id character varying(64) DEFAULT ''::character varying NOT NULL,
    reaction character varying(32) NOT NULL
);


ALTER TABLE public.oc_reactions OWNER TO postgres;

--
-- Name: oc_reactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_reactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_reactions_id_seq OWNER TO postgres;

--
-- Name: oc_reactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_reactions_id_seq OWNED BY public.oc_reactions.id;


--
-- Name: oc_recent_contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_recent_contact (
    id integer NOT NULL,
    actor_uid character varying(64) NOT NULL,
    uid character varying(64) DEFAULT NULL::character varying,
    email character varying(255) DEFAULT NULL::character varying,
    federated_cloud_id character varying(255) DEFAULT NULL::character varying,
    card bytea NOT NULL,
    last_contact integer NOT NULL
);


ALTER TABLE public.oc_recent_contact OWNER TO postgres;

--
-- Name: oc_recent_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_recent_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_recent_contact_id_seq OWNER TO postgres;

--
-- Name: oc_recent_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_recent_contact_id_seq OWNED BY public.oc_recent_contact.id;


--
-- Name: oc_schedulingobjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_schedulingobjects (
    id bigint NOT NULL,
    principaluri character varying(255) DEFAULT NULL::character varying,
    calendardata bytea,
    uri character varying(255) DEFAULT NULL::character varying,
    lastmodified integer,
    etag character varying(32) DEFAULT NULL::character varying,
    size bigint NOT NULL
);


ALTER TABLE public.oc_schedulingobjects OWNER TO postgres;

--
-- Name: oc_schedulingobjects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_schedulingobjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_schedulingobjects_id_seq OWNER TO postgres;

--
-- Name: oc_schedulingobjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_schedulingobjects_id_seq OWNED BY public.oc_schedulingobjects.id;


--
-- Name: oc_share; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_share (
    id bigint NOT NULL,
    share_type smallint DEFAULT 0 NOT NULL,
    share_with character varying(255) DEFAULT NULL::character varying,
    password character varying(255) DEFAULT NULL::character varying,
    uid_owner character varying(64) DEFAULT ''::character varying NOT NULL,
    uid_initiator character varying(64) DEFAULT NULL::character varying,
    parent bigint,
    item_type character varying(64) DEFAULT ''::character varying NOT NULL,
    item_source character varying(255) DEFAULT NULL::character varying,
    item_target character varying(255) DEFAULT NULL::character varying,
    file_source bigint,
    file_target character varying(512) DEFAULT NULL::character varying,
    permissions smallint DEFAULT 0 NOT NULL,
    stime bigint DEFAULT 0 NOT NULL,
    accepted smallint DEFAULT 0 NOT NULL,
    expiration timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    token character varying(32) DEFAULT NULL::character varying,
    mail_send smallint DEFAULT 0 NOT NULL,
    share_name character varying(64) DEFAULT NULL::character varying,
    password_by_talk boolean DEFAULT false,
    note text,
    hide_download smallint DEFAULT 0,
    label character varying(255) DEFAULT NULL::character varying,
    attributes json,
    password_expiration_time timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.oc_share OWNER TO postgres;

--
-- Name: oc_share_external; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_share_external (
    id bigint NOT NULL,
    parent bigint DEFAULT '-1'::integer,
    share_type integer,
    remote character varying(512) NOT NULL,
    remote_id character varying(255) DEFAULT ''::character varying,
    share_token character varying(64) NOT NULL,
    password character varying(64) DEFAULT NULL::character varying,
    name character varying(4000) NOT NULL,
    owner character varying(64) NOT NULL,
    "user" character varying(64) NOT NULL,
    mountpoint character varying(4000) NOT NULL,
    mountpoint_hash character varying(32) NOT NULL,
    accepted integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_share_external OWNER TO postgres;

--
-- Name: oc_share_external_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_share_external_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_share_external_id_seq OWNER TO postgres;

--
-- Name: oc_share_external_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_share_external_id_seq OWNED BY public.oc_share_external.id;


--
-- Name: oc_share_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_share_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_share_id_seq OWNER TO postgres;

--
-- Name: oc_share_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_share_id_seq OWNED BY public.oc_share.id;


--
-- Name: oc_shares_limits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_shares_limits (
    id character varying(32) NOT NULL,
    "limit" bigint NOT NULL,
    downloads bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_shares_limits OWNER TO postgres;

--
-- Name: oc_storages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_storages (
    numeric_id bigint NOT NULL,
    id character varying(64) DEFAULT NULL::character varying,
    available integer DEFAULT 1 NOT NULL,
    last_checked integer
);


ALTER TABLE public.oc_storages OWNER TO postgres;

--
-- Name: oc_storages_credentials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_storages_credentials (
    id bigint NOT NULL,
    "user" character varying(64) DEFAULT NULL::character varying,
    identifier character varying(64) NOT NULL,
    credentials text
);


ALTER TABLE public.oc_storages_credentials OWNER TO postgres;

--
-- Name: oc_storages_credentials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_storages_credentials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_storages_credentials_id_seq OWNER TO postgres;

--
-- Name: oc_storages_credentials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_storages_credentials_id_seq OWNED BY public.oc_storages_credentials.id;


--
-- Name: oc_storages_numeric_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_storages_numeric_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_storages_numeric_id_seq OWNER TO postgres;

--
-- Name: oc_storages_numeric_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_storages_numeric_id_seq OWNED BY public.oc_storages.numeric_id;


--
-- Name: oc_systemtag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_systemtag (
    id bigint NOT NULL,
    name character varying(64) DEFAULT ''::character varying NOT NULL,
    visibility smallint DEFAULT 1 NOT NULL,
    editable smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.oc_systemtag OWNER TO postgres;

--
-- Name: oc_systemtag_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_systemtag_group (
    systemtagid bigint DEFAULT 0 NOT NULL,
    gid character varying(255) NOT NULL
);


ALTER TABLE public.oc_systemtag_group OWNER TO postgres;

--
-- Name: oc_systemtag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_systemtag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_systemtag_id_seq OWNER TO postgres;

--
-- Name: oc_systemtag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_systemtag_id_seq OWNED BY public.oc_systemtag.id;


--
-- Name: oc_systemtag_object_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_systemtag_object_mapping (
    objectid character varying(64) DEFAULT ''::character varying NOT NULL,
    objecttype character varying(64) DEFAULT ''::character varying NOT NULL,
    systemtagid bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_systemtag_object_mapping OWNER TO postgres;

--
-- Name: oc_taskprocessing_tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_taskprocessing_tasks (
    id bigint NOT NULL,
    type character varying(255) NOT NULL,
    input text NOT NULL,
    output text,
    status integer DEFAULT 0,
    user_id character varying(64) DEFAULT NULL::character varying,
    app_id character varying(32) DEFAULT ''::character varying NOT NULL,
    custom_id character varying(255) DEFAULT ''::character varying,
    last_updated integer DEFAULT 0,
    completion_expected_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    progress double precision DEFAULT '0'::double precision,
    error_message character varying(4000) DEFAULT NULL::character varying,
    scheduled_at integer,
    started_at integer,
    ended_at integer,
    webhook_uri character varying(4000) DEFAULT NULL::character varying,
    webhook_method character varying(64) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_taskprocessing_tasks OWNER TO postgres;

--
-- Name: oc_taskprocessing_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_taskprocessing_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_taskprocessing_tasks_id_seq OWNER TO postgres;

--
-- Name: oc_taskprocessing_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_taskprocessing_tasks_id_seq OWNED BY public.oc_taskprocessing_tasks.id;


--
-- Name: oc_text2image_tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_text2image_tasks (
    id bigint NOT NULL,
    input text NOT NULL,
    status integer DEFAULT 0,
    number_of_images integer DEFAULT 1 NOT NULL,
    user_id character varying(64) DEFAULT NULL::character varying,
    app_id character varying(32) DEFAULT ''::character varying NOT NULL,
    identifier character varying(255) DEFAULT ''::character varying,
    last_updated timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    completion_expected_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.oc_text2image_tasks OWNER TO postgres;

--
-- Name: oc_text2image_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_text2image_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_text2image_tasks_id_seq OWNER TO postgres;

--
-- Name: oc_text2image_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_text2image_tasks_id_seq OWNED BY public.oc_text2image_tasks.id;


--
-- Name: oc_text_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_text_documents (
    id bigint NOT NULL,
    current_version bigint DEFAULT 0,
    last_saved_version bigint DEFAULT 0,
    last_saved_version_time bigint NOT NULL,
    last_saved_version_etag character varying(64) DEFAULT ''::character varying,
    base_version_etag character varying(64) DEFAULT ''::character varying
);


ALTER TABLE public.oc_text_documents OWNER TO postgres;

--
-- Name: oc_text_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_text_sessions (
    id bigint NOT NULL,
    user_id character varying(64) DEFAULT NULL::character varying,
    guest_name character varying(64) DEFAULT NULL::character varying,
    color character varying(7) DEFAULT NULL::character varying,
    token character varying(64) NOT NULL,
    document_id bigint NOT NULL,
    last_contact bigint NOT NULL,
    last_awareness_message text DEFAULT ''::text
);


ALTER TABLE public.oc_text_sessions OWNER TO postgres;

--
-- Name: oc_text_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_text_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_text_sessions_id_seq OWNER TO postgres;

--
-- Name: oc_text_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_text_sessions_id_seq OWNED BY public.oc_text_sessions.id;


--
-- Name: oc_text_steps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_text_steps (
    id bigint NOT NULL,
    document_id bigint NOT NULL,
    session_id bigint NOT NULL,
    data text NOT NULL,
    version bigint DEFAULT 0,
    "timestamp" bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_text_steps OWNER TO postgres;

--
-- Name: oc_text_steps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_text_steps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_text_steps_id_seq OWNER TO postgres;

--
-- Name: oc_text_steps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_text_steps_id_seq OWNED BY public.oc_text_steps.id;


--
-- Name: oc_textprocessing_tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_textprocessing_tasks (
    id bigint NOT NULL,
    type character varying(255) NOT NULL,
    input text NOT NULL,
    output text,
    status integer DEFAULT 0,
    user_id character varying(64) DEFAULT NULL::character varying,
    app_id character varying(32) DEFAULT ''::character varying NOT NULL,
    identifier character varying(255) DEFAULT ''::character varying NOT NULL,
    last_updated integer DEFAULT 0,
    completion_expected_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.oc_textprocessing_tasks OWNER TO postgres;

--
-- Name: oc_textprocessing_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_textprocessing_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_textprocessing_tasks_id_seq OWNER TO postgres;

--
-- Name: oc_textprocessing_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_textprocessing_tasks_id_seq OWNED BY public.oc_textprocessing_tasks.id;


--
-- Name: oc_trusted_servers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_trusted_servers (
    id integer NOT NULL,
    url character varying(512) NOT NULL,
    url_hash character varying(255) DEFAULT ''::character varying NOT NULL,
    token character varying(128) DEFAULT NULL::character varying,
    shared_secret character varying(256) DEFAULT NULL::character varying,
    status integer DEFAULT 2 NOT NULL,
    sync_token character varying(512) DEFAULT NULL::character varying
);


ALTER TABLE public.oc_trusted_servers OWNER TO postgres;

--
-- Name: oc_trusted_servers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_trusted_servers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_trusted_servers_id_seq OWNER TO postgres;

--
-- Name: oc_trusted_servers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_trusted_servers_id_seq OWNED BY public.oc_trusted_servers.id;


--
-- Name: oc_twofactor_backupcodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_twofactor_backupcodes (
    id bigint NOT NULL,
    user_id character varying(64) DEFAULT ''::character varying NOT NULL,
    code character varying(128) NOT NULL,
    used smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_twofactor_backupcodes OWNER TO postgres;

--
-- Name: oc_twofactor_backupcodes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_twofactor_backupcodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_twofactor_backupcodes_id_seq OWNER TO postgres;

--
-- Name: oc_twofactor_backupcodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_twofactor_backupcodes_id_seq OWNED BY public.oc_twofactor_backupcodes.id;


--
-- Name: oc_twofactor_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_twofactor_providers (
    provider_id character varying(32) NOT NULL,
    uid character varying(64) NOT NULL,
    enabled smallint NOT NULL
);


ALTER TABLE public.oc_twofactor_providers OWNER TO postgres;

--
-- Name: oc_user_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_user_status (
    id bigint NOT NULL,
    user_id character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    status_timestamp integer NOT NULL,
    is_user_defined boolean,
    message_id character varying(255) DEFAULT NULL::character varying,
    custom_icon character varying(255) DEFAULT NULL::character varying,
    custom_message text,
    clear_at integer,
    is_backup boolean DEFAULT false,
    status_message_timestamp integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.oc_user_status OWNER TO postgres;

--
-- Name: oc_user_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_user_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_user_status_id_seq OWNER TO postgres;

--
-- Name: oc_user_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_user_status_id_seq OWNED BY public.oc_user_status.id;


--
-- Name: oc_user_transfer_owner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_user_transfer_owner (
    id bigint NOT NULL,
    source_user character varying(64) NOT NULL,
    target_user character varying(64) NOT NULL,
    file_id bigint NOT NULL,
    node_name character varying(255) NOT NULL
);


ALTER TABLE public.oc_user_transfer_owner OWNER TO postgres;

--
-- Name: oc_user_transfer_owner_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_user_transfer_owner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_user_transfer_owner_id_seq OWNER TO postgres;

--
-- Name: oc_user_transfer_owner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_user_transfer_owner_id_seq OWNED BY public.oc_user_transfer_owner.id;


--
-- Name: oc_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_users (
    uid character varying(64) DEFAULT ''::character varying NOT NULL,
    displayname character varying(64) DEFAULT NULL::character varying,
    password character varying(255) DEFAULT ''::character varying NOT NULL,
    uid_lower character varying(64) DEFAULT ''::character varying
);


ALTER TABLE public.oc_users OWNER TO postgres;

--
-- Name: oc_vcategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_vcategory (
    id bigint NOT NULL,
    uid character varying(64) DEFAULT ''::character varying NOT NULL,
    type character varying(64) DEFAULT ''::character varying NOT NULL,
    category character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_vcategory OWNER TO postgres;

--
-- Name: oc_vcategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_vcategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_vcategory_id_seq OWNER TO postgres;

--
-- Name: oc_vcategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_vcategory_id_seq OWNED BY public.oc_vcategory.id;


--
-- Name: oc_vcategory_to_object; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_vcategory_to_object (
    objid bigint DEFAULT 0 NOT NULL,
    categoryid bigint DEFAULT 0 NOT NULL,
    type character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oc_vcategory_to_object OWNER TO postgres;

--
-- Name: oc_webauthn; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_webauthn (
    id integer NOT NULL,
    uid character varying(64) NOT NULL,
    name character varying(64) NOT NULL,
    public_key_credential_id character varying(512) NOT NULL,
    data text NOT NULL,
    user_verification boolean DEFAULT false
);


ALTER TABLE public.oc_webauthn OWNER TO postgres;

--
-- Name: oc_webauthn_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_webauthn_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_webauthn_id_seq OWNER TO postgres;

--
-- Name: oc_webauthn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_webauthn_id_seq OWNED BY public.oc_webauthn.id;


--
-- Name: oc_webhook_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_webhook_listeners (
    id bigint NOT NULL,
    app_id character varying(64) DEFAULT NULL::character varying,
    user_id character varying(64) DEFAULT NULL::character varying,
    http_method character varying(32) NOT NULL,
    uri character varying(4000) NOT NULL,
    event character varying(4000) NOT NULL,
    event_filter text,
    user_id_filter character varying(64) DEFAULT NULL::character varying,
    headers text,
    auth_method character varying(16) DEFAULT ''::character varying NOT NULL,
    auth_data text
);


ALTER TABLE public.oc_webhook_listeners OWNER TO postgres;

--
-- Name: oc_webhook_listeners_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_webhook_listeners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_webhook_listeners_id_seq OWNER TO postgres;

--
-- Name: oc_webhook_listeners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_webhook_listeners_id_seq OWNED BY public.oc_webhook_listeners.id;


--
-- Name: oc_whats_new; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oc_whats_new (
    id integer NOT NULL,
    version character varying(64) DEFAULT '11'::character varying NOT NULL,
    etag character varying(64) DEFAULT ''::character varying NOT NULL,
    last_check integer DEFAULT 0 NOT NULL,
    data text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.oc_whats_new OWNER TO postgres;

--
-- Name: oc_whats_new_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oc_whats_new_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oc_whats_new_id_seq OWNER TO postgres;

--
-- Name: oc_whats_new_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oc_whats_new_id_seq OWNED BY public.oc_whats_new.id;


--
-- Name: oc_accounts_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_accounts_data ALTER COLUMN id SET DEFAULT nextval('public.oc_accounts_data_id_seq'::regclass);


--
-- Name: oc_activity activity_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_activity ALTER COLUMN activity_id SET DEFAULT nextval('public.oc_activity_activity_id_seq'::regclass);


--
-- Name: oc_activity_mq mail_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_activity_mq ALTER COLUMN mail_id SET DEFAULT nextval('public.oc_activity_mq_mail_id_seq'::regclass);


--
-- Name: oc_addressbookchanges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_addressbookchanges ALTER COLUMN id SET DEFAULT nextval('public.oc_addressbookchanges_id_seq'::regclass);


--
-- Name: oc_addressbooks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_addressbooks ALTER COLUMN id SET DEFAULT nextval('public.oc_addressbooks_id_seq'::regclass);


--
-- Name: oc_appconfig_ex id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_appconfig_ex ALTER COLUMN id SET DEFAULT nextval('public.oc_appconfig_ex_id_seq'::regclass);


--
-- Name: oc_authorized_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_authorized_groups ALTER COLUMN id SET DEFAULT nextval('public.oc_authorized_groups_id_seq'::regclass);


--
-- Name: oc_authtoken id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_authtoken ALTER COLUMN id SET DEFAULT nextval('public.oc_authtoken_id_seq'::regclass);


--
-- Name: oc_bruteforce_attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_bruteforce_attempts ALTER COLUMN id SET DEFAULT nextval('public.oc_bruteforce_attempts_id_seq'::regclass);


--
-- Name: oc_calendar_invitations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendar_invitations ALTER COLUMN id SET DEFAULT nextval('public.oc_calendar_invitations_id_seq'::regclass);


--
-- Name: oc_calendar_reminders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendar_reminders ALTER COLUMN id SET DEFAULT nextval('public.oc_calendar_reminders_id_seq'::regclass);


--
-- Name: oc_calendar_resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendar_resources ALTER COLUMN id SET DEFAULT nextval('public.oc_calendar_resources_id_seq'::regclass);


--
-- Name: oc_calendar_resources_md id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendar_resources_md ALTER COLUMN id SET DEFAULT nextval('public.oc_calendar_resources_md_id_seq'::regclass);


--
-- Name: oc_calendar_rooms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendar_rooms ALTER COLUMN id SET DEFAULT nextval('public.oc_calendar_rooms_id_seq'::regclass);


--
-- Name: oc_calendar_rooms_md id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendar_rooms_md ALTER COLUMN id SET DEFAULT nextval('public.oc_calendar_rooms_md_id_seq'::regclass);


--
-- Name: oc_calendarchanges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendarchanges ALTER COLUMN id SET DEFAULT nextval('public.oc_calendarchanges_id_seq'::regclass);


--
-- Name: oc_calendarobjects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendarobjects ALTER COLUMN id SET DEFAULT nextval('public.oc_calendarobjects_id_seq'::regclass);


--
-- Name: oc_calendarobjects_props id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendarobjects_props ALTER COLUMN id SET DEFAULT nextval('public.oc_calendarobjects_props_id_seq'::regclass);


--
-- Name: oc_calendars id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendars ALTER COLUMN id SET DEFAULT nextval('public.oc_calendars_id_seq'::regclass);


--
-- Name: oc_calendarsubscriptions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendarsubscriptions ALTER COLUMN id SET DEFAULT nextval('public.oc_calendarsubscriptions_id_seq'::regclass);


--
-- Name: oc_cards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_cards ALTER COLUMN id SET DEFAULT nextval('public.oc_cards_id_seq'::regclass);


--
-- Name: oc_cards_properties id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_cards_properties ALTER COLUMN id SET DEFAULT nextval('public.oc_cards_properties_id_seq'::regclass);


--
-- Name: oc_circles_circle id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_circle ALTER COLUMN id SET DEFAULT nextval('public.oc_circles_circle_id_seq'::regclass);


--
-- Name: oc_circles_member id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_member ALTER COLUMN id SET DEFAULT nextval('public.oc_circles_member_id_seq'::regclass);


--
-- Name: oc_circles_mount id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_mount ALTER COLUMN id SET DEFAULT nextval('public.oc_circles_mount_id_seq'::regclass);


--
-- Name: oc_circles_mountpoint id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_mountpoint ALTER COLUMN id SET DEFAULT nextval('public.oc_circles_mountpoint_id_seq'::regclass);


--
-- Name: oc_circles_remote id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_remote ALTER COLUMN id SET DEFAULT nextval('public.oc_circles_remote_id_seq'::regclass);


--
-- Name: oc_circles_share_lock id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_share_lock ALTER COLUMN id SET DEFAULT nextval('public.oc_circles_share_lock_id_seq'::regclass);


--
-- Name: oc_circles_token id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_token ALTER COLUMN id SET DEFAULT nextval('public.oc_circles_token_id_seq'::regclass);


--
-- Name: oc_collres_collections id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_collres_collections ALTER COLUMN id SET DEFAULT nextval('public.oc_collres_collections_id_seq'::regclass);


--
-- Name: oc_comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_comments ALTER COLUMN id SET DEFAULT nextval('public.oc_comments_id_seq'::regclass);


--
-- Name: oc_dav_absence id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_dav_absence ALTER COLUMN id SET DEFAULT nextval('public.oc_dav_absence_id_seq'::regclass);


--
-- Name: oc_dav_cal_proxy id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_dav_cal_proxy ALTER COLUMN id SET DEFAULT nextval('public.oc_dav_cal_proxy_id_seq'::regclass);


--
-- Name: oc_dav_shares id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_dav_shares ALTER COLUMN id SET DEFAULT nextval('public.oc_dav_shares_id_seq'::regclass);


--
-- Name: oc_direct_edit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_direct_edit ALTER COLUMN id SET DEFAULT nextval('public.oc_direct_edit_id_seq'::regclass);


--
-- Name: oc_directlink id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_directlink ALTER COLUMN id SET DEFAULT nextval('public.oc_directlink_id_seq'::regclass);


--
-- Name: oc_ex_apps id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_apps ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_apps_id_seq'::regclass);


--
-- Name: oc_ex_apps_daemons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_apps_daemons ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_apps_daemons_id_seq'::regclass);


--
-- Name: oc_ex_apps_routes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_apps_routes ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_apps_routes_id_seq'::regclass);


--
-- Name: oc_ex_event_handlers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_event_handlers ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_event_handlers_id_seq'::regclass);


--
-- Name: oc_ex_occ_commands id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_occ_commands ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_occ_commands_id_seq'::regclass);


--
-- Name: oc_ex_settings_forms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_settings_forms ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_settings_forms_id_seq'::regclass);


--
-- Name: oc_ex_speech_to_text id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_speech_to_text ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_speech_to_text_id_seq'::regclass);


--
-- Name: oc_ex_speech_to_text_q id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_speech_to_text_q ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_speech_to_text_q_id_seq'::regclass);


--
-- Name: oc_ex_task_processing id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_task_processing ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_task_processing_id_seq'::regclass);


--
-- Name: oc_ex_text_processing id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_text_processing ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_text_processing_id_seq'::regclass);


--
-- Name: oc_ex_text_processing_q id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_text_processing_q ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_text_processing_q_id_seq'::regclass);


--
-- Name: oc_ex_translation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_translation ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_translation_id_seq'::regclass);


--
-- Name: oc_ex_translation_q id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_translation_q ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_translation_q_id_seq'::regclass);


--
-- Name: oc_ex_ui_files_actions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_ui_files_actions ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_ui_files_actions_id_seq'::regclass);


--
-- Name: oc_ex_ui_scripts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_ui_scripts ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_ui_scripts_id_seq'::regclass);


--
-- Name: oc_ex_ui_states id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_ui_states ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_ui_states_id_seq'::regclass);


--
-- Name: oc_ex_ui_styles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_ui_styles ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_ui_styles_id_seq'::regclass);


--
-- Name: oc_ex_ui_top_menu id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_ui_top_menu ALTER COLUMN id SET DEFAULT nextval('public.oc_ex_ui_top_menu_id_seq'::regclass);


--
-- Name: oc_file_locks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_file_locks ALTER COLUMN id SET DEFAULT nextval('public.oc_file_locks_id_seq'::regclass);


--
-- Name: oc_filecache fileid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_filecache ALTER COLUMN fileid SET DEFAULT nextval('public.oc_filecache_fileid_seq'::regclass);


--
-- Name: oc_files_metadata id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_files_metadata ALTER COLUMN id SET DEFAULT nextval('public.oc_files_metadata_id_seq'::regclass);


--
-- Name: oc_files_metadata_index id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_files_metadata_index ALTER COLUMN id SET DEFAULT nextval('public.oc_files_metadata_index_id_seq'::regclass);


--
-- Name: oc_files_reminders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_files_reminders ALTER COLUMN id SET DEFAULT nextval('public.oc_files_reminders_id_seq'::regclass);


--
-- Name: oc_files_trash auto_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_files_trash ALTER COLUMN auto_id SET DEFAULT nextval('public.oc_files_trash_auto_id_seq'::regclass);


--
-- Name: oc_files_versions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_files_versions ALTER COLUMN id SET DEFAULT nextval('public.oc_files_versions_id_seq'::regclass);


--
-- Name: oc_flow_checks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_flow_checks ALTER COLUMN id SET DEFAULT nextval('public.oc_flow_checks_id_seq'::regclass);


--
-- Name: oc_flow_operations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_flow_operations ALTER COLUMN id SET DEFAULT nextval('public.oc_flow_operations_id_seq'::regclass);


--
-- Name: oc_flow_operations_scope id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_flow_operations_scope ALTER COLUMN id SET DEFAULT nextval('public.oc_flow_operations_scope_id_seq'::regclass);


--
-- Name: oc_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_jobs ALTER COLUMN id SET DEFAULT nextval('public.oc_jobs_id_seq'::regclass);


--
-- Name: oc_known_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_known_users ALTER COLUMN id SET DEFAULT nextval('public.oc_known_users_id_seq'::regclass);


--
-- Name: oc_login_flow_v2 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_login_flow_v2 ALTER COLUMN id SET DEFAULT nextval('public.oc_login_flow_v2_id_seq'::regclass);


--
-- Name: oc_mimetypes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_mimetypes ALTER COLUMN id SET DEFAULT nextval('public.oc_mimetypes_id_seq'::regclass);


--
-- Name: oc_mounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_mounts ALTER COLUMN id SET DEFAULT nextval('public.oc_mounts_id_seq'::regclass);


--
-- Name: oc_notifications notification_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_notifications ALTER COLUMN notification_id SET DEFAULT nextval('public.oc_notifications_notification_id_seq'::regclass);


--
-- Name: oc_notifications_pushhash id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_notifications_pushhash ALTER COLUMN id SET DEFAULT nextval('public.oc_notifications_pushhash_id_seq'::regclass);


--
-- Name: oc_notifications_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_notifications_settings ALTER COLUMN id SET DEFAULT nextval('public.oc_notifications_settings_id_seq'::regclass);


--
-- Name: oc_oauth2_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_oauth2_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.oc_oauth2_access_tokens_id_seq'::regclass);


--
-- Name: oc_oauth2_clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_oauth2_clients ALTER COLUMN id SET DEFAULT nextval('public.oc_oauth2_clients_id_seq'::regclass);


--
-- Name: oc_open_local_editor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_open_local_editor ALTER COLUMN id SET DEFAULT nextval('public.oc_open_local_editor_id_seq'::regclass);


--
-- Name: oc_photos_albums album_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_photos_albums ALTER COLUMN album_id SET DEFAULT nextval('public.oc_photos_albums_album_id_seq'::regclass);


--
-- Name: oc_photos_albums_collabs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_photos_albums_collabs ALTER COLUMN id SET DEFAULT nextval('public.oc_photos_albums_collabs_id_seq'::regclass);


--
-- Name: oc_photos_albums_files album_file_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_photos_albums_files ALTER COLUMN album_file_id SET DEFAULT nextval('public.oc_photos_albums_files_album_file_id_seq'::regclass);


--
-- Name: oc_preferences_ex id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_preferences_ex ALTER COLUMN id SET DEFAULT nextval('public.oc_preferences_ex_id_seq'::regclass);


--
-- Name: oc_privacy_admins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_privacy_admins ALTER COLUMN id SET DEFAULT nextval('public.oc_privacy_admins_id_seq'::regclass);


--
-- Name: oc_profile_config id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_profile_config ALTER COLUMN id SET DEFAULT nextval('public.oc_profile_config_id_seq'::regclass);


--
-- Name: oc_properties id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_properties ALTER COLUMN id SET DEFAULT nextval('public.oc_properties_id_seq'::regclass);


--
-- Name: oc_ratelimit_entries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ratelimit_entries ALTER COLUMN id SET DEFAULT nextval('public.oc_ratelimit_entries_id_seq'::regclass);


--
-- Name: oc_reactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_reactions ALTER COLUMN id SET DEFAULT nextval('public.oc_reactions_id_seq'::regclass);


--
-- Name: oc_recent_contact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_recent_contact ALTER COLUMN id SET DEFAULT nextval('public.oc_recent_contact_id_seq'::regclass);


--
-- Name: oc_schedulingobjects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_schedulingobjects ALTER COLUMN id SET DEFAULT nextval('public.oc_schedulingobjects_id_seq'::regclass);


--
-- Name: oc_share id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_share ALTER COLUMN id SET DEFAULT nextval('public.oc_share_id_seq'::regclass);


--
-- Name: oc_share_external id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_share_external ALTER COLUMN id SET DEFAULT nextval('public.oc_share_external_id_seq'::regclass);


--
-- Name: oc_storages numeric_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_storages ALTER COLUMN numeric_id SET DEFAULT nextval('public.oc_storages_numeric_id_seq'::regclass);


--
-- Name: oc_storages_credentials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_storages_credentials ALTER COLUMN id SET DEFAULT nextval('public.oc_storages_credentials_id_seq'::regclass);


--
-- Name: oc_systemtag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_systemtag ALTER COLUMN id SET DEFAULT nextval('public.oc_systemtag_id_seq'::regclass);


--
-- Name: oc_taskprocessing_tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_taskprocessing_tasks ALTER COLUMN id SET DEFAULT nextval('public.oc_taskprocessing_tasks_id_seq'::regclass);


--
-- Name: oc_text2image_tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_text2image_tasks ALTER COLUMN id SET DEFAULT nextval('public.oc_text2image_tasks_id_seq'::regclass);


--
-- Name: oc_text_sessions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_text_sessions ALTER COLUMN id SET DEFAULT nextval('public.oc_text_sessions_id_seq'::regclass);


--
-- Name: oc_text_steps id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_text_steps ALTER COLUMN id SET DEFAULT nextval('public.oc_text_steps_id_seq'::regclass);


--
-- Name: oc_textprocessing_tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_textprocessing_tasks ALTER COLUMN id SET DEFAULT nextval('public.oc_textprocessing_tasks_id_seq'::regclass);


--
-- Name: oc_trusted_servers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_trusted_servers ALTER COLUMN id SET DEFAULT nextval('public.oc_trusted_servers_id_seq'::regclass);


--
-- Name: oc_twofactor_backupcodes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_twofactor_backupcodes ALTER COLUMN id SET DEFAULT nextval('public.oc_twofactor_backupcodes_id_seq'::regclass);


--
-- Name: oc_user_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_user_status ALTER COLUMN id SET DEFAULT nextval('public.oc_user_status_id_seq'::regclass);


--
-- Name: oc_user_transfer_owner id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_user_transfer_owner ALTER COLUMN id SET DEFAULT nextval('public.oc_user_transfer_owner_id_seq'::regclass);


--
-- Name: oc_vcategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_vcategory ALTER COLUMN id SET DEFAULT nextval('public.oc_vcategory_id_seq'::regclass);


--
-- Name: oc_webauthn id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_webauthn ALTER COLUMN id SET DEFAULT nextval('public.oc_webauthn_id_seq'::regclass);


--
-- Name: oc_webhook_listeners id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_webhook_listeners ALTER COLUMN id SET DEFAULT nextval('public.oc_webhook_listeners_id_seq'::regclass);


--
-- Name: oc_whats_new id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_whats_new ALTER COLUMN id SET DEFAULT nextval('public.oc_whats_new_id_seq'::regclass);


--
-- Data for Name: oc_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_accounts (uid, data) FROM stdin;
admin	{"displayname":{"value":"admin","scope":"v2-federated","verified":"0"},"address":{"value":"","scope":"v2-local","verified":"0"},"website":{"value":"","scope":"v2-local","verified":"0"},"email":{"value":null,"scope":"v2-federated","verified":"0"},"avatar":{"scope":"v2-federated"},"phone":{"value":"","scope":"v2-local","verified":"0"},"twitter":{"value":"","scope":"v2-local","verified":"0"},"fediverse":{"value":"","scope":"v2-local","verified":"0"},"organisation":{"value":"","scope":"v2-local"},"role":{"value":"","scope":"v2-local"},"headline":{"value":"","scope":"v2-local"},"biography":{"value":"","scope":"v2-local"},"birthdate":{"value":"","scope":"v2-local"},"profile_enabled":{"value":"1"}}
\.


--
-- Data for Name: oc_accounts_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_accounts_data (id, uid, name, value) FROM stdin;
1	admin	displayname	admin
2	admin	address	
3	admin	website	
4	admin	email	
5	admin	phone	
6	admin	twitter	
7	admin	fediverse	
8	admin	organisation	
9	admin	role	
10	admin	headline	
11	admin	biography	
12	admin	birthdate	
13	admin	profile_enabled	1
\.


--
-- Data for Name: oc_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_activity (activity_id, "timestamp", priority, type, "user", affecteduser, app, subject, subjectparams, message, messageparams, file, link, object_type, object_id) FROM stdin;
1	1730334177	30	file_created	admin	admin	files	created_self	[{"3":"\\/Nextcloud intro.mp4"}]		[]	/Nextcloud intro.mp4	http://localhost/index.php/apps/files/?dir=/	files	3
2	1730334177	30	file_changed	admin	admin	files	changed_self	[{"3":"\\/Nextcloud intro.mp4"}]		[]	/Nextcloud intro.mp4	http://localhost/index.php/apps/files/?dir=/	files	3
3	1730334177	30	file_created	admin	admin	files	created_self	[{"4":"\\/Photos"}]		[]	/Photos	http://localhost/index.php/apps/files/?dir=/	files	4
4	1730334177	30	file_created	admin	admin	files	created_self	[{"5":"\\/Photos\\/Birdie.jpg"}]		[]	/Photos/Birdie.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	5
5	1730334177	30	file_changed	admin	admin	files	changed_self	[{"5":"\\/Photos\\/Birdie.jpg"}]		[]	/Photos/Birdie.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	5
6	1730334177	30	file_created	admin	admin	files	created_self	[{"6":"\\/Photos\\/Toucan.jpg"}]		[]	/Photos/Toucan.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	6
7	1730334177	30	file_changed	admin	admin	files	changed_self	[{"6":"\\/Photos\\/Toucan.jpg"}]		[]	/Photos/Toucan.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	6
8	1730334177	30	file_created	admin	admin	files	created_self	[{"7":"\\/Photos\\/Library.jpg"}]		[]	/Photos/Library.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	7
9	1730334177	30	file_changed	admin	admin	files	changed_self	[{"7":"\\/Photos\\/Library.jpg"}]		[]	/Photos/Library.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	7
10	1730334177	30	file_created	admin	admin	files	created_self	[{"8":"\\/Photos\\/Frog.jpg"}]		[]	/Photos/Frog.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	8
11	1730334177	30	file_changed	admin	admin	files	changed_self	[{"8":"\\/Photos\\/Frog.jpg"}]		[]	/Photos/Frog.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	8
12	1730334177	30	file_created	admin	admin	files	created_self	[{"9":"\\/Photos\\/Vineyard.jpg"}]		[]	/Photos/Vineyard.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	9
13	1730334177	30	file_changed	admin	admin	files	changed_self	[{"9":"\\/Photos\\/Vineyard.jpg"}]		[]	/Photos/Vineyard.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	9
14	1730334177	30	file_created	admin	admin	files	created_self	[{"10":"\\/Photos\\/Gorilla.jpg"}]		[]	/Photos/Gorilla.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	10
15	1730334177	30	file_changed	admin	admin	files	changed_self	[{"10":"\\/Photos\\/Gorilla.jpg"}]		[]	/Photos/Gorilla.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	10
16	1730334177	30	file_created	admin	admin	files	created_self	[{"11":"\\/Photos\\/Nextcloud community.jpg"}]		[]	/Photos/Nextcloud community.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	11
17	1730334177	30	file_changed	admin	admin	files	changed_self	[{"11":"\\/Photos\\/Nextcloud community.jpg"}]		[]	/Photos/Nextcloud community.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	11
18	1730334177	30	file_created	admin	admin	files	created_self	[{"12":"\\/Photos\\/Readme.md"}]		[]	/Photos/Readme.md	http://localhost/index.php/apps/files/?dir=/Photos	files	12
19	1730334177	30	file_changed	admin	admin	files	changed_self	[{"12":"\\/Photos\\/Readme.md"}]		[]	/Photos/Readme.md	http://localhost/index.php/apps/files/?dir=/Photos	files	12
20	1730334177	30	file_created	admin	admin	files	created_self	[{"13":"\\/Photos\\/Steps.jpg"}]		[]	/Photos/Steps.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	13
21	1730334177	30	file_changed	admin	admin	files	changed_self	[{"13":"\\/Photos\\/Steps.jpg"}]		[]	/Photos/Steps.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	13
22	1730334177	30	file_created	admin	admin	files	created_self	[{"14":"\\/Nextcloud Manual.pdf"}]		[]	/Nextcloud Manual.pdf	http://localhost/index.php/apps/files/?dir=/	files	14
23	1730334177	30	file_changed	admin	admin	files	changed_self	[{"14":"\\/Nextcloud Manual.pdf"}]		[]	/Nextcloud Manual.pdf	http://localhost/index.php/apps/files/?dir=/	files	14
24	1730334177	30	file_created	admin	admin	files	created_self	[{"15":"\\/Readme.md"}]		[]	/Readme.md	http://localhost/index.php/apps/files/?dir=/	files	15
25	1730334177	30	file_changed	admin	admin	files	changed_self	[{"15":"\\/Readme.md"}]		[]	/Readme.md	http://localhost/index.php/apps/files/?dir=/	files	15
26	1730334177	30	file_created	admin	admin	files	created_self	[{"16":"\\/Nextcloud.png"}]		[]	/Nextcloud.png	http://localhost/index.php/apps/files/?dir=/	files	16
27	1730334177	30	file_changed	admin	admin	files	changed_self	[{"16":"\\/Nextcloud.png"}]		[]	/Nextcloud.png	http://localhost/index.php/apps/files/?dir=/	files	16
28	1730334177	30	file_created	admin	admin	files	created_self	[{"17":"\\/Templates"}]		[]	/Templates	http://localhost/index.php/apps/files/?dir=/	files	17
29	1730334177	30	file_created	admin	admin	files	created_self	[{"18":"\\/Templates\\/Mother's day.odt"}]		[]	/Templates/Mother's day.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	18
30	1730334177	30	file_changed	admin	admin	files	changed_self	[{"18":"\\/Templates\\/Mother's day.odt"}]		[]	/Templates/Mother's day.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	18
31	1730334177	30	file_created	admin	admin	files	created_self	[{"19":"\\/Templates\\/Photo book.odt"}]		[]	/Templates/Photo book.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	19
32	1730334177	30	file_changed	admin	admin	files	changed_self	[{"19":"\\/Templates\\/Photo book.odt"}]		[]	/Templates/Photo book.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	19
33	1730334178	30	file_created	admin	admin	files	created_self	[{"20":"\\/Templates\\/Business model canvas.ods"}]		[]	/Templates/Business model canvas.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	20
34	1730334178	30	file_changed	admin	admin	files	changed_self	[{"20":"\\/Templates\\/Business model canvas.ods"}]		[]	/Templates/Business model canvas.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	20
35	1730334178	30	file_created	admin	admin	files	created_self	[{"21":"\\/Templates\\/Invoice.odt"}]		[]	/Templates/Invoice.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	21
36	1730334178	30	file_changed	admin	admin	files	changed_self	[{"21":"\\/Templates\\/Invoice.odt"}]		[]	/Templates/Invoice.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	21
37	1730334178	30	file_created	admin	admin	files	created_self	[{"22":"\\/Templates\\/Modern company.odp"}]		[]	/Templates/Modern company.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	22
38	1730334178	30	file_changed	admin	admin	files	changed_self	[{"22":"\\/Templates\\/Modern company.odp"}]		[]	/Templates/Modern company.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	22
39	1730334178	30	file_created	admin	admin	files	created_self	[{"23":"\\/Templates\\/Resume.odt"}]		[]	/Templates/Resume.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	23
40	1730334178	30	file_changed	admin	admin	files	changed_self	[{"23":"\\/Templates\\/Resume.odt"}]		[]	/Templates/Resume.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	23
41	1730334178	30	file_created	admin	admin	files	created_self	[{"24":"\\/Templates\\/Brainstorming.whiteboard"}]		[]	/Templates/Brainstorming.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	24
42	1730334178	30	file_changed	admin	admin	files	changed_self	[{"24":"\\/Templates\\/Brainstorming.whiteboard"}]		[]	/Templates/Brainstorming.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	24
43	1730334178	30	file_created	admin	admin	files	created_self	[{"25":"\\/Templates\\/Flowchart.whiteboard"}]		[]	/Templates/Flowchart.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	25
44	1730334178	30	file_changed	admin	admin	files	changed_self	[{"25":"\\/Templates\\/Flowchart.whiteboard"}]		[]	/Templates/Flowchart.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	25
45	1730334178	30	file_created	admin	admin	files	created_self	[{"26":"\\/Templates\\/Yellow idea.odp"}]		[]	/Templates/Yellow idea.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	26
46	1730334178	30	file_changed	admin	admin	files	changed_self	[{"26":"\\/Templates\\/Yellow idea.odp"}]		[]	/Templates/Yellow idea.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	26
47	1730334178	30	file_created	admin	admin	files	created_self	[{"27":"\\/Templates\\/Business model canvas.odg"}]		[]	/Templates/Business model canvas.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	27
48	1730334178	30	file_changed	admin	admin	files	changed_self	[{"27":"\\/Templates\\/Business model canvas.odg"}]		[]	/Templates/Business model canvas.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	27
49	1730334178	30	file_created	admin	admin	files	created_self	[{"28":"\\/Templates\\/Timeline.whiteboard"}]		[]	/Templates/Timeline.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	28
50	1730334178	30	file_changed	admin	admin	files	changed_self	[{"28":"\\/Templates\\/Timeline.whiteboard"}]		[]	/Templates/Timeline.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	28
51	1730334178	30	file_created	admin	admin	files	created_self	[{"29":"\\/Templates\\/Venn diagram.whiteboard"}]		[]	/Templates/Venn diagram.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	29
52	1730334178	30	file_changed	admin	admin	files	changed_self	[{"29":"\\/Templates\\/Venn diagram.whiteboard"}]		[]	/Templates/Venn diagram.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	29
53	1730334178	30	file_created	admin	admin	files	created_self	[{"30":"\\/Templates\\/Business model canvas.whiteboard"}]		[]	/Templates/Business model canvas.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	30
54	1730334178	30	file_changed	admin	admin	files	changed_self	[{"30":"\\/Templates\\/Business model canvas.whiteboard"}]		[]	/Templates/Business model canvas.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	30
55	1730334178	30	file_created	admin	admin	files	created_self	[{"31":"\\/Templates\\/Mindmap.odg"}]		[]	/Templates/Mindmap.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	31
56	1730334178	30	file_changed	admin	admin	files	changed_self	[{"31":"\\/Templates\\/Mindmap.odg"}]		[]	/Templates/Mindmap.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	31
57	1730334178	30	file_created	admin	admin	files	created_self	[{"32":"\\/Templates\\/Diagram & table.ods"}]		[]	/Templates/Diagram & table.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	32
58	1730334178	30	file_changed	admin	admin	files	changed_self	[{"32":"\\/Templates\\/Diagram & table.ods"}]		[]	/Templates/Diagram & table.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	32
59	1730334178	30	file_created	admin	admin	files	created_self	[{"33":"\\/Templates\\/Org chart.odg"}]		[]	/Templates/Org chart.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	33
60	1730334178	30	file_changed	admin	admin	files	changed_self	[{"33":"\\/Templates\\/Org chart.odg"}]		[]	/Templates/Org chart.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	33
61	1730334178	30	file_created	admin	admin	files	created_self	[{"34":"\\/Templates\\/Meeting notes.md"}]		[]	/Templates/Meeting notes.md	http://localhost/index.php/apps/files/?dir=/Templates	files	34
62	1730334178	30	file_changed	admin	admin	files	changed_self	[{"34":"\\/Templates\\/Meeting notes.md"}]		[]	/Templates/Meeting notes.md	http://localhost/index.php/apps/files/?dir=/Templates	files	34
63	1730334178	30	file_created	admin	admin	files	created_self	[{"35":"\\/Templates\\/Impact effort.whiteboard"}]		[]	/Templates/Impact effort.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	35
64	1730334178	30	file_changed	admin	admin	files	changed_self	[{"35":"\\/Templates\\/Impact effort.whiteboard"}]		[]	/Templates/Impact effort.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	35
65	1730334178	30	file_created	admin	admin	files	created_self	[{"36":"\\/Templates\\/Flowchart.odg"}]		[]	/Templates/Flowchart.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	36
66	1730334178	30	file_changed	admin	admin	files	changed_self	[{"36":"\\/Templates\\/Flowchart.odg"}]		[]	/Templates/Flowchart.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	36
67	1730334178	30	file_created	admin	admin	files	created_self	[{"37":"\\/Templates\\/Mind map.whiteboard"}]		[]	/Templates/Mind map.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	37
68	1730334178	30	file_changed	admin	admin	files	changed_self	[{"37":"\\/Templates\\/Mind map.whiteboard"}]		[]	/Templates/Mind map.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	37
69	1730334178	30	file_created	admin	admin	files	created_self	[{"38":"\\/Templates\\/Meeting agenda.whiteboard"}]		[]	/Templates/Meeting agenda.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	38
70	1730334178	30	file_changed	admin	admin	files	changed_self	[{"38":"\\/Templates\\/Meeting agenda.whiteboard"}]		[]	/Templates/Meeting agenda.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	38
71	1730334178	30	file_created	admin	admin	files	created_self	[{"39":"\\/Templates\\/Readme.md"}]		[]	/Templates/Readme.md	http://localhost/index.php/apps/files/?dir=/Templates	files	39
72	1730334178	30	file_changed	admin	admin	files	changed_self	[{"39":"\\/Templates\\/Readme.md"}]		[]	/Templates/Readme.md	http://localhost/index.php/apps/files/?dir=/Templates	files	39
73	1730334178	30	file_created	admin	admin	files	created_self	[{"40":"\\/Templates\\/Product plan.md"}]		[]	/Templates/Product plan.md	http://localhost/index.php/apps/files/?dir=/Templates	files	40
74	1730334178	30	file_changed	admin	admin	files	changed_self	[{"40":"\\/Templates\\/Product plan.md"}]		[]	/Templates/Product plan.md	http://localhost/index.php/apps/files/?dir=/Templates	files	40
75	1730334178	30	file_created	admin	admin	files	created_self	[{"41":"\\/Templates\\/Timesheet.ods"}]		[]	/Templates/Timesheet.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	41
76	1730334178	30	file_changed	admin	admin	files	changed_self	[{"41":"\\/Templates\\/Timesheet.ods"}]		[]	/Templates/Timesheet.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	41
77	1730334178	30	file_created	admin	admin	files	created_self	[{"42":"\\/Templates\\/Simple.odp"}]		[]	/Templates/Simple.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	42
78	1730334178	30	file_changed	admin	admin	files	changed_self	[{"42":"\\/Templates\\/Simple.odp"}]		[]	/Templates/Simple.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	42
79	1730334179	30	file_created	admin	admin	files	created_self	[{"43":"\\/Templates\\/Kanban board.whiteboard"}]		[]	/Templates/Kanban board.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	43
80	1730334179	30	file_changed	admin	admin	files	changed_self	[{"43":"\\/Templates\\/Kanban board.whiteboard"}]		[]	/Templates/Kanban board.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	43
81	1730334179	30	file_created	admin	admin	files	created_self	[{"44":"\\/Templates\\/Syllabus.odt"}]		[]	/Templates/Syllabus.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	44
82	1730334179	30	file_changed	admin	admin	files	changed_self	[{"44":"\\/Templates\\/Syllabus.odt"}]		[]	/Templates/Syllabus.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	44
83	1730334179	30	file_created	admin	admin	files	created_self	[{"45":"\\/Templates\\/Letter.odt"}]		[]	/Templates/Letter.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	45
84	1730334179	30	file_changed	admin	admin	files	changed_self	[{"45":"\\/Templates\\/Letter.odt"}]		[]	/Templates/Letter.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	45
85	1730334179	30	file_created	admin	admin	files	created_self	[{"46":"\\/Templates\\/Sticky notes.whiteboard"}]		[]	/Templates/Sticky notes.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	46
86	1730334179	30	file_changed	admin	admin	files	changed_self	[{"46":"\\/Templates\\/Sticky notes.whiteboard"}]		[]	/Templates/Sticky notes.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	46
87	1730334179	30	file_created	admin	admin	files	created_self	[{"47":"\\/Templates\\/Elegant.odp"}]		[]	/Templates/Elegant.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	47
88	1730334179	30	file_changed	admin	admin	files	changed_self	[{"47":"\\/Templates\\/Elegant.odp"}]		[]	/Templates/Elegant.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	47
89	1730334179	30	file_created	admin	admin	files	created_self	[{"48":"\\/Templates\\/Party invitation.odt"}]		[]	/Templates/Party invitation.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	48
90	1730334179	30	file_changed	admin	admin	files	changed_self	[{"48":"\\/Templates\\/Party invitation.odt"}]		[]	/Templates/Party invitation.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	48
91	1730334179	30	file_created	admin	admin	files	created_self	[{"49":"\\/Templates\\/Gotong royong.odp"}]		[]	/Templates/Gotong royong.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	49
92	1730334179	30	file_changed	admin	admin	files	changed_self	[{"49":"\\/Templates\\/Gotong royong.odp"}]		[]	/Templates/Gotong royong.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	49
93	1730334179	30	file_created	admin	admin	files	created_self	[{"50":"\\/Templates\\/Expense report.ods"}]		[]	/Templates/Expense report.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	50
94	1730334179	30	file_changed	admin	admin	files	changed_self	[{"50":"\\/Templates\\/Expense report.ods"}]		[]	/Templates/Expense report.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	50
95	1730334179	30	file_created	admin	admin	files	created_self	[{"51":"\\/Templates credits.md"}]		[]	/Templates credits.md	http://localhost/index.php/apps/files/?dir=/	files	51
96	1730334179	30	file_changed	admin	admin	files	changed_self	[{"51":"\\/Templates credits.md"}]		[]	/Templates credits.md	http://localhost/index.php/apps/files/?dir=/	files	51
97	1730334179	30	file_created	admin	admin	files	created_self	[{"52":"\\/Reasons to use Nextcloud.pdf"}]		[]	/Reasons to use Nextcloud.pdf	http://localhost/index.php/apps/files/?dir=/	files	52
98	1730334179	30	file_changed	admin	admin	files	changed_self	[{"52":"\\/Reasons to use Nextcloud.pdf"}]		[]	/Reasons to use Nextcloud.pdf	http://localhost/index.php/apps/files/?dir=/	files	52
99	1730334179	30	file_created	admin	admin	files	created_self	[{"53":"\\/Documents"}]		[]	/Documents	http://localhost/index.php/apps/files/?dir=/	files	53
100	1730334179	30	file_created	admin	admin	files	created_self	[{"54":"\\/Documents\\/Example.md"}]		[]	/Documents/Example.md	http://localhost/index.php/apps/files/?dir=/Documents	files	54
101	1730334179	30	file_changed	admin	admin	files	changed_self	[{"54":"\\/Documents\\/Example.md"}]		[]	/Documents/Example.md	http://localhost/index.php/apps/files/?dir=/Documents	files	54
102	1730334179	30	file_created	admin	admin	files	created_self	[{"55":"\\/Documents\\/Nextcloud flyer.pdf"}]		[]	/Documents/Nextcloud flyer.pdf	http://localhost/index.php/apps/files/?dir=/Documents	files	55
103	1730334179	30	file_changed	admin	admin	files	changed_self	[{"55":"\\/Documents\\/Nextcloud flyer.pdf"}]		[]	/Documents/Nextcloud flyer.pdf	http://localhost/index.php/apps/files/?dir=/Documents	files	55
104	1730334179	30	file_created	admin	admin	files	created_self	[{"56":"\\/Documents\\/Readme.md"}]		[]	/Documents/Readme.md	http://localhost/index.php/apps/files/?dir=/Documents	files	56
105	1730334179	30	file_changed	admin	admin	files	changed_self	[{"56":"\\/Documents\\/Readme.md"}]		[]	/Documents/Readme.md	http://localhost/index.php/apps/files/?dir=/Documents	files	56
106	1730334179	30	file_created	admin	admin	files	created_self	[{"57":"\\/Documents\\/Welcome to Nextcloud Hub.docx"}]		[]	/Documents/Welcome to Nextcloud Hub.docx	http://localhost/index.php/apps/files/?dir=/Documents	files	57
107	1730334179	30	file_changed	admin	admin	files	changed_self	[{"57":"\\/Documents\\/Welcome to Nextcloud Hub.docx"}]		[]	/Documents/Welcome to Nextcloud Hub.docx	http://localhost/index.php/apps/files/?dir=/Documents	files	57
\.


--
-- Data for Name: oc_activity_mq; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_activity_mq (mail_id, amq_timestamp, amq_latest_send, amq_type, amq_affecteduser, amq_appid, amq_subject, amq_subjectparams, object_type, object_id) FROM stdin;
\.


--
-- Data for Name: oc_addressbookchanges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_addressbookchanges (id, uri, synctoken, addressbookid, operation, created_at) FROM stdin;
\.


--
-- Data for Name: oc_addressbooks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_addressbooks (id, principaluri, displayname, uri, description, synctoken) FROM stdin;
\.


--
-- Data for Name: oc_appconfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_appconfig (appid, configkey, configvalue, type, lazy) FROM stdin;
core	installedat	1730334167.4094	2	0
core	lastupdatedat	1730334167	8	0
core	vendor	nextcloud	2	0
webhook_listeners	installed_version	1.1.0-dev	2	0
webhook_listeners	types	filesystem	2	0
webhook_listeners	enabled	yes	2	0
logreader	installed_version	3.0.0	2	0
logreader	types	logging	2	0
logreader	enabled	yes	2	0
federatedfilesharing	installed_version	1.20.0	2	0
federatedfilesharing	types		2	0
federatedfilesharing	enabled	yes	2	0
app_api	installed_version	4.0.0	2	0
app_api	types		2	0
app_api	enabled	yes	2	0
files_reminders	installed_version	1.3.0	2	0
files_reminders	types		2	0
files_reminders	enabled	yes	2	0
related_resources	installed_version	1.5.0	2	0
related_resources	types		2	0
related_resources	enabled	yes	2	0
workflowengine	installed_version	2.12.0	2	0
workflowengine	types	filesystem	2	0
workflowengine	enabled	yes	2	0
recommendations	installed_version	3.0.0	2	0
recommendations	types		2	0
recommendations	enabled	yes	2	0
circles	installed_version	30.0.0-dev	2	0
circles	types	filesystem,dav	2	0
circles	enabled	yes	2	0
text	installed_version	4.1.0	2	0
text	types	dav	2	0
text	enabled	yes	2	0
files_downloadlimit	installed_version	3.0.0	2	0
files_downloadlimit	types		2	0
files_downloadlimit	enabled	yes	2	0
files_versions	installed_version	1.23.0	2	0
files_versions	types	filesystem,dav	2	0
files_versions	enabled	yes	2	0
federation	installed_version	1.20.0	2	0
federation	types	authentication	2	0
federation	enabled	yes	2	0
password_policy	installed_version	2.0.0	2	0
password_policy	types	authentication	2	0
password_policy	enabled	yes	2	0
activity	installed_version	3.0.0	2	0
activity	types	filesystem	2	0
activity	enabled	yes	2	0
privacy	installed_version	2.0.0	2	0
privacy	types		2	0
privacy	enabled	yes	2	0
settings	installed_version	1.13.0	2	0
settings	types		2	0
settings	enabled	yes	2	0
viewer	installed_version	3.0.0	2	0
viewer	types		2	0
viewer	enabled	yes	2	0
files_sharing	installed_version	1.22.0	2	0
core	public_files	files_sharing/public.php	2	0
files_sharing	types	filesystem	2	0
files_sharing	enabled	yes	2	0
sharebymail	installed_version	1.20.0	2	0
sharebymail	types	filesystem	2	0
sharebymail	enabled	yes	2	0
dashboard	installed_version	7.10.0	2	0
dashboard	types		2	0
dashboard	enabled	yes	2	0
updatenotification	installed_version	1.20.0	2	0
updatenotification	types		2	0
updatenotification	enabled	yes	2	0
lookup_server_connector	installed_version	1.18.0	2	0
lookup_server_connector	types	authentication	2	0
lookup_server_connector	enabled	yes	2	0
comments	installed_version	1.20.1	2	0
comments	types	logging	2	0
comments	enabled	yes	2	0
oauth2	installed_version	1.18.1	2	0
oauth2	types	authentication	2	0
oauth2	enabled	yes	2	0
photos	installed_version	3.0.2	2	0
photos	types	dav,authentication	2	0
photos	enabled	yes	2	0
twofactor_backupcodes	installed_version	1.19.0	2	0
twofactor_backupcodes	types		2	0
twofactor_backupcodes	enabled	yes	2	0
dav	installed_version	1.31.1	2	0
dav	types	filesystem	2	0
dav	enabled	yes	2	0
systemtags	installed_version	1.20.0	2	0
systemtags	types	logging	2	0
systemtags	enabled	yes	2	0
user_status	installed_version	1.10.0	2	0
user_status	types		2	0
user_status	enabled	yes	2	0
notifications	installed_version	3.0.0	2	0
notifications	types	logging	2	0
notifications	enabled	yes	2	0
files_pdfviewer	installed_version	3.0.0	2	0
files_pdfviewer	types		2	0
files_pdfviewer	enabled	yes	2	0
bruteforcesettings	installed_version	3.0.0	2	0
bruteforcesettings	types		2	0
bruteforcesettings	enabled	yes	2	0
weather_status	installed_version	1.10.0	2	0
weather_status	types		2	0
weather_status	enabled	yes	2	0
nextcloud_announcements	installed_version	2.0.0	2	0
nextcloud_announcements	types	logging	2	0
nextcloud_announcements	enabled	yes	2	0
contactsinteraction	installed_version	1.11.0	2	0
contactsinteraction	types	dav	2	0
contactsinteraction	enabled	yes	2	0
theming	installed_version	2.5.0	2	0
theming	types	logging	2	0
theming	enabled	yes	2	0
files_trashbin	installed_version	1.20.1	2	0
files_trashbin	types	filesystem,dav	2	0
files_trashbin	enabled	yes	2	0
firstrunwizard	installed_version	3.0.0	2	0
firstrunwizard	types	logging	2	0
firstrunwizard	enabled	yes	2	0
cloud_federation_api	installed_version	1.13.0	2	0
cloud_federation_api	types	filesystem	2	0
cloud_federation_api	enabled	yes	2	0
serverinfo	installed_version	2.0.0	2	0
serverinfo	types		2	0
serverinfo	enabled	yes	2	0
provisioning_api	installed_version	1.20.0	2	0
provisioning_api	types	prevent_group_restriction	2	0
provisioning_api	enabled	yes	2	0
survey_client	installed_version	2.0.0	2	0
survey_client	types		2	0
survey_client	enabled	yes	2	0
files	installed_version	2.2.0	2	0
files	types	filesystem	2	0
files	enabled	yes	2	0
support	installed_version	2.0.0	2	0
support	types	session	2	0
support	enabled	yes	2	0
circles	loopback_tmp_scheme	http	2	0
core	files_metadata	{"photos-original_date_time":{"value":null,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":null,"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":null,"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":null,"type":"array","etag":"","indexed":false,"editPermission":0}}	64	1
backgroundjob	lastjob	2	2	0
core	lastcron	1730337056	8	0
\.


--
-- Data for Name: oc_appconfig_ex; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_appconfig_ex (id, appid, configkey, configvalue, sensitive) FROM stdin;
\.


--
-- Data for Name: oc_authorized_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_authorized_groups (id, group_id, class) FROM stdin;
\.


--
-- Data for Name: oc_authtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_authtoken (id, uid, login_name, password, name, token, type, remember, last_activity, last_check, scope, expires, private_key, public_key, version, password_invalid, password_hash) FROM stdin;
1	admin	admin	h/y452EzteCaheKlQG4clGIu0Vvv0Kc3cqSXhrskD8J6mPA6NLNllT6169q/qHka9ZClTDFzBjXRHwxCUFcRakVcgYW+fUDv2BCeotDeGvj+3C6nbcAbfBeTJk8daK9BaJCupzZO6/x/I6l+Kq8qE2hOuLTLNPt/a2oFqBeo3mNisj1Nyv9NRzzz7VLV8xUzjJBNr5gGJm2ktxLUMFjCs2wXa/ssg1ZfpQ/R9xtwWkZTn1H5G/xs4ZfTDbXvfmSNPqShml9VCt3CJCn8ncMl+SLvdTkMVLQquHYjXE2mGTs4wizjnjJz2hT3pFpqNysxwFvI3PLxTnbZFxxQ8cBY3w==	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 YaBrowser/24.10.…	5c8679df918ce3476d3ad8381c4485e403df4f1fa6773ec79401fab5c1bea9cba2e88201e5c89f961dadb18a6aa74c10c3174630b662fd4a058e750191c998fc	0	1	1730337054	1730337054	\N	\N	b5e8cd52f8fbbb542ef1d4aa89e76956522c355f9dcd6c95d0a8fd853538e9cc84e61e1e7a36f6db65c84dc5e63605c9ec0e0064074df3efa5ff1cd6e4ad37d01270413f03ed10d3e61c43cb713657672c34012ad54ab3de10436001cdcd763044dad51394f7fcaf67e9db667c71b4536a8e9abe008977c67d80544744cea3ace371d6d50341835b2254137fe3625000671108a4faf67f68dbf6857727a26e5930dfc1be7f1d80c2899e0858d5284bbc7d25daa3aafd4a2a4be9b2e79b3556681f0f350741c0a5b329106039719a185711df0ec36f5a9583947126cec9ae4ae69bedec10dba512052477fb9db45f28491562e2a47d260390a44563efb8cb2eedfb61a5883f18f112610acbfb682f0273be5110e96fd17a9b25432308f4503b1f06786f4e718d58c1aad54c80f1673eb3e3b7744965ab0430298a474a50fe2b6d624af430860e646b14cec0512d13c96f8f6d7fd985cd2386251dd69ec1c55957bded5e3d3460295480cfa605f079e51dd275a2bf2df91c3bb86d8e6470bdd3ffc2a8fbe8661be3585ef996686bc4fd2d4d92e923bfb7e97c5496af4b4bc823c988abd4caf7d758f1d605cc3c38d14986d6350599fdd38b534fc3ca98026ceb219358278a5f9f11254f09c8d7562dce914cbf935e8c1420941a62f531862be8bf897bef6f3c414b42b14d83643e455fc19e47b8d4cb4782e99200032c36e0491c186208d1c2d98d1ae0456a22979fd5ca5d763e2b0af76b122abdf7b5b0669de35f5996929a7ec712575bd19b2593b11d770ea946f151df05faf23d668d9ec027736e58c495f550c96c7dcad691cfc7f7ed4e8f7b364ec4d85302d2a6f4fbdc95270f0fc1f46a4a3a038633ab997eabf12a0f6a87aedbaebe01819d20fae688bcd5c3990f4895736db2bac2f81c701e017fc68aaacaa6a01f8ade2296cdf116f550a3cd7cbebff21121804f6b90f883bbda25744fc995aa4572491cb3aaad282a601567c5cda432c0e4059f17fc7ef9c8e34a4c5fd20a9c3209de6580742c0da70fc2baaf75e69b6be4c6354c85d757fbadce3760379984241559fc99a1f5ac5bfed81dca97564627f2ab95ff6c1570c22509b8b71b5394053731b6d40bad3ded719d66d85d480e8259fd37823cff0d5c09880adc5062dee47f515238f5dcae12846321670672171e0301e7457d7d193e2b5d13614003622c1b9f070e9d4847de6a06337963d022c2cfef618e3447c1b5e903f4d96ac2196b4328fd72c37a2fd29a69fe34b8e9c32ab1834e0d34bb208d04955e6b1dceb154fa0108289723e998189799ddc1b3f6902fe82d5c999e8a052c6089481eacc16b6a6f3ee53487f8bbee60fdfbc3f9ef724a9083898d60135c1a275c273d9bae4b5b88de231905f09475152be204183d9f7e78dd97a6ea2bacd3f3d05d3448e62945be45a3a77c8d3d3ca0e5471d7a7ad3deea13640db64aeb3565fc04f5324397d299c6b7f4fdd6cea354a97ab2c951437c0b52019fb31454123cf3640f0a4f77f916919e0d8953d8ec35936e8806811c926eaaefcb813031f4768344a7c90c4ae2609290ba4f9baf1d48492b5e0e84413df0308c6d646a56767b1d065384a671cb87fdcfd1ff2bcc0eec763f06fdbc475715e2c5f5fcae0f612b56222ad56e4bc7d96b25bc36c556880206cf9fcdcfc5aeaf47061e98a4deba97a2bfe8dbda7067c193ce77efc808f8c2c36f06f4489722a0fc531d903ba22495c240966b369f739f8a10ffd780a69edc81f18a7005d69f5063c8f1060284788a0a3842004473b8e8c180b8a14b29d2b9980e76f7843805fb336fc02f273f969852fb64701001d7b6629608aef62f6f20a73ffcb62243bb914dcbd62d9985ebdef3b903d0218439cdd825ad8a00973e0ae9fa86ca61190796c299949d821680c4b6f36b3e2c04a43a149df6d946a2a19ff57a16a7d14152f0d3a707cf9922aed2547ce2caf09849b0a6f2489462eb9c74aa9fa068c10c179715461d23f2d5cce7163030cb1bdfb46f7af686fbc47081bbd977088f375efd73bbbb700f341c6921ce623ba6bf710fa8738d1e02e214b63b44b62517d1be4de16c73ffc9b59edc31d2aec6b66ca088c0abdcb24f61110d28b12bb9c199d26163dbf1c515e48804ce8b0396ec59c2f080b6ce752e84ea09d20138eae0d2f9474daac9f66e822bc551f14637db67d960272727b4195c2305b7c98746775971d09c6d6d23686af170ab455c48914b41ae47884527348001c280c6e679153d903006276f7219a2dd01b28ff94b6cab83341a329d722c640b00404ecfc4cc78c9581fd189097ee4606a2bbd79b671dcfbaaeef33306c4362005a070c170c0498cc4938d94912ba5b38e2d32029a3b411c07b402f8e9419d8f7b9419039126e21406777a64a455ae3e|abb66a55dc11c294ce4f49f32f1d8465|12a2a5499cf285c4a649f334b77ca46e06600e2034ec8b5ac0d23c7f5e294efcb5a98bb7db73937c703a40d325e9edf5108cc7acee525410798df59be5c4ecd4|3	-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2mA71e4ctA8wG+TdjFxz\n04djQqakUvZ3ZPohEFJXMmBQHdr7LO0lFtWAOvp/tQQFCkG3BRMK8L9v4I98ZoXi\ntqv/nNwkqUBz1KHBfxE7EEGABHsQOdX+IE/43BPiRuGpMgZyTK222Gsq812FzkF8\nsqgTJ9jwVkWs0uBruiogCT5qSxwL2PmCFSYouYzxeeJEB47c9ud1JqpAHYF/l3WF\nil/g+gIh78a/OPZnVT6/CWGSuPa1BX1ZT73C/2TnesYhdDd0LcaNFT1fPX/wccD/\nL2/CSb4A3gqnapt0j8Dj8sodtEz0mAomESxtJMyE2f9Bnxk+hMUKCEQWmCh73hGF\nKwIDAQAB\n-----END PUBLIC KEY-----\n	2	f	3|$argon2id$v=19$m=65536,t=4,p=1$NmdwOThsNDkvOGMyaFVBdQ$xPJgObL7GMYPoYEClltumueC4kW/lIUwYagrxRppCPo
\.


--
-- Data for Name: oc_bruteforce_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_bruteforce_attempts (id, action, occurred, ip, subnet, metadata) FROM stdin;
\.


--
-- Data for Name: oc_calendar_invitations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_calendar_invitations (id, uid, recurrenceid, attendee, organizer, sequence, token, expiration) FROM stdin;
\.


--
-- Data for Name: oc_calendar_reminders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_calendar_reminders (id, calendar_id, object_id, is_recurring, uid, recurrence_id, is_recurrence_exception, event_hash, alarm_hash, type, is_relative, notification_date, is_repeat_based) FROM stdin;
\.


--
-- Data for Name: oc_calendar_resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_calendar_resources (id, backend_id, resource_id, email, displayname, group_restrictions) FROM stdin;
\.


--
-- Data for Name: oc_calendar_resources_md; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_calendar_resources_md (id, resource_id, key, value) FROM stdin;
\.


--
-- Data for Name: oc_calendar_rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_calendar_rooms (id, backend_id, resource_id, email, displayname, group_restrictions) FROM stdin;
\.


--
-- Data for Name: oc_calendar_rooms_md; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_calendar_rooms_md (id, room_id, key, value) FROM stdin;
\.


--
-- Data for Name: oc_calendarchanges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_calendarchanges (id, uri, synctoken, calendarid, operation, calendartype, created_at) FROM stdin;
\.


--
-- Data for Name: oc_calendarobjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_calendarobjects (id, calendardata, uri, calendarid, lastmodified, etag, size, componenttype, firstoccurence, lastoccurence, uid, classification, calendartype, deleted_at) FROM stdin;
\.


--
-- Data for Name: oc_calendarobjects_props; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_calendarobjects_props (id, calendarid, objectid, name, parameter, value, calendartype) FROM stdin;
\.


--
-- Data for Name: oc_calendars; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_calendars (id, principaluri, displayname, uri, synctoken, description, calendarorder, calendarcolor, timezone, components, transparent, deleted_at) FROM stdin;
\.


--
-- Data for Name: oc_calendarsubscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_calendarsubscriptions (id, uri, principaluri, displayname, refreshrate, calendarorder, calendarcolor, striptodos, stripalarms, stripattachments, lastmodified, synctoken, source) FROM stdin;
\.


--
-- Data for Name: oc_cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_cards (id, addressbookid, carddata, uri, lastmodified, etag, size, uid) FROM stdin;
\.


--
-- Data for Name: oc_cards_properties; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_cards_properties (id, addressbookid, cardid, name, value, preferred) FROM stdin;
\.


--
-- Data for Name: oc_circles_circle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_circles_circle (id, unique_id, name, display_name, sanitized_name, instance, config, source, settings, description, creation, contact_addressbook, contact_groupname) FROM stdin;
1	4RLqGs1rRcEiVjSZpexhnuU6iXuWict	user:admin:4RLqGs1rRcEiVjSZpexhnuU6iXuWict	admin			1	1	[]		2024-10-31 00:22:57	0	
2	Pc6uoAaacSdfgo2pPvCf7OyhaXhBodJ	app:circles:Pc6uoAaacSdfgo2pPvCf7OyhaXhBodJ	Circles			8193	10001	[]		2024-10-31 00:22:57	0	
\.


--
-- Data for Name: oc_circles_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_circles_event (token, instance, event, result, interface, severity, retry, status, updated, creation) FROM stdin;
\.


--
-- Data for Name: oc_circles_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_circles_member (id, single_id, circle_id, member_id, user_id, user_type, instance, invited_by, level, status, note, cached_name, cached_update, contact_id, contact_meta, joined) FROM stdin;
1	Pc6uoAaacSdfgo2pPvCf7OyhaXhBodJ	Pc6uoAaacSdfgo2pPvCf7OyhaXhBodJ	Pc6uoAaacSdfgo2pPvCf7OyhaXhBodJ	circles	10000		\N	9	Member	[]	Circles	2024-10-31 00:22:57		\N	2024-10-31 00:22:57
2	4RLqGs1rRcEiVjSZpexhnuU6iXuWict	4RLqGs1rRcEiVjSZpexhnuU6iXuWict	4RLqGs1rRcEiVjSZpexhnuU6iXuWict	admin	1		Pc6uoAaacSdfgo2pPvCf7OyhaXhBodJ	9	Member	[]	admin	2024-10-31 00:22:57		\N	2024-10-31 00:22:57
\.


--
-- Data for Name: oc_circles_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_circles_membership (circle_id, single_id, level, inheritance_first, inheritance_last, inheritance_depth, inheritance_path) FROM stdin;
Pc6uoAaacSdfgo2pPvCf7OyhaXhBodJ	Pc6uoAaacSdfgo2pPvCf7OyhaXhBodJ	9	Pc6uoAaacSdfgo2pPvCf7OyhaXhBodJ	Pc6uoAaacSdfgo2pPvCf7OyhaXhBodJ	1	["Pc6uoAaacSdfgo2pPvCf7OyhaXhBodJ"]
4RLqGs1rRcEiVjSZpexhnuU6iXuWict	4RLqGs1rRcEiVjSZpexhnuU6iXuWict	9	4RLqGs1rRcEiVjSZpexhnuU6iXuWict	4RLqGs1rRcEiVjSZpexhnuU6iXuWict	1	["4RLqGs1rRcEiVjSZpexhnuU6iXuWict"]
\.


--
-- Data for Name: oc_circles_mount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_circles_mount (id, mount_id, circle_id, single_id, token, parent, mountpoint, mountpoint_hash) FROM stdin;
\.


--
-- Data for Name: oc_circles_mountpoint; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_circles_mountpoint (id, mount_id, single_id, mountpoint, mountpoint_hash) FROM stdin;
\.


--
-- Data for Name: oc_circles_remote; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_circles_remote (id, type, interface, uid, instance, href, item, creation) FROM stdin;
\.


--
-- Data for Name: oc_circles_share_lock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_circles_share_lock (id, item_id, circle_id, instance) FROM stdin;
\.


--
-- Data for Name: oc_circles_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_circles_token (id, share_id, circle_id, single_id, member_id, token, password, accepted) FROM stdin;
\.


--
-- Data for Name: oc_collres_accesscache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_collres_accesscache (user_id, collection_id, resource_type, resource_id, access) FROM stdin;
\.


--
-- Data for Name: oc_collres_collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_collres_collections (id, name) FROM stdin;
\.


--
-- Data for Name: oc_collres_resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_collres_resources (collection_id, resource_type, resource_id) FROM stdin;
\.


--
-- Data for Name: oc_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_comments (id, parent_id, topmost_parent_id, children_count, actor_type, actor_id, message, verb, creation_timestamp, latest_child_timestamp, object_type, object_id, reference_id, reactions, expire_date, meta_data) FROM stdin;
\.


--
-- Data for Name: oc_comments_read_markers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_comments_read_markers (user_id, object_type, object_id, marker_datetime) FROM stdin;
\.


--
-- Data for Name: oc_dav_absence; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_dav_absence (id, user_id, first_day, last_day, status, message, replacement_user_id, replacement_user_display_name) FROM stdin;
\.


--
-- Data for Name: oc_dav_cal_proxy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_dav_cal_proxy (id, owner_id, proxy_id, permissions) FROM stdin;
\.


--
-- Data for Name: oc_dav_shares; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_dav_shares (id, principaluri, type, access, resourceid, publicuri) FROM stdin;
\.


--
-- Data for Name: oc_direct_edit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_direct_edit (id, editor_id, token, file_id, user_id, share_id, "timestamp", accessed, file_path) FROM stdin;
\.


--
-- Data for Name: oc_directlink; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_directlink (id, user_id, file_id, token, expiration) FROM stdin;
\.


--
-- Data for Name: oc_ex_apps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_apps (id, appid, version, name, daemon_config_name, port, secret, status, enabled, created_time) FROM stdin;
\.


--
-- Data for Name: oc_ex_apps_daemons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_apps_daemons (id, name, display_name, accepts_deploy_id, protocol, host, deploy_config) FROM stdin;
\.


--
-- Data for Name: oc_ex_apps_routes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_apps_routes (id, appid, url, verb, access_level, headers_to_exclude, bruteforce_protection) FROM stdin;
\.


--
-- Data for Name: oc_ex_event_handlers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_event_handlers (id, appid, event_type, event_subtypes, action_handler) FROM stdin;
\.


--
-- Data for Name: oc_ex_occ_commands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_occ_commands (id, appid, name, description, hidden, arguments, options, usages, execute_handler) FROM stdin;
\.


--
-- Data for Name: oc_ex_settings_forms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_settings_forms (id, appid, formid, scheme) FROM stdin;
\.


--
-- Data for Name: oc_ex_speech_to_text; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_speech_to_text (id, appid, name, display_name, action_handler) FROM stdin;
\.


--
-- Data for Name: oc_ex_speech_to_text_q; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_speech_to_text_q (id, result, error, finished, created_time) FROM stdin;
\.


--
-- Data for Name: oc_ex_task_processing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_task_processing (id, app_id, name, display_name, task_type, custom_task_type, provider) FROM stdin;
\.


--
-- Data for Name: oc_ex_text_processing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_text_processing (id, appid, name, display_name, action_handler, task_type) FROM stdin;
\.


--
-- Data for Name: oc_ex_text_processing_q; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_text_processing_q (id, result, error, finished, created_time) FROM stdin;
\.


--
-- Data for Name: oc_ex_translation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_translation (id, appid, name, display_name, from_languages, to_languages, action_handler, action_detect_lang) FROM stdin;
\.


--
-- Data for Name: oc_ex_translation_q; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_translation_q (id, result, error, finished, created_time) FROM stdin;
\.


--
-- Data for Name: oc_ex_ui_files_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_ui_files_actions (id, appid, name, display_name, mime, permissions, "order", icon, action_handler, version) FROM stdin;
\.


--
-- Data for Name: oc_ex_ui_scripts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_ui_scripts (id, appid, type, name, path, after_app_id) FROM stdin;
\.


--
-- Data for Name: oc_ex_ui_states; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_ui_states (id, appid, type, name, key, value) FROM stdin;
\.


--
-- Data for Name: oc_ex_ui_styles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_ui_styles (id, appid, type, name, path) FROM stdin;
\.


--
-- Data for Name: oc_ex_ui_top_menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ex_ui_top_menu (id, appid, name, display_name, icon, admin_required) FROM stdin;
\.


--
-- Data for Name: oc_federated_reshares; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_federated_reshares (share_id, remote_id) FROM stdin;
\.


--
-- Data for Name: oc_file_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_file_locks (id, lock, key, ttl) FROM stdin;
46	0	files/b695e4b3484f6df7fc0eecb24de92e8b	1730337846
80	0	files/2b7672f973c3a15d28236ab9fb12e2d0	1730337874
4	0	files/4d0a5085369fc0554c67b8420144d947	1730337846
5	0	files/e383867aff18b7c5e8263b4253ceaed7	1730337846
6	0	files/a3594fd4eca7119cb937772e1f8f5415	1730337846
7	0	files/b0df350f6c579724f72f7a9e8f1d1be3	1730337846
8	0	files/04b04fe189b4d860ee921c334b784a45	1730337846
9	0	files/9776180ed070c788377c96bbfc24ea18	1730337846
10	0	files/c664b097928118f6350c22131da63fec	1730337846
11	0	files/f2aa49601b7da42eb5ec7bb2adb7561a	1730337846
12	0	files/14170dfc3f2cf15e29ed79ac7dcb0218	1730337846
13	0	files/d9712b9716cc3bf1291505ee6348f1c3	1730337846
14	0	files/3513aba8aa4305d3ad33fc7122d4af30	1730337846
15	0	files/ffa8b01491fafe4496ddf6fc6eaaa8dc	1730337846
16	0	files/6b2de085d9b53fa93fa74433933ff37f	1730337846
17	0	files/3bf81792d8ce10562404153add132f75	1730337846
18	0	files/cecfa4eb5a3277d2b93f3c58256f99d8	1730337846
19	0	files/26592869621775b437da2223f81b57ec	1730337846
20	0	files/2c7eaecb9090bd89cef1dcd4d0d5881a	1730337846
21	0	files/a21f2db2857ff8f0af2d086b900d6dd3	1730337846
22	0	files/50828671bb59ecfd2bc1cbff52e5077a	1730337846
23	0	files/c17e8098cd101dbe333f74e78257b737	1730337846
24	0	files/cdf4769023065d25ae5571bf77c9200c	1730337846
25	0	files/d1f9adf6eb0cc7dd37f84ad006435d93	1730337846
26	0	files/bce9630d228b40c3bf6478933cfc6da6	1730337846
27	0	files/6b287149c319860005f7cf2e40c1d09e	1730337846
28	0	files/6b025307057aa3d4fb90ad56c311dd89	1730337846
29	0	files/3b8d36bb36a199b8971d25e9c7eb3aa2	1730337846
30	0	files/2762ef7643fb4a1413af031a0aac3a4e	1730337846
31	0	files/10a803d2e57d9a2f22c4d5f93a7a3ff4	1730337846
32	0	files/eb88e86b9f781dd43c596eb05ba13814	1730337846
33	0	files/670fee0cbc7fb92580e0c43a8eec2b68	1730337846
34	0	files/ce956f85c654587bcfd65328c5491387	1730337846
35	0	files/b75b806b4d6e7e77198487745bdb05ce	1730337846
36	0	files/9eb2a98da8094292dc6cf5a6e79ee7a2	1730337846
37	0	files/bc6fe456601d213821f6950978ac5a8e	1730337846
38	0	files/9bfc15c790807b5630bc67a3cd76e6de	1730337846
39	0	files/a41794afafa4a001f6e9c3ef18b21990	1730337846
40	0	files/88dbb101e895c935de2c7e120272edb2	1730337846
41	0	files/b575091e218e272ae165c773674f569a	1730337846
42	0	files/53ad21e8141c35aa10a0b3d25675c487	1730337846
43	0	files/007ce985c1c578f9782ec24e3cc637a9	1730337846
44	0	files/dd30906cc296af85444d734e2d00469a	1730337846
45	0	files/d10a8c9c61027b86aec9821239de20f1	1730337846
47	0	files/95d9e9dd4eefd9b3d43be7d481719437	1730337846
48	0	files/d4a14ebc64e5bd2e4f16dd662d1f2f4c	1730337846
49	0	files/07a057f5d336990a6e6bf8746dfea979	1730337846
50	0	files/77c8515497f602b741791fcfce9b3fcc	1730337846
51	0	files/b6e0759e050388650b5f1287c1b96803	1730337846
52	0	files/79b5c3a9bd647253e892cd34ae8fbf99	1730337846
53	0	files/baa1a49dafe4a7cbe8bcd67a387369da	1730337846
54	0	files/97d15c943c24571e9d96b3b56ea1fab7	1730337846
55	0	files/e07516eb75bb0612a31d042984bf5f81	1730337846
56	0	files/4e426f49f1f84f3c02a83c262a232960	1730337846
57	0	files/0f74876037f6f8741f1a8b46e67d977a	1730337846
58	0	files/a56e46a0840130c77801888b7938ef44	1730337846
59	0	files/9a0b39a848b58c9ae6c99efc97236b17	1730337846
60	0	files/99e7157d3c108dea2df788adac98dcdf	1730337846
61	0	files/50ecde4704a2b3c10bf78e6ddf4e6dd8	1730337846
62	0	files/585427965688188d3e490bfeafa0dc23	1730337846
63	0	files/72c4638c236edf2ec81e1df367b7af50	1730337846
64	0	files/19baa7c26d24e47f13d42bb8b091ab32	1730337846
65	0	files/84fc6d08ed3bd071bcdab33a99d2d7d9	1730337846
66	0	files/47538805457b7a5c23cdc08e3858b70a	1730337846
67	0	files/c492d3d32aa90c35d6bf235f7e123aec	1730337846
68	0	files/a412c1deefd2e9d760c25a710847f796	1730337846
69	0	files/65c01881f1be38fb66046ed8188f51ee	1730337846
70	0	files/ad16b97dfd273c55c5f15661de36db84	1730337846
71	0	files/4391a7ecedf7675ce5603834db81641f	1730337846
72	0	files/eaaad54de88a95e834e6e7164b2a3e2c	1730337846
73	0	files/83f44a83c313ebf8afb1ece18b387c24	1730337846
74	0	files/a696a612dc95ed2ccbf08146d21b485d	1730337846
75	0	files/cbc6f4e337332b94c2e02444d64b1c16	1730337846
76	0	files/e016be2b058d14bafb1412a962744aba	1730337846
2	0	files/b6ef755cfc70b5eb94f5d3aad8ba833d	1730337846
1	0	files/e8482945c9011a1fad7f0293d9760c26	1730337846
77	0	files/b4a14fde31daa9633bc8efb453e6286e	1730337860
78	0	files/1301749863afc8a61d58799f5031bff0	1730337874
81	0	files/1666d4ef5bbac5028233ad221f1d2a9a	1730337874
83	0	files/e53d14b0b072496d5bdb7caa1aa4881e	1730337874
93	0	files/fa3f8aae23f26268bf1d0ab1dfe97335	1730337874
94	0	files/70e44378ec306e1d50f036886871684c	1730337874
79	0	files/098f7066954794fbdc1c5e1758d90fcb	1730337874
95	0	files/ee044d74b5c94dfa76c5e3f64e9c5669	1730337874
96	0	files/04370be60ade6f67c45caed02120ddd5	1730337874
97	0	files/1a414b885a65f573c40bf853417e2a26	1730337874
84	0	files/68d99afc0ae1ee880b50f09bd874cd55	1730337874
86	0	files/3333b13b9db3d12ed24c442553147d38	1730337874
98	0	files/48607ea7cb8e21aaf2e1089f1d530489	1730337875
99	0	files/319d7692affb8b5f930f052fa6463040	1730337875
100	0	files/a56def31ee3fe1652c9153de32e6ed75	1730337875
101	0	files/be479a6b914ac82c6338f055f2b86784	1730337875
102	0	files/020f9e0ccf3488e8c7b14b5d7d884a01	1730337875
103	0	files/74d0a0ebf3fa7e4f2b7556ad35d9599a	1730337875
104	0	files/9acdcf3c0df13b8a00674166a6a62016	1730337875
105	0	files/36ea1e9e3a4344b4e64e9b3556d830af	1730337875
106	0	files/271a9084221edee7c477fc5585227045	1730337875
107	0	files/0ff54e64f019b7ded13c73bd2f42498b	1730337875
108	0	files/d3407a09141f8cf530b14f2b40e279b3	1730337875
109	0	files/54506b599d55aa386a20596c828387c8	1730337875
110	0	files/f299d78800ab35ba9ebb95c730477a0b	1730337875
111	0	files/d0a880de4567911f016cd8181c59c7f9	1730337875
112	0	files/f4e3b1e1db3664f08b027b3fe6ad2bcc	1730337875
113	0	files/be5353c0aab96e9ff642937beb602090	1730337875
114	0	files/7195a8739e4c9b8135a7975735f789a1	1730337875
115	0	files/8dc7335332d4b73e62e5fc9edbaa3f7d	1730337875
116	0	files/84b4f50276d83968811d700414e43ca1	1730337875
117	0	files/9cae0b134989f6c29e09c26177dbad34	1730337875
118	0	files/2fa771f144683666f415672c593e8d6d	1730337875
119	0	files/197fbc7d7bb7f4ae1057a5fd0a0e4fa8	1730337876
120	0	files/274a576e411056b2d6184e6247b1bded	1730337876
121	0	files/3d91dedf65a82e7160cfdc57b6876e44	1730337876
122	0	files/be38439d66a0be94cafff24727453659	1730337876
123	0	files/af15c438ae9d97f7adb2dbcd117f2c07	1730337876
124	0	files/0bfdc62f0f6a248309f356beba514c61	1730337876
125	0	files/14a9af8b0e302c8d650e076d71f62f52	1730337876
132	0	files/f9e937621a87e4ef63799c17c589d04b	1730337876
133	0	files/ded2ff422e912f9383556a1b427fe53a	1730337876
134	0	files/48615c60edf3db22deb0d735a39c0060	1730337876
135	0	files/4577a84a3f669ffc4db52217f04781ec	1730337876
136	0	files/cbac126d17c49ae4019a46c5eee7946d	1730337876
137	0	files/d5ca8cbbdcfdfa53c77619413204ea65	1730337876
126	0	files/a5fd154e2755eda86a3930dfb2fd7caa	1730337876
127	0	files/30da4d994f31799a92ecca8ff4fbe5f6	1730337876
128	0	files/18abaf6d9d866eaa458ba8c4dc81bf1b	1730337876
129	0	files/862a6c1a871ec970bfdcd384f31b0385	1730337876
130	0	files/9e4cde5183d2cdda3a5bac0f9e1520a6	1730337876
131	0	files/a751f0949c221b88df2a4edb8c47ff5b	1730337876
138	0	files/070a779af6d947d4e7a2e92a5ec41a6f	1730337877
139	0	files/908e6c3f16b3d5461bf57b2eadace1d3	1730337877
140	0	files/832f69531d3a880ebf80fb064117d2fe	1730337877
141	0	files/a95b514c2055df9eab120c27bc3f0f06	1730337877
142	0	files/68b5eee59cc9e9ad06017e49513549bd	1730337877
143	0	files/a8866b60e6a100f9bd36ba406f022e9c	1730337877
147	0	files/b28bdc16a3ee070595c2379a39f7d47d	1730337877
144	0	files/e7fe70930951173d8117eb208145bd4a	1730337877
145	0	files/ca7675ee22d50912174dcd11ee765025	1730337877
146	0	files/caa24a1d219b769adf42a2ba40dd8fe9	1730337877
150	0	files/524cb7cf14572b5a74030e0f7d60f1ab	1730337877
148	0	files/eb55cce123951cee74ba78106422db06	1730337877
155	0	files/ad6da5b39214e39cc1237295686502de	1730337877
156	0	files/63c18e3045666384c0d6229546f092ea	1730337877
157	0	files/d31ad1fafe383164890526be495833ad	1730337877
158	0	files/26a13990be4f709f4092390b8471026e	1730337877
159	0	files/2f138b1aff9aff1135fbad7aa4dfd666	1730337877
160	0	files/6b9ad81f3fde5647e0f15acee6d5d506	1730337877
161	0	files/371b4ee55b7f0044eeb34300a18ae776	1730337877
151	0	files/689a05db49d7b81c3cda625419b28b5d	1730337877
162	0	files/fdcaf95a3bbad422d947f0eaae9eb03c	1730337878
163	0	files/15c7d60acd9055d88c3cf10de4ab6e87	1730337878
164	0	files/fc226b4152611a73cf8d32f8bc2b6239	1730337878
165	0	files/6a2099d094d7396ca424d56917681364	1730337878
166	0	files/45d0b81c9c60f1888dbdd3d3713c22e1	1730337878
167	0	files/78568ffaedf8def16fee0ea49890d288	1730337878
168	0	files/32b7467ada97590278bb5dee0d3bb72b	1730337878
177	0	files/dedfed24417abecbcc2391135139af4c	1730337878
178	0	files/f578a6dc07fa2940586ed0740c808156	1730337878
179	0	files/ee1379c49db0d8a132779a34c4c93e9c	1730337878
180	0	files/9baed60d054d11f130eef54379e9f140	1730337878
181	0	files/71303cc587a48d728b8204ac32062da3	1730337878
182	0	files/f788c0a51f93c2a16eebcef5cb25c3fc	1730337878
169	0	files/137a1b5cdbabc31b0af7f50c0abfe12f	1730340656
88	0	files/ff3b7c4061713c960e510a10d17b3860	1730340656
89	0	files/d503606e30519509d5bc6c42f508b0d7	1730340656
185	0	files/e0ce94e8430c291b5534745e51a3cb9a	1730340656
149	0	files/9a35999eafb219f5ceb9186987689f0d	1730340656
187	0	files/7c1da151c20c3a505e3d8ed84185ef16	1730340656
188	0	files/90b028a528d9e71aeabddcf9d083ba3c	1730340656
\.


--
-- Data for Name: oc_filecache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_filecache (fileid, storage, path, path_hash, parent, name, mimetype, mimepart, size, mtime, storage_mtime, encrypted, unencrypted_size, etag, permissions, checksum) FROM stdin;
58	1	cache	0fea6a13c52b4d4725368f24b045ca84	1	cache	2	1	0	1729856346	1729856346	0	0	6722ce268ef25	31	
3	1	files/Nextcloud intro.mp4	e4919345bcc87d4585a5525daaad99c0	2	Nextcloud intro.mp4	4	3	3963036	1729856347	1729856347	0	0	1f51b7ce2910a7eb71efb212d398a7ea	27	
14	1	files/Nextcloud Manual.pdf	2bc58a43566a8edde804a4a97a9c7469	2	Nextcloud Manual.pdf	10	9	12860592	1729856346	1729856346	0	0	dc49a5fa692e49cc1bc4586aabf9f8dc	27	
15	1	files/Readme.md	49af83716f8dcbfa89aaf835241c0b9f	2	Readme.md	8	7	206	1729856347	1729856347	0	0	b15265df81b7d27321bcda3cec34adcf	27	
16	1	files/Nextcloud.png	2bcc0ff06465ef1bfc4a868efde1e485	2	Nextcloud.png	11	5	50598	1729856347	1729856347	0	0	94be59b847166bc9de89eab0b5f24b25	27	
5	1	files/Photos/Birdie.jpg	cd31c7af3a0ec6e15782b5edd2774549	4	Birdie.jpg	6	5	593508	1729856346	1729856346	0	0	a23a63f4ed2d8d23fb455d13ff0ebd03	27	
6	1	files/Photos/Toucan.jpg	681d1e78f46a233e12ecfa722cbc2aef	4	Toucan.jpg	6	5	167989	1729856346	1729856346	0	0	fcfc85c00d46b9f409408139a882c322	27	
7	1	files/Photos/Library.jpg	0b785d02a19fc00979f82f6b54a05805	4	Library.jpg	6	5	2170375	1729856346	1729856346	0	0	65fb105ab1c6f5e1702aafafa4cff4f9	27	
8	1	files/Photos/Frog.jpg	d6219add1a9129ed0c1513af985e2081	4	Frog.jpg	6	5	457744	1729856346	1729856346	0	0	5142c3629c50578d32ed11fc1a37e223	27	
9	1	files/Photos/Vineyard.jpg	14e5f2670b0817614acd52269d971db8	4	Vineyard.jpg	6	5	427030	1729856346	1729856346	0	0	f2b85f1b7a3ee0b756c2bd0f3a12232b	27	
10	1	files/Photos/Gorilla.jpg	6d5f5956d8ff76a5f290cebb56402789	4	Gorilla.jpg	6	5	474653	1729856346	1729856346	0	0	3656ff57f648d3046e8d6e80d04514c3	27	
11	1	files/Photos/Nextcloud community.jpg	b9b3caef83a2a1c20354b98df6bcd9d0	4	Nextcloud community.jpg	6	5	797325	1729856346	1729856346	0	0	f31e966a66ec388236c80b58db79f653	27	
12	1	files/Photos/Readme.md	2a4ac36bb841d25d06d164f291ee97db	4	Readme.md	8	7	150	1729856346	1729856346	0	0	551096369270d391e59b720e1358b04b	27	
13	1	files/Photos/Steps.jpg	7b2ca8d05bbad97e00cbf5833d43e912	4	Steps.jpg	6	5	567689	1729856346	1729856346	0	0	a51de9e4a6bf4987f725b830d479aa8d	27	
59	1	files_trashbin	fb66dca5f27af6f15c1d1d81e6f8d28b	1	files_trashbin	2	1	1163970	1730334246	1729857835	0	0	6722ce26cffd8	31	
4	1	files/Photos	d01bb67e7b71dd49fd06bad922f521c9	2	Photos	2	1	15755462	1730334246	1729860936	0	0	6722ce26cffd8	31	
60	1	files_trashbin/keys	9195c7cfc1b867f229ac78cc1b6a0be3	59	keys	2	1	0	1729857835	1729857835	0	0	6722ce2698a0e	31	
61	1	files_trashbin/versions	c639d144d3f1014051e14a98beac5705	59	versions	2	1	0	1729857835	1729857835	0	0	6722ce2698ae5	31	
63	1	files_trashbin/files/28b278b6-4c69-499b-9580-85d2fca26058.jpg.d1729858057	04fd1c1cfe680bdefece971789f6e59d	62	28b278b6-4c69-499b-9580-85d2fca26058.jpg.d1729858057	18	9	581985	1729103820	1729103820	0	0	d9df7e2a8fd47b281bd3883b5a2f2542	27	
51	1	files/Templates credits.md	f7c01e3e0b55bb895e09dc08d19375b3	2	Templates credits.md	8	7	2403	1729856347	1729856347	0	0	9b0b0b82c65044617766f616b4ee27b2	27	
52	1	files/Reasons to use Nextcloud.pdf	418b19142a61c5bef296ea56ee144ca3	2	Reasons to use Nextcloud.pdf	10	9	976625	1729856347	1729856347	0	0	31edbeda9e3038af2828cf6c4fc0da49	27	
54	1	files/Documents/Example.md	efe0853470dd0663db34818b444328dd	53	Example.md	8	7	1095	1729856346	1729856346	0	0	857d0d9a6d9ab291203810472f79b387	27	
55	1	files/Documents/Nextcloud flyer.pdf	9c5b4dc7182a7435767708ac3e8d126c	53	Nextcloud flyer.pdf	10	9	1083339	1729856346	1729856346	0	0	9b8bc08094563de0d365fea74bdb8f03	27	
56	1	files/Documents/Readme.md	51ec9e44357d147dd5c212b850f6910f	53	Readme.md	8	7	136	1729856346	1729856346	0	0	0ec7413503bf274c692b615635ccc478	27	
57	1	files/Documents/Welcome to Nextcloud Hub.docx	b44cb84f22ceddc4ca2826e026038091	53	Welcome to Nextcloud Hub.docx	17	9	24295	1729856346	1729856346	0	0	2306379864bcd815fafda46b25a87a92	27	
1	1		d41d8cd98f00b204e9800998ecf8427e	-1		2	1	46823872	1730334246	1729857835	0	0	6722ce26cffd8	23	
2	1	files	45b963397aa40d4a0063e0d85e4fe7a1	1	files	2	1	45659902	1730334246	1729856347	0	0	6722ce26cffd8	31	
53	1	files/Documents	0ad78ba05b6961d92f7970b2b3922eca	2	Documents	2	1	1108865	1730334246	1729856346	0	0	6722ce26cffd8	31	
64	1	files_trashbin/files/28b278b6-4c69-499b-9580-85d2fca26058.jpg.d1729857835	a7b3984c47d1e0f3f286032a915db014	62	28b278b6-4c69-499b-9580-85d2fca26058.jpg.d1729857835	18	9	581985	1729103820	1729103820	0	0	c798fa33aa5b197ff3f710f1473a08e1	27	
66	1	files/Шаблоны/Mother's day.odt	50caba58c7937fc4a6ab1d2d5b6f265d	65	Mother's day.odt	12	9	340061	1729856346	1729856346	0	0	0b032b46d132d1ab7764c3478815fe3b	27	
67	1	files/Шаблоны/Photo book.odt	ec940badcb44839828c67b8b89f7ee32	65	Photo book.odt	12	9	5155877	1729856346	1729856346	0	0	c67e0c65adf4ffea5810ee5034920e55	27	
68	1	files/Шаблоны/Business model canvas.ods	7f3e2caefa462380184fab92771011cd	65	Business model canvas.ods	13	9	52843	1729856346	1729856346	0	0	18ba4c24484d608a0d311179bc107a6a	27	
69	1	files/Шаблоны/Invoice.odt	4a60df9d144a0b680a3ef6bd6140ec9d	65	Invoice.odt	12	9	17276	1729856346	1729856346	0	0	6d2930b3d26b6dfc94ada604216734a2	27	
70	1	files/Шаблоны/Modern company.odp	cedee4df4e9bccf8c1efe470c861fdd9	65	Modern company.odp	14	9	317015	1729856346	1729856346	0	0	0e6a1a38aa834231b61ca8792c73317e	27	
71	1	files/Шаблоны/Resume.odt	c328edb26e47553625806c89e9d76819	65	Resume.odt	12	9	39404	1729856346	1729856346	0	0	1c9682a94e2b34e1588c73498268c93d	27	
72	1	files/Шаблоны/Brainstorming.whiteboard	5f41358e166809defec8171800030182	65	Brainstorming.whiteboard	15	9	30780	1729856346	1729856346	0	0	417dc6e68e4e0e9f204602cb7f2eb1ec	27	
73	1	files/Шаблоны/Flowchart.whiteboard	d2dfc18ace1fd1ef2ceeb1f0b94d424d	65	Flowchart.whiteboard	15	9	31132	1729856346	1729856346	0	0	f20fe8e62382681449c9b957579cb8b4	27	
74	1	files/Шаблоны/Yellow idea.odp	87c1e3a586f3352f41aff5ee68418815	65	Yellow idea.odp	14	9	81196	1729856346	1729856346	0	0	d37815adad21f5fdea741d2830dcd732	27	
75	1	files/Шаблоны/Business model canvas.odg	d2928c01e2a2a596bad63f3ce330340d	65	Business model canvas.odg	16	9	16988	1729856346	1729856346	0	0	54b80ad1090a31e4c5228e72507a8726	27	
76	1	files/Шаблоны/Timeline.whiteboard	48b994344715beeb470f8b7673888af5	65	Timeline.whiteboard	15	9	31325	1729856346	1729856346	0	0	4be931ee8926dad9c8c4a5dd4f1e91db	27	
77	1	files/Шаблоны/Venn diagram.whiteboard	37f0564d8703c46a66aae8952b2970ea	65	Venn diagram.whiteboard	15	9	23359	1729856346	1729856346	0	0	a5980b4fffeddfa8ad9d90b1355a1fc9	27	
78	1	files/Шаблоны/Business model canvas.whiteboard	3dc9c951923e9de1f2653f885c491947	65	Business model canvas.whiteboard	15	9	30290	1729856346	1729856346	0	0	717d1d6384410de6dd7d54b445dd33f5	27	
79	1	files/Шаблоны/Mindmap.odg	e80d4d1f8653ed3c5b9331936097ab33	65	Mindmap.odg	16	9	13653	1729856346	1729856346	0	0	5b0bb5c987fbb49990603a05992713f9	27	
80	1	files/Шаблоны/Diagram & table.ods	ab7b65f2ffbaa387dff2a22166fcc422	65	Diagram & table.ods	13	9	13378	1729856346	1729856346	0	0	e6b2da45dd52cff28786a08455708199	27	
81	1	files/Шаблоны/Org chart.odg	c972c2f87b49757b7f7cc824b8b58500	65	Org chart.odg	16	9	13878	1729856346	1729856346	0	0	374e9f39139c0dc9ad95c493f155cc5a	27	
82	1	files/Шаблоны/Meeting notes.md	5f2853c91c82ee8cac05eca924947a6e	65	Meeting notes.md	8	7	326	1729856346	1729856346	0	0	58f9c4c1d93ca5222671fdb64a7a4128	27	
83	1	files/Шаблоны/Impact effort.whiteboard	8d81ce953d985ca45ab6d5a476d200d5	65	Impact effort.whiteboard	15	9	30671	1729856346	1729856346	0	0	79263c34e008524f0e021b645dd3d750	27	
84	1	files/Шаблоны/Flowchart.odg	a67f73a8abbe3e69569dc0459aafa8fc	65	Flowchart.odg	16	9	11836	1729856346	1729856346	0	0	7099fd3c1788eb881bc6a49a9d44f52b	27	
85	1	files/Шаблоны/Mind map.whiteboard	0a4c9588b99b451c1b88ed9925f02541	65	Mind map.whiteboard	15	9	35657	1729856346	1729856346	0	0	f6be8b9faf829a61b074bde31ba34416	27	
86	1	files/Шаблоны/Meeting agenda.whiteboard	54c87c757d98833064b980d14ba117b3	65	Meeting agenda.whiteboard	15	9	27629	1729856346	1729856346	0	0	68279ae6b458f217fafd270641ceba8b	27	
87	1	files/Шаблоны/Readme.md	86f8b32fa5a3b87df88515298a8daf92	65	Readme.md	8	7	554	1729856346	1729856346	0	0	9374fb28293db9f22a8c983c0f4dced5	27	
88	1	files/Шаблоны/Product plan.md	a9763dd69fe6a70172c67cf932462e2c	65	Product plan.md	8	7	573	1729856346	1729856346	0	0	0ed494ee2415a43865a12adf1055adc9	27	
89	1	files/Шаблоны/Timesheet.ods	b69151b29d3ffaba66b5e5a2f1d9c4be	65	Timesheet.ods	13	9	88394	1729856346	1729856346	0	0	f1ec48c1da987edd47c1aa223b1b43b5	27	
90	1	files/Шаблоны/Simple.odp	b3ded56369aeae536966c6b51faf0007	65	Simple.odp	14	9	14810	1729856346	1729856346	0	0	cc1dc87d0adaadcceebd768f221cbff3	27	
91	1	files/Шаблоны/Kanban board.whiteboard	8cd7eac2a008b502cb3b28679cc15e3c	65	Kanban board.whiteboard	15	9	25621	1729856346	1729856346	0	0	dd12db09f08f49363f3745fb175b9296	27	
92	1	files/Шаблоны/Syllabus.odt	8e1bbb81ba30fd183bc224236e793a1b	65	Syllabus.odt	12	9	30354	1729856346	1729856346	0	0	7a6ebf9f0eb04a785018b23ce1f3c8e3	27	
93	1	files/Шаблоны/Letter.odt	41a85da1c31ae56a0e7528de96ac3779	65	Letter.odt	12	9	15961	1729856346	1729856346	0	0	44d618778c13b3f18e676d7a288191a4	27	
94	1	files/Шаблоны/Sticky notes.whiteboard	146759fd78a15446d11108a2867ad060	65	Sticky notes.whiteboard	15	9	45778	1729856346	1729856346	0	0	b012bd13b5cddf5510f7de945051d0e1	27	
62	1	files_trashbin/files	3014a771cbe30761f2e9ff3272110dbf	59	files	2	1	1163970	1730334246	1729858057	0	0	6722ce26cffd8	31	
95	1	files/Шаблоны/Elegant.odp	84e4d694b123ac2dd753daa10efb6ada	65	Elegant.odp	14	9	14316	1729856346	1729856346	0	0	41d8661b64447b337e4a4b3ee92e41f9	27	
96	1	files/Шаблоны/Party invitation.odt	e22087b17ba0ff7cea6b9a2ff2232cf0	65	Party invitation.odt	12	9	868111	1729856346	1729856346	0	0	1ad97265d8ded5079bee7a024df1d257	27	
97	1	files/Шаблоны/Gotong royong.odp	ff4375a068e8858681eb5767926bc825	65	Gotong royong.odp	14	9	3509628	1729856346	1729856346	0	0	62c88a4fc5a593d106ef91a9b2a9725c	27	
98	1	files/Шаблоны/Expense report.ods	81b3ac7c38dfc3c390e572de0f42e7f0	65	Expense report.ods	13	9	13441	1729856346	1729856346	0	0	873291982d3472a7c70d333cf01233f7	27	
99	1	files/Photos/minsk_halfmarathon2024-20240908170313-1ef3a1d0d4f3.jpg	65bd661f515439ba0534d972b4bf2dde	4	minsk_halfmarathon2024-20240908170313-1ef3a1d0d4f3.jpg	6	5	1093189	1729856346	1729856346	0	0	730b3af3b01e8674f8f888529baa525e	27	
100	1	files/Photos/minsk_halfmarathon2024-20240908133626-e4c68dc8f925.jpg	60ae93be78e38177d38eea9a8ce679d7	4	minsk_halfmarathon2024-20240908133626-e4c68dc8f925.jpg	6	5	1336876	1729856346	1729856346	0	0	42edb9b00042e2388ece89f4c14e6693	27	
101	1	files/Photos/b4c31dcc-8a6e-4195-91db-b7075ee9d8e2.jpg	25f5ab3cfb92f34a02834ad7b9a924b6	4	b4c31dcc-8a6e-4195-91db-b7075ee9d8e2.jpg	6	5	1021000	1729856346	1729856346	0	0	72ce16492bd7b48010240969c3ed604f	27	
102	1	files/Photos/28b278b6-4c69-499b-9580-85d2fca26058.jpg	2b03d920cbf86b6fcbadcfd64ae1c33c	4	28b278b6-4c69-499b-9580-85d2fca26058.jpg	6	5	581985	1729103820	1729103820	0	0	03d6cdaefca75e2f61dff926c70f2cfc	27	
103	1	files/Photos/65c6d3bd-dfe0-4c95-9de3-92e7d014c7e1.jpg	a9e43f4ac4539cd3aa0ee99c15fbfd20	4	65c6d3bd-dfe0-4c95-9de3-92e7d014c7e1.jpg	6	5	1021924	1729856346	1729856346	0	0	b29ef7bed240dbf79982a4f623a732a6	27	
104	1	files/Photos/9c544df3-4f3c-46d6-9cf3-7c2ec1674262.jpg	1867d3f0fa6e6511edb5f66c9f4be2af	4	9c544df3-4f3c-46d6-9cf3-7c2ec1674262.jpg	6	5	736842	1729856346	1729856346	0	0	39b7b13078ab94e299dd938486918913	27	
105	1	files/Photos/71371e82-e096-4916-acf5-680ab3bf84d5.jpg	13314cf1bf431a127449858e2da1cd6e	4	71371e82-e096-4916-acf5-680ab3bf84d5.jpg	6	5	941112	1729856346	1729856346	0	0	a20e6f0d97d99fe2ef114fe6031ea48b	27	
106	1	files/Photos/6adf4d1b-fccd-49c9-bf71-b8b7efd5d1fc.jpg	5ca13e77507248db6a1eb9764ca340ed	4	6adf4d1b-fccd-49c9-bf71-b8b7efd5d1fc.jpg	6	5	517097	1729856346	1729856346	0	0	e971404f2da6ff4e1f034a2801f2c9ac	27	
107	1	files/Photos/minsk_halfmarathon2024-20240908135733-d75d9053207a.jpg	4b4af51cc3361178e13113f6b94c5e49	4	minsk_halfmarathon2024-20240908135733-d75d9053207a.jpg	6	5	1251423	1729856346	1729856346	0	0	d5011405d198fb93183e778d91190f50	27	
108	1	files/Photos/minsk_halfmarathon2024-20240908132015-f0fb1b04cacd.jpg	c5253cacd8dfe72757e701a9165c5b61	4	minsk_halfmarathon2024-20240908132015-f0fb1b04cacd.jpg	6	5	1597551	1729856346	1729856346	0	0	199460188ddfd8ef79b14e534e308302	27	
65	1	files/Шаблоны	32743fc4196709e150544bcf7d35be54	2	Шаблоны	2	1	10942115	1730334246	1729856346	0	0	6722ce26cffd8	31	
109	2		d41d8cd98f00b204e9800998ecf8427e	-1		2	1	-1	1730334260	1730334260	0	0	6722ce344f120	23	
111	2	appdata_oc6hv8utdrxp/theming	c118a9339c1e5fa7526403be7ad3425a	110	theming	2	1	0	1730334260	1730334260	0	0	6722ce3451b49	31	
112	2	appdata_oc6hv8utdrxp/theming/global	f2ac88424b83ee69f71d2e4a2448771d	111	global	2	1	0	1730334260	1730334260	0	0	6722ce3453647	31	
113	2	appdata_oc6hv8utdrxp/js	9442fcdd1331dd1f3520cb46db90dab7	110	js	2	1	0	1730334273	1730334273	0	0	6722ce411ffeb	31	
114	2	appdata_oc6hv8utdrxp/js/core	63c725545d9bbb33b2321bc6f0767dba	113	core	2	1	0	1730334273	1730334273	0	0	6722ce4123d44	31	
115	2	appdata_oc6hv8utdrxp/js/core/merged-template-prepend.js	cd47a59f8228f66a258e306811d9b843	114	merged-template-prepend.js	19	9	11728	1730334273	1730334273	0	0	068b3bebfeed845cf0ea647761c8371b	27	
116	2	appdata_oc6hv8utdrxp/js/core/merged-template-prepend.js.deps	511d427b89408c82744bc30a49223c45	114	merged-template-prepend.js.deps	18	9	266	1730334273	1730334273	0	0	4f807c35a57e7bf1a496901192d53b04	27	
117	2	appdata_oc6hv8utdrxp/js/core/merged-template-prepend.js.gzip	5b4464f9ca7e387d501f3e281eac5b77	114	merged-template-prepend.js.gzip	20	9	2811	1730334273	1730334273	0	0	b8af84e3869aa1a1478d2fe3c450d3f1	27	
118	2	appdata_oc6hv8utdrxp/avatar	e11671230a84b2489249d21ef3238d50	110	avatar	2	1	0	1730334274	1730334274	0	0	6722ce425c902	31	
110	2	appdata_oc6hv8utdrxp	ebc8ffc22225495e32e9077804741444	109	appdata_oc6hv8utdrxp	2	1	0	1730334274	1730334274	0	0	6722ce344ece3	31	
119	2	appdata_oc6hv8utdrxp/avatar/admin	18f6f2ae42e0706395c44ab466472777	118	admin	2	1	0	1730334274	1730334274	0	0	6722ce425eb5a	31	
120	2	appdata_oc6hv8utdrxp/preview	51ae193cacafe120343b76b360691c65	110	preview	2	1	0	1730334274	1730334274	0	0	6722ce4281605	31	
127	2	appdata_oc6hv8utdrxp/preview/6/5/1/2/b	f0222ad38efe36edfb17b4795b9ff292	125	b	2	1	-1	1730334274	1730334274	0	0	6722ce428821d	31	
128	2	appdata_oc6hv8utdrxp/preview/6/5/1/2/b/d	a3e5b8e1c850b883e8e6f6af7765747f	127	d	2	1	-1	1730334274	1730334274	0	0	6722ce4287dfe	31	
129	2	appdata_oc6hv8utdrxp/preview/6/5/1/2/b/d/4	d6aa79ec477a429e5498cec5c1ef02ad	128	4	2	1	-1	1730334274	1730334274	0	0	6722ce42879f0	31	
123	2	appdata_oc6hv8utdrxp/preview/6/5/1	08c60a4ab596922e3e3daf35befd9784	122	1	2	1	-1	1730334274	1730334274	0	0	6722ce4288ce2	31	
125	2	appdata_oc6hv8utdrxp/preview/6/5/1/2	6b68deafd050fed10fca814a2575fbd6	123	2	2	1	-1	1730334274	1730334274	0	0	6722ce428867e	31	
155	2	appdata_oc6hv8utdrxp/preview/6/5/1/2/b/d/4/11/1024-683.jpg	c25dc3b6eb49c751d09a766dbac96d93	132	1024-683.jpg	6	5	170188	1730334275	1730334275	0	0	86235aee003bc793ab4560d8542cccf2	27	
130	2	appdata_oc6hv8utdrxp/avatar/admin/avatar.png	730673f341e92e45c2aa51b79cab37c3	119	avatar.png	11	5	15643	1730334274	1730334274	0	0	d3e43fb7ef032639c6886b5588da2c99	27	
134	2	appdata_oc6hv8utdrxp/avatar/admin/generated	a9c1013853a3a7d28e066cca4d49bfb5	119	generated	18	9	0	1730334274	1730334274	0	0	b9ea7c9a82eda61471321671b7df0710	27	
137	2	appdata_oc6hv8utdrxp/avatar/admin/avatar.64.png	61dc7ef9f4f857137daeb1dc6a184f06	119	avatar.64.png	11	5	792	1730334274	1730334274	0	0	8df1a4c384abfde7715988a0826b4264	27	
138	2	appdata_oc6hv8utdrxp/preview/6/5/b	5524c3746225c84fe550a49b09939167	122	b	2	1	-1	1730334274	1730334274	0	0	6722ce42b4ae7	31	
122	2	appdata_oc6hv8utdrxp/preview/6/5	59b0a370fb412d835f18b5efce6b1bea	121	5	2	1	-1	1730334274	1730334274	0	0	6722d920da826	31	
139	2	appdata_oc6hv8utdrxp/preview/6/5/b/9	1f36fe748e763ecd49d3cd54e6f637eb	138	9	2	1	-1	1730334274	1730334274	0	0	6722ce42b492a	31	
140	2	appdata_oc6hv8utdrxp/preview/6/5/b/9/e	6f7115b003bef30892510a45e7a61927	139	e	2	1	-1	1730334274	1730334274	0	0	6722ce42b476b	31	
141	2	appdata_oc6hv8utdrxp/preview/6/5/b/9/e/e	903345890b7e23d1b8c61f89549f74c4	140	e	2	1	-1	1730334274	1730334274	0	0	6722ce42b4582	31	
142	2	appdata_oc6hv8utdrxp/preview/6/5/b/9/e/e/a	456ce13606be2140b32cbfa9bc3b6f5b	141	a	2	1	-1	1730334274	1730334274	0	0	6722ce42b438d	31	
144	2	appdata_oc6hv8utdrxp/preview/6/5/1/2/b/d/4/11/3000-2000-max.jpg	1b4a9dff587d32cf5c9e0c02546225ce	132	3000-2000-max.jpg	6	5	808212	1730334274	1730334274	0	0	22c6988ed84ba9160ec31cfa436b629a	27	
145	2	appdata_oc6hv8utdrxp/preview/6/5/1/2/b/d/4/11/64-43.jpg	d9261761b2e96c094e6b658f60d286f4	132	64-43.jpg	6	5	1750	1730334275	1730334275	0	0	afbf058b9d3de8d2a15b11c98fc2b33b	27	
132	2	appdata_oc6hv8utdrxp/preview/6/5/1/2/b/d/4/11	11b9fa216550718ae42565157833e108	129	11	2	1	0	1730334275	1730334275	0	0	6722ce4286e77	31	
146	2	appdata_oc6hv8utdrxp/preview/f	cbcc129e8df34b4378059c2e487b3673	120	f	2	1	-1	1730334275	1730334275	0	0	6722ce431cb52	31	
147	2	appdata_oc6hv8utdrxp/preview/f/0	376eb8f99e6b4b2cb3a3e6f1c27a8be7	146	0	2	1	-1	1730334275	1730334275	0	0	6722ce431c739	31	
148	2	appdata_oc6hv8utdrxp/preview/f/0/9	9a39d9470eb5dbbbf3ebb691e6e196bf	147	9	2	1	-1	1730334275	1730334275	0	0	6722ce431c559	31	
149	2	appdata_oc6hv8utdrxp/preview/f/0/9/3	fa30bb95f41c497c195c85628a4a9025	148	3	2	1	-1	1730334275	1730334275	0	0	6722ce431c360	31	
150	2	appdata_oc6hv8utdrxp/preview/f/0/9/3/5	b6193280f51f986747311ebb5c1a0d07	149	5	2	1	-1	1730334275	1730334275	0	0	6722ce431c175	31	
151	2	appdata_oc6hv8utdrxp/preview/f/0/9/3/5/e	05ef92b5c9ad81da2c351a6e42d26346	150	e	2	1	-1	1730334275	1730334275	0	0	6722ce431bf4d	31	
152	2	appdata_oc6hv8utdrxp/preview/f/0/9/3/5/e/4	b5a57369814f8e150a23de5400f69349	151	4	2	1	-1	1730334275	1730334275	0	0	6722ce431bc76	31	
153	2	appdata_oc6hv8utdrxp/preview/f/0/9/3/5/e/4/106	0d548f65d6038face8414ff79ed6261e	152	106	2	1	0	1730334275	1730334275	0	0	6722ce431b6fe	31	
154	2	appdata_oc6hv8utdrxp/preview/6/5/b/9/e/e/a/105/2688-4032-max.jpg	cae2a050e0a3aa80f9abe2465be25c59	143	2688-4032-max.jpg	6	5	963557	1730334275	1730334275	0	0	30bf71c0592c0f8e1926877900c74e3c	27	
143	2	appdata_oc6hv8utdrxp/preview/6/5/b/9/e/e/a/105	d3aa8ef9d622dbca2f717b7247c65b77	142	105	2	1	0	1730334275	1730334275	0	0	6722ce42b4006	31	
156	2	appdata_oc6hv8utdrxp/preview/f/0/9/3/5/e/4/106/3984-2656-max.jpg	85f40c172387f41131832df594128692	153	3984-2656-max.jpg	6	5	550490	1730334275	1730334275	0	0	14b62489409144b6fa96d300bc5eba69	27	
157	2	appdata_oc6hv8utdrxp/preview/6/5/b/9/e/e/a/105/43-64.jpg	66b32e6f594713ee44ff110b44e182b9	143	43-64.jpg	6	5	1555	1730334275	1730334275	0	0	c12d11035a1d4a85dae880e6dee76a96	27	
158	2	appdata_oc6hv8utdrxp/preview/f/0/9/3/5/e/4/106/64-43.jpg	00c04d4b2335a7f8af63fadbd94e890c	153	64-43.jpg	6	5	1666	1730334275	1730334275	0	0	11ae17ff1b0e9d428aaf94f4c1ddc6f4	27	
159	2	appdata_oc6hv8utdrxp/preview/3	fbebdad093b07fe4caa0cc65be2a2936	120	3	2	1	-1	1730334275	1730334275	0	0	6722ce43851ce	31	
160	2	appdata_oc6hv8utdrxp/preview/3/8	5ee6327c7cd35edb432f5fb981e61a31	159	8	2	1	-1	1730334275	1730334275	0	0	6722ce4384ffe	31	
161	2	appdata_oc6hv8utdrxp/preview/3/8/b	94670c8783e50f00338b102b9ea7c212	160	b	2	1	-1	1730334275	1730334275	0	0	6722ce4384e0c	31	
162	2	appdata_oc6hv8utdrxp/preview/3/8/b/3	64b7b1743619ccd3e13225320c7240f5	161	3	2	1	-1	1730334275	1730334275	0	0	6722ce4384b87	31	
163	2	appdata_oc6hv8utdrxp/preview/3/8/b/3/e	850c7a5988c4ae92570b531a1136cff9	162	e	2	1	-1	1730334275	1730334275	0	0	6722ce4384894	31	
164	2	appdata_oc6hv8utdrxp/preview/3/8/b/3/e/f	cfc9fa30150db316f4ea4b756da85735	163	f	2	1	-1	1730334275	1730334275	0	0	6722ce4384659	31	
165	2	appdata_oc6hv8utdrxp/preview/3/8/b/3/e/f/f	bb8302c114156b5ef0e1f7fade35ede6	164	f	2	1	-1	1730334275	1730334275	0	0	6722ce4384307	31	
167	2	appdata_oc6hv8utdrxp/preview/6/5/b/9/e/e/a/105/683-1024.jpg	080b734839ad9ff9a4a67841a45a66c6	143	683-1024.jpg	6	5	76190	1730334275	1730334275	0	0	321442cfaf25b5daea86ae3aa32a4624	27	
168	2	appdata_oc6hv8utdrxp/preview/c	80683ec38c4ce23abaf59bbeb0abd032	120	c	2	1	-1	1730334275	1730334275	0	0	6722ce43aee56	31	
169	2	appdata_oc6hv8utdrxp/preview/c/9	8daecbf3ac2701b9ea7e480ea7a276c5	168	9	2	1	-1	1730334275	1730334275	0	0	6722ce43aec7b	31	
170	2	appdata_oc6hv8utdrxp/preview/c/9/e	694472281e0c30c7e89c9d444f3e1884	169	e	2	1	-1	1730334275	1730334275	0	0	6722ce43ae97e	31	
171	2	appdata_oc6hv8utdrxp/preview/c/9/e/1	4f8463c594318924a696ee4e7d86360c	170	1	2	1	-1	1730334275	1730334275	0	0	6722ce43ae5e3	31	
172	2	appdata_oc6hv8utdrxp/preview/c/9/e/1/0	6913f7caf55e257ef36dbb2a1a13e8c3	171	0	2	1	-1	1730334275	1730334275	0	0	6722ce43ae370	31	
173	2	appdata_oc6hv8utdrxp/preview/c/9/e/1/0/7	e84f48a27eceda4322815f185ed96e98	172	7	2	1	-1	1730334275	1730334275	0	0	6722ce43ae11e	31	
174	2	appdata_oc6hv8utdrxp/preview/c/9/e/1/0/7/4	37d7591da38d95bf40be546b9c881060	173	4	2	1	-1	1730334275	1730334275	0	0	6722ce43ade71	31	
176	2	appdata_oc6hv8utdrxp/preview/f/0/9/3/5/e/4/106/1024-683.jpg	a04eedda0d3451e657b74fa61c88e6fe	153	1024-683.jpg	6	5	82447	1730334275	1730334275	0	0	fb4658c23ee99e32bebed309d49a3ce3	27	
177	2	appdata_oc6hv8utdrxp/preview/3/8/b/3/e/f/f/101/3840-2560-max.jpg	b7a1be1550c7c3290ee5ab2aae029f2a	166	3840-2560-max.jpg	6	5	1048503	1730334276	1730334276	0	0	e408c3c622d5bf1e27786298caaae656	27	
187	2	appdata_oc6hv8utdrxp/preview/3/8/b/3/e/f/f/101/1024-683.jpg	5189b43e93201f06f1b083d304ec65ae	166	1024-683.jpg	6	5	126343	1730334276	1730334276	0	0	a2adec73e25a1a92e0331ab57fc4b334	27	
188	2	appdata_oc6hv8utdrxp/preview/c/9/e/1/0/7/4/104/4096-2731-max.jpg	11129f2a6e6664f37b2bad74e7947117	175	4096-2731-max.jpg	6	5	776082	1730334276	1730334276	0	0	d696c4ccc9824f6437ba6cac4833015e	27	
175	2	appdata_oc6hv8utdrxp/preview/c/9/e/1/0/7/4/104	0be44fc1f011c0f3e08046aea82dda56	174	104	2	1	0	1730334276	1730334276	0	0	6722ce43ad72a	31	
190	2	appdata_oc6hv8utdrxp/preview/c/9/e/1/0/7/4/104/64-43.jpg	8d1c4284edcaa76d73ac1c860c77ef1d	175	64-43.jpg	6	5	1486	1730334276	1730334276	0	0	cb5c6792613b1850dcc656ee6ac4d1f4	27	
178	2	appdata_oc6hv8utdrxp/preview/3/8/b/3/e/f/f/101/64-43.jpg	fa62e8ce1bec04b95bf13db3fe313167	166	64-43.jpg	6	5	1661	1730334276	1730334276	0	0	146b66e3d8b03c37d94bee793c73a7d1	27	
166	2	appdata_oc6hv8utdrxp/preview/3/8/b/3/e/f/f/101	4a9a21cdf82ec3b6f54fe549be0bedc3	165	101	2	1	0	1730334276	1730334276	0	0	6722ce4383f56	31	
179	2	appdata_oc6hv8utdrxp/preview/a	b82d7f5dad63823f2d717a518fc28917	120	a	2	1	-1	1730334276	1730334276	0	0	6722ce447dc96	31	
180	2	appdata_oc6hv8utdrxp/preview/a/9	81317ce95af926f12f733c5467276be7	179	9	2	1	-1	1730334276	1730334276	0	0	6722ce447da1a	31	
181	2	appdata_oc6hv8utdrxp/preview/a/9/7	ecddd4ab7bc946723cfb1ac0648926e7	180	7	2	1	-1	1730334276	1730334276	0	0	6722ce447d801	31	
182	2	appdata_oc6hv8utdrxp/preview/a/9/7/d	077d523cb4c63b920e380b5526b2280a	181	d	2	1	-1	1730334276	1730334276	0	0	6722ce447d5c0	31	
183	2	appdata_oc6hv8utdrxp/preview/a/9/7/d/a	9b520920ea7e1d77fcd0ad5b10f7466b	182	a	2	1	-1	1730334276	1730334276	0	0	6722ce447d36e	31	
184	2	appdata_oc6hv8utdrxp/preview/a/9/7/d/a/6	8ac133039cb6b7690106461f7f3ff12b	183	6	2	1	-1	1730334276	1730334276	0	0	6722ce447ce63	31	
185	2	appdata_oc6hv8utdrxp/preview/a/9/7/d/a/6/2	2d0d93cc6e2a3a22acb232701ad8c2a6	184	2	2	1	-1	1730334276	1730334276	0	0	6722ce447cbf4	31	
186	2	appdata_oc6hv8utdrxp/preview/a/9/7/d/a/6/2/107	d08d37e8c33b579bf343d23055dd2574	185	107	2	1	0	1730334276	1730334276	0	0	6722ce447c654	31	
189	2	appdata_oc6hv8utdrxp/preview/a/9/7/d/a/6/2/107/2000-3000-max.jpg	1bb8213986f081f835102c3854102137	186	2000-3000-max.jpg	6	5	425252	1730334276	1730334276	0	0	e78e717e1e0ccfe86ef42528fbae39ef	27	
191	2	appdata_oc6hv8utdrxp/preview/a/9/7/d/a/6/2/107/43-64.jpg	f285455ead383596d3f013e94caa553a	186	43-64.jpg	6	5	1600	1730334276	1730334276	0	0	3eef525820b3abd13a84150c291b922a	27	
192	2	appdata_oc6hv8utdrxp/preview/a/3	9da57f228634df2c8f97d4bfe6097b24	179	3	2	1	-1	1730334276	1730334276	0	0	6722ce44ce00e	31	
193	2	appdata_oc6hv8utdrxp/preview/a/3/c	484e5b3a6d5f1dfd74f28fac975d37ea	192	c	2	1	-1	1730334276	1730334276	0	0	6722ce44cd593	31	
194	2	appdata_oc6hv8utdrxp/preview/a/3/c/6	31a6bc5c25b0cd7a216dde93d14c9e09	193	6	2	1	-1	1730334276	1730334276	0	0	6722ce44cd37a	31	
195	2	appdata_oc6hv8utdrxp/preview/a/3/c/6/5	c1828599d4874685093e9cfd58762e41	194	5	2	1	-1	1730334276	1730334276	0	0	6722ce44cd11d	31	
196	2	appdata_oc6hv8utdrxp/preview/a/3/c/6/5/c	0970161375f7c4dec59b711fabf3780c	195	c	2	1	-1	1730334276	1730334276	0	0	6722ce44ccf38	31	
197	2	appdata_oc6hv8utdrxp/preview/a/3/c/6/5/c/2	851239a79f1c2c25fce9e643b7a83ad8	196	2	2	1	-1	1730334276	1730334276	0	0	6722ce44ccd37	31	
199	2	appdata_oc6hv8utdrxp/preview/c/9/e/1/0/7/4/104/1024-683.jpg	ad6f85d628c32140d4f9049b31e83f75	175	1024-683.jpg	6	5	82241	1730334276	1730334276	0	0	2a77989a27a6ba1ad33834531e524a3b	27	
200	2	appdata_oc6hv8utdrxp/preview/f/8	6c34b9857124f1199d8d36911e40a304	146	8	2	1	-1	1730334276	1730334276	0	0	6722ce44eb77a	31	
201	2	appdata_oc6hv8utdrxp/preview/f/8/9	8c81cd025e30035101a175b1bfd8c887	200	9	2	1	-1	1730334276	1730334276	0	0	6722ce44eb43d	31	
202	2	appdata_oc6hv8utdrxp/preview/f/8/9/9	4f68a1d33ac65014314f45030bcb692a	201	9	2	1	-1	1730334276	1730334276	0	0	6722ce44eaff6	31	
203	2	appdata_oc6hv8utdrxp/preview/f/8/9/9/1	f94383d78169488511f3f898aad18697	202	1	2	1	-1	1730334276	1730334276	0	0	6722ce44eab9a	31	
204	2	appdata_oc6hv8utdrxp/preview/f/8/9/9/1/3	dab97d2f9cc5d08fbe97e49e717d4f73	203	3	2	1	-1	1730334276	1730334276	0	0	6722ce44ea25b	31	
205	2	appdata_oc6hv8utdrxp/preview/f/8/9/9/1/3/9	ec632db759e6b653c0c787c361b32433	204	9	2	1	-1	1730334276	1730334276	0	0	6722ce44e98dc	31	
207	2	appdata_oc6hv8utdrxp/preview/a/9/7/d/a/6/2/107/683-1024.jpg	a8db8a877d9ad984c8be7a8aa690a012	186	683-1024.jpg	6	5	76485	1730334276	1730334276	0	0	a9944f3eeb2f8d1d4342cc402a3a298d	27	
208	2	appdata_oc6hv8utdrxp/preview/a/3/c/6/5/c/2/108/1999-3000-max.jpg	7683e8d62ae05446e75cdd6cc20b41d7	198	1999-3000-max.jpg	6	5	628131	1730334277	1730334277	0	0	a713d6100b6f8c36ec6e83c91d0f92ac	27	
198	2	appdata_oc6hv8utdrxp/preview/a/3/c/6/5/c/2/108	cb174dce5799f2e681d938ee1f2e3ca6	197	108	2	1	0	1730334277	1730334277	0	0	6722ce44cc966	31	
209	2	appdata_oc6hv8utdrxp/preview/f/8/9/9/1/3/9/100/3000-2000-max.jpg	eb634dd78af74bda46eab471d87542e7	206	3000-2000-max.jpg	6	5	445790	1730334277	1730334277	0	0	287838b220d6e655c09d28f5bcf61cf9	27	
206	2	appdata_oc6hv8utdrxp/preview/f/8/9/9/1/3/9/100	4c33af591eec57de5272a59aef3d9910	205	100	2	1	0	1730334277	1730334277	0	0	6722ce44e84cf	31	
210	2	appdata_oc6hv8utdrxp/preview/f/8/9/9/1/3/9/100/1024-683.jpg	83d02e44800c8b9697f2e176edd1d26f	206	1024-683.jpg	6	5	87743	1730334277	1730334277	0	0	5d98b9289aba2a1875315ccd87b1a2eb	27	
211	2	appdata_oc6hv8utdrxp/preview/a/c	358fff02c818f9bef11c097155e48744	179	c	2	1	-1	1730334277	1730334277	0	0	6722ce4552bfd	31	
212	2	appdata_oc6hv8utdrxp/preview/a/c/6	accebc5418df69a91b8bf57f811e844e	211	6	2	1	-1	1730334277	1730334277	0	0	6722ce4552a69	31	
213	2	appdata_oc6hv8utdrxp/preview/a/c/6/2	191926655aa36f32b45bbe41e3d29241	212	2	2	1	-1	1730334277	1730334277	0	0	6722ce45528c5	31	
214	2	appdata_oc6hv8utdrxp/preview/a/c/6/2/7	aba0b24f2654d9a59455f7e660e413d5	213	7	2	1	-1	1730334277	1730334277	0	0	6722ce45526cc	31	
215	2	appdata_oc6hv8utdrxp/preview/a/c/6/2/7/a	c6e11a9cd030c607c0fc4885ec2114fe	214	a	2	1	-1	1730334277	1730334277	0	0	6722ce4552497	31	
216	2	appdata_oc6hv8utdrxp/preview/a/c/6/2/7/a/b	0eae130333acca4e79a81ff5edca9d67	215	b	2	1	-1	1730334277	1730334277	0	0	6722ce455213e	31	
217	2	appdata_oc6hv8utdrxp/preview/a/c/6/2/7/a/b/99	138c5291e9c9174aff3b2c94784179ef	216	99	2	1	0	1730334277	1730334277	0	0	6722ce4551b6c	31	
232	2	appdata_oc6hv8utdrxp/preview/a/c/6/2/7/a/b/99/43-64.jpg	ee77e6f789c1628f2afe4b5c82d09649	217	43-64.jpg	6	5	1456	1730334277	1730334277	0	0	1e59ce837788357fbb0565bf0e51c291	27	
218	2	appdata_oc6hv8utdrxp/preview/f/8/9/9/1/3/9/100/64-43.jpg	528c8bc6486888fc69254a13e20df42c	206	64-43.jpg	6	5	1839	1730334277	1730334277	0	0	484e32eac28f4f7e7c5a1430bc992667	27	
219	2	appdata_oc6hv8utdrxp/preview/a/3/c/6/5/c/2/108/682-1024.jpg	7132b6c76971a50c4889d59c5620d14c	198	682-1024.jpg	6	5	116164	1730334277	1730334277	0	0	b31671d949d862e6ddac2f8d383159fa	27	
220	2	appdata_oc6hv8utdrxp/preview/a/3/c/6/5/c/2/108/43-64.jpg	3a0bf9ff7c111f837081ecb180df842d	198	43-64.jpg	6	5	1695	1730334277	1730334277	0	0	68e8cbe97bf46a6da189628a302c1a56	27	
222	2	appdata_oc6hv8utdrxp/preview/6/9/7	8858728fc5134699348f67f0fb56186b	221	7	2	1	-1	1730334277	1730334277	0	0	6722ce4570320	31	
223	2	appdata_oc6hv8utdrxp/preview/6/9/7/4	e4204cf55d17c4f1f89f1eeadb63e6ce	222	4	2	1	-1	1730334277	1730334277	0	0	6722ce456ff9d	31	
224	2	appdata_oc6hv8utdrxp/preview/6/9/7/4/c	56df79afe3a16b82bf00de1597b264d2	223	c	2	1	-1	1730334277	1730334277	0	0	6722ce456fcdc	31	
226	2	appdata_oc6hv8utdrxp/preview/6/9/7/4/c/e	ce2cbd53d2cdf84cbfcfca6ffb905879	224	e	2	1	-1	1730334277	1730334277	0	0	6722ce456f5ff	31	
227	2	appdata_oc6hv8utdrxp/preview/6/9/7/4/c/e/5	92fd93d09a57fdedf05e0743c5bbca36	226	5	2	1	-1	1730334277	1730334277	0	0	6722ce456f0bd	31	
231	2	appdata_oc6hv8utdrxp/preview/a/c/6/2/7/a/b/99/2000-3000-max.jpg	4b3fbc3df0b2a1bf9a2656d242b5e4ec	217	2000-3000-max.jpg	6	5	365127	1730334277	1730334277	0	0	2e6b4945e786aa3485ab929111654cf3	27	
233	2	appdata_oc6hv8utdrxp/preview/e	057ca22478ac9c6894abffb6e7238d4a	120	e	2	1	-1	1730334277	1730334277	0	0	6722ce45a5c65	31	
234	2	appdata_oc6hv8utdrxp/preview/e/c	7bdb8bd2ed66095286e09b57164575aa	233	c	2	1	-1	1730334277	1730334277	0	0	6722ce45a5ae7	31	
235	2	appdata_oc6hv8utdrxp/preview/e/c/8	23fcb4cfb633f891090d2bfab433f465	234	8	2	1	-1	1730334277	1730334277	0	0	6722ce45a591b	31	
236	2	appdata_oc6hv8utdrxp/preview/e/c/8/9	19906a2dd2d97320f3db9f10fedd5957	235	9	2	1	-1	1730334277	1730334277	0	0	6722ce45a5750	31	
237	2	appdata_oc6hv8utdrxp/preview/e/c/8/9/5	1a4d46c4c96a287ba3614c2155248de4	236	5	2	1	-1	1730334277	1730334277	0	0	6722ce45a553a	31	
238	2	appdata_oc6hv8utdrxp/preview/e/c/8/9/5/6	20073454aa5a73138a498e95468a3b2e	237	6	2	1	-1	1730334277	1730334277	0	0	6722ce45a51bc	31	
239	2	appdata_oc6hv8utdrxp/preview/e/c/8/9/5/6/6	3cc0872990c7cb88309085f812418d98	238	6	2	1	-1	1730334277	1730334277	0	0	6722ce45a5006	31	
241	2	appdata_oc6hv8utdrxp/preview/a/c/6/2/7/a/b/99/683-1024.jpg	ddec69ac814ba0afa7be0549fa3240b6	217	683-1024.jpg	6	5	68269	1730334277	1730334277	0	0	5e953e9a57896807934abdf1ffa2b7ee	27	
242	2	appdata_oc6hv8utdrxp/preview/6/9/7/4/c/e/5/103/2656-3984-max.jpg	797936f7f7f537e02768ae2036d81529	229	2656-3984-max.jpg	6	5	1055411	1730334277	1730334277	0	0	10a0965886b3137467eadfcb6cb6157d	27	
243	2	appdata_oc6hv8utdrxp/preview/e/c/8/9/5/6/6/102/3840-2560-max.jpg	2215946a70ca123c98d185f7e8bada5a	240	3840-2560-max.jpg	6	5	618200	1730334278	1730334278	0	0	47c9695d9540282f9fbffc23ae735483	27	
244	2	appdata_oc6hv8utdrxp/preview/6/9/7/4/c/e/5/103/43-64.jpg	1c4c50d8ea3713b18f2527676593a6ac	229	43-64.jpg	6	5	1764	1730334278	1730334278	0	0	a2049f3c3111bdcffc0f774d28a643ac	27	
229	2	appdata_oc6hv8utdrxp/preview/6/9/7/4/c/e/5/103	9e7692ea85c99f159e3bfad8d572e4d5	227	103	2	1	0	1730334278	1730334278	0	0	6722ce45709f1	31	
245	2	appdata_oc6hv8utdrxp/preview/e/c/8/9/5/6/6/102/64-43.jpg	5cbff7c1f3769d0317adc4704c681d8e	240	64-43.jpg	6	5	1529	1730334278	1730334278	0	0	06c76c842a4e0807829c83d625517b3a	27	
240	2	appdata_oc6hv8utdrxp/preview/e/c/8/9/5/6/6/102	d97be0d70d870b45437171790d5f4bf2	239	102	2	1	0	1730334278	1730334278	0	0	6722ce45a4cd5	31	
246	2	appdata_oc6hv8utdrxp/preview/4	5be05404ec1c0448caec8398402ab660	120	4	2	1	-1	1730334278	1730334278	0	0	6722ce4619eaa	31	
247	2	appdata_oc6hv8utdrxp/preview/4/5	468fd24de31182b13c72770bbf9b7d54	246	5	2	1	-1	1730334278	1730334278	0	0	6722ce4619b8a	31	
248	2	appdata_oc6hv8utdrxp/preview/4/5/c	0c2977523c9f8f11e281ba34f2439ee4	247	c	2	1	-1	1730334278	1730334278	0	0	6722ce461966d	31	
249	2	appdata_oc6hv8utdrxp/preview/4/5/c/4	ca37f1159cdfadfedae4b9828ddd5dc0	248	4	2	1	-1	1730334278	1730334278	0	0	6722ce4618e1c	31	
250	2	appdata_oc6hv8utdrxp/preview/4/5/c/4/8	c86251d65c111875fa9fd706c6987722	249	8	2	1	-1	1730334278	1730334278	0	0	6722ce4618ab0	31	
251	2	appdata_oc6hv8utdrxp/preview/4/5/c/4/8/c	086b41ee3e30ba2549b5e8b0c21325d2	250	c	2	1	-1	1730334278	1730334278	0	0	6722ce4618730	31	
252	2	appdata_oc6hv8utdrxp/preview/4/5/c/4/8/c/c	8da1c35205927fcf458d0a3fc2abfef2	251	c	2	1	-1	1730334278	1730334278	0	0	6722ce4617b9a	31	
253	2	appdata_oc6hv8utdrxp/preview/4/5/c/4/8/c/c/9	dbd82c97a655cfd73c07a70e95287033	252	9	2	1	0	1730334278	1730334278	0	0	6722ce461787e	31	
254	2	appdata_oc6hv8utdrxp/preview/4/5/c/4/8/c/c/9/1920-1281-max.jpg	0d1f3c400124bb4ae84b3f3e224922e3	253	1920-1281-max.jpg	6	5	294390	1730334278	1730334278	0	0	45a426816f8bfd9a7b53b3b0067aefce	27	
255	2	appdata_oc6hv8utdrxp/preview/6/9/7/4/c/e/5/103/683-1024.jpg	95fbe72699fef6c5f045246f2d18c223	229	683-1024.jpg	6	5	113756	1730334278	1730334278	0	0	317f0a4b078393ff1c53472def7d4bf4	27	
256	2	appdata_oc6hv8utdrxp/preview/4/5/c/4/8/c/c/9/64-43.jpg	6a5eb20627a59abf89804219daf730eb	253	64-43.jpg	6	5	1559	1730334278	1730334278	0	0	d84f94f86e8f1c38ab62adee5f569dcf	27	
257	2	appdata_oc6hv8utdrxp/preview/e/c/8/9/5/6/6/102/1024-683.jpg	31e8eb6ac559f80b8ffc093359c62316	240	1024-683.jpg	6	5	91851	1730334278	1730334278	0	0	bffe21f027d5d20923cc1435f45ebb3f	27	
258	2	appdata_oc6hv8utdrxp/preview/6/1600-1067-max.jpg	665742e8fe68f9c70004c69480463877	121	1600-1067-max.jpg	6	5	137923	1730334278	1730334278	0	0	115b79fd76cc45a00200e54feb122c25	27	
259	2	appdata_oc6hv8utdrxp/preview/c/5	577ef9f5100597b3b5d4c009c81e5045	168	5	2	1	-1	1730334278	1730334278	0	0	6722ce465a15e	31	
260	2	appdata_oc6hv8utdrxp/preview/c/5/1	ff04ce39f943b62cf4753c8242c41bb4	259	1	2	1	-1	1730334278	1730334278	0	0	6722ce4659f65	31	
261	2	appdata_oc6hv8utdrxp/preview/c/5/1/c	884c1d32978af11d835f98fb742188bf	260	c	2	1	-1	1730334278	1730334278	0	0	6722ce4659d91	31	
262	2	appdata_oc6hv8utdrxp/preview/c/5/1/c/e	745c070d3aa234b8bee0844404600993	261	e	2	1	-1	1730334278	1730334278	0	0	6722ce4659bf1	31	
263	2	appdata_oc6hv8utdrxp/preview/c/5/1/c/e/4	b0fc89aa33aa997a01cf7338a080641b	262	4	2	1	-1	1730334278	1730334278	0	0	6722ce4659a45	31	
264	2	appdata_oc6hv8utdrxp/preview/c/5/1/c/e/4/1	3707923f0f18a2d0fefbec0b8fe0d683	263	1	2	1	-1	1730334278	1730334278	0	0	6722ce4659863	31	
266	2	appdata_oc6hv8utdrxp/preview/6/64-43.jpg	1126e8da54b13e554c29ae98c73f3acd	121	64-43.jpg	6	5	1784	1730334278	1730334278	0	0	be60eee051488ed279fed7ad988ff817	27	
265	2	appdata_oc6hv8utdrxp/preview/c/5/1/c/e/4/1/13	f2fba01393631bd22b16a1244ccf788b	264	13	2	1	0	1730334278	1730334278	0	0	6722ce4658bdb	31	
267	2	appdata_oc6hv8utdrxp/preview/4/5/c/4/8/c/c/9/1024-683.jpg	6a14ed882a810421f49340f22350b326	253	1024-683.jpg	6	5	101397	1730334278	1730334278	0	0	f37c1267bc72b238c1429ccd6b1f7c4b	27	
268	2	appdata_oc6hv8utdrxp/preview/c/5/1/c/e/4/1/13/1200-1800-max.jpg	67ed6bb3535abee35bf581ac82f60456	265	1200-1800-max.jpg	6	5	207095	1730334278	1730334278	0	0	aca34c32c66aa28626811df840c41d9a	27	
269	2	appdata_oc6hv8utdrxp/preview/6/1024-683.jpg	de3c583c2b5a51f514c49b586d944f2c	121	1024-683.jpg	6	5	85855	1730334278	1730334278	0	0	19d8f3df005704567e2c21d3bd1ce71a	27	
270	2	appdata_oc6hv8utdrxp/preview/c/5/1/c/e/4/1/13/43-64.jpg	b011caa4be22730f7fddea97bc8549b1	265	43-64.jpg	6	5	1196	1730334278	1730334278	0	0	56a0495c568ce50b322a0e2918c84e52	27	
271	2	appdata_oc6hv8utdrxp/preview/c/5/1/c/e/4/1/13/683-1024.jpg	62d8d274a66d2cd6c94b7fb98ebe7700	265	683-1024.jpg	6	5	67045	1730334278	1730334278	0	0	a8a4d9095184b7e8f0047908445d15e2	27	
121	2	appdata_oc6hv8utdrxp/preview/6	9aad6bded812b233af01e48553e226af	120	6	2	1	-1	1730334278	1730334278	0	0	6722d920ddd98	31	
221	2	appdata_oc6hv8utdrxp/preview/6/9	28ac3a2add15bc96938193b6dc4ab062	121	9	2	1	-1	1730334277	1730334277	0	0	6722d920da80c	31	
\.


--
-- Data for Name: oc_filecache_extended; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_filecache_extended (fileid, metadata_etag, creation_time, upload_time) FROM stdin;
\.


--
-- Data for Name: oc_files_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_files_metadata (id, file_id, json, sync_token, last_update) FROM stdin;
1	3	{"photos-original_date_time":{"value":1730334177,"type":"int","etag":"","indexed":true,"editPermission":0}}	xYAPpyN	2024-10-31 03:22:57
2	5	{"photos-original_date_time":{"value":1341059531,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":{"ExposureTime":"1\\/125","FNumber":"28\\/5","ExposureProgram":3,"ISOSpeedRatings":320,"UndefinedTag__x____":320,"ExifVersion":"0230","DateTimeOriginal":"2012:06:30 12:32:11","DateTimeDigitized":"2012:06:30 12:32:11","ComponentsConfiguration":"","ShutterSpeedValue":"7\\/1","ApertureValue":"5\\/1","ExposureBiasValue":"0\\/1","MaxApertureValue":"189284\\/33461","MeteringMode":5,"Flash":16,"FocalLength":"280\\/1","SubSecTime":"83","SubSecTimeOriginal":"83","SubSecTimeDigitized":"83","FlashPixVersion":"0100","ColorSpace":1,"ExifImageWidth":1600,"ExifImageLength":1067,"FocalPlaneXResolution":"1920000\\/487","FocalPlaneYResolution":"320000\\/81","FocalPlaneResolutionUnit":2,"CustomRendered":0,"ExposureMode":0,"WhiteBalance":0,"SceneCaptureType":0,"UndefinedTag__xA___":"0000000000"},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":{"Make":"Canon","Model":"Canon EOS 5D Mark III","Orientation":1,"XResolution":"72\\/1","YResolution":"72\\/1","ResolutionUnit":2,"DateTime":"2012:06:30 12:32:11","Exif_IFD_Pointer":174},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":{"width":1600,"height":1067},"type":"array","etag":"","indexed":false,"editPermission":0}}	39gX8VR	2024-10-31 03:22:57
3	6	{"photos-original_date_time":{"value":1444907264,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":{"ExposureTime":"1\\/320","FNumber":"4\\/1","ExposureProgram":3,"ISOSpeedRatings":640,"UndefinedTag__x____":640,"ExifVersion":"0230","DateTimeOriginal":"2015:10:15 11:07:44","DateTimeDigitized":"2015:10:15 11:07:44","ShutterSpeedValue":"27970\\/3361","ApertureValue":"4\\/1","ExposureBiasValue":"1\\/3","MaxApertureValue":"4\\/1","MeteringMode":5,"Flash":16,"FocalLength":"200\\/1","SubSecTimeOriginal":"63","SubSecTimeDigitized":"63","ColorSpace":1,"ExifImageWidth":1600,"ExifImageLength":1067,"FocalPlaneXResolution":"1600\\/1","FocalPlaneYResolution":"1600\\/1","FocalPlaneResolutionUnit":3,"CustomRendered":0,"ExposureMode":0,"WhiteBalance":0,"SceneCaptureType":0,"UndefinedTag__xA___":"000084121f"},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":{"Make":"Canon","Model":"Canon EOS 5D Mark III","Orientation":1,"XResolution":"240\\/1","YResolution":"240\\/1","ResolutionUnit":2,"Software":"Adobe Photoshop Lightroom 6.2.1 (Macintosh)","DateTime":"2015:10:16 14:40:21","Exif_IFD_Pointer":230},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":{"width":1600,"height":1067},"type":"array","etag":"","indexed":false,"editPermission":0}}	OtbLOUb	2024-10-31 03:22:57
4	7	{"photos-original_date_time":{"value":1341258636,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":{"ExposureTime":"1\\/80","FNumber":"4\\/1","ExposureProgram":3,"ISOSpeedRatings":400,"ExifVersion":"0230","DateTimeOriginal":"2012:07:02 19:50:36","DateTimeDigitized":"2012:07:02 19:50:36","ComponentsConfiguration":"","ShutterSpeedValue":"51\\/8","ApertureValue":"4\\/1","ExposureBiasValue":"0\\/1","MaxApertureValue":"4\\/1","MeteringMode":5,"Flash":16,"FocalLength":"32\\/1","SubSecTime":"00","SubSecTimeOriginal":"00","SubSecTimeDigitized":"00","FlashPixVersion":"0100","ColorSpace":1,"ExifImageWidth":1600,"ExifImageLength":1066,"FocalPlaneXResolution":"382423\\/97","FocalPlaneYResolution":"185679\\/47","FocalPlaneResolutionUnit":2,"CustomRendered":0,"ExposureMode":0,"WhiteBalance":0,"SceneCaptureType":0},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":{"Make":"Canon","Model":"Canon EOS 5D Mark III","Orientation":1,"XResolution":"72\\/1","YResolution":"72\\/1","ResolutionUnit":2,"Software":"GIMP 2.8.0","DateTime":"2012:07:02 22:06:14","Exif_IFD_Pointer":198},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":{"width":1600,"height":1066},"type":"array","etag":"","indexed":false,"editPermission":0}}	O5yY6RG	2024-10-31 03:22:57
5	8	{"photos-original_date_time":{"value":1341072915,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":{"ExposureTime":"1\\/500","FNumber":"28\\/5","ExposureProgram":1,"ISOSpeedRatings":8000,"ExifVersion":"0230","DateTimeOriginal":"2012:06:30 16:15:15","DateTimeDigitized":"2012:06:30 16:15:15","ComponentsConfiguration":"","ShutterSpeedValue":"9\\/1","ApertureValue":"5\\/1","ExposureBiasValue":"0\\/1","MaxApertureValue":"6149\\/1087","MeteringMode":5,"Flash":16,"FocalLength":"280\\/1","SubSecTime":"00","SubSecTimeOriginal":"00","SubSecTimeDigitized":"00","FlashPixVersion":"0100","ColorSpace":1,"ExifImageWidth":1600,"ExifImageLength":1067,"FocalPlaneXResolution":"382423\\/97","FocalPlaneYResolution":"134321\\/34","FocalPlaneResolutionUnit":2,"CustomRendered":0,"ExposureMode":1,"WhiteBalance":0,"SceneCaptureType":0},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":{"Make":"Canon","Model":"Canon EOS 5D Mark III","Orientation":1,"XResolution":"72\\/1","YResolution":"72\\/1","ResolutionUnit":2,"Software":"Aperture 3.3.1","DateTime":"2012:06:30 16:15:15","Exif_IFD_Pointer":202},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":{"width":1600,"height":1067},"type":"array","etag":"","indexed":false,"editPermission":0}}	IvLAOLG	2024-10-31 03:22:57
6	9	{"photos-original_date_time":{"value":1526500980,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":{"ExposureTime":"10\\/12500","FNumber":"35\\/10","ExposureProgram":3,"ISOSpeedRatings":100,"DateTimeOriginal":"2018:05:16 20:03:00","DateTimeDigitized":"2018:05:16 20:03:00","ExposureBiasValue":"0\\/6","MaxApertureValue":"30\\/10","MeteringMode":5,"LightSource":0,"Flash":16,"FocalLength":"700\\/10","MakerNote":"Nikon","UserComment":"Christoph WurstCC-SA 4.0","SubSecTime":"30","SubSecTimeOriginal":"30","SubSecTimeDigitized":"30","ColorSpace":1,"SensingMethod":2,"FileSource":"","SceneType":"","CustomRendered":0,"ExposureMode":0,"WhiteBalance":0,"DigitalZoomRatio":"1\\/1","FocalLengthIn__mmFilm":70,"SceneCaptureType":0,"GainControl":0,"Contrast":1,"Saturation":0,"Sharpness":1,"SubjectDistanceRange":0},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":{"ImageDescription":"Christoph WurstCC-SA 4.0","Make":"NIKON CORPORATION","Model":"NIKON D610","Orientation":1,"XResolution":"72\\/1","YResolution":"72\\/1","ResolutionUnit":2,"Software":"GIMP 2.10.14","DateTime":"2019:12:10 08:51:16","Artist":"Christoph Wurst                     ","Copyright":"Christoph Wurst                                       ","Exif_IFD_Pointer":402,"GPS_IFD_Pointer":13738,"DateTimeOriginal":"2018:05:16 20:03:00"},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":{"width":1920,"height":1281},"type":"array","etag":"","indexed":false,"editPermission":0}}	jePSAvQ	2024-10-31 03:22:58
7	10	{"photos-original_date_time":{"value":1341064060,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":{"ExposureTime":"1\\/640","FNumber":"28\\/5","ExposureProgram":1,"ISOSpeedRatings":12800,"ExifVersion":"0230","DateTimeOriginal":"2012:06:30 13:47:40","DateTimeDigitized":"2012:06:30 13:47:40","ComponentsConfiguration":"","ShutterSpeedValue":"75\\/8","ApertureValue":"5\\/1","ExposureBiasValue":"0\\/1","MaxApertureValue":"6149\\/1087","MeteringMode":5,"Flash":16,"FocalLength":"235\\/1","SubSecTime":"00","SubSecTimeOriginal":"00","SubSecTimeDigitized":"00","FlashPixVersion":"0100","ExifImageWidth":1600,"ExifImageLength":1067,"FocalPlaneXResolution":"382423\\/97","FocalPlaneYResolution":"134321\\/34","FocalPlaneResolutionUnit":2,"CustomRendered":0,"ExposureMode":1,"WhiteBalance":0,"SceneCaptureType":0},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":{"Make":"Canon","Model":"Canon EOS 5D Mark III","Orientation":1,"XResolution":"72\\/1","YResolution":"72\\/1","ResolutionUnit":2,"Software":"Aperture 3.3.1","DateTime":"2012:06:30 13:47:40","Exif_IFD_Pointer":202},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":{"width":1600,"height":1067},"type":"array","etag":"","indexed":false,"editPermission":0}}	HI1J8CG	2024-10-31 03:22:58
8	11	{"photos-original_date_time":{"value":1730334177,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-size":{"value":{"width":3000,"height":2000},"type":"array","etag":"","indexed":false,"editPermission":0}}	1uRvZQA	2024-10-31 03:22:58
9	13	{"photos-original_date_time":{"value":1372319469,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":{"ExposureTime":"1\\/160","FNumber":"4\\/1","ExposureProgram":3,"ISOSpeedRatings":100,"ExifVersion":"0230","DateTimeOriginal":"2013:06:27 07:51:09","DateTimeDigitized":"2013:06:27 07:51:09","ComponentsConfiguration":"","ShutterSpeedValue":"59\\/8","ApertureValue":"4\\/1","ExposureBiasValue":"2\\/3","MaxApertureValue":"4\\/1","MeteringMode":5,"Flash":16,"FocalLength":"45\\/1","SubSecTime":"00","SubSecTimeOriginal":"00","SubSecTimeDigitized":"00","FlashPixVersion":"0100","ColorSpace":1,"ExifImageWidth":1200,"ExifImageLength":1800,"FocalPlaneXResolution":"382423\\/97","FocalPlaneYResolution":"185679\\/47","FocalPlaneResolutionUnit":2,"CustomRendered":0,"ExposureMode":0,"WhiteBalance":0,"SceneCaptureType":0,"UndefinedTag__xA___":"000052602c"},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":{"Make":"Canon","Model":"Canon EOS 5D Mark III","Orientation":1,"XResolution":"72\\/1","YResolution":"72\\/1","ResolutionUnit":2,"Software":"Aperture 3.4.5","DateTime":"2013:06:27 07:51:09","Exif_IFD_Pointer":202},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":{"width":1200,"height":1800},"type":"array","etag":"","indexed":false,"editPermission":0}}	F9T3EfW	2024-10-31 03:22:58
10	16	{"photos-original_date_time":{"value":1730334177,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-size":{"value":{"width":500,"height":500},"type":"array","etag":"","indexed":false,"editPermission":0}}	hGeBaRD	2024-10-31 03:22:58
\.


--
-- Data for Name: oc_files_metadata_index; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_files_metadata_index (id, file_id, meta_key, meta_value_string, meta_value_int) FROM stdin;
1	3	photos-original_date_time	\N	1730334177
3	5	photos-original_date_time	\N	1341059531
5	6	photos-original_date_time	\N	1444907264
7	7	photos-original_date_time	\N	1341258636
9	8	photos-original_date_time	\N	1341072915
11	9	photos-original_date_time	\N	1526500980
13	10	photos-original_date_time	\N	1341064060
15	11	photos-original_date_time	\N	1730334177
17	13	photos-original_date_time	\N	1372319469
19	16	photos-original_date_time	\N	1730334177
\.


--
-- Data for Name: oc_files_reminders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_files_reminders (id, user_id, file_id, due_date, updated_at, created_at, notified) FROM stdin;
\.


--
-- Data for Name: oc_files_trash; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_files_trash (auto_id, id, "user", "timestamp", location, type, mime, deleted_by) FROM stdin;
\.


--
-- Data for Name: oc_files_versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_files_versions (id, file_id, "timestamp", size, mimetype, metadata) FROM stdin;
1	3	1730334177	3963036	4	{"author":"admin"}
22	26	1730334178	81196	14	{"author":"admin"}
2	5	1730334177	593508	6	{"author":"admin"}
37	41	1730334178	88394	13	{"author":"admin"}
3	6	1730334177	167989	6	{"author":"admin"}
23	27	1730334178	16988	16	{"author":"admin"}
4	7	1730334177	2170375	6	{"author":"admin"}
48	52	1730334179	976625	10	{"author":"admin"}
5	8	1730334177	457744	6	{"author":"admin"}
24	28	1730334178	31325	15	{"author":"admin"}
6	9	1730334177	427030	6	{"author":"admin"}
38	42	1730334178	14810	14	{"author":"admin"}
7	10	1730334177	474653	6	{"author":"admin"}
25	29	1730334178	23359	15	{"author":"admin"}
8	11	1730334177	797325	6	{"author":"admin"}
9	12	1730334177	150	8	{"author":"admin"}
26	30	1730334178	30290	15	{"author":"admin"}
10	13	1730334177	567689	6	{"author":"admin"}
39	43	1730334179	25621	15	{"author":"admin"}
11	14	1730334177	12860592	10	{"author":"admin"}
27	31	1730334178	13653	16	{"author":"admin"}
12	15	1730334177	206	8	{"author":"admin"}
49	54	1730334179	1095	8	{"author":"admin"}
13	16	1730334177	50598	11	{"author":"admin"}
28	32	1730334178	13378	13	{"author":"admin"}
14	18	1730334177	340061	12	{"author":"admin"}
40	44	1730334179	30354	12	{"author":"admin"}
15	19	1730334177	5155877	12	{"author":"admin"}
29	33	1730334178	13878	16	{"author":"admin"}
16	20	1730334178	52843	13	{"author":"admin"}
17	21	1730334178	17276	12	{"author":"admin"}
30	34	1730334178	326	8	{"author":"admin"}
18	22	1730334178	317015	14	{"author":"admin"}
41	45	1730334179	15961	12	{"author":"admin"}
19	23	1730334178	39404	12	{"author":"admin"}
31	35	1730334178	30671	15	{"author":"admin"}
20	24	1730334178	30780	15	{"author":"admin"}
21	25	1730334178	31132	15	{"author":"admin"}
50	55	1730334179	1083339	10	{"author":"admin"}
32	36	1730334178	11836	16	{"author":"admin"}
42	46	1730334179	45778	15	{"author":"admin"}
33	37	1730334178	35657	15	{"author":"admin"}
34	38	1730334178	27629	15	{"author":"admin"}
43	47	1730334179	14316	14	{"author":"admin"}
35	39	1730334178	554	8	{"author":"admin"}
51	56	1730334179	136	8	{"author":"admin"}
36	40	1730334178	573	8	{"author":"admin"}
44	48	1730334179	868111	12	{"author":"admin"}
45	49	1730334179	3509628	14	{"author":"admin"}
52	57	1730334179	24295	17	{"author":"admin"}
46	50	1730334179	13441	13	{"author":"admin"}
47	51	1730334179	2403	8	{"author":"admin"}
\.


--
-- Data for Name: oc_flow_checks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_flow_checks (id, class, operator, value, hash) FROM stdin;
\.


--
-- Data for Name: oc_flow_operations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_flow_operations (id, class, name, checks, operation, entity, events) FROM stdin;
\.


--
-- Data for Name: oc_flow_operations_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_flow_operations_scope (id, operation_id, type, value) FROM stdin;
\.


--
-- Data for Name: oc_group_admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_group_admin (gid, uid) FROM stdin;
\.


--
-- Data for Name: oc_group_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_group_user (gid, uid) FROM stdin;
admin	admin
\.


--
-- Data for Name: oc_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_groups (gid, displayname) FROM stdin;
admin	admin
\.


--
-- Data for Name: oc_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_jobs (id, class, argument, last_run, last_checked, reserved_at, execution_duration, argument_hash, time_sensitive) FROM stdin;
3	OCA\\FilesReminders\\BackgroundJob\\CleanUpReminders	null	0	1730334168	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
4	OCA\\FilesReminders\\BackgroundJob\\ScheduledNotifications	null	0	1730334168	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
5	OCA\\WorkflowEngine\\BackgroundJobs\\Rotate	null	0	1730334168	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
6	OCA\\Circles\\Cron\\Maintenance	null	0	1730334169	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
7	OCA\\Text\\Cron\\Cleanup	null	0	1730334169	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
8	OCA\\Files_Versions\\BackgroundJob\\ExpireVersions	null	0	1730334170	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
9	OCA\\Federation\\SyncJob	null	0	1730334170	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
10	OCA\\Activity\\BackgroundJob\\EmailNotification	null	0	1730334171	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
11	OCA\\Activity\\BackgroundJob\\ExpireActivities	null	0	1730334171	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
12	OCA\\Activity\\BackgroundJob\\DigestMail	null	0	1730334171	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
13	OCA\\Activity\\BackgroundJob\\RemoveFormerActivitySettings	null	0	1730334171	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
14	OCA\\Files_Sharing\\DeleteOrphanedSharesJob	null	0	1730334171	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
15	OCA\\Files_Sharing\\ExpireSharesJob	null	0	1730334171	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
16	OCA\\Files_Sharing\\BackgroundJob\\FederatedSharesDiscoverJob	null	0	1730334171	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
17	OCA\\UpdateNotification\\BackgroundJob\\UpdateAvailableNotifications	null	0	1730334171	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
18	OCA\\OAuth2\\BackgroundJob\\CleanupExpiredAuthorizationCode	null	0	1730334172	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
19	OCA\\Photos\\Jobs\\AutomaticPlaceMapperJob	null	0	1730334172	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
20	OCA\\DAV\\BackgroundJob\\CleanupDirectLinksJob	null	0	1730334173	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
21	OCA\\DAV\\BackgroundJob\\UpdateCalendarResourcesRoomsBackgroundJob	null	0	1730334173	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
22	OCA\\DAV\\BackgroundJob\\CleanupInvitationTokenJob	null	0	1730334173	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
23	OCA\\DAV\\BackgroundJob\\EventReminderJob	null	0	1730334173	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
24	OCA\\DAV\\BackgroundJob\\CalendarRetentionJob	null	0	1730334173	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
25	OCA\\DAV\\BackgroundJob\\PruneOutdatedSyncTokensJob	null	0	1730334173	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
26	OCA\\UserStatus\\BackgroundJob\\ClearOldStatusesBackgroundJob	null	0	1730334174	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
27	OCA\\Notifications\\BackgroundJob\\GenerateUserSettings	null	0	1730334175	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
28	OCA\\Notifications\\BackgroundJob\\SendNotificationMails	null	0	1730334175	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
29	OCA\\NextcloudAnnouncements\\Cron\\Crawler	null	0	1730334175	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
30	OCA\\ContactsInteraction\\BackgroundJob\\CleanupJob	null	0	1730334175	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
31	OCA\\Files_Trashbin\\BackgroundJob\\ExpireTrash	null	0	1730334176	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
32	OCA\\ServerInfo\\Jobs\\UpdateStorageStats	null	0	1730334176	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
33	OCA\\Files\\BackgroundJob\\ScanFiles	null	0	1730334177	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
34	OCA\\Files\\BackgroundJob\\DeleteOrphanedItems	null	0	1730334177	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
35	OCA\\Files\\BackgroundJob\\CleanupFileLocks	null	0	1730334177	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
36	OCA\\Files\\BackgroundJob\\CleanupDirectEditingTokens	null	0	1730334177	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
37	OCA\\Files\\BackgroundJob\\DeleteExpiredOpenLocalEditor	null	0	1730334177	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
38	OCA\\Support\\BackgroundJobs\\CheckSubscription	null	0	1730334177	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
39	OC\\Authentication\\Token\\TokenCleanupJob	null	0	1730334177	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
40	OC\\Log\\Rotate	null	0	1730334177	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
41	OC\\Preview\\BackgroundCleanupJob	null	0	1730334177	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
42	OC\\TextProcessing\\RemoveOldTasksBackgroundJob	null	0	1730334177	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
43	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",3]	0	1730334177	0	0	a324f9b0a0f981cbf0bb0042f95a5ab4456b471f080b49802cd060efc566f1da	1
44	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",5]	0	1730334177	0	0	bab5ba2238ecad63141db6c5f1608efc3b0efecc909f4f8d8e111e0d5c23edad	1
45	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",6]	0	1730334177	0	0	0d840fcf4d96c36eb80b922e14ca2b7aa5acaba8f61b45e2d8bd832199fe8c9d	1
1	OCA\\AppAPI\\BackgroundJob\\ExAppInitStatusCheckJob	null	1730334274	1730334274	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
46	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",7]	0	1730334177	0	0	5889fec72259069bfcddd1167dbbf1c854234eb06614dd8fd894eff7956192a7	1
47	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",8]	0	1730334177	0	0	075228ca5e1ab3f24fd39c1402e41a206a4afd78fc71b52f0021faaa6121c260	1
48	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",9]	0	1730334177	0	0	6aeb888c4dfdca1c745d4f2367a7386cf490285b3d961db0382c594a54c400a0	1
49	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",10]	0	1730334177	0	0	9e79a1d0a821264f3aa6269c1d3dba0f52274f57ff2819cc5c70f60300c2ec6c	1
50	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",11]	0	1730334177	0	0	32ea4cc1f86ec7aba234f815b18136b6eab27615e67f71a4f752e863214b3b22	1
51	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",12]	0	1730334177	0	0	2f60738088dd89b5b25465a7c6c482de073a21ffe62c3b8a3ec59ad5a1f4c15f	1
52	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",13]	0	1730334177	0	0	05b302cbd33b86157c9981f8eb4ab72466e203421a1a8d2b9d504b7ec7e17ea7	1
53	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",14]	0	1730334177	0	0	70e10015f10fbd6d13870e3908314ad4de673976fc3075d2eda0d7d4b2681dc6	1
54	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",15]	0	1730334177	0	0	22aa486f345e5794cae46ce5def4dd3810bcc6c191e1190594fcdcbfaf05c65f	1
55	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",16]	0	1730334177	0	0	cdf77c66ee9dc02019f56d1e8999668d813066995c75ab4c48ce506c209fe0f6	1
56	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",18]	0	1730334177	0	0	d6f63b0735f2a90b0ce0af8891b0398880b7399b786f84b0818adeeba359f1bb	1
57	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",19]	0	1730334177	0	0	27a2cbe5b547b14f49ab72b681e53a8a1e74f549192ae8898bb4c2f4f88555fd	1
58	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",20]	0	1730334178	0	0	876775feb13959831d8c7753e2a4abd552e03b394d84939656bb5dce9ce4f8f6	1
59	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",21]	0	1730334178	0	0	79363e541ba12589811d7a0d3403d97d4d60a73c91e92db043322e5ca990c8fb	1
60	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",22]	0	1730334178	0	0	830acf7a8ef52afbe08fc2713df540bc14c79f1a0f95c854da5e26b0386477f7	1
61	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",23]	0	1730334178	0	0	9cea6ce18595672d882c9d89a3acfbcf7958a0839bc4a5abaa9ef02d88aebaf1	1
62	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",24]	0	1730334178	0	0	727ef905962bfe27b36d943813e028d0e3664c929d5a714f0d7ac0d000ffa5fd	1
63	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",25]	0	1730334178	0	0	529311c9ad07ba8de6b18178dbcf95b582b72597ade6c56cf1d41d7c6d7397c9	1
64	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",26]	0	1730334178	0	0	003cfb4d3aba0fde31ba26c3b3a820a3d150ea868d5ee2c37c1a33771ef8e8b8	1
65	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",27]	0	1730334178	0	0	b0cc502625f847e1481b6d24d1eb94752736146434df36043a153c9b1ee284c5	1
66	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",28]	0	1730334178	0	0	2e1a9923add930564317a65c0bfc12ca3daa3e2530c1accdaf2277732f6ad934	1
67	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",29]	0	1730334178	0	0	128fb9e5163de0bb1da6d975fed7b8c360a97ec2b9fee149f4bb8aaa9598d2b4	1
68	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",30]	0	1730334178	0	0	e782f2107c9202401ac95b15d443e8da595c6bd92e26e8c5a086a268967794c9	1
69	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",31]	0	1730334178	0	0	86924dbd7b48f415fbf674a2669f36ccb651e936cda773d270e5342bc467d53b	1
70	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",32]	0	1730334178	0	0	ee02ec2ee4e390442f92c13e988ac867bb67074f52aecb22a05bdeee504d6e5f	1
71	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",33]	0	1730334178	0	0	d2fc6457a2d723b580d9219ce144539740f68beea42d1a1379b60ea972699109	1
72	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",34]	0	1730334178	0	0	154b723aa40ccca0c4ef5a72218d14f10a6618261e58095632eca79ecef12329	1
73	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",35]	0	1730334178	0	0	a0ef7cdcb39b887087357a25bd2c1da932604ad5db4388671a25dd4a8bd0317a	1
74	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",36]	0	1730334178	0	0	16df61184ae9e35c363a154732c7351c493d2a3ac34cdf8697fdfbc2da04f191	1
75	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",37]	0	1730334178	0	0	b1e224ce7c7b3a952f648379b84369decad2d9b9ff4206324f216da3fad24c68	1
76	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",38]	0	1730334178	0	0	57471075f497d1a8eadd28685fbd9bbf6da61a6c9440d215d823c6ffbd54d4e7	1
77	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",39]	0	1730334178	0	0	5ca6ac67eac9782f6f7a0b7771f087a2584e0241fb44c99c4743984285097b2e	1
78	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",40]	0	1730334178	0	0	07ba9c6a76e9b0c3a72981be352527e6b36975e7b0976a4fcb3bbc0559d2b542	1
79	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",41]	0	1730334178	0	0	4c14497df884240ef37196f1f3e78f9ecb5715d4e5e8155f4c866e4d45d1a9b2	1
80	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",42]	0	1730334178	0	0	d5a6a27596364bdb824290d1d838e04ef81f732a54d4af8b01a3ff7e4765c99c	1
81	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",43]	0	1730334179	0	0	b7e10b61bf98d5f2376b308c483713cefc1dde08cc62fa9525d280283ac00634	1
82	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",44]	0	1730334179	0	0	7f449813b099905192fcaeb5607970d09c4d8d0998bd58dd3621979f8cd11cb0	1
83	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",45]	0	1730334179	0	0	ba2ef4e3cfbade663cfae1431113a10c4d523728ac0ad237af333b584375ddb4	1
84	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",46]	0	1730334179	0	0	80ff70d0c920a046219b03ff7d3ad47cb1bf4a6208c3200dacf769b3fa6c748c	1
85	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",47]	0	1730334179	0	0	a3890d747cc802dba6a5bf5ea3bc64fa76642bfe22a036742524262b78e1fa00	1
86	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",48]	0	1730334179	0	0	37b98ebdecc5f0658741278c00b9b39e585ef51a5528ec2849a1f22fc65e6a68	1
87	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",49]	0	1730334179	0	0	e1d9319ef784d6e2697941e9c9b806eff09802f8c8b88681164e1fad8a195a2c	1
88	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",50]	0	1730334179	0	0	8737a4a10f2493722aef7c2c8e88401b265cddd3be46f68449a98ec3e63f972a	1
89	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",51]	0	1730334179	0	0	c7cc806c5e0ef963d164ac8ddbd45a0d07c20632a814374beba02523041e6366	1
90	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",52]	0	1730334179	0	0	fd7e2f45366cbfaa56418e9f66de32b1152ceff0b9e2a95c35f8ab9cf14e9ab3	1
91	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",54]	0	1730334179	0	0	377bbca9da63af8ce04de552dedba2ec51ab03dedabd1720fd8af9044500ec08	1
92	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",55]	0	1730334179	0	0	c0b05087e2b5a15f9e2889da4e63410fc313358d668337a87e0012a7d4a49abb	1
93	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",56]	0	1730334179	0	0	7c8bf950975a947a8c9ac0c21b5d220c756e025a71ae33a74845207900dfd749	1
94	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",57]	0	1730334179	0	0	56a538f0d0beb9c2a8fdea0f875b6ce62c5eaf8879ed9984caab1a5dec150bc5	1
95	OCA\\FirstRunWizard\\Notification\\BackgroundJob	{"uid":"admin"}	0	1730337054	0	0	70071f2985a39d9762e53229dd5125d134cd7601939c1a4d69cd99aa90057e8a	1
2	OCA\\AppAPI\\BackgroundJob\\ProvidersAICleanUpJob	null	1730337056	1730337056	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	0
\.


--
-- Data for Name: oc_known_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_known_users (id, known_to, known_user) FROM stdin;
\.


--
-- Data for Name: oc_login_flow_v2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_login_flow_v2 (id, "timestamp", started, poll_token, login_token, public_key, private_key, client_name, login_name, server, app_password) FROM stdin;
\.


--
-- Data for Name: oc_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_migrations (app, version) FROM stdin;
core	13000Date20170705121758
core	13000Date20170718121200
core	13000Date20170814074715
core	13000Date20170919121250
core	13000Date20170926101637
core	14000Date20180129121024
core	14000Date20180404140050
core	14000Date20180516101403
core	14000Date20180518120534
core	14000Date20180522074438
core	14000Date20180626223656
core	14000Date20180710092004
core	14000Date20180712153140
core	15000Date20180926101451
core	15000Date20181015062942
core	15000Date20181029084625
core	16000Date20190207141427
core	16000Date20190212081545
core	16000Date20190427105638
core	16000Date20190428150708
core	17000Date20190514105811
core	18000Date20190920085628
core	18000Date20191014105105
core	18000Date20191204114856
core	19000Date20200211083441
core	20000Date20201109081915
core	20000Date20201109081918
core	20000Date20201109081919
core	20000Date20201111081915
core	21000Date20201120141228
core	21000Date20201202095923
core	21000Date20210119195004
core	21000Date20210309185126
core	21000Date20210309185127
core	22000Date20210216080825
core	23000Date20210721100600
core	23000Date20210906132259
core	23000Date20210930122352
core	23000Date20211203110726
core	23000Date20211213203940
core	24000Date20211210141942
core	24000Date20211213081506
core	24000Date20211213081604
core	24000Date20211222112246
core	24000Date20211230140012
core	24000Date20220131153041
core	24000Date20220202150027
core	24000Date20220404230027
core	24000Date20220425072957
core	25000Date20220515204012
core	25000Date20220602190540
core	25000Date20220905140840
core	25000Date20221007010957
core	27000Date20220613163520
core	27000Date20230309104325
core	27000Date20230309104802
core	28000Date20230616104802
core	28000Date20230728104802
core	28000Date20230803221055
core	28000Date20230906104802
core	28000Date20231004103301
core	28000Date20231103104802
core	28000Date20231126110901
core	28000Date20240828142927
core	29000Date20231126110901
core	29000Date20231213104850
core	29000Date20240124132201
core	29000Date20240124132202
core	29000Date20240131122720
core	30000Date20240429122720
core	30000Date20240708160048
core	30000Date20240717111406
core	30000Date20240814180800
core	30000Date20240815080800
core	30000Date20240906095113
webhook_listeners	1000Date20240527153425
webhook_listeners	1001Date20240716184935
federatedfilesharing	1010Date20200630191755
federatedfilesharing	1011Date20201120125158
app_api	1000Date202305221555
app_api	1004Date202311061844
app_api	1005Date202312271744
app_api	1006Date202401011308
app_api	1007Date202401111030
app_api	1008Date202401121205
app_api	2000Date20240120094952
app_api	2005Date20240209094951
app_api	2200Date20240216164351
app_api	2201Date20240221124152
app_api	2203Date20240325124149
app_api	2204Date20240401104001
app_api	2204Date20240403125002
app_api	2205Date20240411124836
app_api	2206Date20240502145029
app_api	2207Date20240502145029
app_api	2700Date20240515092246
app_api	2800Date20240710220000
app_api	2800Date20240711080316
app_api	3000Date20240715170800
app_api	3000Date20240807085759
app_api	3100Date20240822080316
app_api	3200Date20240905080316
files_reminders	10000Date20230725162149
workflowengine	2000Date20190808074233
workflowengine	2200Date20210805101925
circles	0022Date20220526111723
circles	0022Date20220526113601
circles	0022Date20220703115023
circles	0023Date20211216113101
circles	0024Date20220203123901
circles	0024Date20220203123902
circles	0024Date20220317190331
circles	0028Date20230705222601
text	010000Date20190617184535
text	030001Date20200402075029
text	030201Date20201116110353
text	030201Date20201116123153
text	030501Date20220202101853
text	030701Date20230207131313
text	030901Date20231114150437
text	040100Date20240611165300
files_downloadlimit	000000Date20210910094923
files_versions	1020Date20221114144058
federation	1010Date20200630191302
activity	2006Date20170808154933
activity	2006Date20170808155040
activity	2006Date20170919095939
activity	2007Date20181107114613
activity	2008Date20181011095117
activity	2010Date20190416112817
activity	2011Date20201006132544
activity	2011Date20201006132545
activity	2011Date20201006132546
activity	2011Date20201006132547
activity	2011Date20201207091915
privacy	100Date20190217131943
files_sharing	11300Date20201120141438
files_sharing	21000Date20201223143245
files_sharing	22000Date20210216084241
files_sharing	24000Date20220208195521
files_sharing	24000Date20220404142216
updatenotification	011901Date20240305120000
oauth2	010401Date20181207190718
oauth2	010402Date20190107124745
oauth2	011601Date20230522143227
oauth2	011602Date20230613160650
oauth2	011603Date20230620111039
oauth2	011901Date20240829164356
photos	20000Date20220727125801
photos	20001Date20220830131446
photos	20003Date20221102170153
photos	20003Date20221103094628
photos	30000Date20240417075405
twofactor_backupcodes	1002Date20170607104347
twofactor_backupcodes	1002Date20170607113030
twofactor_backupcodes	1002Date20170919123342
twofactor_backupcodes	1002Date20170926101419
twofactor_backupcodes	1002Date20180821043638
dav	1004Date20170825134824
dav	1004Date20170919104507
dav	1004Date20170924124212
dav	1004Date20170926103422
dav	1005Date20180413093149
dav	1005Date20180530124431
dav	1006Date20180619154313
dav	1006Date20180628111625
dav	1008Date20181030113700
dav	1008Date20181105104826
dav	1008Date20181105104833
dav	1008Date20181105110300
dav	1008Date20181105112049
dav	1008Date20181114084440
dav	1011Date20190725113607
dav	1011Date20190806104428
dav	1012Date20190808122342
dav	1016Date20201109085907
dav	1017Date20210216083742
dav	1018Date20210312100735
dav	1024Date20211221144219
dav	1025Date20240308063933
dav	1027Date20230504122946
dav	1029Date20221114151721
dav	1029Date20231004091403
dav	1030Date20240205103243
dav	1031Date20240610134258
user_status	0001Date20200602134824
user_status	0002Date20200902144824
user_status	1000Date20201111130204
user_status	1003Date20210809144824
user_status	1008Date20230921144701
notifications	2004Date20190107135757
notifications	2010Date20210218082811
notifications	2010Date20210218082855
notifications	2011Date20210930134607
notifications	2011Date20220826074907
contactsinteraction	010000Date20200304152605
theming	2006Date20240905111627
files_trashbin	1010Date20200630192639
files_trashbin	1020Date20240403003535
files	11301Date20191205150729
files	12101Date20221011153334
\.


--
-- Data for Name: oc_mimetypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_mimetypes (id, mimetype) FROM stdin;
1	httpd
2	httpd/unix-directory
3	video
4	video/mp4
5	image
6	image/jpeg
7	text
8	text/markdown
9	application
10	application/pdf
11	image/png
12	application/vnd.oasis.opendocument.text
13	application/vnd.oasis.opendocument.spreadsheet
14	application/vnd.oasis.opendocument.presentation
15	application/vnd.excalidraw+json
16	application/vnd.oasis.opendocument.graphics
17	application/vnd.openxmlformats-officedocument.wordprocessingml.document
18	application/octet-stream
19	application/javascript
20	application/gzip
21	image/heic
22	image/webp
23	video/quicktime
\.


--
-- Data for Name: oc_mounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_mounts (id, storage_id, root_id, user_id, mount_point, mount_id, mount_provider_class) FROM stdin;
1	1	1	admin	/admin/	\N	OC\\Files\\Mount\\LocalHomeMountProvider
\.


--
-- Data for Name: oc_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_notifications (notification_id, app, "user", "timestamp", object_type, object_id, subject, subject_parameters, message, message_parameters, link, icon, actions) FROM stdin;
1	firstrunwizard	admin	1730334273	app	recognize	apphint-recognize	[]		[]			[]
2	firstrunwizard	admin	1730334273	app	groupfolders	apphint-groupfolders	[]		[]			[]
3	firstrunwizard	admin	1730334273	app	forms	apphint-forms	[]		[]			[]
4	firstrunwizard	admin	1730334273	app	deck	apphint-deck	[]		[]			[]
5	firstrunwizard	admin	1730334273	app	tasks	apphint-tasks	[]		[]			[]
6	firstrunwizard	admin	1730334273	app	whiteboard	apphint-whiteboard	[]		[]			[]
\.


--
-- Data for Name: oc_notifications_pushhash; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_notifications_pushhash (id, uid, token, deviceidentifier, devicepublickey, devicepublickeyhash, pushtokenhash, proxyserver, apptype) FROM stdin;
\.


--
-- Data for Name: oc_notifications_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_notifications_settings (id, user_id, batch_time, last_send_id, next_send_time) FROM stdin;
1	admin	0	0	0
\.


--
-- Data for Name: oc_oauth2_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_oauth2_access_tokens (id, token_id, client_id, hashed_code, encrypted_token, code_created_at, token_count) FROM stdin;
\.


--
-- Data for Name: oc_oauth2_clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_oauth2_clients (id, name, redirect_uri, client_identifier, secret) FROM stdin;
\.


--
-- Data for Name: oc_open_local_editor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_open_local_editor (id, user_id, path_hash, expiration_time, token) FROM stdin;
\.


--
-- Data for Name: oc_photos_albums; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_photos_albums (album_id, name, "user", created, location, last_added_photo) FROM stdin;
\.


--
-- Data for Name: oc_photos_albums_collabs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_photos_albums_collabs (id, album_id, collaborator_id, collaborator_type) FROM stdin;
\.


--
-- Data for Name: oc_photos_albums_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_photos_albums_files (album_file_id, album_id, file_id, added, owner) FROM stdin;
\.


--
-- Data for Name: oc_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_preferences (userid, appid, configkey, configvalue) FROM stdin;
admin	activity	configured	yes
admin	notifications	sound_notification	no
admin	notifications	sound_talk	no
admin	password_policy	failedLoginAttempts	0
admin	core	templateDirectory	Templates/
admin	login	lastLogin	1730334272
admin	core	timezone	Europe/Moscow
admin	login_token	giWX+btg/F4ZwYIjQNBEpaQJ2MdnRYft	1730334273
admin	firstrunwizard	apphint	19
admin	core	lang	ru
admin	avatar	generated	true
\.


--
-- Data for Name: oc_preferences_ex; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_preferences_ex (id, userid, appid, configkey, configvalue) FROM stdin;
\.


--
-- Data for Name: oc_privacy_admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_privacy_admins (id, displayname) FROM stdin;
\.


--
-- Data for Name: oc_profile_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_profile_config (id, user_id, config) FROM stdin;
\.


--
-- Data for Name: oc_properties; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_properties (id, userid, propertypath, propertyname, propertyvalue, valuetype) FROM stdin;
\.


--
-- Data for Name: oc_ratelimit_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_ratelimit_entries (id, hash, delete_after) FROM stdin;
\.


--
-- Data for Name: oc_reactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_reactions (id, parent_id, message_id, actor_type, actor_id, reaction) FROM stdin;
\.


--
-- Data for Name: oc_recent_contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_recent_contact (id, actor_uid, uid, email, federated_cloud_id, card, last_contact) FROM stdin;
\.


--
-- Data for Name: oc_schedulingobjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_schedulingobjects (id, principaluri, calendardata, uri, lastmodified, etag, size) FROM stdin;
\.


--
-- Data for Name: oc_share; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_share (id, share_type, share_with, password, uid_owner, uid_initiator, parent, item_type, item_source, item_target, file_source, file_target, permissions, stime, accepted, expiration, token, mail_send, share_name, password_by_talk, note, hide_download, label, attributes, password_expiration_time) FROM stdin;
\.


--
-- Data for Name: oc_share_external; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_share_external (id, parent, share_type, remote, remote_id, share_token, password, name, owner, "user", mountpoint, mountpoint_hash, accepted) FROM stdin;
\.


--
-- Data for Name: oc_shares_limits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_shares_limits (id, "limit", downloads) FROM stdin;
\.


--
-- Data for Name: oc_storages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_storages (numeric_id, id, available, last_checked) FROM stdin;
1	home::admin	1	\N
2	local::/mnt/nextcloud/data/	1	\N
\.


--
-- Data for Name: oc_storages_credentials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_storages_credentials (id, "user", identifier, credentials) FROM stdin;
\.


--
-- Data for Name: oc_systemtag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_systemtag (id, name, visibility, editable) FROM stdin;
\.


--
-- Data for Name: oc_systemtag_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_systemtag_group (systemtagid, gid) FROM stdin;
\.


--
-- Data for Name: oc_systemtag_object_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_systemtag_object_mapping (objectid, objecttype, systemtagid) FROM stdin;
\.


--
-- Data for Name: oc_taskprocessing_tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_taskprocessing_tasks (id, type, input, output, status, user_id, app_id, custom_id, last_updated, completion_expected_at, progress, error_message, scheduled_at, started_at, ended_at, webhook_uri, webhook_method) FROM stdin;
\.


--
-- Data for Name: oc_text2image_tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_text2image_tasks (id, input, status, number_of_images, user_id, app_id, identifier, last_updated, completion_expected_at) FROM stdin;
\.


--
-- Data for Name: oc_text_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_text_documents (id, current_version, last_saved_version, last_saved_version_time, last_saved_version_etag, base_version_etag) FROM stdin;
\.


--
-- Data for Name: oc_text_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_text_sessions (id, user_id, guest_name, color, token, document_id, last_contact, last_awareness_message) FROM stdin;
\.


--
-- Data for Name: oc_text_steps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_text_steps (id, document_id, session_id, data, version, "timestamp") FROM stdin;
\.


--
-- Data for Name: oc_textprocessing_tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_textprocessing_tasks (id, type, input, output, status, user_id, app_id, identifier, last_updated, completion_expected_at) FROM stdin;
\.


--
-- Data for Name: oc_trusted_servers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_trusted_servers (id, url, url_hash, token, shared_secret, status, sync_token) FROM stdin;
\.


--
-- Data for Name: oc_twofactor_backupcodes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_twofactor_backupcodes (id, user_id, code, used) FROM stdin;
\.


--
-- Data for Name: oc_twofactor_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_twofactor_providers (provider_id, uid, enabled) FROM stdin;
backup_codes	admin	0
\.


--
-- Data for Name: oc_user_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_user_status (id, user_id, status, status_timestamp, is_user_defined, message_id, custom_icon, custom_message, clear_at, is_backup, status_message_timestamp) FROM stdin;
1	admin	online	1730337056	f	\N	\N	\N	\N	f	0
\.


--
-- Data for Name: oc_user_transfer_owner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_user_transfer_owner (id, source_user, target_user, file_id, node_name) FROM stdin;
\.


--
-- Data for Name: oc_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_users (uid, displayname, password, uid_lower) FROM stdin;
admin	\N	3|$argon2id$v=19$m=65536,t=4,p=1$QXpwN2drNDF5T0p6RE9hLg$CwbYpSLeD3cnQb0YaZEZL9EbUFIDcPDBXjSe84vIEp0	admin
\.


--
-- Data for Name: oc_vcategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_vcategory (id, uid, type, category) FROM stdin;
\.


--
-- Data for Name: oc_vcategory_to_object; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_vcategory_to_object (objid, categoryid, type) FROM stdin;
\.


--
-- Data for Name: oc_webauthn; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_webauthn (id, uid, name, public_key_credential_id, data, user_verification) FROM stdin;
\.


--
-- Data for Name: oc_webhook_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_webhook_listeners (id, app_id, user_id, http_method, uri, event, event_filter, user_id_filter, headers, auth_method, auth_data) FROM stdin;
\.


--
-- Data for Name: oc_whats_new; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_whats_new (id, version, etag, last_check, data) FROM stdin;
\.


--
-- Name: oc_accounts_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_accounts_data_id_seq', 13, true);


--
-- Name: oc_activity_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_activity_activity_id_seq', 107, true);


--
-- Name: oc_activity_mq_mail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_activity_mq_mail_id_seq', 1, false);


--
-- Name: oc_addressbookchanges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_addressbookchanges_id_seq', 1, false);


--
-- Name: oc_addressbooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_addressbooks_id_seq', 1, false);


--
-- Name: oc_appconfig_ex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_appconfig_ex_id_seq', 1, false);


--
-- Name: oc_authorized_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_authorized_groups_id_seq', 1, false);


--
-- Name: oc_authtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_authtoken_id_seq', 1, true);


--
-- Name: oc_bruteforce_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_bruteforce_attempts_id_seq', 1, false);


--
-- Name: oc_calendar_invitations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_calendar_invitations_id_seq', 1, false);


--
-- Name: oc_calendar_reminders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_calendar_reminders_id_seq', 1, false);


--
-- Name: oc_calendar_resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_calendar_resources_id_seq', 1, false);


--
-- Name: oc_calendar_resources_md_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_calendar_resources_md_id_seq', 1, false);


--
-- Name: oc_calendar_rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_calendar_rooms_id_seq', 1, false);


--
-- Name: oc_calendar_rooms_md_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_calendar_rooms_md_id_seq', 1, false);


--
-- Name: oc_calendarchanges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_calendarchanges_id_seq', 1, false);


--
-- Name: oc_calendarobjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_calendarobjects_id_seq', 1, false);


--
-- Name: oc_calendarobjects_props_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_calendarobjects_props_id_seq', 1, false);


--
-- Name: oc_calendars_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_calendars_id_seq', 1, false);


--
-- Name: oc_calendarsubscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_calendarsubscriptions_id_seq', 1, false);


--
-- Name: oc_cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_cards_id_seq', 1, false);


--
-- Name: oc_cards_properties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_cards_properties_id_seq', 1, false);


--
-- Name: oc_circles_circle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_circles_circle_id_seq', 2, true);


--
-- Name: oc_circles_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_circles_member_id_seq', 2, true);


--
-- Name: oc_circles_mount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_circles_mount_id_seq', 1, false);


--
-- Name: oc_circles_mountpoint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_circles_mountpoint_id_seq', 1, false);


--
-- Name: oc_circles_remote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_circles_remote_id_seq', 1, false);


--
-- Name: oc_circles_share_lock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_circles_share_lock_id_seq', 1, false);


--
-- Name: oc_circles_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_circles_token_id_seq', 1, false);


--
-- Name: oc_collres_collections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_collres_collections_id_seq', 1, false);


--
-- Name: oc_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_comments_id_seq', 1, false);


--
-- Name: oc_dav_absence_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_dav_absence_id_seq', 1, false);


--
-- Name: oc_dav_cal_proxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_dav_cal_proxy_id_seq', 1, false);


--
-- Name: oc_dav_shares_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_dav_shares_id_seq', 1, false);


--
-- Name: oc_direct_edit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_direct_edit_id_seq', 1, false);


--
-- Name: oc_directlink_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_directlink_id_seq', 1, false);


--
-- Name: oc_ex_apps_daemons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_apps_daemons_id_seq', 1, false);


--
-- Name: oc_ex_apps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_apps_id_seq', 1, false);


--
-- Name: oc_ex_apps_routes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_apps_routes_id_seq', 1, false);


--
-- Name: oc_ex_event_handlers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_event_handlers_id_seq', 1, false);


--
-- Name: oc_ex_occ_commands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_occ_commands_id_seq', 1, false);


--
-- Name: oc_ex_settings_forms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_settings_forms_id_seq', 1, false);


--
-- Name: oc_ex_speech_to_text_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_speech_to_text_id_seq', 1, false);


--
-- Name: oc_ex_speech_to_text_q_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_speech_to_text_q_id_seq', 1, false);


--
-- Name: oc_ex_task_processing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_task_processing_id_seq', 1, false);


--
-- Name: oc_ex_text_processing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_text_processing_id_seq', 1, false);


--
-- Name: oc_ex_text_processing_q_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_text_processing_q_id_seq', 1, false);


--
-- Name: oc_ex_translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_translation_id_seq', 1, false);


--
-- Name: oc_ex_translation_q_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_translation_q_id_seq', 1, false);


--
-- Name: oc_ex_ui_files_actions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_ui_files_actions_id_seq', 1, false);


--
-- Name: oc_ex_ui_scripts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_ui_scripts_id_seq', 1, false);


--
-- Name: oc_ex_ui_states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_ui_states_id_seq', 1, false);


--
-- Name: oc_ex_ui_styles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_ui_styles_id_seq', 1, false);


--
-- Name: oc_ex_ui_top_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ex_ui_top_menu_id_seq', 1, false);


--
-- Name: oc_file_locks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_file_locks_id_seq', 196, true);


--
-- Name: oc_filecache_fileid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_filecache_fileid_seq', 271, true);


--
-- Name: oc_files_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_files_metadata_id_seq', 10, true);


--
-- Name: oc_files_metadata_index_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_files_metadata_index_id_seq', 19, true);


--
-- Name: oc_files_reminders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_files_reminders_id_seq', 1, false);


--
-- Name: oc_files_trash_auto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_files_trash_auto_id_seq', 1, false);


--
-- Name: oc_files_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_files_versions_id_seq', 52, true);


--
-- Name: oc_flow_checks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_flow_checks_id_seq', 1, false);


--
-- Name: oc_flow_operations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_flow_operations_id_seq', 1, false);


--
-- Name: oc_flow_operations_scope_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_flow_operations_scope_id_seq', 1, false);


--
-- Name: oc_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_jobs_id_seq', 95, true);


--
-- Name: oc_known_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_known_users_id_seq', 1, false);


--
-- Name: oc_login_flow_v2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_login_flow_v2_id_seq', 1, false);


--
-- Name: oc_mimetypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_mimetypes_id_seq', 23, true);


--
-- Name: oc_mounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_mounts_id_seq', 1, true);


--
-- Name: oc_notifications_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_notifications_notification_id_seq', 6, true);


--
-- Name: oc_notifications_pushhash_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_notifications_pushhash_id_seq', 1, false);


--
-- Name: oc_notifications_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_notifications_settings_id_seq', 1, true);


--
-- Name: oc_oauth2_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_oauth2_access_tokens_id_seq', 1, false);


--
-- Name: oc_oauth2_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_oauth2_clients_id_seq', 1, false);


--
-- Name: oc_open_local_editor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_open_local_editor_id_seq', 1, false);


--
-- Name: oc_photos_albums_album_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_photos_albums_album_id_seq', 1, false);


--
-- Name: oc_photos_albums_collabs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_photos_albums_collabs_id_seq', 1, false);


--
-- Name: oc_photos_albums_files_album_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_photos_albums_files_album_file_id_seq', 1, false);


--
-- Name: oc_preferences_ex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_preferences_ex_id_seq', 1, false);


--
-- Name: oc_privacy_admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_privacy_admins_id_seq', 1, false);


--
-- Name: oc_profile_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_profile_config_id_seq', 1, false);


--
-- Name: oc_properties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_properties_id_seq', 1, false);


--
-- Name: oc_ratelimit_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_ratelimit_entries_id_seq', 1, false);


--
-- Name: oc_reactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_reactions_id_seq', 1, false);


--
-- Name: oc_recent_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_recent_contact_id_seq', 1, false);


--
-- Name: oc_schedulingobjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_schedulingobjects_id_seq', 1, false);


--
-- Name: oc_share_external_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_share_external_id_seq', 1, false);


--
-- Name: oc_share_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_share_id_seq', 1, false);


--
-- Name: oc_storages_credentials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_storages_credentials_id_seq', 1, false);


--
-- Name: oc_storages_numeric_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_storages_numeric_id_seq', 2, true);


--
-- Name: oc_systemtag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_systemtag_id_seq', 1, false);


--
-- Name: oc_taskprocessing_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_taskprocessing_tasks_id_seq', 1, false);


--
-- Name: oc_text2image_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_text2image_tasks_id_seq', 1, false);


--
-- Name: oc_text_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_text_sessions_id_seq', 1, false);


--
-- Name: oc_text_steps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_text_steps_id_seq', 1, false);


--
-- Name: oc_textprocessing_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_textprocessing_tasks_id_seq', 1, false);


--
-- Name: oc_trusted_servers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_trusted_servers_id_seq', 1, false);


--
-- Name: oc_twofactor_backupcodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_twofactor_backupcodes_id_seq', 1, false);


--
-- Name: oc_user_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_user_status_id_seq', 1, true);


--
-- Name: oc_user_transfer_owner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_user_transfer_owner_id_seq', 1, false);


--
-- Name: oc_vcategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_vcategory_id_seq', 1, false);


--
-- Name: oc_webauthn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_webauthn_id_seq', 1, false);


--
-- Name: oc_webhook_listeners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_webhook_listeners_id_seq', 1, false);


--
-- Name: oc_whats_new_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_whats_new_id_seq', 1, false);


--
-- Name: oc_accounts_data oc_accounts_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_accounts_data
    ADD CONSTRAINT oc_accounts_data_pkey PRIMARY KEY (id);


--
-- Name: oc_accounts oc_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_accounts
    ADD CONSTRAINT oc_accounts_pkey PRIMARY KEY (uid);


--
-- Name: oc_activity_mq oc_activity_mq_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_activity_mq
    ADD CONSTRAINT oc_activity_mq_pkey PRIMARY KEY (mail_id);


--
-- Name: oc_activity oc_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_activity
    ADD CONSTRAINT oc_activity_pkey PRIMARY KEY (activity_id);


--
-- Name: oc_addressbookchanges oc_addressbookchanges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_addressbookchanges
    ADD CONSTRAINT oc_addressbookchanges_pkey PRIMARY KEY (id);


--
-- Name: oc_addressbooks oc_addressbooks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_addressbooks
    ADD CONSTRAINT oc_addressbooks_pkey PRIMARY KEY (id);


--
-- Name: oc_appconfig_ex oc_appconfig_ex_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_appconfig_ex
    ADD CONSTRAINT oc_appconfig_ex_pkey PRIMARY KEY (id);


--
-- Name: oc_appconfig oc_appconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_appconfig
    ADD CONSTRAINT oc_appconfig_pkey PRIMARY KEY (appid, configkey);


--
-- Name: oc_authorized_groups oc_authorized_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_authorized_groups
    ADD CONSTRAINT oc_authorized_groups_pkey PRIMARY KEY (id);


--
-- Name: oc_authtoken oc_authtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_authtoken
    ADD CONSTRAINT oc_authtoken_pkey PRIMARY KEY (id);


--
-- Name: oc_bruteforce_attempts oc_bruteforce_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_bruteforce_attempts
    ADD CONSTRAINT oc_bruteforce_attempts_pkey PRIMARY KEY (id);


--
-- Name: oc_calendar_invitations oc_calendar_invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendar_invitations
    ADD CONSTRAINT oc_calendar_invitations_pkey PRIMARY KEY (id);


--
-- Name: oc_calendar_reminders oc_calendar_reminders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendar_reminders
    ADD CONSTRAINT oc_calendar_reminders_pkey PRIMARY KEY (id);


--
-- Name: oc_calendar_resources_md oc_calendar_resources_md_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendar_resources_md
    ADD CONSTRAINT oc_calendar_resources_md_pkey PRIMARY KEY (id);


--
-- Name: oc_calendar_resources oc_calendar_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendar_resources
    ADD CONSTRAINT oc_calendar_resources_pkey PRIMARY KEY (id);


--
-- Name: oc_calendar_rooms_md oc_calendar_rooms_md_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendar_rooms_md
    ADD CONSTRAINT oc_calendar_rooms_md_pkey PRIMARY KEY (id);


--
-- Name: oc_calendar_rooms oc_calendar_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendar_rooms
    ADD CONSTRAINT oc_calendar_rooms_pkey PRIMARY KEY (id);


--
-- Name: oc_calendarchanges oc_calendarchanges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendarchanges
    ADD CONSTRAINT oc_calendarchanges_pkey PRIMARY KEY (id);


--
-- Name: oc_calendarobjects oc_calendarobjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendarobjects
    ADD CONSTRAINT oc_calendarobjects_pkey PRIMARY KEY (id);


--
-- Name: oc_calendarobjects_props oc_calendarobjects_props_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendarobjects_props
    ADD CONSTRAINT oc_calendarobjects_props_pkey PRIMARY KEY (id);


--
-- Name: oc_calendars oc_calendars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendars
    ADD CONSTRAINT oc_calendars_pkey PRIMARY KEY (id);


--
-- Name: oc_calendarsubscriptions oc_calendarsubscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_calendarsubscriptions
    ADD CONSTRAINT oc_calendarsubscriptions_pkey PRIMARY KEY (id);


--
-- Name: oc_cards oc_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_cards
    ADD CONSTRAINT oc_cards_pkey PRIMARY KEY (id);


--
-- Name: oc_cards_properties oc_cards_properties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_cards_properties
    ADD CONSTRAINT oc_cards_properties_pkey PRIMARY KEY (id);


--
-- Name: oc_circles_circle oc_circles_circle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_circle
    ADD CONSTRAINT oc_circles_circle_pkey PRIMARY KEY (id);


--
-- Name: oc_circles_event oc_circles_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_event
    ADD CONSTRAINT oc_circles_event_pkey PRIMARY KEY (token, instance);


--
-- Name: oc_circles_member oc_circles_member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_member
    ADD CONSTRAINT oc_circles_member_pkey PRIMARY KEY (id);


--
-- Name: oc_circles_membership oc_circles_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_membership
    ADD CONSTRAINT oc_circles_membership_pkey PRIMARY KEY (single_id, circle_id);


--
-- Name: oc_circles_mount oc_circles_mount_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_mount
    ADD CONSTRAINT oc_circles_mount_pkey PRIMARY KEY (id);


--
-- Name: oc_circles_mountpoint oc_circles_mountpoint_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_mountpoint
    ADD CONSTRAINT oc_circles_mountpoint_pkey PRIMARY KEY (id);


--
-- Name: oc_circles_remote oc_circles_remote_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_remote
    ADD CONSTRAINT oc_circles_remote_pkey PRIMARY KEY (id);


--
-- Name: oc_circles_share_lock oc_circles_share_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_share_lock
    ADD CONSTRAINT oc_circles_share_lock_pkey PRIMARY KEY (id);


--
-- Name: oc_circles_token oc_circles_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_circles_token
    ADD CONSTRAINT oc_circles_token_pkey PRIMARY KEY (id);


--
-- Name: oc_collres_accesscache oc_collres_accesscache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_collres_accesscache
    ADD CONSTRAINT oc_collres_accesscache_pkey PRIMARY KEY (user_id, collection_id, resource_type, resource_id);


--
-- Name: oc_collres_collections oc_collres_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_collres_collections
    ADD CONSTRAINT oc_collres_collections_pkey PRIMARY KEY (id);


--
-- Name: oc_collres_resources oc_collres_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_collres_resources
    ADD CONSTRAINT oc_collres_resources_pkey PRIMARY KEY (collection_id, resource_type, resource_id);


--
-- Name: oc_comments oc_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_comments
    ADD CONSTRAINT oc_comments_pkey PRIMARY KEY (id);


--
-- Name: oc_comments_read_markers oc_comments_read_markers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_comments_read_markers
    ADD CONSTRAINT oc_comments_read_markers_pkey PRIMARY KEY (user_id, object_type, object_id);


--
-- Name: oc_dav_absence oc_dav_absence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_dav_absence
    ADD CONSTRAINT oc_dav_absence_pkey PRIMARY KEY (id);


--
-- Name: oc_dav_cal_proxy oc_dav_cal_proxy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_dav_cal_proxy
    ADD CONSTRAINT oc_dav_cal_proxy_pkey PRIMARY KEY (id);


--
-- Name: oc_dav_shares oc_dav_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_dav_shares
    ADD CONSTRAINT oc_dav_shares_pkey PRIMARY KEY (id);


--
-- Name: oc_direct_edit oc_direct_edit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_direct_edit
    ADD CONSTRAINT oc_direct_edit_pkey PRIMARY KEY (id);


--
-- Name: oc_directlink oc_directlink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_directlink
    ADD CONSTRAINT oc_directlink_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_apps_daemons oc_ex_apps_daemons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_apps_daemons
    ADD CONSTRAINT oc_ex_apps_daemons_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_apps oc_ex_apps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_apps
    ADD CONSTRAINT oc_ex_apps_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_apps_routes oc_ex_apps_routes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_apps_routes
    ADD CONSTRAINT oc_ex_apps_routes_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_event_handlers oc_ex_event_handlers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_event_handlers
    ADD CONSTRAINT oc_ex_event_handlers_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_occ_commands oc_ex_occ_commands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_occ_commands
    ADD CONSTRAINT oc_ex_occ_commands_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_settings_forms oc_ex_settings_forms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_settings_forms
    ADD CONSTRAINT oc_ex_settings_forms_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_speech_to_text oc_ex_speech_to_text_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_speech_to_text
    ADD CONSTRAINT oc_ex_speech_to_text_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_speech_to_text_q oc_ex_speech_to_text_q_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_speech_to_text_q
    ADD CONSTRAINT oc_ex_speech_to_text_q_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_task_processing oc_ex_task_processing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_task_processing
    ADD CONSTRAINT oc_ex_task_processing_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_text_processing oc_ex_text_processing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_text_processing
    ADD CONSTRAINT oc_ex_text_processing_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_text_processing_q oc_ex_text_processing_q_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_text_processing_q
    ADD CONSTRAINT oc_ex_text_processing_q_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_translation oc_ex_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_translation
    ADD CONSTRAINT oc_ex_translation_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_translation_q oc_ex_translation_q_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_translation_q
    ADD CONSTRAINT oc_ex_translation_q_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_ui_files_actions oc_ex_ui_files_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_ui_files_actions
    ADD CONSTRAINT oc_ex_ui_files_actions_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_ui_scripts oc_ex_ui_scripts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_ui_scripts
    ADD CONSTRAINT oc_ex_ui_scripts_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_ui_states oc_ex_ui_states_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_ui_states
    ADD CONSTRAINT oc_ex_ui_states_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_ui_styles oc_ex_ui_styles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_ui_styles
    ADD CONSTRAINT oc_ex_ui_styles_pkey PRIMARY KEY (id);


--
-- Name: oc_ex_ui_top_menu oc_ex_ui_top_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ex_ui_top_menu
    ADD CONSTRAINT oc_ex_ui_top_menu_pkey PRIMARY KEY (id);


--
-- Name: oc_federated_reshares oc_federated_reshares_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_federated_reshares
    ADD CONSTRAINT oc_federated_reshares_pkey PRIMARY KEY (share_id);


--
-- Name: oc_file_locks oc_file_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_file_locks
    ADD CONSTRAINT oc_file_locks_pkey PRIMARY KEY (id);


--
-- Name: oc_filecache_extended oc_filecache_extended_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_filecache_extended
    ADD CONSTRAINT oc_filecache_extended_pkey PRIMARY KEY (fileid);


--
-- Name: oc_filecache oc_filecache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_filecache
    ADD CONSTRAINT oc_filecache_pkey PRIMARY KEY (fileid);


--
-- Name: oc_files_metadata_index oc_files_metadata_index_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_files_metadata_index
    ADD CONSTRAINT oc_files_metadata_index_pkey PRIMARY KEY (id);


--
-- Name: oc_files_metadata oc_files_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_files_metadata
    ADD CONSTRAINT oc_files_metadata_pkey PRIMARY KEY (id);


--
-- Name: oc_files_reminders oc_files_reminders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_files_reminders
    ADD CONSTRAINT oc_files_reminders_pkey PRIMARY KEY (id);


--
-- Name: oc_files_trash oc_files_trash_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_files_trash
    ADD CONSTRAINT oc_files_trash_pkey PRIMARY KEY (auto_id);


--
-- Name: oc_files_versions oc_files_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_files_versions
    ADD CONSTRAINT oc_files_versions_pkey PRIMARY KEY (id);


--
-- Name: oc_flow_checks oc_flow_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_flow_checks
    ADD CONSTRAINT oc_flow_checks_pkey PRIMARY KEY (id);


--
-- Name: oc_flow_operations oc_flow_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_flow_operations
    ADD CONSTRAINT oc_flow_operations_pkey PRIMARY KEY (id);


--
-- Name: oc_flow_operations_scope oc_flow_operations_scope_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_flow_operations_scope
    ADD CONSTRAINT oc_flow_operations_scope_pkey PRIMARY KEY (id);


--
-- Name: oc_group_admin oc_group_admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_group_admin
    ADD CONSTRAINT oc_group_admin_pkey PRIMARY KEY (gid, uid);


--
-- Name: oc_group_user oc_group_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_group_user
    ADD CONSTRAINT oc_group_user_pkey PRIMARY KEY (gid, uid);


--
-- Name: oc_groups oc_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_groups
    ADD CONSTRAINT oc_groups_pkey PRIMARY KEY (gid);


--
-- Name: oc_jobs oc_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_jobs
    ADD CONSTRAINT oc_jobs_pkey PRIMARY KEY (id);


--
-- Name: oc_known_users oc_known_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_known_users
    ADD CONSTRAINT oc_known_users_pkey PRIMARY KEY (id);


--
-- Name: oc_login_flow_v2 oc_login_flow_v2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_login_flow_v2
    ADD CONSTRAINT oc_login_flow_v2_pkey PRIMARY KEY (id);


--
-- Name: oc_migrations oc_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_migrations
    ADD CONSTRAINT oc_migrations_pkey PRIMARY KEY (app, version);


--
-- Name: oc_mimetypes oc_mimetypes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_mimetypes
    ADD CONSTRAINT oc_mimetypes_pkey PRIMARY KEY (id);


--
-- Name: oc_mounts oc_mounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_mounts
    ADD CONSTRAINT oc_mounts_pkey PRIMARY KEY (id);


--
-- Name: oc_notifications oc_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_notifications
    ADD CONSTRAINT oc_notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: oc_notifications_pushhash oc_notifications_pushhash_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_notifications_pushhash
    ADD CONSTRAINT oc_notifications_pushhash_pkey PRIMARY KEY (id);


--
-- Name: oc_notifications_settings oc_notifications_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_notifications_settings
    ADD CONSTRAINT oc_notifications_settings_pkey PRIMARY KEY (id);


--
-- Name: oc_oauth2_access_tokens oc_oauth2_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_oauth2_access_tokens
    ADD CONSTRAINT oc_oauth2_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: oc_oauth2_clients oc_oauth2_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_oauth2_clients
    ADD CONSTRAINT oc_oauth2_clients_pkey PRIMARY KEY (id);


--
-- Name: oc_open_local_editor oc_open_local_editor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_open_local_editor
    ADD CONSTRAINT oc_open_local_editor_pkey PRIMARY KEY (id);


--
-- Name: oc_photos_albums_collabs oc_photos_albums_collabs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_photos_albums_collabs
    ADD CONSTRAINT oc_photos_albums_collabs_pkey PRIMARY KEY (id);


--
-- Name: oc_photos_albums_files oc_photos_albums_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_photos_albums_files
    ADD CONSTRAINT oc_photos_albums_files_pkey PRIMARY KEY (album_file_id);


--
-- Name: oc_photos_albums oc_photos_albums_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_photos_albums
    ADD CONSTRAINT oc_photos_albums_pkey PRIMARY KEY (album_id);


--
-- Name: oc_preferences_ex oc_preferences_ex_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_preferences_ex
    ADD CONSTRAINT oc_preferences_ex_pkey PRIMARY KEY (id);


--
-- Name: oc_preferences oc_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_preferences
    ADD CONSTRAINT oc_preferences_pkey PRIMARY KEY (userid, appid, configkey);


--
-- Name: oc_privacy_admins oc_privacy_admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_privacy_admins
    ADD CONSTRAINT oc_privacy_admins_pkey PRIMARY KEY (id);


--
-- Name: oc_profile_config oc_profile_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_profile_config
    ADD CONSTRAINT oc_profile_config_pkey PRIMARY KEY (id);


--
-- Name: oc_properties oc_properties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_properties
    ADD CONSTRAINT oc_properties_pkey PRIMARY KEY (id);


--
-- Name: oc_ratelimit_entries oc_ratelimit_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_ratelimit_entries
    ADD CONSTRAINT oc_ratelimit_entries_pkey PRIMARY KEY (id);


--
-- Name: oc_reactions oc_reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_reactions
    ADD CONSTRAINT oc_reactions_pkey PRIMARY KEY (id);


--
-- Name: oc_recent_contact oc_recent_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_recent_contact
    ADD CONSTRAINT oc_recent_contact_pkey PRIMARY KEY (id);


--
-- Name: oc_schedulingobjects oc_schedulingobjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_schedulingobjects
    ADD CONSTRAINT oc_schedulingobjects_pkey PRIMARY KEY (id);


--
-- Name: oc_share_external oc_share_external_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_share_external
    ADD CONSTRAINT oc_share_external_pkey PRIMARY KEY (id);


--
-- Name: oc_share oc_share_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_share
    ADD CONSTRAINT oc_share_pkey PRIMARY KEY (id);


--
-- Name: oc_shares_limits oc_shares_limits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_shares_limits
    ADD CONSTRAINT oc_shares_limits_pkey PRIMARY KEY (id);


--
-- Name: oc_storages_credentials oc_storages_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_storages_credentials
    ADD CONSTRAINT oc_storages_credentials_pkey PRIMARY KEY (id);


--
-- Name: oc_storages oc_storages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_storages
    ADD CONSTRAINT oc_storages_pkey PRIMARY KEY (numeric_id);


--
-- Name: oc_systemtag_group oc_systemtag_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_systemtag_group
    ADD CONSTRAINT oc_systemtag_group_pkey PRIMARY KEY (gid, systemtagid);


--
-- Name: oc_systemtag_object_mapping oc_systemtag_object_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_systemtag_object_mapping
    ADD CONSTRAINT oc_systemtag_object_mapping_pkey PRIMARY KEY (objecttype, objectid, systemtagid);


--
-- Name: oc_systemtag oc_systemtag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_systemtag
    ADD CONSTRAINT oc_systemtag_pkey PRIMARY KEY (id);


--
-- Name: oc_taskprocessing_tasks oc_taskprocessing_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_taskprocessing_tasks
    ADD CONSTRAINT oc_taskprocessing_tasks_pkey PRIMARY KEY (id);


--
-- Name: oc_text2image_tasks oc_text2image_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_text2image_tasks
    ADD CONSTRAINT oc_text2image_tasks_pkey PRIMARY KEY (id);


--
-- Name: oc_text_documents oc_text_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_text_documents
    ADD CONSTRAINT oc_text_documents_pkey PRIMARY KEY (id);


--
-- Name: oc_text_sessions oc_text_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_text_sessions
    ADD CONSTRAINT oc_text_sessions_pkey PRIMARY KEY (id);


--
-- Name: oc_text_steps oc_text_steps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_text_steps
    ADD CONSTRAINT oc_text_steps_pkey PRIMARY KEY (id);


--
-- Name: oc_textprocessing_tasks oc_textprocessing_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_textprocessing_tasks
    ADD CONSTRAINT oc_textprocessing_tasks_pkey PRIMARY KEY (id);


--
-- Name: oc_trusted_servers oc_trusted_servers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_trusted_servers
    ADD CONSTRAINT oc_trusted_servers_pkey PRIMARY KEY (id);


--
-- Name: oc_twofactor_backupcodes oc_twofactor_backupcodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_twofactor_backupcodes
    ADD CONSTRAINT oc_twofactor_backupcodes_pkey PRIMARY KEY (id);


--
-- Name: oc_twofactor_providers oc_twofactor_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_twofactor_providers
    ADD CONSTRAINT oc_twofactor_providers_pkey PRIMARY KEY (provider_id, uid);


--
-- Name: oc_user_status oc_user_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_user_status
    ADD CONSTRAINT oc_user_status_pkey PRIMARY KEY (id);


--
-- Name: oc_user_transfer_owner oc_user_transfer_owner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_user_transfer_owner
    ADD CONSTRAINT oc_user_transfer_owner_pkey PRIMARY KEY (id);


--
-- Name: oc_users oc_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_users
    ADD CONSTRAINT oc_users_pkey PRIMARY KEY (uid);


--
-- Name: oc_vcategory oc_vcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_vcategory
    ADD CONSTRAINT oc_vcategory_pkey PRIMARY KEY (id);


--
-- Name: oc_vcategory_to_object oc_vcategory_to_object_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_vcategory_to_object
    ADD CONSTRAINT oc_vcategory_to_object_pkey PRIMARY KEY (categoryid, objid, type);


--
-- Name: oc_webauthn oc_webauthn_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_webauthn
    ADD CONSTRAINT oc_webauthn_pkey PRIMARY KEY (id);


--
-- Name: oc_webhook_listeners oc_webhook_listeners_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_webhook_listeners
    ADD CONSTRAINT oc_webhook_listeners_pkey PRIMARY KEY (id);


--
-- Name: oc_whats_new oc_whats_new_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oc_whats_new
    ADD CONSTRAINT oc_whats_new_pkey PRIMARY KEY (id);


--
-- Name: ac_lazy_i; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ac_lazy_i ON public.oc_appconfig USING btree (lazy);


--
-- Name: accounts_data_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_data_name ON public.oc_accounts_data USING btree (name);


--
-- Name: accounts_data_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_data_uid ON public.oc_accounts_data USING btree (uid);


--
-- Name: accounts_data_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_data_value ON public.oc_accounts_data USING btree (value);


--
-- Name: activity_filter; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX activity_filter ON public.oc_activity USING btree (affecteduser, type, app, "timestamp");


--
-- Name: activity_filter_by; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX activity_filter_by ON public.oc_activity USING btree (affecteduser, "user", "timestamp");


--
-- Name: activity_object; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX activity_object ON public.oc_activity USING btree (object_type, object_id);


--
-- Name: activity_user_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX activity_user_time ON public.oc_activity USING btree (affecteduser, "timestamp");


--
-- Name: addressbook_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX addressbook_index ON public.oc_addressbooks USING btree (principaluri, uri);


--
-- Name: addressbookid_synctoken; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX addressbookid_synctoken ON public.oc_addressbookchanges USING btree (addressbookid, synctoken);


--
-- Name: admindel_groupid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admindel_groupid_idx ON public.oc_authorized_groups USING btree (group_id);


--
-- Name: album_collabs_uniq_collab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX album_collabs_uniq_collab ON public.oc_photos_albums_collabs USING btree (album_id, collaborator_id, collaborator_type);


--
-- Name: amp_latest_send_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX amp_latest_send_time ON public.oc_activity_mq USING btree (amq_latest_send);


--
-- Name: amp_timestamp_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX amp_timestamp_time ON public.oc_activity_mq USING btree (amq_timestamp);


--
-- Name: amp_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX amp_user ON public.oc_activity_mq USING btree (amq_affecteduser);


--
-- Name: appconfig_ex__configkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX appconfig_ex__configkey ON public.oc_appconfig_ex USING btree (configkey);


--
-- Name: appconfig_ex__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX appconfig_ex__idx ON public.oc_appconfig_ex USING btree (appid, configkey);


--
-- Name: authtoken_last_activity_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authtoken_last_activity_idx ON public.oc_authtoken USING btree (last_activity);


--
-- Name: authtoken_token_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX authtoken_token_index ON public.oc_authtoken USING btree (token);


--
-- Name: authtoken_uid_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authtoken_uid_index ON public.oc_authtoken USING btree (uid);


--
-- Name: bruteforce_attempts_ip; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX bruteforce_attempts_ip ON public.oc_bruteforce_attempts USING btree (ip);


--
-- Name: bruteforce_attempts_subnet; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX bruteforce_attempts_subnet ON public.oc_bruteforce_attempts USING btree (subnet);


--
-- Name: calendar_invitation_tokens; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendar_invitation_tokens ON public.oc_calendar_invitations USING btree (token);


--
-- Name: calendar_reminder_objid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendar_reminder_objid ON public.oc_calendar_reminders USING btree (object_id);


--
-- Name: calendar_reminder_uidrec; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendar_reminder_uidrec ON public.oc_calendar_reminders USING btree (uid, recurrence_id);


--
-- Name: calendar_resources_bkdrsc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendar_resources_bkdrsc ON public.oc_calendar_resources USING btree (backend_id, resource_id);


--
-- Name: calendar_resources_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendar_resources_email ON public.oc_calendar_resources USING btree (email);


--
-- Name: calendar_resources_md_idk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendar_resources_md_idk ON public.oc_calendar_resources_md USING btree (resource_id, key);


--
-- Name: calendar_resources_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendar_resources_name ON public.oc_calendar_resources USING btree (displayname);


--
-- Name: calendar_rooms_bkdrsc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendar_rooms_bkdrsc ON public.oc_calendar_rooms USING btree (backend_id, resource_id);


--
-- Name: calendar_rooms_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendar_rooms_email ON public.oc_calendar_rooms USING btree (email);


--
-- Name: calendar_rooms_md_idk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendar_rooms_md_idk ON public.oc_calendar_rooms_md USING btree (room_id, key);


--
-- Name: calendar_rooms_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendar_rooms_name ON public.oc_calendar_rooms USING btree (displayname);


--
-- Name: calendarobject_calid_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendarobject_calid_index ON public.oc_calendarobjects_props USING btree (calendarid, calendartype);


--
-- Name: calendarobject_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendarobject_index ON public.oc_calendarobjects_props USING btree (objectid, calendartype);


--
-- Name: calendarobject_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendarobject_name_index ON public.oc_calendarobjects_props USING btree (name, calendartype);


--
-- Name: calendarobject_value_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendarobject_value_index ON public.oc_calendarobjects_props USING btree (value, calendartype);


--
-- Name: calendars_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX calendars_index ON public.oc_calendars USING btree (principaluri, uri);


--
-- Name: calid_type_synctoken; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calid_type_synctoken ON public.oc_calendarchanges USING btree (calendarid, calendartype, synctoken);


--
-- Name: calobj_clssfction_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calobj_clssfction_index ON public.oc_calendarobjects USING btree (classification);


--
-- Name: calobjects_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX calobjects_index ON public.oc_calendarobjects USING btree (calendarid, calendartype, uri);


--
-- Name: cals_princ_del_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cals_princ_del_idx ON public.oc_calendars USING btree (principaluri, deleted_at);


--
-- Name: calsub_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX calsub_index ON public.oc_calendarsubscriptions USING btree (principaluri, uri);


--
-- Name: card_contactid_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX card_contactid_index ON public.oc_cards_properties USING btree (cardid);


--
-- Name: card_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX card_name_index ON public.oc_cards_properties USING btree (name);


--
-- Name: card_value_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX card_value_index ON public.oc_cards_properties USING btree (value);


--
-- Name: cards_abiduri; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cards_abiduri ON public.oc_cards USING btree (addressbookid, uri);


--
-- Name: cards_prop_abid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cards_prop_abid ON public.oc_cards_properties USING btree (addressbookid);


--
-- Name: category_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX category_index ON public.oc_vcategory USING btree (category);


--
-- Name: circles_member_cisi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX circles_member_cisi ON public.oc_circles_member USING btree (circle_id, single_id);


--
-- Name: circles_member_cisiuiutil; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX circles_member_cisiuiutil ON public.oc_circles_member USING btree (circle_id, single_id, user_id, user_type, instance, level);


--
-- Name: circles_membership_ifilci; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX circles_membership_ifilci ON public.oc_circles_membership USING btree (inheritance_first, inheritance_last, circle_id);


--
-- Name: circles_mount_cimipt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX circles_mount_cimipt ON public.oc_circles_mount USING btree (circle_id, mount_id, parent, token);


--
-- Name: circles_mountpoint_ms; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX circles_mountpoint_ms ON public.oc_circles_mountpoint USING btree (mount_id, single_id);


--
-- Name: collres_user_res; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX collres_user_res ON public.oc_collres_accesscache USING btree (user_id, resource_type, resource_id);


--
-- Name: comment_reaction; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX comment_reaction ON public.oc_reactions USING btree (reaction);


--
-- Name: comment_reaction_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX comment_reaction_parent_id ON public.oc_reactions USING btree (parent_id);


--
-- Name: comment_reaction_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX comment_reaction_unique ON public.oc_reactions USING btree (parent_id, actor_type, actor_id, reaction);


--
-- Name: comments_actor_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX comments_actor_index ON public.oc_comments USING btree (actor_type, actor_id);


--
-- Name: comments_marker_object_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX comments_marker_object_index ON public.oc_comments_read_markers USING btree (object_type, object_id);


--
-- Name: comments_object_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX comments_object_index ON public.oc_comments USING btree (object_type, object_id, creation_timestamp);


--
-- Name: comments_parent_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX comments_parent_id_index ON public.oc_comments USING btree (parent_id);


--
-- Name: comments_topmost_parent_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX comments_topmost_parent_id_idx ON public.oc_comments USING btree (topmost_parent_id);


--
-- Name: dav_absence_uid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX dav_absence_uid_idx ON public.oc_dav_absence USING btree (user_id);


--
-- Name: dav_cal_proxy_ipid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dav_cal_proxy_ipid ON public.oc_dav_cal_proxy USING btree (proxy_id);


--
-- Name: dav_cal_proxy_uidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX dav_cal_proxy_uidx ON public.oc_dav_cal_proxy USING btree (owner_id, proxy_id, permissions);


--
-- Name: dav_shares_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX dav_shares_index ON public.oc_dav_shares USING btree (principaluri, resourceid, type, publicuri);


--
-- Name: dav_shares_resourceid_access; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dav_shares_resourceid_access ON public.oc_dav_shares USING btree (resourceid, access);


--
-- Name: dav_shares_resourceid_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dav_shares_resourceid_type ON public.oc_dav_shares USING btree (resourceid, type);


--
-- Name: direct_edit_timestamp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX direct_edit_timestamp ON public.oc_direct_edit USING btree ("timestamp");


--
-- Name: directlink_expiration_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX directlink_expiration_idx ON public.oc_directlink USING btree (expiration);


--
-- Name: directlink_token_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX directlink_token_idx ON public.oc_directlink USING btree (token);


--
-- Name: dname; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dname ON public.oc_circles_circle USING btree (display_name);


--
-- Name: ex_apps__appid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ex_apps__appid ON public.oc_ex_apps USING btree (appid);


--
-- Name: ex_apps_c_port__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ex_apps_c_port__idx ON public.oc_ex_apps USING btree (daemon_config_name, port);


--
-- Name: ex_apps_daemons__name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ex_apps_daemons__name ON public.oc_ex_apps_daemons USING btree (name);


--
-- Name: ex_apps_routes_appid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ex_apps_routes_appid ON public.oc_ex_apps_routes USING btree (appid);


--
-- Name: ex_event_handlers__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ex_event_handlers__idx ON public.oc_ex_event_handlers USING btree (appid, event_type);


--
-- Name: ex_occ_commands__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ex_occ_commands__idx ON public.oc_ex_occ_commands USING btree (appid, name);


--
-- Name: ex_settings_forms__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ex_settings_forms__idx ON public.oc_ex_settings_forms USING btree (appid, formid);


--
-- Name: ex_translation__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ex_translation__idx ON public.oc_ex_translation USING btree (appid, name);


--
-- Name: ex_ui_files_actions__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ex_ui_files_actions__idx ON public.oc_ex_ui_files_actions USING btree (appid, name);


--
-- Name: expire_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX expire_date ON public.oc_comments USING btree (expire_date);


--
-- Name: f_meta_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX f_meta_index ON public.oc_files_metadata_index USING btree (file_id, meta_key, meta_value_string);


--
-- Name: f_meta_index_i; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX f_meta_index_i ON public.oc_files_metadata_index USING btree (file_id, meta_key, meta_value_int);


--
-- Name: fce_ctime_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fce_ctime_idx ON public.oc_filecache_extended USING btree (creation_time);


--
-- Name: fce_utime_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fce_utime_idx ON public.oc_filecache_extended USING btree (upload_time);


--
-- Name: file_source_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX file_source_index ON public.oc_share USING btree (file_source);


--
-- Name: files_meta_fileid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX files_meta_fileid ON public.oc_files_metadata USING btree (file_id);


--
-- Name: files_versions_uniq_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX files_versions_uniq_index ON public.oc_files_versions USING btree (file_id, "timestamp");


--
-- Name: flow_unique_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX flow_unique_hash ON public.oc_flow_checks USING btree (hash);


--
-- Name: flow_unique_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX flow_unique_scope ON public.oc_flow_operations_scope USING btree (operation_id, type, value);


--
-- Name: fs_id_storage_size; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fs_id_storage_size ON public.oc_filecache USING btree (fileid, storage, size);


--
-- Name: fs_mtime; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fs_mtime ON public.oc_filecache USING btree (mtime);


--
-- Name: fs_name_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fs_name_hash ON public.oc_filecache USING btree (name);


--
-- Name: fs_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fs_parent ON public.oc_filecache USING btree (parent);


--
-- Name: fs_parent_name_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fs_parent_name_hash ON public.oc_filecache USING btree (parent, name);


--
-- Name: fs_size; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fs_size ON public.oc_filecache USING btree (size);


--
-- Name: fs_storage_mimepart; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fs_storage_mimepart ON public.oc_filecache USING btree (storage, mimepart);


--
-- Name: fs_storage_mimetype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fs_storage_mimetype ON public.oc_filecache USING btree (storage, mimetype);


--
-- Name: fs_storage_path_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX fs_storage_path_hash ON public.oc_filecache USING btree (storage, path_hash);


--
-- Name: fs_storage_size; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fs_storage_size ON public.oc_filecache USING btree (storage, size, fileid);


--
-- Name: group_admin_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX group_admin_uid ON public.oc_group_admin USING btree (uid);


--
-- Name: gu_uid_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gu_uid_index ON public.oc_group_user USING btree (uid);


--
-- Name: id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX id_index ON public.oc_files_trash USING btree (id);


--
-- Name: idx_25c66a49e7a1254a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_25c66a49e7a1254a ON public.oc_circles_member USING btree (contact_id);


--
-- Name: idx_38ce0470a64fab3c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_38ce0470a64fab3c ON public.oc_ex_translation_q USING btree (finished);


--
-- Name: idx_4d5afeca5f37a13b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_4d5afeca5f37a13b ON public.oc_direct_edit USING btree (token);


--
-- Name: idx_8195f5484230b1de; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_8195f5484230b1de ON public.oc_circles_circle USING btree (instance);


--
-- Name: idx_8195f5485f8a7f73; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_8195f5485f8a7f73 ON public.oc_circles_circle USING btree (source);


--
-- Name: idx_8195f548c317b362; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_8195f548c317b362 ON public.oc_circles_circle USING btree (sanitized_name);


--
-- Name: idx_8195f548d48a2f7c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_8195f548d48a2f7c ON public.oc_circles_circle USING btree (config);


--
-- Name: idx_8fc816eae7c1d92b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_8fc816eae7c1d92b ON public.oc_circles_membership USING btree (single_id);


--
-- Name: idx_c1e06c58a64fab3c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_c1e06c58a64fab3c ON public.oc_ex_speech_to_text_q USING btree (finished);


--
-- Name: idx_cb97986aa64fab3c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cb97986aa64fab3c ON public.oc_ex_text_processing_q USING btree (finished);


--
-- Name: idx_f94ef8334f8e741; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_f94ef8334f8e741 ON public.oc_circles_remote USING btree (href);


--
-- Name: idx_f94ef83539b0606; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_f94ef83539b0606 ON public.oc_circles_remote USING btree (uid);


--
-- Name: initiator_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX initiator_index ON public.oc_share USING btree (uid_initiator);


--
-- Name: item_share_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX item_share_type_index ON public.oc_share USING btree (item_type, share_type);


--
-- Name: job_argument_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_argument_hash ON public.oc_jobs USING btree (class, argument_hash);


--
-- Name: job_class_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_class_index ON public.oc_jobs USING btree (class);


--
-- Name: job_lastcheck_reserved; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_lastcheck_reserved ON public.oc_jobs USING btree (last_checked, reserved_at);


--
-- Name: jobs_time_sensitive; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_time_sensitive ON public.oc_jobs USING btree (time_sensitive);


--
-- Name: ku_known_to; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ku_known_to ON public.oc_known_users USING btree (known_to);


--
-- Name: ku_known_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ku_known_user ON public.oc_known_users USING btree (known_user);


--
-- Name: lock_key_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX lock_key_index ON public.oc_file_locks USING btree (key);


--
-- Name: lock_ttl_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX lock_ttl_index ON public.oc_file_locks USING btree (ttl);


--
-- Name: login_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX login_token ON public.oc_login_flow_v2 USING btree (login_token);


--
-- Name: mimetype_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX mimetype_id_index ON public.oc_mimetypes USING btree (mimetype);


--
-- Name: mount_user_storage; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mount_user_storage ON public.oc_mounts USING btree (storage_id, user_id);


--
-- Name: mounts_class_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mounts_class_index ON public.oc_mounts USING btree (mount_provider_class);


--
-- Name: mounts_mount_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mounts_mount_id_index ON public.oc_mounts USING btree (mount_id);


--
-- Name: mounts_root_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mounts_root_index ON public.oc_mounts USING btree (root_id);


--
-- Name: mounts_storage_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mounts_storage_index ON public.oc_mounts USING btree (storage_id);


--
-- Name: mounts_user_root_path_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mounts_user_root_path_index ON public.oc_mounts USING btree (user_id, root_id, mount_point);


--
-- Name: notset_nextsend; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notset_nextsend ON public.oc_notifications_settings USING btree (next_send_time);


--
-- Name: notset_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX notset_user ON public.oc_notifications_settings USING btree (user_id);


--
-- Name: oauth2_access_client_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_access_client_id_idx ON public.oc_oauth2_access_tokens USING btree (client_id);


--
-- Name: oauth2_access_hash_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX oauth2_access_hash_idx ON public.oc_oauth2_access_tokens USING btree (hashed_code);


--
-- Name: oauth2_client_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX oauth2_client_id_idx ON public.oc_oauth2_clients USING btree (client_identifier);


--
-- Name: oauth2_tk_c_created_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_tk_c_created_idx ON public.oc_oauth2_access_tokens USING btree (token_count, code_created_at);


--
-- Name: oc_notifications_app; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oc_notifications_app ON public.oc_notifications USING btree (app);


--
-- Name: oc_notifications_object; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oc_notifications_object ON public.oc_notifications USING btree (object_type, object_id);


--
-- Name: oc_notifications_timestamp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oc_notifications_timestamp ON public.oc_notifications USING btree ("timestamp");


--
-- Name: oc_notifications_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oc_notifications_user ON public.oc_notifications USING btree ("user");


--
-- Name: oc_npushhash_di; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oc_npushhash_di ON public.oc_notifications_pushhash USING btree (deviceidentifier);


--
-- Name: oc_npushhash_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX oc_npushhash_uid ON public.oc_notifications_pushhash USING btree (uid, token);


--
-- Name: openlocal_user_path_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX openlocal_user_path_token ON public.oc_open_local_editor USING btree (user_id, path_hash, token);


--
-- Name: owner_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX owner_index ON public.oc_share USING btree (uid_owner);


--
-- Name: pa_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pa_user ON public.oc_photos_albums USING btree ("user");


--
-- Name: paf_album_file; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX paf_album_file ON public.oc_photos_albums_files USING btree (album_id, file_id);


--
-- Name: paf_folder; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX paf_folder ON public.oc_photos_albums_files USING btree (album_id);


--
-- Name: parent_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX parent_index ON public.oc_share USING btree (parent);


--
-- Name: poll_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX poll_token ON public.oc_login_flow_v2 USING btree (poll_token);


--
-- Name: preferences_app_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX preferences_app_key ON public.oc_preferences USING btree (appid, configkey);


--
-- Name: preferences_ex__configkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX preferences_ex__configkey ON public.oc_preferences_ex USING btree (configkey);


--
-- Name: preferences_ex__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX preferences_ex__idx ON public.oc_preferences_ex USING btree (userid, appid, configkey);


--
-- Name: profile_config_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX profile_config_user_id_idx ON public.oc_profile_config USING btree (user_id);


--
-- Name: properties_path_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX properties_path_index ON public.oc_properties USING btree (userid, propertypath);


--
-- Name: properties_pathonly_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX properties_pathonly_index ON public.oc_properties USING btree (propertypath);


--
-- Name: ratelimit_delete_after; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ratelimit_delete_after ON public.oc_ratelimit_entries USING btree (delete_after);


--
-- Name: ratelimit_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ratelimit_hash ON public.oc_ratelimit_entries USING btree (hash);


--
-- Name: rd_session_token_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rd_session_token_idx ON public.oc_text_sessions USING btree (token);


--
-- Name: rd_steps_did_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rd_steps_did_idx ON public.oc_text_steps USING btree (document_id);


--
-- Name: rd_steps_version_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rd_steps_version_idx ON public.oc_text_steps USING btree (version);


--
-- Name: recent_contact_actor_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recent_contact_actor_uid ON public.oc_recent_contact USING btree (actor_uid);


--
-- Name: recent_contact_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recent_contact_email ON public.oc_recent_contact USING btree (email);


--
-- Name: recent_contact_fed_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recent_contact_fed_id ON public.oc_recent_contact USING btree (federated_cloud_id);


--
-- Name: recent_contact_id_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recent_contact_id_uid ON public.oc_recent_contact USING btree (id, actor_uid);


--
-- Name: recent_contact_last_contact; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recent_contact_last_contact ON public.oc_recent_contact USING btree (last_contact);


--
-- Name: recent_contact_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recent_contact_uid ON public.oc_recent_contact USING btree (uid);


--
-- Name: reminders_uniq_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX reminders_uniq_idx ON public.oc_files_reminders USING btree (user_id, file_id, due_date);


--
-- Name: schedulobj_lastmodified_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedulobj_lastmodified_idx ON public.oc_schedulingobjects USING btree (lastmodified);


--
-- Name: schedulobj_principuri_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schedulobj_principuri_index ON public.oc_schedulingobjects USING btree (principaluri);


--
-- Name: sh_external_mp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sh_external_mp ON public.oc_share_external USING btree ("user", mountpoint_hash);


--
-- Name: share_with_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX share_with_index ON public.oc_share USING btree (share_with);


--
-- Name: sicisimit; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sicisimit ON public.oc_circles_token USING btree (share_id, circle_id, single_id, member_id, token);


--
-- Name: speech_to_text__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX speech_to_text__idx ON public.oc_ex_speech_to_text USING btree (appid, name);


--
-- Name: stocred_ui; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX stocred_ui ON public.oc_storages_credentials USING btree ("user", identifier);


--
-- Name: stocred_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX stocred_user ON public.oc_storages_credentials USING btree ("user");


--
-- Name: storages_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX storages_id_index ON public.oc_storages USING btree (id);


--
-- Name: systag_by_tagid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX systag_by_tagid ON public.oc_systemtag_object_mapping USING btree (systemtagid, objecttype);


--
-- Name: t2i_tasks_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t2i_tasks_status ON public.oc_text2image_tasks USING btree (status);


--
-- Name: t2i_tasks_uid_appid_ident; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t2i_tasks_uid_appid_ident ON public.oc_text2image_tasks USING btree (user_id, app_id, identifier);


--
-- Name: t2i_tasks_updated; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t2i_tasks_updated ON public.oc_text2image_tasks USING btree (last_updated);


--
-- Name: tag_ident; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tag_ident ON public.oc_systemtag USING btree (name, visibility, editable);


--
-- Name: task_processing_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX task_processing_idx ON public.oc_ex_task_processing USING btree (app_id, name, task_type);


--
-- Name: taskp_tasks_status_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX taskp_tasks_status_type ON public.oc_taskprocessing_tasks USING btree (status, type);


--
-- Name: taskp_tasks_uid_appid_cid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX taskp_tasks_uid_appid_cid ON public.oc_taskprocessing_tasks USING btree (user_id, app_id, custom_id);


--
-- Name: taskp_tasks_updated; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX taskp_tasks_updated ON public.oc_taskprocessing_tasks USING btree (last_updated);


--
-- Name: text_processing__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX text_processing__idx ON public.oc_ex_text_processing USING btree (appid, name);


--
-- Name: textstep_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX textstep_session ON public.oc_text_steps USING btree (session_id);


--
-- Name: timestamp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "timestamp" ON public.oc_login_flow_v2 USING btree ("timestamp");


--
-- Name: timestamp_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX timestamp_index ON public.oc_files_trash USING btree ("timestamp");


--
-- Name: token_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_index ON public.oc_share USING btree (token);


--
-- Name: tp_tasks_status_type_nonunique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tp_tasks_status_type_nonunique ON public.oc_textprocessing_tasks USING btree (status, type);


--
-- Name: tp_tasks_uid_appid_ident; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tp_tasks_uid_appid_ident ON public.oc_textprocessing_tasks USING btree (user_id, app_id, identifier);


--
-- Name: tp_tasks_updated; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tp_tasks_updated ON public.oc_textprocessing_tasks USING btree (last_updated);


--
-- Name: ts_docid_lastcontact; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ts_docid_lastcontact ON public.oc_text_sessions USING btree (document_id, last_contact);


--
-- Name: ts_lastcontact; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ts_lastcontact ON public.oc_text_sessions USING btree (last_contact);


--
-- Name: twofactor_backupcodes_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX twofactor_backupcodes_uid ON public.oc_twofactor_backupcodes USING btree (user_id);


--
-- Name: twofactor_providers_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX twofactor_providers_uid ON public.oc_twofactor_providers USING btree (uid);


--
-- Name: type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX type_index ON public.oc_vcategory USING btree (type);


--
-- Name: ui_script__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ui_script__idx ON public.oc_ex_ui_scripts USING btree (appid, type, name, path);


--
-- Name: ui_state__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ui_state__idx ON public.oc_ex_ui_states USING btree (appid, type, name, key);


--
-- Name: ui_style__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ui_style__idx ON public.oc_ex_ui_styles USING btree (appid, type, name, path);


--
-- Name: ui_top_menu__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ui_top_menu__idx ON public.oc_ex_ui_top_menu USING btree (appid, name);


--
-- Name: uid_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX uid_index ON public.oc_vcategory USING btree (uid);


--
-- Name: uniq_337f52f8126f525e70ee2ff6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uniq_337f52f8126f525e70ee2ff6 ON public.oc_circles_share_lock USING btree (item_id, circle_id);


--
-- Name: uniq_8195f548e3c68343; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uniq_8195f548e3c68343 ON public.oc_circles_circle USING btree (unique_id);


--
-- Name: uniq_f94ef834230b1de; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uniq_f94ef834230b1de ON public.oc_circles_remote USING btree (instance);


--
-- Name: url_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX url_hash ON public.oc_trusted_servers USING btree (url_hash);


--
-- Name: user_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_index ON public.oc_files_trash USING btree ("user");


--
-- Name: user_status_clr_ix; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_status_clr_ix ON public.oc_user_status USING btree (clear_at);


--
-- Name: user_status_iud_ix; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_status_iud_ix ON public.oc_user_status USING btree (is_user_defined, status);


--
-- Name: user_status_mtstmp_ix; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_status_mtstmp_ix ON public.oc_user_status USING btree (status_message_timestamp);


--
-- Name: user_status_tstmp_ix; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_status_tstmp_ix ON public.oc_user_status USING btree (status_timestamp);


--
-- Name: user_status_uid_ix; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_status_uid_ix ON public.oc_user_status USING btree (user_id);


--
-- Name: user_uid_lower; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_uid_lower ON public.oc_users USING btree (uid_lower);


--
-- Name: vcategory_objectd_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vcategory_objectd_index ON public.oc_vcategory_to_object USING btree (objid, type);


--
-- Name: version; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX version ON public.oc_whats_new USING btree (version);


--
-- Name: version_etag_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX version_etag_idx ON public.oc_whats_new USING btree (version, etag);


--
-- Name: webauthn_publickeycredentialid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX webauthn_publickeycredentialid ON public.oc_webauthn USING btree (public_key_credential_id);


--
-- Name: webauthn_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX webauthn_uid ON public.oc_webauthn USING btree (uid);


--
-- PostgreSQL database dump complete
--

