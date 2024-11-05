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
1	1730839633	30	file_created	admin	admin	files	created_self	[{"3":"\\/Nextcloud intro.mp4"}]		[]	/Nextcloud intro.mp4	http://localhost/index.php/apps/files/?dir=/	files	3
2	1730839633	30	file_changed	admin	admin	files	changed_self	[{"3":"\\/Nextcloud intro.mp4"}]		[]	/Nextcloud intro.mp4	http://localhost/index.php/apps/files/?dir=/	files	3
3	1730839633	30	file_created	admin	admin	files	created_self	[{"4":"\\/Photos"}]		[]	/Photos	http://localhost/index.php/apps/files/?dir=/	files	4
4	1730839633	30	file_created	admin	admin	files	created_self	[{"5":"\\/Photos\\/Birdie.jpg"}]		[]	/Photos/Birdie.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	5
5	1730839633	30	file_changed	admin	admin	files	changed_self	[{"5":"\\/Photos\\/Birdie.jpg"}]		[]	/Photos/Birdie.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	5
6	1730839633	30	file_created	admin	admin	files	created_self	[{"6":"\\/Photos\\/Toucan.jpg"}]		[]	/Photos/Toucan.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	6
7	1730839633	30	file_changed	admin	admin	files	changed_self	[{"6":"\\/Photos\\/Toucan.jpg"}]		[]	/Photos/Toucan.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	6
8	1730839633	30	file_created	admin	admin	files	created_self	[{"7":"\\/Photos\\/Library.jpg"}]		[]	/Photos/Library.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	7
9	1730839633	30	file_changed	admin	admin	files	changed_self	[{"7":"\\/Photos\\/Library.jpg"}]		[]	/Photos/Library.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	7
10	1730839633	30	file_created	admin	admin	files	created_self	[{"8":"\\/Photos\\/Frog.jpg"}]		[]	/Photos/Frog.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	8
11	1730839633	30	file_changed	admin	admin	files	changed_self	[{"8":"\\/Photos\\/Frog.jpg"}]		[]	/Photos/Frog.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	8
12	1730839633	30	file_created	admin	admin	files	created_self	[{"9":"\\/Photos\\/Vineyard.jpg"}]		[]	/Photos/Vineyard.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	9
13	1730839633	30	file_changed	admin	admin	files	changed_self	[{"9":"\\/Photos\\/Vineyard.jpg"}]		[]	/Photos/Vineyard.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	9
14	1730839633	30	file_created	admin	admin	files	created_self	[{"10":"\\/Photos\\/Gorilla.jpg"}]		[]	/Photos/Gorilla.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	10
15	1730839633	30	file_changed	admin	admin	files	changed_self	[{"10":"\\/Photos\\/Gorilla.jpg"}]		[]	/Photos/Gorilla.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	10
16	1730839633	30	file_created	admin	admin	files	created_self	[{"11":"\\/Photos\\/Nextcloud community.jpg"}]		[]	/Photos/Nextcloud community.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	11
17	1730839633	30	file_changed	admin	admin	files	changed_self	[{"11":"\\/Photos\\/Nextcloud community.jpg"}]		[]	/Photos/Nextcloud community.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	11
18	1730839633	30	file_created	admin	admin	files	created_self	[{"12":"\\/Photos\\/Readme.md"}]		[]	/Photos/Readme.md	http://localhost/index.php/apps/files/?dir=/Photos	files	12
19	1730839633	30	file_changed	admin	admin	files	changed_self	[{"12":"\\/Photos\\/Readme.md"}]		[]	/Photos/Readme.md	http://localhost/index.php/apps/files/?dir=/Photos	files	12
20	1730839633	30	file_created	admin	admin	files	created_self	[{"13":"\\/Photos\\/Steps.jpg"}]		[]	/Photos/Steps.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	13
21	1730839633	30	file_changed	admin	admin	files	changed_self	[{"13":"\\/Photos\\/Steps.jpg"}]		[]	/Photos/Steps.jpg	http://localhost/index.php/apps/files/?dir=/Photos	files	13
22	1730839633	30	file_created	admin	admin	files	created_self	[{"14":"\\/Nextcloud Manual.pdf"}]		[]	/Nextcloud Manual.pdf	http://localhost/index.php/apps/files/?dir=/	files	14
23	1730839633	30	file_changed	admin	admin	files	changed_self	[{"14":"\\/Nextcloud Manual.pdf"}]		[]	/Nextcloud Manual.pdf	http://localhost/index.php/apps/files/?dir=/	files	14
24	1730839633	30	file_created	admin	admin	files	created_self	[{"15":"\\/Readme.md"}]		[]	/Readme.md	http://localhost/index.php/apps/files/?dir=/	files	15
25	1730839633	30	file_changed	admin	admin	files	changed_self	[{"15":"\\/Readme.md"}]		[]	/Readme.md	http://localhost/index.php/apps/files/?dir=/	files	15
26	1730839633	30	file_created	admin	admin	files	created_self	[{"16":"\\/Nextcloud.png"}]		[]	/Nextcloud.png	http://localhost/index.php/apps/files/?dir=/	files	16
27	1730839634	30	file_changed	admin	admin	files	changed_self	[{"16":"\\/Nextcloud.png"}]		[]	/Nextcloud.png	http://localhost/index.php/apps/files/?dir=/	files	16
28	1730839634	30	file_created	admin	admin	files	created_self	[{"17":"\\/Templates"}]		[]	/Templates	http://localhost/index.php/apps/files/?dir=/	files	17
29	1730839634	30	file_created	admin	admin	files	created_self	[{"18":"\\/Templates\\/Mother's day.odt"}]		[]	/Templates/Mother's day.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	18
30	1730839634	30	file_changed	admin	admin	files	changed_self	[{"18":"\\/Templates\\/Mother's day.odt"}]		[]	/Templates/Mother's day.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	18
31	1730839634	30	file_created	admin	admin	files	created_self	[{"19":"\\/Templates\\/Photo book.odt"}]		[]	/Templates/Photo book.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	19
32	1730839634	30	file_changed	admin	admin	files	changed_self	[{"19":"\\/Templates\\/Photo book.odt"}]		[]	/Templates/Photo book.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	19
33	1730839634	30	file_created	admin	admin	files	created_self	[{"20":"\\/Templates\\/Business model canvas.ods"}]		[]	/Templates/Business model canvas.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	20
34	1730839634	30	file_changed	admin	admin	files	changed_self	[{"20":"\\/Templates\\/Business model canvas.ods"}]		[]	/Templates/Business model canvas.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	20
35	1730839634	30	file_created	admin	admin	files	created_self	[{"21":"\\/Templates\\/Invoice.odt"}]		[]	/Templates/Invoice.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	21
36	1730839634	30	file_changed	admin	admin	files	changed_self	[{"21":"\\/Templates\\/Invoice.odt"}]		[]	/Templates/Invoice.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	21
37	1730839634	30	file_created	admin	admin	files	created_self	[{"22":"\\/Templates\\/Modern company.odp"}]		[]	/Templates/Modern company.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	22
38	1730839634	30	file_changed	admin	admin	files	changed_self	[{"22":"\\/Templates\\/Modern company.odp"}]		[]	/Templates/Modern company.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	22
39	1730839634	30	file_created	admin	admin	files	created_self	[{"23":"\\/Templates\\/Resume.odt"}]		[]	/Templates/Resume.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	23
40	1730839634	30	file_changed	admin	admin	files	changed_self	[{"23":"\\/Templates\\/Resume.odt"}]		[]	/Templates/Resume.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	23
41	1730839634	30	file_created	admin	admin	files	created_self	[{"24":"\\/Templates\\/Brainstorming.whiteboard"}]		[]	/Templates/Brainstorming.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	24
42	1730839634	30	file_changed	admin	admin	files	changed_self	[{"24":"\\/Templates\\/Brainstorming.whiteboard"}]		[]	/Templates/Brainstorming.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	24
43	1730839634	30	file_created	admin	admin	files	created_self	[{"25":"\\/Templates\\/Flowchart.whiteboard"}]		[]	/Templates/Flowchart.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	25
44	1730839634	30	file_changed	admin	admin	files	changed_self	[{"25":"\\/Templates\\/Flowchart.whiteboard"}]		[]	/Templates/Flowchart.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	25
45	1730839634	30	file_created	admin	admin	files	created_self	[{"26":"\\/Templates\\/Yellow idea.odp"}]		[]	/Templates/Yellow idea.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	26
46	1730839634	30	file_changed	admin	admin	files	changed_self	[{"26":"\\/Templates\\/Yellow idea.odp"}]		[]	/Templates/Yellow idea.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	26
47	1730839634	30	file_created	admin	admin	files	created_self	[{"27":"\\/Templates\\/Business model canvas.odg"}]		[]	/Templates/Business model canvas.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	27
48	1730839634	30	file_changed	admin	admin	files	changed_self	[{"27":"\\/Templates\\/Business model canvas.odg"}]		[]	/Templates/Business model canvas.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	27
49	1730839634	30	file_created	admin	admin	files	created_self	[{"28":"\\/Templates\\/Timeline.whiteboard"}]		[]	/Templates/Timeline.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	28
50	1730839634	30	file_changed	admin	admin	files	changed_self	[{"28":"\\/Templates\\/Timeline.whiteboard"}]		[]	/Templates/Timeline.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	28
51	1730839634	30	file_created	admin	admin	files	created_self	[{"29":"\\/Templates\\/Venn diagram.whiteboard"}]		[]	/Templates/Venn diagram.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	29
52	1730839634	30	file_changed	admin	admin	files	changed_self	[{"29":"\\/Templates\\/Venn diagram.whiteboard"}]		[]	/Templates/Venn diagram.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	29
53	1730839634	30	file_created	admin	admin	files	created_self	[{"30":"\\/Templates\\/Business model canvas.whiteboard"}]		[]	/Templates/Business model canvas.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	30
54	1730839634	30	file_changed	admin	admin	files	changed_self	[{"30":"\\/Templates\\/Business model canvas.whiteboard"}]		[]	/Templates/Business model canvas.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	30
55	1730839634	30	file_created	admin	admin	files	created_self	[{"31":"\\/Templates\\/Mindmap.odg"}]		[]	/Templates/Mindmap.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	31
56	1730839634	30	file_changed	admin	admin	files	changed_self	[{"31":"\\/Templates\\/Mindmap.odg"}]		[]	/Templates/Mindmap.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	31
57	1730839634	30	file_created	admin	admin	files	created_self	[{"32":"\\/Templates\\/Diagram & table.ods"}]		[]	/Templates/Diagram & table.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	32
58	1730839634	30	file_changed	admin	admin	files	changed_self	[{"32":"\\/Templates\\/Diagram & table.ods"}]		[]	/Templates/Diagram & table.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	32
59	1730839634	30	file_created	admin	admin	files	created_self	[{"33":"\\/Templates\\/Org chart.odg"}]		[]	/Templates/Org chart.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	33
60	1730839634	30	file_changed	admin	admin	files	changed_self	[{"33":"\\/Templates\\/Org chart.odg"}]		[]	/Templates/Org chart.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	33
61	1730839634	30	file_created	admin	admin	files	created_self	[{"34":"\\/Templates\\/Meeting notes.md"}]		[]	/Templates/Meeting notes.md	http://localhost/index.php/apps/files/?dir=/Templates	files	34
62	1730839634	30	file_changed	admin	admin	files	changed_self	[{"34":"\\/Templates\\/Meeting notes.md"}]		[]	/Templates/Meeting notes.md	http://localhost/index.php/apps/files/?dir=/Templates	files	34
63	1730839634	30	file_created	admin	admin	files	created_self	[{"35":"\\/Templates\\/Impact effort.whiteboard"}]		[]	/Templates/Impact effort.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	35
64	1730839634	30	file_changed	admin	admin	files	changed_self	[{"35":"\\/Templates\\/Impact effort.whiteboard"}]		[]	/Templates/Impact effort.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	35
65	1730839634	30	file_created	admin	admin	files	created_self	[{"36":"\\/Templates\\/Flowchart.odg"}]		[]	/Templates/Flowchart.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	36
66	1730839634	30	file_changed	admin	admin	files	changed_self	[{"36":"\\/Templates\\/Flowchart.odg"}]		[]	/Templates/Flowchart.odg	http://localhost/index.php/apps/files/?dir=/Templates	files	36
67	1730839634	30	file_created	admin	admin	files	created_self	[{"37":"\\/Templates\\/Mind map.whiteboard"}]		[]	/Templates/Mind map.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	37
68	1730839634	30	file_changed	admin	admin	files	changed_self	[{"37":"\\/Templates\\/Mind map.whiteboard"}]		[]	/Templates/Mind map.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	37
69	1730839635	30	file_created	admin	admin	files	created_self	[{"38":"\\/Templates\\/Meeting agenda.whiteboard"}]		[]	/Templates/Meeting agenda.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	38
70	1730839635	30	file_changed	admin	admin	files	changed_self	[{"38":"\\/Templates\\/Meeting agenda.whiteboard"}]		[]	/Templates/Meeting agenda.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	38
71	1730839635	30	file_created	admin	admin	files	created_self	[{"39":"\\/Templates\\/Readme.md"}]		[]	/Templates/Readme.md	http://localhost/index.php/apps/files/?dir=/Templates	files	39
72	1730839635	30	file_changed	admin	admin	files	changed_self	[{"39":"\\/Templates\\/Readme.md"}]		[]	/Templates/Readme.md	http://localhost/index.php/apps/files/?dir=/Templates	files	39
73	1730839635	30	file_created	admin	admin	files	created_self	[{"40":"\\/Templates\\/Product plan.md"}]		[]	/Templates/Product plan.md	http://localhost/index.php/apps/files/?dir=/Templates	files	40
74	1730839635	30	file_changed	admin	admin	files	changed_self	[{"40":"\\/Templates\\/Product plan.md"}]		[]	/Templates/Product plan.md	http://localhost/index.php/apps/files/?dir=/Templates	files	40
75	1730839635	30	file_created	admin	admin	files	created_self	[{"41":"\\/Templates\\/Timesheet.ods"}]		[]	/Templates/Timesheet.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	41
76	1730839635	30	file_changed	admin	admin	files	changed_self	[{"41":"\\/Templates\\/Timesheet.ods"}]		[]	/Templates/Timesheet.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	41
77	1730839635	30	file_created	admin	admin	files	created_self	[{"42":"\\/Templates\\/Simple.odp"}]		[]	/Templates/Simple.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	42
78	1730839635	30	file_changed	admin	admin	files	changed_self	[{"42":"\\/Templates\\/Simple.odp"}]		[]	/Templates/Simple.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	42
79	1730839635	30	file_created	admin	admin	files	created_self	[{"43":"\\/Templates\\/Kanban board.whiteboard"}]		[]	/Templates/Kanban board.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	43
80	1730839635	30	file_changed	admin	admin	files	changed_self	[{"43":"\\/Templates\\/Kanban board.whiteboard"}]		[]	/Templates/Kanban board.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	43
81	1730839635	30	file_created	admin	admin	files	created_self	[{"44":"\\/Templates\\/Syllabus.odt"}]		[]	/Templates/Syllabus.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	44
82	1730839635	30	file_changed	admin	admin	files	changed_self	[{"44":"\\/Templates\\/Syllabus.odt"}]		[]	/Templates/Syllabus.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	44
83	1730839635	30	file_created	admin	admin	files	created_self	[{"45":"\\/Templates\\/Letter.odt"}]		[]	/Templates/Letter.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	45
84	1730839635	30	file_changed	admin	admin	files	changed_self	[{"45":"\\/Templates\\/Letter.odt"}]		[]	/Templates/Letter.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	45
85	1730839635	30	file_created	admin	admin	files	created_self	[{"46":"\\/Templates\\/Sticky notes.whiteboard"}]		[]	/Templates/Sticky notes.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	46
86	1730839635	30	file_changed	admin	admin	files	changed_self	[{"46":"\\/Templates\\/Sticky notes.whiteboard"}]		[]	/Templates/Sticky notes.whiteboard	http://localhost/index.php/apps/files/?dir=/Templates	files	46
87	1730839635	30	file_created	admin	admin	files	created_self	[{"47":"\\/Templates\\/Elegant.odp"}]		[]	/Templates/Elegant.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	47
88	1730839635	30	file_changed	admin	admin	files	changed_self	[{"47":"\\/Templates\\/Elegant.odp"}]		[]	/Templates/Elegant.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	47
89	1730839635	30	file_created	admin	admin	files	created_self	[{"48":"\\/Templates\\/Party invitation.odt"}]		[]	/Templates/Party invitation.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	48
90	1730839635	30	file_changed	admin	admin	files	changed_self	[{"48":"\\/Templates\\/Party invitation.odt"}]		[]	/Templates/Party invitation.odt	http://localhost/index.php/apps/files/?dir=/Templates	files	48
91	1730839635	30	file_created	admin	admin	files	created_self	[{"49":"\\/Templates\\/Gotong royong.odp"}]		[]	/Templates/Gotong royong.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	49
92	1730839635	30	file_changed	admin	admin	files	changed_self	[{"49":"\\/Templates\\/Gotong royong.odp"}]		[]	/Templates/Gotong royong.odp	http://localhost/index.php/apps/files/?dir=/Templates	files	49
93	1730839635	30	file_created	admin	admin	files	created_self	[{"50":"\\/Templates\\/Expense report.ods"}]		[]	/Templates/Expense report.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	50
94	1730839635	30	file_changed	admin	admin	files	changed_self	[{"50":"\\/Templates\\/Expense report.ods"}]		[]	/Templates/Expense report.ods	http://localhost/index.php/apps/files/?dir=/Templates	files	50
95	1730839635	30	file_created	admin	admin	files	created_self	[{"51":"\\/Templates credits.md"}]		[]	/Templates credits.md	http://localhost/index.php/apps/files/?dir=/	files	51
96	1730839635	30	file_changed	admin	admin	files	changed_self	[{"51":"\\/Templates credits.md"}]		[]	/Templates credits.md	http://localhost/index.php/apps/files/?dir=/	files	51
97	1730839635	30	file_created	admin	admin	files	created_self	[{"52":"\\/Reasons to use Nextcloud.pdf"}]		[]	/Reasons to use Nextcloud.pdf	http://localhost/index.php/apps/files/?dir=/	files	52
98	1730839635	30	file_changed	admin	admin	files	changed_self	[{"52":"\\/Reasons to use Nextcloud.pdf"}]		[]	/Reasons to use Nextcloud.pdf	http://localhost/index.php/apps/files/?dir=/	files	52
99	1730839635	30	file_created	admin	admin	files	created_self	[{"53":"\\/Documents"}]		[]	/Documents	http://localhost/index.php/apps/files/?dir=/	files	53
100	1730839635	30	file_created	admin	admin	files	created_self	[{"54":"\\/Documents\\/Example.md"}]		[]	/Documents/Example.md	http://localhost/index.php/apps/files/?dir=/Documents	files	54
101	1730839635	30	file_changed	admin	admin	files	changed_self	[{"54":"\\/Documents\\/Example.md"}]		[]	/Documents/Example.md	http://localhost/index.php/apps/files/?dir=/Documents	files	54
102	1730839635	30	file_created	admin	admin	files	created_self	[{"55":"\\/Documents\\/Nextcloud flyer.pdf"}]		[]	/Documents/Nextcloud flyer.pdf	http://localhost/index.php/apps/files/?dir=/Documents	files	55
103	1730839635	30	file_changed	admin	admin	files	changed_self	[{"55":"\\/Documents\\/Nextcloud flyer.pdf"}]		[]	/Documents/Nextcloud flyer.pdf	http://localhost/index.php/apps/files/?dir=/Documents	files	55
104	1730839635	30	file_created	admin	admin	files	created_self	[{"56":"\\/Documents\\/Readme.md"}]		[]	/Documents/Readme.md	http://localhost/index.php/apps/files/?dir=/Documents	files	56
105	1730839635	30	file_changed	admin	admin	files	changed_self	[{"56":"\\/Documents\\/Readme.md"}]		[]	/Documents/Readme.md	http://localhost/index.php/apps/files/?dir=/Documents	files	56
106	1730839635	30	file_created	admin	admin	files	created_self	[{"57":"\\/Documents\\/Welcome to Nextcloud Hub.docx"}]		[]	/Documents/Welcome to Nextcloud Hub.docx	http://localhost/index.php/apps/files/?dir=/Documents	files	57
107	1730839635	30	file_changed	admin	admin	files	changed_self	[{"57":"\\/Documents\\/Welcome to Nextcloud Hub.docx"}]		[]	/Documents/Welcome to Nextcloud Hub.docx	http://localhost/index.php/apps/files/?dir=/Documents	files	57
108	1730839761	30	file_created	admin	admin	files	created_self	[{"249":"\\/Photos\\/6adf4d1b-fccd-49c9-bf71-b8b7efd5d1fc.jpg"}]		[]	/Photos/6adf4d1b-fccd-49c9-bf71-b8b7efd5d1fc.jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	249
109	1730839774	30	file_created	admin	admin	files	created_self	[{"260":"\\/Photos\\/9c544df3-4f3c-46d6-9cf3-7c2ec1674262.jpg"}]		[]	/Photos/9c544df3-4f3c-46d6-9cf3-7c2ec1674262.jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	260
110	1730839791	30	file_created	admin	admin	files	created_self	[{"270":"\\/Photos\\/22a1d1ee-460d-4cb8-93c2-b84b3f79b9d3.jpg"}]		[]	/Photos/22a1d1ee-460d-4cb8-93c2-b84b3f79b9d3.jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	270
111	1730839814	30	file_created	admin	admin	files	created_self	[{"281":"\\/Photos\\/71371e82-e096-4916-acf5-680ab3bf84d5.jpg"}]		[]	/Photos/71371e82-e096-4916-acf5-680ab3bf84d5.jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	281
112	1730839873	30	file_created	admin	admin	files	created_self	[{"291":"\\/Photos\\/2024-10-22 10.24.36.jpg"}]		[]	/Photos/2024-10-22 10.24.36.jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	291
113	1730839876	30	file_created	admin	admin	files	created_self	[{"301":"\\/Photos\\/2024-10-22 10.24.59.jpg"}]		[]	/Photos/2024-10-22 10.24.59.jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	301
114	1730839898	30	file_deleted	admin	admin	files	deleted_self	[{"291":"\\/Photos\\/2024-10-22 10.24.36.jpg"}]		[]	/Photos/2024-10-22 10.24.36.jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	291
115	1730839908	30	file_deleted	admin	admin	files	deleted_self	[{"270":"\\/Photos\\/22a1d1ee-460d-4cb8-93c2-b84b3f79b9d3.jpg"}]		[]	/Photos/22a1d1ee-460d-4cb8-93c2-b84b3f79b9d3.jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	270
116	1730839972	30	file_created	admin	admin	files	created_self	[{"327":"\\/Photos\\/58add1a6-3046-4783-a9f2-3224facb28c7.jpg"}]		[]	/Photos/58add1a6-3046-4783-a9f2-3224facb28c7.jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	327
117	1730840010	30	file_created	admin	admin	files	created_self	[{"338":"\\/Photos\\/minsk_halfmarathon2024-20240908132015-f0fb1b04cacd.jpg"}]		[]	/Photos/minsk_halfmarathon2024-20240908132015-f0fb1b04cacd.jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	338
118	1730840017	30	file_created	admin	admin	files	created_self	[{"348":"\\/Photos\\/minsk_halfmarathon2024-20240908133616-a364d4bb1ad5.jpg"}]		[]	/Photos/minsk_halfmarathon2024-20240908133616-a364d4bb1ad5.jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	348
119	1730840032	30	file_created	admin	admin	files	created_self	[{"358":"\\/Photos\\/minsk_halfmarathon2024-20240908133626-e4c68dc8f925.jpg"}]		[]	/Photos/minsk_halfmarathon2024-20240908133626-e4c68dc8f925.jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	358
120	1730840047	30	file_created	admin	admin	files	created_self	[{"367":"\\/Photos\\/minsk_halfmarathon2024-20240908135734-d6a1fffb9855.jpg"}]		[]	/Photos/minsk_halfmarathon2024-20240908135734-d6a1fffb9855.jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	367
121	1730840091	30	file_created	admin	admin	files	created_self	[{"393":"\\/Photos\\/minsk_halfmarathon2024-20240908143703-ff5fc7f117e2.jpg"}]		[]	/Photos/minsk_halfmarathon2024-20240908143703-ff5fc7f117e2.jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	393
122	1730840220	30	file_created	admin	admin	files	created_self	[{"404":"\\/Photos\\/e386abed-7b68-4d84-922a-da8d3a1a939d (1).jpg"}]		[]	/Photos/e386abed-7b68-4d84-922a-da8d3a1a939d (1).jpg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	404
123	1730840224	30	file_created	admin	admin	files	created_self	[{"414":"\\/Photos\\/photo_2024-07-23 11.36.51.jpeg"}]		[]	/Photos/photo_2024-07-23 11.36.51.jpeg	https://nextcloud1.home.local/index.php/apps/files/?dir=/Photos	files	414
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
core	installedat	1730839624.3883	2	0
core	lastupdatedat	1730839624	8	0
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
core	moveavatarsdone	yes	2	0
core	previewsCleanedUp	1	2	0
files	mimetype_version	30.0.1.2	2	0
circles	migration_22	1	2	0
circles	migration_run	0	2	0
dav	regeneratedBirthdayCalendarsForYearFix	yes	2	0
dav	buildCalendarSearchIndex	yes	2	0
dav	buildCalendarReminderIndex	yes	2	0
support	SwitchUpdaterServerHasRun	yes	2	0
circles	maintenance_run	0	2	0
circles	maintenance_update	{"3":1730840084,"2":1730840084,"1":1730840084}	2	0
backgroundjob	lastjob	7	2	0
core	lastcron	1730840227	8	0
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
1	admin	admin	n2UxTsg4UqWsfO93lr8xTWtmvelJTxyfvJLLxc4a7ffRW/bOQqwVYEFHZb3P3L5qmoYxigkCKnQ4r4CgevJzqdonLVpErtu3lewjr+0fl/NESL49FPO9u7RCMT67kbyhCB30wFsXQlAO0B+XyHQAk/M0IXwj5vAI4guVxk92H00NGZx7kpYLrenxiv7AAbJBdhjp5LUylTTncQv8GP8/rciacIvgHg8dSq5t9ThM4OiYiwpgwQ/e9kpdXfWvIFTWRLJyBxy3TyBHBtt5z4EC2/mHIsEnOUZGZyYSBLPA97pXrkPRNbxxtCxS8AOQN8SULgqPS/ZQmfzb7SLoRnqS4g==	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36	35150309a3281bbfa7ff631230df2911a347a45ef425cd36d09bf139f72b3a188aee601a07d8c2ac7a9da28c6dc43507e6bb64485fe3f650cc8182cad07fcafc	0	1	1730840527	1730840415	\N	\N	c9802c2afcf110d2e2a513bf4c13002e47f5555f4481d77bcd12193e07116a1ebb90186c83a9081ffa3721788e09eb0459ddd4fa00c3a0810ac3870f26bd03d860e58e00fcc1c456c6a45737688b7879d56fc3dd808836d6fa04e2c04a0f2c7e53b7464bfe428099a7983d274cfb4eeb5916f59f2ecac22fd7c756b27f3cf4b3743cb079e27148c30479c3e29651c2e2b3db6828d9c8785914a85dcab45d411d42d7d2616447d0d7244f06e3cefbe7d6d64736f90165a363381d1fd22bcd6bde1589fe3568b387809f03ffb331f618526587e7105b4f7a35300cfa7da4d50ae422d4dd8db0c65beccc42046e6fc843c17d4180f600ba1da83efc67d58766cae87cd88727733ebe238589c5688defbd45f9f9d696c8b45a00b2de831fefeda687dac5ab22b85e57c3b9de2369dc1bb3854fe2819bfebe384fb0489687f87a954636f6e76e641d2c2d1f94f7b2d917bc1d16d8284e1e07a267a69ab400f036bc6bcdca54cd2fe6dca0e1787c91d28c3e1e5f1b58bc555a45a4fad852f6318e89a4bfe3805bcfea12bc01b5c8db3ad5dcc805746ca12668960bef2b0f255a6b64aeba6782f905b8697c4d9800301647cbb32c992f7414f0ded952e6ad50851ee9876a366642c5d269675ec3876e881947fcc20321bdaeff3240a6faa2f981d19bdc6ce5110ff7b6f172f1fe3ff246fab67cde4c6ed75efd480000e4f3ce08863e99856c49a284b334ead29f3df55762a8ec2cca90adbea03229bff7f4e8004c7f306e3c1cb7dd83368cf80fca0470b4bd26e23e58c8ba07643efa2d313c31f739699040914615ccc4f55f13ba86d5891f904ceab70fd1acc9b94ffe1d5d637217d03217f4c61b3edd1a4712ee5db94aaebba0dd5c458fa71c5b732673ae244705e1257516dd04c57a6e7c131f2b3717d8ddf95566d425fd70308e3fbb25b77a8663c25a4f2508941f04c765b3acb38a3f146dfb4c383074b46e7791295e3dbd8b1ef146301e5c2f0308bb994c6ed9ef2a5ae0554fd2b61df5e09f9c15772b13efe0b1a5c5b221098e7961560dd9c795ea0837deb0962deb0aa63432b538e924453e7c4377a10413ad5d11f08f1c8d63a79c74c781e9dd6e6d0a1aabc77431845130af4703b4666a88c81aeed2213bcfa1f80ff83dad7ec63869747988203f1a1a77c32c729d7496077dbf8c38cc754b17d7e1db7003c5864646715ec5497b2104e7a266857089a263b380564d7d4e96f1e6783946dab9205db78c6574a3d147560fa4f2db0953c35e86bdb737df9f7d1c9e32e75266b3116847647d3dab9d09eca6607e376437cd3bab877bcbc8abc2fe35d06ec631263837feaaea2538349e4d857deb6c1f5a8a17907a53b476447d357471b0ff16751bdd43d0148865781ca294f6cd9199b106a2d0013887e2a6a14f05a378539e8add0b2bcf2d0a9b1541fd9d6bfa4f088d1d8d5038a5a355c63e218a894e5193db6504ee7c1b427e2b603bfbef67418f828a35abc8758087cdf5eda6bbb3524ad353f6eed0ab504173232f892c919ee8a81a6364b4327f71c996fa3617851c8cd539f84ad954777cd1dea8de36b2342d086736316c1b9ed5f4b4b3b68e296f4853db50d58424568de006b2b712a84cc42d2eb0d49e10f786e0d3badd1d230017ab64c4bd60080ad13a6a1bdee5ef6af47e5d48cbda65144646faba481b6c23e8c322633172d8c7a586deb3e3288d082d22f00cf02e1ded36b21a27e3666bab3bf1863b2b75f31daa6067fd6da28f010e2d04a0589dcdea3e1aaff358fbce9d8faf5f59fc35771806d4f77a7c867201fe761bf4acb6358532ba418bcc9b3c7bd29bce3c17da64d8abb6a0fed537ddffe64e99a855bb1d1adb291fda411b17a1715fed9c446ecba5de79aac45c9f90f10d0276e4042bf9aa24a7286f17c25c6998ed0872a4644ac999f23830bcca19907573488d32e5188babada8cf240ccc86ec4d0b5d8012e4eb8745992725f7d879015c8b61df1090978b9831e45f3bc9be3c4a4889100a07db4e8760832ef6d918f2634939ccaafcc5c3463eae5c5ecb7df606f913fa704d26057a23607d892d8891c808e1528192f60e5188d0445bff6e51cdc971d7dbab231a2ea1bc42023a05f0374c4440c595693b66cfb9e27845d647e02f0b7e8b79cc017c2b433da8f6d45dd2fa588e2ee465da63f38880230d08cfba1a63c1b6b9602b1b3a7f2446903c7d406e7de6e9b4773d0686b9a45ff6c624fe783610b7745ce17c1e085ae277eb745ce29b424686076cf10daa6b7231e1a7bdc09b2df93085aa97d26f8d02fd9a77d7abd70385b4a0c4fba7ad4f9e93a1caf368214759c56432f6065428581b1c83ceb3ab5fe90dd66282ed5c4d026495d39eeba2021d0f0d8458b4fe1ddc700781efe4d489cec89de3083e682f|bb4ad354cd09a89cf5b8df35ba942f3a|70bd41d8d4fc4b13f7c55ef50b8af41c3c1eda0856b5f84b5545f3de0892fc7c491ee24dd3626f97c1e4c1fb0bab49d6528e2ce91fd4706bcde173734cfeb855|3	-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6Vc1dw8CwWAMM/FcnmmL\nt+O8WOdcmHwXv71iQ+AgvLDSrJLbGVnqkrURBhmtvfjG1RclXrcAvMwXetMerfOX\nPTsTBZ6NSKC+UT7ywI7hK93DoEvqh6A5CA4Fo+ocTlQ3LWXjHaMSREbJP1Q3kC8v\n+d/UJb7FpZc6ohXaYsgYkd9CAz96Ba9DHeMAMXfFcmnbBahsbEYt0FxRN3unFdZz\nd/HGcHemvWfES23koRx+gxKvY0QnCy3FHKBxJ2CAkAwTDh6PyKP0YN7jxlEP2vbc\nJXYwjcQR26jHev56UV6B6FuaKYKSWq0T/6JZqapWHzM6IpPWK5urfaKDApqYcYre\npQIDAQAB\n-----END PUBLIC KEY-----\n	2	f	3|$argon2id$v=19$m=65536,t=4,p=1$ZmxQQndINUEzcWpnVTZ2eQ$k9ZalXyIEXUSzYbkp3dqXN9abP79UW/SS271NdMbxfw
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
1	UgHuTLhItmuRHDNRGxerBeqENGlXkDo	user:admin:UgHuTLhItmuRHDNRGxerBeqENGlXkDo	admin			1	1	[]		2024-11-05 20:47:13	0	
2	PkZOCMueH7Tc58XPbJEpEUnX5pQHj2J	app:circles:PkZOCMueH7Tc58XPbJEpEUnX5pQHj2J	Circles			8193	10001	[]		2024-11-05 20:47:13	0	
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
1	PkZOCMueH7Tc58XPbJEpEUnX5pQHj2J	PkZOCMueH7Tc58XPbJEpEUnX5pQHj2J	PkZOCMueH7Tc58XPbJEpEUnX5pQHj2J	circles	10000		\N	9	Member	[]	Circles	2024-11-05 20:47:13		\N	2024-11-05 20:47:13
2	UgHuTLhItmuRHDNRGxerBeqENGlXkDo	UgHuTLhItmuRHDNRGxerBeqENGlXkDo	UgHuTLhItmuRHDNRGxerBeqENGlXkDo	admin	1		PkZOCMueH7Tc58XPbJEpEUnX5pQHj2J	9	Member	[]	admin	2024-11-05 20:47:13		\N	2024-11-05 20:47:13
\.


--
-- Data for Name: oc_circles_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_circles_membership (circle_id, single_id, level, inheritance_first, inheritance_last, inheritance_depth, inheritance_path) FROM stdin;
PkZOCMueH7Tc58XPbJEpEUnX5pQHj2J	PkZOCMueH7Tc58XPbJEpEUnX5pQHj2J	9	PkZOCMueH7Tc58XPbJEpEUnX5pQHj2J	PkZOCMueH7Tc58XPbJEpEUnX5pQHj2J	1	["PkZOCMueH7Tc58XPbJEpEUnX5pQHj2J"]
UgHuTLhItmuRHDNRGxerBeqENGlXkDo	UgHuTLhItmuRHDNRGxerBeqENGlXkDo	9	UgHuTLhItmuRHDNRGxerBeqENGlXkDo	UgHuTLhItmuRHDNRGxerBeqENGlXkDo	1	["UgHuTLhItmuRHDNRGxerBeqENGlXkDo"]
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
46	0	files/9dd12709aa5a405107dd1b4022fb0530	1730843236
68	0	files/7740e1ec60623cc4bf4872a5ad7a010f	1730843256
4	0	files/a3594fd4eca7119cb937772e1f8f5415	1730843236
5	0	files/d9712b9716cc3bf1291505ee6348f1c3	1730843236
7	0	files/ffa8b01491fafe4496ddf6fc6eaaa8dc	1730843236
93	0	files/df6c81f0f0c23bac123a22ac6b3c7eec	1730844021
9	0	files/3bf81792d8ce10562404153add132f75	1730843236
365	0	files/7a97940e751848ba9d9eb01f56197cf0	1730843617
11	0	files/cecfa4eb5a3277d2b93f3c58256f99d8	1730843352
12	0	files/26592869621775b437da2223f81b57ec	1730843236
94	0	files/5d11179bd33a6459a4636e37eea5518b	1730844021
14	0	files/97d15c943c24571e9d96b3b56ea1fab7	1730843236
15	0	files/e07516eb75bb0612a31d042984bf5f81	1730843236
16	0	files/a56e46a0840130c77801888b7938ef44	1730843236
17	0	files/99e7157d3c108dea2df788adac98dcdf	1730843236
18	0	files/50ecde4704a2b3c10bf78e6ddf4e6dd8	1730843236
19	0	files/585427965688188d3e490bfeafa0dc23	1730843236
20	0	files/72c4638c236edf2ec81e1df367b7af50	1730843236
60	0	files/00d303f083a0e12e22aeedf18cfea27a	1730843824
22	0	files/65c01881f1be38fb66046ed8188f51ee	1730843236
23	0	files/4f53a0755b9a327991769630d9f3a6df	1730843236
24	0	files/c2909f8357bdb55caa3cfab3244b491d	1730843236
25	0	files/52a339061f458ebaf8ac51482ef5a7b6	1730843236
26	0	files/d8a65ca6da44c3d64b0bb38675aaf239	1730843236
27	0	files/e58b6cafd92b1275de186e076801da8e	1730843236
28	0	files/911ca602bc4d497be38f208b52e3e924	1730843236
29	0	files/949be7d3dec8bc4b67ba455d1c156abe	1730843236
30	0	files/9ce0f21b323051ab1c07e5ec678d6898	1730843236
31	0	files/87f7757f072295f83c07aec6979240cb	1730843236
32	0	files/cdff7cca41f3f905de0c60387e63dbf3	1730843236
33	0	files/5c08f5e71f92427ab017cf9c59bd9db9	1730843236
34	0	files/5d47ae4b00bfa7d5f077a6e551512581	1730843236
35	0	files/22c25415cc7af7810820da0c389874a9	1730843236
36	0	files/744a1b989a030a9cabcf60ae4f3880f9	1730843236
37	0	files/2f246069f2b9f7ff5ec68f75bd8d196d	1730843236
38	0	files/aa6c31aac2fb137baa6ce6837855a4e1	1730843236
39	0	files/76f4c73b545e08cea45d806526415381	1730843236
40	0	files/b93b10b1b78ba1bee06170a7071504b2	1730843236
41	0	files/bf37f95f1699b3984e9340cc9910c910	1730843236
42	0	files/c74a31ab5b9600c9b35b905544a716e6	1730843236
43	0	files/98e383fa8a3f979e87b2c1375e6e1672	1730843236
75	0	files/57b90f453f720722f23b3b35fb18b602	1730844027
67	0	files/b811a49c6a05478ab83eeae85541ce6e	1730844027
66	0	files/596f983892cc5b4e63782fddb6e65112	1730844027
47	0	files/a7cbbe2af620c21a0c8834e23b08d024	1730843236
48	0	files/8726104a595b336396e42e15c22b2850	1730843236
49	0	files/5cee638e61c80810ec19d33ab0689268	1730843236
50	0	files/d7f93e169178cf12e2d72f9d6f2f7631	1730843236
51	0	files/f8e6c05bec011310390ae1b3b7531888	1730843236
535	1	files/b4a14fde31daa9633bc8efb453e6286e	1730844034
53	0	files/9523448d04e1dbd64f78bf916ae84ab2	1730843236
54	0	files/24cf2c4f6a669b92fbe94181a6ceb5f9	1730843236
55	0	files/ed67ddd54c8c5e073856084bb9448e12	1730843236
56	0	files/83f44a83c313ebf8afb1ece18b387c24	1730843236
57	0	files/a696a612dc95ed2ccbf08146d21b485d	1730843236
44	0	files/585273f764f7401d20c06a646f408e8a	1730843351
59	0	files/e016be2b058d14bafb1412a962744aba	1730843236
1	0	files/e8482945c9011a1fad7f0293d9760c26	1730843236
69	0	files/e2e87d71b4aa0692b559b9b25dd093c2	1730843256
70	0	files/a681b59088afa15f6784726d282747b9	1730843256
71	0	files/235eeb061a11a4b2638571e613229aa0	1730843256
72	0	files/2f6c08bada5179ad9a52558e81d1436c	1730843256
73	0	files/2bde7114dfeb5780417e95387897bb53	1730843256
74	0	files/a686f5c7d4a5d96ccb284e3959d6fefb	1730843256
61	0	files/f4aad03befc4a073c8b79c607a32109b	1730843256
62	0	files/f77cce6bbf6886eaf9aa803dc97d7cad	1730843256
63	0	files/3c88babef1f62bd6dd4c160bb8097ae4	1730843256
64	0	files/c2d0591668f4fdf0ec3d7175c218e201	1730843256
65	0	files/2b753e2dbf65dd167e7aa37e194029ec	1730843256
81	0	files/92a3445c87673a92bae906205dc02aeb	1730843256
82	0	files/ba0631d59f56bee67e1517d3d1c5a75c	1730843256
83	0	files/2b9207613829c505d87bb145863a7028	1730843256
84	0	files/588918b7af34ba9cbcf8facc9b5aed66	1730843256
85	0	files/c222024bc1e09172b8a56073da5e064e	1730843256
88	0	files/bb83ae67d4d304d7cbaada913b0752ed	1730843256
89	0	files/9dc0011f7667d1e0bf804e4cb53271ac	1730843256
90	0	files/a7c21f167f02c3a517505ce13053b5df	1730843256
91	0	files/6686bd01fb652e13216c8ed3e227c23c	1730843256
92	0	files/698bbf564a688ea6478c3bed99d6b98b	1730843256
52	0	files/fa8b49ccd03e69f7eaf9dda531a53e32	1730843351
13	0	files/2c7eaecb9090bd89cef1dcd4d0d5881a	1730843351
45	0	files/70e45c5922aeaf3fd4bc012830eec4db	1730843351
10	0	files/2b7e5de9afe8b3f7b056c0ba2a04af46	1730843351
58	0	files/cbc6f4e337332b94c2e02444d64b1c16	1730843351
8	0	files/6b2de085d9b53fa93fa74433933ff37f	1730843352
6	0	files/3513aba8aa4305d3ad33fc7122d4af30	1730843824
21	0	files/84fc6d08ed3bd071bcdab33a99d2d7d9	1730843353
86	0	files/7522969f42cae378874dc4ebf90a6401	1730843256
87	0	files/50759e48fa8e2f05852c2937dee352d1	1730843256
363	0	files/d0cad6de2360de8e3a21d15082adccf1	1730843617
102	0	files/a6d183b7ed858c2e9c9bdad340b34784	1730843351
103	0	files/aa10227f8f4077a35d253b49d79f806a	1730843351
104	0	files/dd34b807858c2601f1c5aeb0e9b1eeda	1730843351
105	0	files/c03ab62d8ca2c601b8f7f26ad9d659f9	1730843351
107	0	files/3dc78fc9b49d8a218f24fe56c8f929e0	1730843351
95	0	files/0defcae37a52a449c1dc3c2efc32e719	1730843351
96	0	files/a2baa3efacbe1fb92a2ba93fd37592da	1730843351
97	0	files/ac72924c48dca1d6b81e9a47e8b0a7e9	1730843351
98	0	files/ba431b6994b59705f3ee6e3e55e65bff	1730843351
99	0	files/c531d04b3c768b7ed69a1be932e4a61b	1730843351
100	0	files/297a4dd8b3d4516535ec20e28ec86f95	1730843351
101	0	files/ba05a11475791f6a20d6abbe626a3d7d	1730843351
116	0	files/34ae5ed0b2e8cdd3b5ac58c9f0cc7e1c	1730843351
117	0	files/254ae0eee89c265f9174670d69523bcf	1730843351
118	0	files/14288859418721a59543a9d597ff2951	1730843351
119	0	files/5ad9b123d12a3bf9d8d07389b5262e23	1730843351
120	0	files/5d377c931dbd4d87a297fb083acfbb0e	1730843351
125	0	files/a8235f5ab3bdaeeda5bbf8abfb739c2c	1730843351
126	0	files/6298328c68775d9b8938eea71bf7ee9b	1730843351
127	0	files/b84f89c9b41e43747dd9d56fe7554f7f	1730843351
128	0	files/324e3926317f1785c0dd35017475ca68	1730843351
129	0	files/d673afb9105d4886364d0ba047451280	1730843351
130	0	files/63aaf7248c776b940b35751cfd8db689	1730843351
131	0	files/69597547e592f397d8ba2cb3f156f3b6	1730843351
136	0	files/c71c0eca9c13f34861583f4fea560775	1730843352
137	0	files/df10c46d93a2bcc0d13b17e44d1ec66b	1730843352
138	0	files/225a008e7b06a7221f5d11c0037cfe3f	1730843352
139	0	files/6450b097abac57794d474fc8b2e74157	1730843352
140	0	files/424989bda0f8478b68b6702d1c9d9e3c	1730843352
141	0	files/2d4372ca325ed2c18d83134a8efaacc4	1730843352
142	0	files/10f5017a173a2e5ed49d91c172bc0933	1730843352
143	0	files/2b8c69244feaf790c894246e0effd05d	1730843352
144	0	files/2625d9b3a1f663a309473b49c4814511	1730843352
145	0	files/86d5fc4f7b4dda7ea2ea9a45c5100d2f	1730843352
146	0	files/16f90a838617b560a25fc50a525a3977	1730843352
147	0	files/b37a69e602af6e31d4745d48723ae250	1730843352
149	0	files/e3a6897443f5d4cb4f451d55b292cba3	1730843352
148	0	files/f7fd933d46358d79551b4f16f99d1aeb	1730843352
150	0	files/d4d878170bf77187e744814b3852d3fe	1730843352
151	0	files/0e69ec92b83c3dfe41ead37afcbf610f	1730843352
152	0	files/b10f38c842769e4bb32ebf3de5d36d22	1730843352
153	0	files/73511d1fa8710350163bab3e66f2034f	1730843352
154	0	files/fcc05924fb17c1c972d15591acc83b7a	1730843352
155	0	files/cdf4286caef0e0421de72f5c516fcba3	1730843352
156	0	files/369c123b4e1d32c06dfe8328c909a27c	1730843352
157	0	files/3df62df2d7149d8aef36ae4aa60549a2	1730843352
158	0	files/72e233c1280138a535282e2d95d05c32	1730843352
159	0	files/73998451b6e5b520a19ba54563ecf0bc	1730843352
160	0	files/6298f0137df8a04c4ee3fa926bc0494e	1730843352
449	0	files/14b6850aa11499458f44d9fac53d796e	1730843691
379	0	files/c1863bda5ede7412d6c9883da521357d	1730843632
431	0	files/e379c746c1f36495737e963662a757e0	1730844021
377	0	files/0f74876037f6f8741f1a8b46e67d977a	1730843632
109	0	files/ffc1ba1aded2d65c9e57461b232a957a	1730844027
392	0	files/21a3b757e25a2370ee2fb94bc4261b0d	1730843647
390	0	files/02c32fdb0ec568e9f185f593367c11e9	1730843647
466	0	files/b8df56f780797f25955dba5f8cc527ba	1730843820
464	0	files/5b73c20f21a85b307e05e8b028bcff67	1730843820
451	0	files/bda350c4fedf81361b15ad87422e4c36	1730843691
480	0	files/007ee3e004b64584ec000fea224d0b25	1730843824
478	0	files/c3f53f5cc63407293e071f7e5d9c6213	1730843824
2	0	files/b6ef755cfc70b5eb94f5d3aad8ba833d	1730843824
163	0	files/f4c7bbdbf55d923df63b134bd36f85e8	1730843352
165	0	files/f049afc8c3eb88ce6ec756fd907b77ef	1730843352
167	0	files/71aee8cc5d0c89fc87ceb17286b85566	1730843352
169	0	files/345f4b336abd852c0bec85f66324c2a0	1730843352
170	0	files/eacb46f486026dbe65eceda4b022ea1c	1730843352
172	0	files/5512962ebf53b2af54fab2e03062d2ab	1730843352
161	0	files/a81a8c92ea19f81e221f1e089700d8d0	1730843352
162	0	files/540407a1bb48b2c0155de94842941728	1730843352
164	0	files/5b2bdf7ff4300a9cb26737f15ff836d9	1730843352
166	0	files/e24ec98fb4e9f8f19d85b36b80b67eb2	1730843352
168	0	files/fcb6c096f2bf1d81ddf7c4031ae7a570	1730843352
171	0	files/b6dab8e7ba35a0f450922dd9cb1f1d71	1730843352
173	0	files/003bb0c7e0eb6170011ab2cb14d5d385	1730843352
174	0	files/bfab350315e9006b6f83d2fbe9844dbe	1730843352
181	0	files/94175908fcc4bfbe94109585f5007e24	1730844021
183	0	files/8d65b9c919afcfeecda787cc4a7e4a7b	1730843353
185	0	files/5064da788e5c16a6c075b41376f96652	1730843353
186	0	files/38a87771a101488d58e58137d0fac486	1730843353
187	0	files/5a934716a7fc9f0ada3ce28aa4567fec	1730843353
188	0	files/f3386a5bd5e003f565639a83c42b7cb9	1730843353
189	0	files/9c585cdf8128ede206aa4ba9b96b0db0	1730843353
190	0	files/20bc19649eeaf2289ef0efd106b8193a	1730843353
191	0	files/e5fd5a30821d6d9119e0d42b1a1c1786	1730843353
192	0	files/5f46507eecb9ead7a8f1244be9a63afe	1730843353
193	0	files/9e7129115bc8ce9f93d96f09c45ba1f4	1730843353
194	0	files/41443c9936ba495f2c214ce0528387dd	1730843353
195	0	files/5b3f7ffd1b18845483c6dd47fd724697	1730843353
208	0	files/c532ddde05bfb7c8fe1394277f11ffcf	1730844027
209	0	files/db3df4bb991bc6bcd2d661ed97a239b6	1730844027
210	0	files/2ac05c5c64de6fb1dcb4f5a08c119d10	1730844027
196	0	files/6e9aaec3d1f383f33c9b219c7db4d6ca	1730843353
197	0	files/8dd2a0e5d6d1389a7fae30e02b3a5c5b	1730843353
198	0	files/75427248ddab0974887b4c79b42569ad	1730843353
199	0	files/96cc7f6985eca3de5384202db311fcec	1730843353
200	0	files/c39ab6920afb4f77a150b0e15eb058d9	1730843353
201	0	files/2eaafdb7ea7df8801f83cbf35da4a0dc	1730843353
221	0	files/bbfa314ff7a147179f0e1cf12c693d91	1730843361
222	0	files/8c1bb3c661234af4a7fb6f18ced99443	1730843361
215	0	files/cc446d8058e0c02897776523ca9af871	1730843361
244	0	files/548e8628d20f8f5dc3dce61fbf4e90f8	1730843391
279	0	files/46b1b925ee22c31ab33eb7a1b29d9e96	1730843473
280	0	files/9e61f0766871426edd92c54ebeac7934	1730843473
213	0	files/ad16b97dfd273c55c5f15661de36db84	1730843361
223	0	files/43f8f8add3465929908af42b83176857	1730843361
224	0	files/3fb471d8c4aa3510f1eb511a3877e34b	1730843361
225	0	files/0dfd674a5ac8fe0a6dd0e06869d9fae1	1730843361
226	0	files/8c588ec805513118b95ab28505a47886	1730843361
227	0	files/41025215a74313d033ea85e8f301925c	1730843361
371	0	files/6532acebb71175df5a5d2f6902373c09	1730843617
218	0	files/15235e661bd7c3712f110567b2dd4678	1730843824
281	0	files/4a2dd9a12626a9e5d8c899df61f7affc	1730843473
242	0	files/0b0b334cd9d27573115999a0947e2279	1730843508
230	0	files/61fb92137148f571832ecc1809f57a3c	1730843374
228	0	files/c492d3d32aa90c35d6bf235f7e123aec	1730843374
236	0	files/08a6bb7dd1ed13f96e37f96de88822a2	1730843374
237	0	files/041d6406f8fa3dd6cf3d66de667401ec	1730843374
238	0	files/82996255c8bc3ef2a56e760d5d6f3427	1730843374
239	0	files/2a28a3e251eb8f09d56388a20a56e29e	1730843374
240	0	files/5c17ab11c7cdb5ab666b9b94fb7a952e	1730843374
241	0	files/851c6ba5e919481f8d9ddbc9112a72b0	1730843374
257	0	files/a412c1deefd2e9d760c25a710847f796	1730843414
250	0	files/ec5eb77087bb4b333752712f7bdacace	1730843392
251	0	files/fba6391eb0188c1d3aa443a6def87dbb	1730843392
252	0	files/d9f4d2b56b71ee79fdc119c3190a2c4b	1730843392
253	0	files/bec0b86ab96de99e75790e26f433e57f	1730843392
254	0	files/fa6fd37e211ef99b8c5c8c1c58d3fddd	1730843392
255	0	files/602da272250a860c71bd23abe253c8bb	1730843392
256	0	files/49199b71b6095a68ed5bda3aeff52c05	1730843392
259	0	files/37133543d6dbe11d60a29b2c7d17cf6f	1730843414
265	0	files/c680842f6e4fd97f10c413c99abd5195	1730843415
266	0	files/070bacabaacd4d47a104a1b7844abbd4	1730843415
267	0	files/72f8309c9cd454b5cd8fd87ce36d5a09	1730843415
268	0	files/80fe93adb8c1d230066a633127722124	1730843415
269	0	files/15291c65c138b7e1c0a84ebc7278ebec	1730843415
270	0	files/52b251a1b08d1973bc22e2d1577b115c	1730843415
282	0	files/d7be5108ffc6fe95cd28f8d89161d24d	1730843473
283	0	files/0264001e83eb6585f0985b8ab729c38b	1730843473
273	0	files/6487efb1f4898f22cf09e287c2bf42c5	1730843473
287	0	files/48b6fbe3418a3a129df07e3e8e475f7f	1730843476
271	0	files/2374f04e18a11a1f50ed80a0b4707c62	1730843498
284	0	files/3cc71ff0d4546e99e63e300ff14761d2	1730843473
293	0	files/eb7b743c43e28f25b03d9baea293742e	1730843476
285	0	files/efd9e9f707b9256fdeab0943a9ea22fc	1730843476
294	0	files/6d5947aa70087596fdcb3ef794414187	1730843476
295	0	files/17d209bf7b8e1bd7c4aca4ce75a4e800	1730843476
296	0	files/76d8b0ce2455a6f0abffc0a094ecc783	1730843476
217	0	files/992d299d65c32f6c9045148c430ef1b9	1730843824
216	0	files/aef894266018a34f48c5bfd4a5c1de5a	1730843824
297	0	files/52330f3871d38937c9bae2f7ada9509f	1730843476
298	0	files/b6e0c9969ff03fd18fafb95da31c3deb	1730843476
317	0	files/6d5b644bb6d111724b02fd4899d47fed	1730843498
320	0	files/35668e6441f9aa1594970613ae3e02e6	1730843508
457	0	files/b444092058f1329cdb6cc8ebdf49e726	1730843691
458	0	files/af4e0407d614940025f0ea7f9dc58f51	1730843691
459	0	files/eaaee68dccabf8649ad7572eeb2ea572	1730843691
372	0	files/b329e31d1b67217882ad68c4fe408d89	1730843617
336	0	files/1c2b78c3dbfe12b8412003cf72d96828	1730843572
334	0	files/808e126d473f1f40cb00568b550369dd	1730843572
342	0	files/b7461a16a2938405fd56b307bba37395	1730843572
343	0	files/f1f2a85b4dba3df586d863ee68d0b067	1730843572
344	0	files/52c77ec2d93a0caf5f4e678bb9bc71ae	1730843572
345	0	files/70fdac19f51e0bc4e2ce229e9ba2a3df	1730843572
346	0	files/348fc594c673ff21b78ae9e174aed195	1730843572
347	0	files/44e94c77411ed9ebbbefe6c0266ca158	1730843572
348	0	files/3ba55ae2782d03b519c13f4933707c54	1730843572
373	0	files/3b2369eb44aea3656a673d99dbe9be31	1730843617
374	0	files/d8ccd92e28817fadfbad083137063801	1730843617
351	0	files/a7de6633e50a1aa7fd3692b19eca5d87	1730843610
349	0	files/eaaad54de88a95e834e6e7164b2a3e2c	1730843610
357	0	files/2dc3de5255d9d89cb6726b6de7c9a147	1730843610
358	0	files/fe550a2edf1f6f14493b709c783176dc	1730843610
359	0	files/7e120b19970ad3379f041f71820edf27	1730843610
360	0	files/4b7bbbc985e070f0ac1e1e05ae83308c	1730843610
361	0	files/1733134c8f368809a9da3f3c111da07b	1730843610
460	0	files/c5641278c528f67f71c7da48d6a5fa77	1730843691
375	0	files/068447c8efbb24f42e5abf831c574b56	1730843617
376	0	files/b025fba4dc96fd9d32bd10d60fa0afca	1730843617
385	0	files/20b500d68bc1549c5278378a857bf230	1730843632
386	0	files/711d6d407aa9041f7686ba07e5f009a7	1730843632
387	0	files/cdc0d9eea49b765eb2812eace0f5578a	1730843632
388	0	files/9ba5cb87e5322456680fcdec950069b9	1730843632
389	0	files/88a54ec2b2f2eeed1e924996cf193929	1730843632
398	0	files/72cb30769280d23b5adc0e0cd8c0982d	1730843648
399	0	files/f8cac08b398b4dd19ff6e03ca9828ad8	1730843648
400	0	files/22dd916dd387ff2bca0f44f14aa6a589	1730843648
401	0	files/4a7bfc2ca1534dc0a311076ec03c0b6a	1730843648
402	0	files/9415e7bcfab1a9f91a19f9dde3aceba6	1730843648
403	0	files/a649e485ba4a4aa12668e0c9c893ea3d	1730843648
461	0	files/acd0ca5fe3c0acf648652075c487c782	1730843691
462	0	files/8bb332f89cd246423c8f8d69f9bff55c	1730843691
463	0	files/8743785705d1843be10252f7aef80822	1730843691
435	0	files/535c5c6387ae67ba85e852f7be6a7bbc	1730844021
472	0	files/5483f59b6519a34e840b71d00649e003	1730843821
473	0	files/44d872fdebe918c69c6af8385239af4b	1730843821
474	0	files/fe0d05fc11e5bace675e13e7b8c01aa4	1730843821
475	0	files/33a18246e0aa86a3c9484ba01fdd2fc6	1730843821
476	0	files/0ba144874f3aa829288166e497db47d7	1730843821
477	0	files/b34c9dd3a452b6df5392cd7092ed0c28	1730843821
324	0	files/d59ada58eea593c86665fea5c9aead03	1730844021
486	0	files/1930fed05593f044e2ef3483cb97f195	1730843824
487	0	files/385ca506a3a6b39e435e784f12a5543d	1730843824
488	0	files/e39d8cfb225b82b084490084ff83caf0	1730843824
489	0	files/f595ce955a8146fc3f8aba66cc4d54e6	1730843824
490	0	files/ab348fcd0b6cc1aff067e6eb13e077df	1730843824
325	0	files/adb50b7434b7661fca7fd6144885e5ad	1730844021
362	0	files/40adcc03bc0c58e712ae59ce641c2afb	1730844021
302	0	files/024330c88fd727470b74b5ba98afd27f	1730844027
491	0	files/5ba91ad99b5107cdce54cc28844c1fd8	1730844027
\.


--
-- Data for Name: oc_filecache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_filecache (fileid, storage, path, path_hash, parent, name, mimetype, mimepart, size, mtime, storage_mtime, encrypted, unencrypted_size, etag, permissions, checksum) FROM stdin;
63	1	cache	0fea6a13c52b4d4725368f24b045ca84	1	cache	2	1	0	1730839654	1730839654	0	0	672a846645fbd	31	
348	1	files/Photos/minsk_halfmarathon2024-20240908133616-a364d4bb1ad5.jpg	0851767ad8bad3164a0d98015380ea7f	4	minsk_halfmarathon2024-20240908133616-a364d4bb1ad5.jpg	6	5	1331710	1728295920	1728295920	0	0	4df610d05c4438cdcedaad2ad5fc5570	27	
15	1	files/Readme.md	49af83716f8dcbfa89aaf835241c0b9f	2	Readme.md	8	7	206	1730839633	1730839633	0	0	15eba66fa462cf1aaa062fcef0e1996c	27	
3	1	files/Nextcloud intro.mp4	e4919345bcc87d4585a5525daaad99c0	2	Nextcloud intro.mp4	4	3	3963036	1730839633	1730839633	0	0	406f2b35a097d44bd71437e35cbae603	27	
8	1	files/Photos/Frog.jpg	d6219add1a9129ed0c1513af985e2081	4	Frog.jpg	6	5	457744	1730839633	1730839633	0	0	62017bf4c68bbf42845659126a0bc33a	27	
4	1	files/Photos	d01bb67e7b71dd49fd06bad922f521c9	2	Photos	2	1	16716353	1730840224	1730840224	0	0	672a86a00df64	31	
5	1	files/Photos/Birdie.jpg	cd31c7af3a0ec6e15782b5edd2774549	4	Birdie.jpg	6	5	593508	1730839633	1730839633	0	0	9f14c1743eb38ce9efa3a9d20591b522	27	
12	1	files/Photos/Readme.md	2a4ac36bb841d25d06d164f291ee97db	4	Readme.md	8	7	150	1730839633	1730839633	0	0	27131687a1c94f29683806eb5dcb82b8	27	
6	1	files/Photos/Toucan.jpg	681d1e78f46a233e12ecfa722cbc2aef	4	Toucan.jpg	6	5	167989	1730839633	1730839633	0	0	8970b0f946a988f4f005ec946e03ae61	27	
9	1	files/Photos/Vineyard.jpg	14e5f2670b0817614acd52269d971db8	4	Vineyard.jpg	6	5	427030	1730839633	1730839633	0	0	2e9a8de6439abc1277b778579170788c	27	
7	1	files/Photos/Library.jpg	0b785d02a19fc00979f82f6b54a05805	4	Library.jpg	6	5	2170375	1730839633	1730839633	0	0	ae59bb0bc7018ca877b9cb77d3a6cc1a	27	
10	1	files/Photos/Gorilla.jpg	6d5f5956d8ff76a5f290cebb56402789	4	Gorilla.jpg	6	5	474653	1730839633	1730839633	0	0	16f496ed1804b3c13e2b6a9766299348	27	
11	1	files/Photos/Nextcloud community.jpg	b9b3caef83a2a1c20354b98df6bcd9d0	4	Nextcloud community.jpg	6	5	797325	1730839633	1730839633	0	0	3c66496ccf7f82694375486c4fbdcc3b	27	
13	1	files/Photos/Steps.jpg	7b2ca8d05bbad97e00cbf5833d43e912	4	Steps.jpg	6	5	567689	1730839633	1730839633	0	0	b3471a047aaf613c6dceaf9fcc4052a4	27	
16	1	files/Nextcloud.png	2bcc0ff06465ef1bfc4a868efde1e485	2	Nextcloud.png	11	5	50598	1730839634	1730839634	0	0	b09954ff1093c8ff39fb7b33aa689b29	27	
14	1	files/Nextcloud Manual.pdf	2bc58a43566a8edde804a4a97a9c7469	2	Nextcloud Manual.pdf	10	9	12860592	1730839633	1730839633	0	0	9dbf67e3015ee0403e9abdf35c293eb5	27	
22	1	files/Templates/Modern company.odp	96ad2c06ebb6a79bcdf2f4030421dee3	17	Modern company.odp	14	9	317015	1730839634	1730839634	0	0	a5ecfed4c8ec0f07920a754b75710076	27	
18	1	files/Templates/Mother's day.odt	cb66c617dbb4acc9b534ec095c400b53	17	Mother's day.odt	12	9	340061	1730839634	1730839634	0	0	38b7c090ddc4fa3f3b9d038fcbbf0ae0	27	
19	1	files/Templates/Photo book.odt	ea35993988e2799424fef3ff4f420c24	17	Photo book.odt	12	9	5155877	1730839634	1730839634	0	0	bee57c88b3fe014771248ba1a3cd80c1	27	
20	1	files/Templates/Business model canvas.ods	86c10a47dedf156bf4431cb75e0f76ec	17	Business model canvas.ods	13	9	52843	1730839634	1730839634	0	0	2c238564b6ab25ec6bbafaded212bbd0	27	
21	1	files/Templates/Invoice.odt	40fdccb51b6c3e3cf20532e06ed5016e	17	Invoice.odt	12	9	17276	1730839634	1730839634	0	0	c168f30d1d583552089e738e4289d798	27	
24	1	files/Templates/Brainstorming.whiteboard	aa2d36938cf5c1f41813d1e8bbd3ae00	17	Brainstorming.whiteboard	15	9	30780	1730839634	1730839634	0	0	a7e39000234225b2af9e1011fa90f7b9	27	
23	1	files/Templates/Resume.odt	ace8f81202eadb2f0c15ba6ecc2539f5	17	Resume.odt	12	9	39404	1730839634	1730839634	0	0	935dee7225e9a8fda770f7e9c9f03bc0	27	
25	1	files/Templates/Flowchart.whiteboard	b944a25f1ef13e8e256107178bb28141	17	Flowchart.whiteboard	15	9	31132	1730839634	1730839634	0	0	49399e6bc29397064e2f22cb7302d8cb	27	
26	1	files/Templates/Yellow idea.odp	3a57051288d7b81bef3196a2123f4af5	17	Yellow idea.odp	14	9	81196	1730839634	1730839634	0	0	b0208dff8020542093ceb30970eb9165	27	
27	1	files/Templates/Business model canvas.odg	6a8f3e02bdf45c8b0671967969393bcb	17	Business model canvas.odg	16	9	16988	1730839634	1730839634	0	0	fb4c189d2dbacc13dcf013f7011f6b8d	27	
28	1	files/Templates/Timeline.whiteboard	a009a1620252b19a9307d35de49311e9	17	Timeline.whiteboard	15	9	31325	1730839634	1730839634	0	0	8c7980f27cde4018cf95404328a6b2e4	27	
29	1	files/Templates/Venn diagram.whiteboard	71d9f77ebd2c126375fa7170a1c86509	17	Venn diagram.whiteboard	15	9	23359	1730839634	1730839634	0	0	1875d15bd27d38fb9897d3126fb940f2	27	
30	1	files/Templates/Business model canvas.whiteboard	1c4e5432621502fa9a668c49b25b81d9	17	Business model canvas.whiteboard	15	9	30290	1730839634	1730839634	0	0	58b96f53b53707282a2c10acbd0540ba	27	
31	1	files/Templates/Mindmap.odg	74cff798fc1b9634ee45380599b2a6da	17	Mindmap.odg	16	9	13653	1730839634	1730839634	0	0	ebceb8a511f800d9ed73f7b1cb6dcf7f	27	
60	2	appdata_oct85qsb3cn1/js	98fae6b30256cbb47e797a232a8b845a	59	js	2	1	0	1730839654	1730839654	0	0	672a8455cc9a2	31	
59	2	appdata_oct85qsb3cn1	706d0b0cd6630fba824c72b0695a6a64	58	appdata_oct85qsb3cn1	2	1	0	1730839656	1730839656	0	0	672a8455cab50	31	
2	1	files	45b963397aa40d4a0063e0d85e4fe7a1	1	files	2	1	46620793	1730840224	1730839635	0	0	672a86a00df64	31	
32	1	files/Templates/Diagram & table.ods	0a89f154655f6d4a0098bc4e6ca87367	17	Diagram & table.ods	13	9	13378	1730839634	1730839634	0	0	0103f3f82b52f40b1f14ac4183f1505c	27	
40	1	files/Templates/Product plan.md	a9fbf58bf31cebb8143f7ad3a5205633	17	Product plan.md	8	7	573	1730839635	1730839635	0	0	bb00426d24538088b9840ddd5bf21358	27	
33	1	files/Templates/Org chart.odg	fd846bc062b158abb99a75a5b33b53e7	17	Org chart.odg	16	9	13878	1730839634	1730839634	0	0	0b3ac4febba649e18f7d7f0286c01d95	27	
34	1	files/Templates/Meeting notes.md	c0279758bb570afdcdbc2471b2f16285	17	Meeting notes.md	8	7	326	1730839634	1730839634	0	0	b8f893e6680affa600db8f7e42055594	27	
35	1	files/Templates/Impact effort.whiteboard	071dbd5231cfcb493fa2fcc4a763be05	17	Impact effort.whiteboard	15	9	30671	1730839634	1730839634	0	0	564387429b2981fef5ae1d073afcc36c	27	
46	1	files/Templates/Sticky notes.whiteboard	72309dacd55c6de379c738caf18d84c4	17	Sticky notes.whiteboard	15	9	45778	1730839635	1730839635	0	0	9cf2e3190a52a194ad84b1aa60f6e284	27	
36	1	files/Templates/Flowchart.odg	832942849155883ceddc6f3cede21867	17	Flowchart.odg	16	9	11836	1730839634	1730839634	0	0	2d4eecd6fa7b05c24adb500c0f319cc9	27	
41	1	files/Templates/Timesheet.ods	cb79c81e41d3c3c77cd31576dc7f1a3a	17	Timesheet.ods	13	9	88394	1730839635	1730839635	0	0	ca909f3e8270e287a138587cba002e27	27	
37	1	files/Templates/Mind map.whiteboard	27c7b4d83fd3526a42122bcacf5dfbe9	17	Mind map.whiteboard	15	9	35657	1730839634	1730839634	0	0	9490d5b9b236e5efaf87c89bb4722d52	27	
38	1	files/Templates/Meeting agenda.whiteboard	be213da59b99766ceae11e80093803a9	17	Meeting agenda.whiteboard	15	9	27629	1730839635	1730839635	0	0	3d26b890a87cea313b0d3478f74a1f6a	27	
39	1	files/Templates/Readme.md	71fa2e74ab30f39eed525572ccc3bbec	17	Readme.md	8	7	554	1730839635	1730839635	0	0	51b9c32498e5c80fa0d57860f8ca2da0	27	
42	1	files/Templates/Simple.odp	a2c90ff606d31419d699b0b437969c61	17	Simple.odp	14	9	14810	1730839635	1730839635	0	0	8423381abae1ea3d64f105fc608c2324	27	
43	1	files/Templates/Kanban board.whiteboard	174b2766514fef9a88cbb3076e362b4a	17	Kanban board.whiteboard	15	9	25621	1730839635	1730839635	0	0	23a59477fb5c2cfc096ed6383c4b1694	27	
50	1	files/Templates/Expense report.ods	d0a4025621279b95d2f94ff4ec09eab3	17	Expense report.ods	13	9	13441	1730839635	1730839635	0	0	d9e7abd9434a5c190f396377361c1514	27	
44	1	files/Templates/Syllabus.odt	03b3147e6dae00674c1d50fe22bb8496	17	Syllabus.odt	12	9	30354	1730839635	1730839635	0	0	38284c0362d241aaa246033a0eea233c	27	
47	1	files/Templates/Elegant.odp	f3ec70ed694c0ca215f094b98eb046a7	17	Elegant.odp	14	9	14316	1730839635	1730839635	0	0	856b0a3a116e7b254f3663f23f79c190	27	
45	1	files/Templates/Letter.odt	15545ade0e9863c98f3a5cc0fbf2836a	17	Letter.odt	12	9	15961	1730839635	1730839635	0	0	cc848838187f0d1a08b85a80f7a6d070	27	
48	1	files/Templates/Party invitation.odt	439f95f734be87868374b1a5a312c550	17	Party invitation.odt	12	9	868111	1730839635	1730839635	0	0	e82403e41ab5cc543224feb2c5db73ab	27	
49	1	files/Templates/Gotong royong.odp	14b958f5aafb7cfd703090226f3cbd1b	17	Gotong royong.odp	14	9	3509628	1730839635	1730839635	0	0	adb7abcd6ed9d3ee83b56c641c7de277	27	
51	1	files/Templates credits.md	f7c01e3e0b55bb895e09dc08d19375b3	2	Templates credits.md	8	7	2403	1730839635	1730839635	0	0	8f2608beb4199e22f1f07ba91c0ce807	27	
52	1	files/Reasons to use Nextcloud.pdf	418b19142a61c5bef296ea56ee144ca3	2	Reasons to use Nextcloud.pdf	10	9	976625	1730839635	1730839635	0	0	a3a70aead544b75302ea7f3c90ee1320	27	
54	1	files/Documents/Example.md	efe0853470dd0663db34818b444328dd	53	Example.md	8	7	1095	1730839635	1730839635	0	0	504330a43688026ddda42040514b3c23	27	
55	1	files/Documents/Nextcloud flyer.pdf	9c5b4dc7182a7435767708ac3e8d126c	53	Nextcloud flyer.pdf	10	9	1083339	1730839635	1730839635	0	0	409ae35143c94a3fb1735299c62b1d77	27	
57	1	files/Documents/Welcome to Nextcloud Hub.docx	b44cb84f22ceddc4ca2826e026038091	53	Welcome to Nextcloud Hub.docx	17	9	24295	1730839635	1730839635	0	0	e3dcd1c4415199401ca6cf363a236299	27	
56	1	files/Documents/Readme.md	51ec9e44357d147dd5c212b850f6910f	53	Readme.md	8	7	136	1730839635	1730839635	0	0	a085252aed621178cac998bab60eefd7	27	
17	1	files/Templates	530b342d0b8164ff3b4754c2273a453e	2	Templates	2	1	10942115	1730839635	1730839635	0	0	672a84538d627	31	
53	1	files/Documents	0ad78ba05b6961d92f7970b2b3922eca	2	Documents	2	1	1108865	1730839635	1730839635	0	0	672a8453d3fa6	31	
58	2		d41d8cd98f00b204e9800998ecf8427e	-1		2	1	-1	1730839637	1730839637	0	0	672a8455cae8e	23	
61	2	appdata_oct85qsb3cn1/theming	f964285d870873e3ccb5a15dbd388f7c	59	theming	2	1	0	1730839643	1730839643	0	0	672a845be7361	31	
64	2	appdata_oct85qsb3cn1/js/core	d4f7dda19304b5a0adf0e46413a3dfaf	60	core	2	1	0	1730839654	1730839654	0	0	672a8466d30b9	31	
65	2	appdata_oct85qsb3cn1/js/core/merged-template-prepend.js	38287109be030523b6a9b7765354e997	64	merged-template-prepend.js	18	9	11728	1730839654	1730839654	0	0	aae9749c87db01eb45fb739edc2f95e7	27	
66	2	appdata_oct85qsb3cn1/js/core/merged-template-prepend.js.deps	453ea817d48bddf8c1b3069cefd24e52	64	merged-template-prepend.js.deps	19	9	266	1730839654	1730839654	0	0	382a5b57332f1a57f4f00916a22fd2c3	27	
67	2	appdata_oct85qsb3cn1/js/core/merged-template-prepend.js.gzip	e807cb88ed72c2d7cd2791bb9d80b41a	64	merged-template-prepend.js.gzip	20	9	2811	1730839654	1730839654	0	0	da7a94f382f3c8c70d4879460dc3f98c	27	
68	2	appdata_oct85qsb3cn1/avatar	da375f97892c7b56e842ff666416285a	59	avatar	2	1	0	1730839656	1730839656	0	0	672a846805a25	31	
1	1		d41d8cd98f00b204e9800998ecf8427e	-1		2	1	47407652	1730840224	1730839898	0	0	672a86a00df64	23	
69	2	appdata_oct85qsb3cn1/avatar/admin	9f97b159df7414b6e0d81d3d6b69df77	68	admin	2	1	0	1730839656	1730839656	0	0	672a846807719	31	
70	2	appdata_oct85qsb3cn1/avatar/admin/avatar.png	fc5ac3f54f321431f08505e2c3ed0992	69	avatar.png	11	5	15643	1730839656	1730839656	0	0	c64de5012f78cf9018bceceee424f730	27	
71	2	appdata_oct85qsb3cn1/avatar/admin/generated	4f6f4b10448fbe88bcc7dd47cdcbc45b	69	generated	19	9	0	1730839656	1730839656	0	0	60a4dd67683a65e6480f1956eb54a155	27	
72	2	appdata_oct85qsb3cn1/avatar/admin/avatar.64.png	61c4a9220ac184d04d54021747853e26	69	avatar.64.png	11	5	792	1730839656	1730839656	0	0	cf043ad4107d1c64dde64e152c0f0903	27	
73	2	appdata_oct85qsb3cn1/preview	ba1897caaca96f5956ad774dfd302689	59	preview	2	1	0	1730839656	1730839656	0	0	672a846821fa7	31	
76	2	appdata_oct85qsb3cn1/preview/6/5/1	1781b39259ca0169100c25a3a70d770a	75	1	2	1	-1	1730839656	1730839656	0	0	672a846824f04	31	
77	2	appdata_oct85qsb3cn1/preview/6/5/1/2	3d03364e96e844e7c7cc549b645826ea	76	2	2	1	-1	1730839656	1730839656	0	0	672a8468246e4	31	
78	2	appdata_oct85qsb3cn1/preview/6/5/1/2/b	de5aa533c73d35356b1200b6d29fe689	77	b	2	1	-1	1730839656	1730839656	0	0	672a8468240cf	31	
79	2	appdata_oct85qsb3cn1/preview/6/5/1/2/b/d	f1c6d6a1b49fe4efeb6116c14ca6df0d	78	d	2	1	-1	1730839656	1730839656	0	0	672a846823d21	31	
80	2	appdata_oct85qsb3cn1/preview/6/5/1/2/b/d/4	0370574596ea32206d478180a9145451	79	4	2	1	-1	1730839656	1730839656	0	0	672a8468239e9	31	
74	2	appdata_oct85qsb3cn1/preview/6	facd620f664f7bd382bc16b771f85dab	73	6	2	1	-1	1730840224	1730840224	0	0	672a876b423d2	31	
82	2	appdata_oct85qsb3cn1/preview/4	2a39efd289bb8fd8a4999358516ea1b7	73	4	2	1	-1	1730839656	1730839656	0	0	672a846830033	31	
83	2	appdata_oct85qsb3cn1/preview/4/5	ee821cfd595acc5314598225e2205d33	82	5	2	1	-1	1730839656	1730839656	0	0	672a84682fd45	31	
84	2	appdata_oct85qsb3cn1/preview/4/5/c	86fd6b42b453c30931c1fa78e99101e5	83	c	2	1	-1	1730839656	1730839656	0	0	672a84682ef90	31	
85	2	appdata_oct85qsb3cn1/preview/4/5/c/4	df6043d00f7bb0f69bfea98ee3ae0a8d	84	4	2	1	-1	1730839656	1730839656	0	0	672a84682de95	31	
86	2	appdata_oct85qsb3cn1/preview/4/5/c/4/8	7994f4e06a548fb467dc7e2ebaf586ba	85	8	2	1	-1	1730839656	1730839656	0	0	672a84682d071	31	
87	2	appdata_oct85qsb3cn1/preview/4/5/c/4/8/c	17e476fbaf18bb293af136ec5b7ecf23	86	c	2	1	-1	1730839656	1730839656	0	0	672a84682ccce	31	
88	2	appdata_oct85qsb3cn1/preview/4/5/c/4/8/c/c	d2092db874011b42a68975b7c0bb400a	87	c	2	1	-1	1730839656	1730839656	0	0	672a84682c4d9	31	
90	2	appdata_oct85qsb3cn1/preview/6/5/1/2/b/d/4/11/3000-2000-max.jpg	26e03e2015eed293579c8c5e11beb806	81	3000-2000-max.jpg	6	5	808212	1730839656	1730839656	0	0	d853bce2c2e73daeda81cab01a5c0931	27	
91	2	appdata_oct85qsb3cn1/preview/4/5/c/4/8/c/c/9/1920-1281-max.jpg	e220f8ed28af0a73919db370a2a6f841	89	1920-1281-max.jpg	6	5	294390	1730839656	1730839656	0	0	b3b83985d3926a9e3980e48aca43dd6a	27	
92	2	appdata_oct85qsb3cn1/preview/4/5/c/4/8/c/c/9/1024-683.jpg	cce1c7cc173b037bb98109a8754db163	89	1024-683.jpg	6	5	101397	1730839656	1730839656	0	0	08af0c2b24d7788c4a91b6f44c3b0cbe	27	
93	2	appdata_oct85qsb3cn1/preview/4/5/c/4/8/c/c/9/64-43.jpg	091e96edfd41706089480fa3a5ff4a59	89	64-43.jpg	6	5	1559	1730839656	1730839656	0	0	aaa1a8b12a1e9bf1ab982e2524c559ef	27	
94	2	appdata_oct85qsb3cn1/preview/6/5/1/2/b/d/4/11/64-43.jpg	b42c7ab58394e17c250eaf8038bf908c	81	64-43.jpg	6	5	1750	1730839656	1730839656	0	0	6b0f6c9ae02577190efaab09c80e3c4c	27	
95	2	appdata_oct85qsb3cn1/preview/6/1600-1067-max.jpg	8c8441d0e0bbdcd61e29622b5a158466	74	1600-1067-max.jpg	6	5	137923	1730839656	1730839656	0	0	a2d09ec8961db6797dd267a319c83d65	27	
96	2	appdata_oct85qsb3cn1/preview/6/64-43.jpg	a33e073c77c99e48a89c73516c1caed2	74	64-43.jpg	6	5	1784	1730839656	1730839656	0	0	e34866e91a691a885f2d963776082d1e	27	
81	2	appdata_oct85qsb3cn1/preview/6/5/1/2/b/d/4/11	8341a86719df00155b15724b07a1ad82	80	11	2	1	0	1730839753	1730839753	0	0	672a8468234bd	31	
89	2	appdata_oct85qsb3cn1/preview/4/5/c/4/8/c/c/9	f95c521d4d7dfc169dbe5ea1d1359748	88	9	2	1	0	1730839753	1730839753	0	0	672a84682be49	31	
97	2	appdata_oct85qsb3cn1/preview/c	dbbf79beba8fa4db9dda712a71df75e1	73	c	2	1	-1	1730839656	1730839656	0	0	672a8468956b0	31	
98	2	appdata_oct85qsb3cn1/preview/c/5	4ddbb5ee7efc6b18be43e01753f7610c	97	5	2	1	-1	1730839656	1730839656	0	0	672a846895497	31	
99	2	appdata_oct85qsb3cn1/preview/c/5/1	7e7f2336d01a583ff5e144c64042e124	98	1	2	1	-1	1730839656	1730839656	0	0	672a84689525e	31	
100	2	appdata_oct85qsb3cn1/preview/c/5/1/c	2844dde060b5ae14dbb122dc8fec2f70	99	c	2	1	-1	1730839656	1730839656	0	0	672a846895011	31	
101	2	appdata_oct85qsb3cn1/preview/c/5/1/c/e	922cb7fa5d9b34b2d075192c08496909	100	e	2	1	-1	1730839656	1730839656	0	0	672a846894d5a	31	
102	2	appdata_oct85qsb3cn1/preview/c/5/1/c/e/4	aa76eae7d0b4d33ac96e6807a75c87de	101	4	2	1	-1	1730839656	1730839656	0	0	672a846894a6f	31	
103	2	appdata_oct85qsb3cn1/preview/c/5/1/c/e/4/1	a2fdb92d520860207f09a4ae219b73b6	102	1	2	1	-1	1730839656	1730839656	0	0	672a846894728	31	
349	2	appdata_oct85qsb3cn1/preview/0/1	59d95addba7fa0466e31e6f72cb4e83c	250	1	2	1	-1	1730840017	1730840017	0	0	672a85d15f9c2	31	
105	2	appdata_oct85qsb3cn1/preview/6/5/1/2/b/d/4/11/1024-683.jpg	3801892caace5bc0728a3eac7fdb3cda	81	1024-683.jpg	6	5	170188	1730839656	1730839656	0	0	df3614995bb9dad566e41da305ba242d	27	
109	2	appdata_oct85qsb3cn1/preview/8/f	13792a337d6579e43233658d43e7de51	108	f	2	1	-1	1730839656	1730839656	0	0	672a87656c201	31	
106	2	appdata_oct85qsb3cn1/preview/6/1024-683.jpg	0c0b7a0b42e23937ea0b42f1d52fd11c	74	1024-683.jpg	6	5	85855	1730839656	1730839656	0	0	25be378bceb439d743e24f02a84388ce	27	
107	2	appdata_oct85qsb3cn1/preview/c/5/1/c/e/4/1/13/1200-1800-max.jpg	307f11b692265be005cfe5eebed43e69	104	1200-1800-max.jpg	6	5	207095	1730839656	1730839656	0	0	cf7869897cb761ca0478cb09476ccc38	27	
110	2	appdata_oct85qsb3cn1/preview/8/f/1	b5e1c80e9737a8ea58bc364d745b109a	109	1	2	1	-1	1730839656	1730839656	0	0	672a8468a7a78	31	
111	2	appdata_oct85qsb3cn1/preview/8/f/1/4	d1aa9c8575fb5bac1dfb6b4b98680322	110	4	2	1	-1	1730839656	1730839656	0	0	672a8468a7821	31	
112	2	appdata_oct85qsb3cn1/preview/8/f/1/4/e	e15850be73230076982b9a657f3d73ca	111	e	2	1	-1	1730839656	1730839656	0	0	672a8468a75bb	31	
113	2	appdata_oct85qsb3cn1/preview/c/5/1/c/e/4/1/13/43-64.jpg	a1f59b4f618d0543d54241d141d9db2b	104	43-64.jpg	6	5	1196	1730839656	1730839656	0	0	a5d6f24e28da17bdcd8782c3f49ef327	27	
114	2	appdata_oct85qsb3cn1/preview/8/f/1/4/e/4	1fadef4f7eb40d8292d1dc1266ae95a6	112	4	2	1	-1	1730839656	1730839656	0	0	672a8468a72ed	31	
115	2	appdata_oct85qsb3cn1/preview/8/f/1/4/e/4/5	3793264f88d91936d30b9be1b3a89b42	114	5	2	1	-1	1730839656	1730839656	0	0	672a8468a6eb0	31	
117	2	appdata_oct85qsb3cn1/preview/8/f/1/4/e/4/5/7/1600-1066-max.jpg	fcdd91b0087932d876a64ad51f4a6d5b	116	1600-1066-max.jpg	6	5	351167	1730839656	1730839656	0	0	630398119f443a3385fc9898f3f2902d	27	
118	2	appdata_oct85qsb3cn1/preview/c/5/1/c/e/4/1/13/683-1024.jpg	f8047cdfc8f92081ee6488d5914ec15b	104	683-1024.jpg	6	5	67045	1730839656	1730839656	0	0	0fd10d389b36ec1b17f62335344cbfc2	27	
119	2	appdata_oct85qsb3cn1/preview/8/f/1/4/e/4/5/7/64-43.jpg	c1324692d07c42f579e48117c533d008	116	64-43.jpg	6	5	1551	1730839656	1730839656	0	0	fee5b467ad8a7264ead80bc6115b307a	27	
120	2	appdata_oct85qsb3cn1/preview/8/f/1/4/e/4/5/7/1024-682.jpg	ba71a07da68d38bce68ed3e14a0ad951	116	1024-682.jpg	6	5	151867	1730839656	1730839656	0	0	54bff74141269d27e99afbfe8e49abbc	27	
62	2	appdata_oct85qsb3cn1/theming/global	3790bc7db26e957a1101c5ca811fc743	61	global	2	1	0	1730839751	1730839751	0	0	672a845be8997	31	
122	2	appdata_oct85qsb3cn1/theming/global/0/icon-core-#00679efiletypes_whiteboard.svg	f40ceca10783f97bf0355321a3785853	121	icon-core-#00679efiletypes_whiteboard.svg	23	5	281	1730839751	1730839751	0	0	74248f7e6fe6dcf829b20844b4f905ab	27	
123	2	appdata_oct85qsb3cn1/preview/d	d1fa1209c372f0ecc256c61150821cdc	73	d	2	1	-1	1730839751	1730839751	0	0	672a84c7a23a9	31	
124	2	appdata_oct85qsb3cn1/preview/d/6	598a39d5300875c36c3ef118ddbd1378	123	6	2	1	-1	1730839751	1730839751	0	0	672a84c7a20c6	31	
125	2	appdata_oct85qsb3cn1/preview/d/6/4	a86d3e803896eedf24d4410a1892d21c	124	4	2	1	-1	1730839751	1730839751	0	0	672a84c7a1af2	31	
126	2	appdata_oct85qsb3cn1/preview/d/6/4/5	95e6e4bd53083d6e3bf0154a80912b15	125	5	2	1	-1	1730839751	1730839751	0	0	672a84c7a1552	31	
127	2	appdata_oct85qsb3cn1/preview/d/6/4/5/9	422f1aa049f3180d5bd574dd4bfd54a2	126	9	2	1	-1	1730839751	1730839751	0	0	672a84c7a1208	31	
128	2	appdata_oct85qsb3cn1/preview/d/6/4/5/9/2	28df401aec2d997c9f588d4cb2e0d828	127	2	2	1	-1	1730839751	1730839751	0	0	672a84c7a0eba	31	
129	2	appdata_oct85qsb3cn1/preview/d/6/4/5/9/2/0	048d5ac253553ea7b7ada6c4f641792d	128	0	2	1	-1	1730839751	1730839751	0	0	672a84c7a08f6	31	
121	2	appdata_oct85qsb3cn1/theming/global/0	e43b662f45bffb3ba59ac25bee246149	62	0	2	1	0	1730839752	1730839752	0	0	672a84c79b393	31	
116	2	appdata_oct85qsb3cn1/preview/8/f/1/4/e/4/5/7	1d98a25bb7eabe80f9090494ff8faffa	115	7	2	1	0	1730839753	1730839753	0	0	672a8468a6a6c	31	
104	2	appdata_oct85qsb3cn1/preview/c/5/1/c/e/4/1/13	b4c64e002aeeaf1e88efeb353e69343c	103	13	2	1	0	1730839753	1730839753	0	0	672a8468943c1	31	
350	2	appdata_oct85qsb3cn1/preview/0/1/3	2fc05ee3dc14e87eb200e74ebd158585	349	3	2	1	-1	1730840017	1730840017	0	0	672a85d15f7a4	31	
132	2	appdata_oct85qsb3cn1/preview/6/7/c	9fff535e089c5ac88a55242821d6d034	131	c	2	1	-1	1730839751	1730839751	0	0	672a84c7abb63	31	
133	2	appdata_oct85qsb3cn1/preview/6/7/c/6	caf839ad2e77a33063b72b9029a6dec5	132	6	2	1	-1	1730839751	1730839751	0	0	672a84c7ab170	31	
134	2	appdata_oct85qsb3cn1/preview/6/7/c/6/a	03a2ffc2285061f0328dd2ebe00ccfb2	133	a	2	1	-1	1730839751	1730839751	0	0	672a84c7aaa8d	31	
135	2	appdata_oct85qsb3cn1/preview/6/7/c/6/a/1	7de5dcd005d65aa31b73aa1199cc1a42	134	1	2	1	-1	1730839751	1730839751	0	0	672a84c7aa75f	31	
136	2	appdata_oct85qsb3cn1/preview/6/7/c/6/a/1/e	45a9d74be655589305fa49fd16b3a7d9	135	e	2	1	-1	1730839751	1730839751	0	0	672a84c7a9d67	31	
137	2	appdata_oct85qsb3cn1/preview/6/7/c/6/a/1/e/47	a20aa3d11ffd821e4c2accb68d2718dd	136	47	2	1	0	1730839751	1730839751	0	0	672a84c7a9a2d	31	
138	2	appdata_oct85qsb3cn1/preview/6/7/c/6/a/1/e/47/256-144-max.png	2c1a2f3a16b8c48428644344cfeadda5	137	256-144-max.png	11	5	1898	1730839751	1730839751	0	0	2d7b2282f1a91dd874479a5c24f05235	27	
139	2	appdata_oct85qsb3cn1/preview/6/7/c/6/a/1/e/47/144-144-crop.png	213d4f6e14949421b5467abf0b4ae55f	137	144-144-crop.png	11	5	5337	1730839751	1730839751	0	0	c7fc7b70e5cad27051e52abb8dee9d74	27	
140	2	appdata_oct85qsb3cn1/preview/d/6/7	d197a08c5dac8c880916d18de802649e	124	7	2	1	-1	1730839751	1730839751	0	0	672a84c7bb47f	31	
141	2	appdata_oct85qsb3cn1/preview/d/6/7/d	da624b44a6a69f7811bcc17b017b881b	140	d	2	1	-1	1730839751	1730839751	0	0	672a84c7bb227	31	
142	2	appdata_oct85qsb3cn1/preview/d/6/7/d/8	7a5d2f86f09cbc1a673aac4bf2a419ed	141	8	2	1	-1	1730839751	1730839751	0	0	672a84c7baf0f	31	
143	2	appdata_oct85qsb3cn1/preview/d/6/7/d/8/a	4e3066e61f8781938f792fa493579601	142	a	2	1	-1	1730839751	1730839751	0	0	672a84c7bac68	31	
144	2	appdata_oct85qsb3cn1/preview/d/6/7/d/8/a/b	535b945264621f52955ed2ac315c1eec	143	b	2	1	-1	1730839751	1730839751	0	0	672a84c7baa09	31	
146	2	appdata_oct85qsb3cn1/preview/d/6/4/5/9/2/0/40/4096-4096-max.png	6a554f514121b9a1687fd6d66c9c4bcd	130	4096-4096-max.png	11	5	67383	1730839751	1730839751	0	0	9d6b0afc2dfdd16badd7c2f23ccc3ddf	27	
147	2	appdata_oct85qsb3cn1/preview/9	c6c5d2d3cd4312a675aa717bfd73590e	73	9	2	1	-1	1730839751	1730839751	0	0	672a84c7d0564	31	
148	2	appdata_oct85qsb3cn1/preview/9/f	1de7b434b6e509c6ecabafaca4683db9	147	f	2	1	-1	1730839751	1730839751	0	0	672a84c7d0364	31	
149	2	appdata_oct85qsb3cn1/preview/9/f/6	ed7ab9754dc23c49c500e189c45cf4ff	148	6	2	1	-1	1730839751	1730839751	0	0	672a84c7d018f	31	
150	2	appdata_oct85qsb3cn1/preview/9/f/6/1	933585afab9e597b84aa2102c09b22c3	149	1	2	1	-1	1730839751	1730839751	0	0	672a84c7cff9d	31	
151	2	appdata_oct85qsb3cn1/preview/9/f/6/1/4	56902563fc1b83081147bd50a2f519ad	150	4	2	1	-1	1730839751	1730839751	0	0	672a84c7cfd95	31	
152	2	appdata_oct85qsb3cn1/preview/9/f/6/1/4/0	eb00495ef7ffe1add6cfe33eb3f5c278	151	0	2	1	-1	1730839751	1730839751	0	0	672a84c7cfb83	31	
153	2	appdata_oct85qsb3cn1/preview/9/f/6/1/4/0/8	accecea81e272f13b0c845f606fabac6	152	8	2	1	-1	1730839751	1730839751	0	0	672a84c7cf8f9	31	
155	2	appdata_oct85qsb3cn1/preview/d/6/7/d/8/a/b/39/4096-4096-max.png	f6c061f543e6f4ac484cbb02459575c5	145	4096-4096-max.png	11	5	111694	1730839751	1730839751	0	0	44d49d1cd48fba6942b288c5061e757d	27	
156	2	appdata_oct85qsb3cn1/preview/9/f/6/1/4/0/8/56/4096-4096-max.png	3e4d7d11b17e93ca3db2992026e4a148	154	4096-4096-max.png	11	5	37438	1730839751	1730839751	0	0	ed10a9f0592f1443ff6fb3ea8c24d0dc	27	
157	2	appdata_oct85qsb3cn1/theming/global/0/icon-core-#00679efiletypes_text.svg	1ae4edbd00ec38828793ce4d53af8616	121	icon-core-#00679efiletypes_text.svg	23	5	299	1730839752	1730839752	0	0	369b982eda39e2cbecb0d5fea2f52692	27	
158	2	appdata_oct85qsb3cn1/preview/d/6/4/5/9/2/0/40/256-256-crop.png	ccc653e1fd34186b3cd4bc3840ccdb6a	130	256-256-crop.png	11	5	12109	1730839752	1730839752	0	0	fd270d599f6588d1e5ef5f52350d57d5	27	
130	2	appdata_oct85qsb3cn1/preview/d/6/4/5/9/2/0/40	2467bac8952364316b554547e66aa4cb	129	40	2	1	0	1730839752	1730839752	0	0	672a84c79fdeb	31	
159	2	appdata_oct85qsb3cn1/theming/global/0/icon-core-#00679efiletypes_x-office-document.svg	98d7a7d6a09df3f4c09c9fba2fa3df35	121	icon-core-#00679efiletypes_x-office-document.svg	23	5	304	1730839752	1730839752	0	0	31fed5d4bc012dbb59e9b3ff6ed67290	27	
160	2	appdata_oct85qsb3cn1/preview/d/6/7/d/8/a/b/39/256-256-crop.png	131369b54460718f0df078ee1dd03c28	145	256-256-crop.png	11	5	20914	1730839752	1730839752	0	0	cca8429b92524b872980f1ebc4afaf06	27	
145	2	appdata_oct85qsb3cn1/preview/d/6/7/d/8/a/b/39	425f3ab454d58b05346e53cf7d76920a	144	39	2	1	0	1730839752	1730839752	0	0	672a84c7ba54a	31	
161	2	appdata_oct85qsb3cn1/theming/global/0/icon-core-#00679efiletypes_application-pdf.svg	cd71cf62ac3d3b4ad9205bd94fc2a6cc	121	icon-core-#00679efiletypes_application-pdf.svg	23	5	468	1730839752	1730839752	0	0	8709fa4101cafd00a617242ba95bc9c2	27	
162	2	appdata_oct85qsb3cn1/theming/global/0/icon-core-#00679efiletypes_x-office-presentation.svg	6922209370b20571fe71a4fe048a3a27	121	icon-core-#00679efiletypes_x-office-presentation.svg	23	5	221	1730839752	1730839752	0	0	23ac9b2ac4dce429d05398f2f39d9d4e	27	
163	2	appdata_oct85qsb3cn1/preview/c/7	86f93c323800d18e28a7c5c7f689631f	97	7	2	1	-1	1730839752	1730839752	0	0	672a84c8367d4	31	
164	2	appdata_oct85qsb3cn1/preview/c/7/4	7106915268232be51817cd7f44bd5b76	163	4	2	1	-1	1730839752	1730839752	0	0	672a84c8362a4	31	
165	2	appdata_oct85qsb3cn1/preview/c/7/4/d	65be7962121cf58ac19201fafadac536	164	d	2	1	-1	1730839752	1730839752	0	0	672a84c8358bf	31	
166	2	appdata_oct85qsb3cn1/preview/c/7/4/d/9	f528558b4c12bb527dc15869ccbf4c3a	165	9	2	1	-1	1730839752	1730839752	0	0	672a84c835221	31	
167	2	appdata_oct85qsb3cn1/preview/c/7/4/d/9/7	eed8183c91743a3a9b98a16c85c13c60	166	7	2	1	-1	1730839752	1730839752	0	0	672a84c834405	31	
168	2	appdata_oct85qsb3cn1/preview/c/7/4/d/9/7/b	dd90a65eaa8e1c5e2878353b19603eb0	167	b	2	1	-1	1730839752	1730839752	0	0	672a84c833d65	31	
351	2	appdata_oct85qsb3cn1/preview/0/1/3/8	1be17aad5be50eede32cb8582b9dde15	350	8	2	1	-1	1730840017	1730840017	0	0	672a85d15f597	31	
169	2	appdata_oct85qsb3cn1/preview/c/7/4/d/9/7/b/16	44e37d5a1473fc06193f4cbeddff54d5	168	16	2	1	0	1730839752	1730839752	0	0	672a84c833867	31	
175	2	appdata_oct85qsb3cn1/preview/c/7/4/d/9/7/b/16/500-500-max.png	ff77c2311a92bce4d1936827eda7d850	169	500-500-max.png	11	5	50545	1730839752	1730839752	0	0	6b7e2da4a5d1fa106fd725f6a4c263d9	27	
182	2	appdata_oct85qsb3cn1/preview/c/7/4/d/9/7/b/16/64-64-crop.png	e97636d96468a47a3ceac7bb0abb6a55	169	64-64-crop.png	11	5	3895	1730839752	1730839752	0	0	b9e5d26054f269a5e8cacd2c2b023a7b	27	
352	2	appdata_oct85qsb3cn1/preview/0/1/3/8/6	ba305c067c35b12c5803cfd770d5b9cd	351	6	2	1	-1	1730840017	1730840017	0	0	672a85d15f351	31	
353	2	appdata_oct85qsb3cn1/preview/0/1/3/8/6/b	ba98d39353d3fcb01837f012868b1664	352	b	2	1	-1	1730840017	1730840017	0	0	672a85d15f0f6	31	
354	2	appdata_oct85qsb3cn1/preview/0/1/3/8/6/b/d	0bbce5b9bde7547c3815667fd2f59baa	353	d	2	1	-1	1730840017	1730840017	0	0	672a85d15ee61	31	
356	2	appdata_oct85qsb3cn1/preview/0/1/3/8/6/b/d/348/3000-2000-max.jpg	ac06c972c0551c96f2b7c54780869616	355	3000-2000-max.jpg	6	5	459018	1730840017	1730840017	0	0	6d2fe0c6c358bc33cda2c7a1b5719d2f	27	
357	2	appdata_oct85qsb3cn1/preview/0/1/3/8/6/b/d/348/64-64-crop.jpg	3cc38b2b6bb5b5ceb54291b44dadc739	355	64-64-crop.jpg	6	5	2033	1730840017	1730840017	0	0	86acf91e3ebec0c8c2592aaee5600c1b	27	
377	2	appdata_oct85qsb3cn1/preview/b/8/3/a/a/c/2/327/43-64.jpg	179e23e43b2a77dba078218011e8c7a3	335	43-64.jpg	6	5	1797	1730840050	1730840050	0	0	1d30b361484e58317cd47ad1c88c28c9	27	
335	2	appdata_oct85qsb3cn1/preview/b/8/3/a/a/c/2/327	310488a68762ff36f3c093733f98d138	334	327	2	1	0	1730840050	1730840050	0	0	672a85a486085	31	
355	2	appdata_oct85qsb3cn1/preview/0/1/3/8/6/b/d/348	828f4bb0f1de366bf965c52502c80db2	354	348	2	1	0	1730840050	1730840050	0	0	672a85d15eaf8	31	
382	2	appdata_oct85qsb3cn1/preview/8/1/9/f/4/6/e/338/43-64.jpg	e35604408c3e27c408879889eda5a3f9	345	43-64.jpg	6	5	1695	1730840050	1730840050	0	0	d217ae12ffcdb8b258f3e1eb2cab3a0a	27	
386	2	appdata_oct85qsb3cn1/preview/8/1/9/f/4/6/e/338/682-1024.jpg	8fd80e49585f42f7b2302f2a47a8c3bb	345	682-1024.jpg	6	5	116164	1730840051	1730840051	0	0	969d4ebe860403b1ccfcd9aa01840321	27	
391	2	appdata_oct85qsb3cn1/preview/d/3/d/9/4/4/6/10/1024-683.jpg	b517d7f182d88e4ac3a4e9cdc095dc83	233	1024-683.jpg	6	5	100640	1730840052	1730840052	0	0	8b1b35a629dd1931592e64ec3602313a	27	
404	1	files/Photos/e386abed-7b68-4d84-922a-da8d3a1a939d (1).jpg	22599ac30599072e5de7bcc5840f8fa2	4	e386abed-7b68-4d84-922a-da8d3a1a939d (1).jpg	6	5	795433	1721723704	1721723704	0	0	f2cf08fa10607a28ce4904bddf713ccf	27	
423	2	appdata_oct85qsb3cn1/preview/6/6/8/0/8/e/3/414/64-64-crop.jpg	c35cdfb9c7f8a4618a01c03824227af7	421	64-64-crop.jpg	6	5	1843	1730840224	1730840224	0	0	3728a648bd6e85b6c3f895dc04d90a9b	27	
426	2	appdata_oct85qsb3cn1/preview/7/0/c/6/3/9/d/393/43-64.jpg	4fa0722ca0e1cd82f04907e2d5025df3	401	43-64.jpg	6	5	1858	1730840228	1730840228	0	0	bb9351ca9eb62f647c791ec63ad254d9	27	
428	2	appdata_oct85qsb3cn1/preview/6/6/8/0/8/e/3/414/1024-682.jpg	2eb9df32f8af179c57061a7d8398d0c5	421	1024-682.jpg	6	5	101333	1730840228	1730840228	0	0	6f9cf5deacdb342d7dfe148a02dbdec9	27	
170	2	appdata_oct85qsb3cn1/preview/9/f/6/1/4/0/8/56/256-256-crop.png	f7e0dabe88bd486bdc2542d9602296d2	154	256-256-crop.png	11	5	6674	1730839752	1730839752	0	0	a8c91ca9f5d55a5728ca1328ab69dd6b	27	
154	2	appdata_oct85qsb3cn1/preview/9/f/6/1/4/0/8/56	45ac5977c8c4cf0feb7b55a629f6edcc	153	56	2	1	0	1730839752	1730839752	0	0	672a84c7cf5b3	31	
171	2	appdata_oct85qsb3cn1/preview/e	65c7032fdfa115bf42000cf4ef260633	73	e	2	1	-1	1730839752	1730839752	0	0	672a84c83df63	31	
172	2	appdata_oct85qsb3cn1/preview/e/c	1cb7fcd913039e4981e3d8dd8fd2a0c2	171	c	2	1	-1	1730839752	1730839752	0	0	672a84c83dcae	31	
173	2	appdata_oct85qsb3cn1/preview/e/c/c	961ef5e123cc7de7e367a4c2259c32c3	172	c	2	1	-1	1730839752	1730839752	0	0	672a84c83da17	31	
174	2	appdata_oct85qsb3cn1/preview/e/c/c/b	9c92ee2f66216ffe467868776ae92b18	173	b	2	1	-1	1730839752	1730839752	0	0	672a84c83d579	31	
176	2	appdata_oct85qsb3cn1/preview/a	a0ef4abfb775c27c30b0be5c5caf006f	73	a	2	1	-1	1730839752	1730839752	0	0	672a84c840930	31	
177	2	appdata_oct85qsb3cn1/preview/e/c/c/b/c	12a9142b562c9a054bdba4e2f6a9b68b	174	c	2	1	-1	1730839752	1730839752	0	0	672a84c83cf5b	31	
178	2	appdata_oct85qsb3cn1/preview/a/a	16fda7ac9bbfb64af8f778f33750578e	176	a	2	1	-1	1730839752	1730839752	0	0	672a84c84054b	31	
179	2	appdata_oct85qsb3cn1/preview/e/c/c/b/c/8	d15a2066a9fe4760e80bc5b18cb975cd	177	8	2	1	-1	1730839752	1730839752	0	0	672a84c83c0e3	31	
180	2	appdata_oct85qsb3cn1/preview/a/a/b	c62a0bdb7c903c52f3a17421417b89a7	178	b	2	1	-1	1730839752	1730839752	0	0	672a84c83fd9f	31	
181	2	appdata_oct85qsb3cn1/preview/e/c/c/b/c/8/7	8892a9e8ec15d395c35f1acb554c1b39	179	7	2	1	-1	1730839752	1730839752	0	0	672a84c83bd85	31	
183	2	appdata_oct85qsb3cn1/preview/a/a/b/3	befc4014a1c80a86154d9e0a65c5f423	180	3	2	1	-1	1730839752	1730839752	0	0	672a84c83f349	31	
185	2	appdata_oct85qsb3cn1/preview/a/a/b/3/2	aec70554aa2e32fb8ab6699a624c68fa	183	2	2	1	-1	1730839752	1730839752	0	0	672a84c83ed55	31	
184	2	appdata_oct85qsb3cn1/preview/e/c/c/b/c/8/7/3	696e9233c142995c139cd5092d154d34	181	3	2	1	0	1730839752	1730839752	0	0	672a84c83b99e	31	
186	2	appdata_oct85qsb3cn1/preview/a/a/b/3/2/3	843e7826e95480ec78c04487f2965b78	185	3	2	1	-1	1730839752	1730839752	0	0	672a84c83e68b	31	
187	2	appdata_oct85qsb3cn1/preview/a/a/b/3/2/3/8	e27288fd11ffc5845b90f27cb32bd47a	186	8	2	1	-1	1730839752	1730839752	0	0	672a84c83e07c	31	
188	2	appdata_oct85qsb3cn1/preview/a/a/b/3/2/3/8/14	dc15cf5262ff97326551faaf2b16ccb5	187	14	2	1	0	1730839752	1730839752	0	0	672a84c83d90c	31	
189	2	appdata_oct85qsb3cn1/preview/9/b	b48e48e9bb5b9055180fb82b1158181e	147	b	2	1	-1	1730839752	1730839752	0	0	672a84c851dad	31	
190	2	appdata_oct85qsb3cn1/preview/9/b/f	f35023682843e42980eb876cece5dc8e	189	f	2	1	-1	1730839752	1730839752	0	0	672a84c85182c	31	
191	2	appdata_oct85qsb3cn1/preview/9/b/f/3	3c33cd6c96a0d17e14075de65d55be05	190	3	2	1	-1	1730839752	1730839752	0	0	672a84c8514ae	31	
192	2	appdata_oct85qsb3cn1/preview/9/b/f/3/1	0567477e67dc18759225b6df4e5e1c70	191	1	2	1	-1	1730839752	1730839752	0	0	672a84c851042	31	
193	2	appdata_oct85qsb3cn1/preview/9/b/f/3/1/c	89efdcdc1c875aa659d9e08690058f4c	192	c	2	1	-1	1730839752	1730839752	0	0	672a84c850d7e	31	
194	2	appdata_oct85qsb3cn1/preview/9/b/f/3/1/c/7	07e59b22825f27273fdfa050d6d15c85	193	7	2	1	-1	1730839752	1730839752	0	0	672a84c8509a4	31	
195	2	appdata_oct85qsb3cn1/preview/9/b/f/3/1/c/7/15	c96bf5af12e13dafd89d01a7bfa643ee	194	15	2	1	0	1730839752	1730839752	0	0	672a84c850229	31	
196	2	appdata_oct85qsb3cn1/preview/9/a	f76030517c4dddec3f5e1e8f2817ebbf	147	a	2	1	-1	1730839752	1730839752	0	0	672a84c8562bf	31	
197	2	appdata_oct85qsb3cn1/preview/9/a/1	401250f34e42a1544e361282ba14e283	196	1	2	1	-1	1730839752	1730839752	0	0	672a84c856012	31	
198	2	appdata_oct85qsb3cn1/preview/2	18f8e32159f6fb962c8db36dc64bec40	73	2	2	1	-1	1730839752	1730839752	0	0	672a84c856a84	31	
199	2	appdata_oct85qsb3cn1/preview/2/8	03bccdeb9d7dcf0ea57c9e253884dc49	198	8	2	1	-1	1730839752	1730839752	0	0	672a84c856678	31	
200	2	appdata_oct85qsb3cn1/preview/9/a/1/1	338304c1f69fee1ed55dda2f2e4f6bef	197	1	2	1	-1	1730839752	1730839752	0	0	672a84c855ca5	31	
201	2	appdata_oct85qsb3cn1/preview/2/8/3	99781e105af7cb8bef30e34ca52d5b26	199	3	2	1	-1	1730839752	1730839752	0	0	672a84c8561a6	31	
202	2	appdata_oct85qsb3cn1/preview/9/a/1/1/5	ad244c6c9ea6a751b399b63f0956ec03	200	5	2	1	-1	1730839752	1730839752	0	0	672a84c855848	31	
203	2	appdata_oct85qsb3cn1/preview/2/8/3/8	99ad9519a32a6d3e1093c37c65de7c54	201	8	2	1	-1	1730839752	1730839752	0	0	672a84c855bc3	31	
204	2	appdata_oct85qsb3cn1/preview/9/a/1/1/5/8	bbe337c8dfe6d1cc6dc822a939c3a2dc	202	8	2	1	-1	1730839752	1730839752	0	0	672a84c855567	31	
211	2	appdata_oct85qsb3cn1/preview/9/b/f/3/1/c/7/15/4096-4096-max.png	5aa6ff273f99e7fc3a92bdd3df2a7155	195	4096-4096-max.png	11	5	47099	1730839752	1730839752	0	0	585c114900bfdf17b28078256f13a2bd	27	
213	2	appdata_oct85qsb3cn1/preview/9/b/f/3/1/c/7/15/64-64-crop.png	23088eb0dfbd6ce29a1ad256995a8796	195	64-64-crop.png	11	5	1158	1730839752	1730839752	0	0	6d195c1926a18492d8e5ac82625b5435	27	
205	2	appdata_oct85qsb3cn1/preview/2/8/3/8/0	62c8cfdefc26d4ebf90a7e09a8fa2ab0	203	0	2	1	-1	1730839752	1730839752	0	0	672a84c855838	31	
207	2	appdata_oct85qsb3cn1/preview/2/8/3/8/0/2	954b99deec7b7da9f320fd34b75034dc	205	2	2	1	-1	1730839752	1730839752	0	0	672a84c855120	31	
209	2	appdata_oct85qsb3cn1/preview/2/8/3/8/0/2/3	f8b6f3f86711bfca3e3c23654c4c2d4a	207	3	2	1	-1	1730839752	1730839752	0	0	672a84c854ba7	31	
210	2	appdata_oct85qsb3cn1/preview/2/8/3/8/0/2/3/51	967f166e940d0cace97407d1efe4834e	209	51	2	1	0	1730839752	1730839752	0	0	672a84c8547ea	31	
212	2	appdata_oct85qsb3cn1/preview/2/8/3/8/0/2/3/51/4096-4096-max.png	11d876b826fa90e33a7f80ed765e0fbe	210	4096-4096-max.png	11	5	195801	1730839752	1730839752	0	0	873145d2eaca10d448833207048b5319	27	
214	2	appdata_oct85qsb3cn1/preview/2/8/3/8/0/2/3/51/64-64-crop.png	bda2af547b7c1520b9e4da4280e80096	210	64-64-crop.png	11	5	3277	1730839752	1730839752	0	0	babcea482f6eab5960e27eea3cc05d77	27	
358	1	files/Photos/minsk_halfmarathon2024-20240908133626-e4c68dc8f925.jpg	60ae93be78e38177d38eea9a8ce679d7	4	minsk_halfmarathon2024-20240908133626-e4c68dc8f925.jpg	6	5	1336876	1728295920	1728295920	0	0	d7e2a4c0b5fa9c80e8b65140e21b4376	27	
378	2	appdata_oct85qsb3cn1/preview/b/8/3/a/a/c/2/327/683-1024.jpg	13a8f551861f02ebebddbcec310148c8	335	683-1024.jpg	6	5	116610	1730840050	1730840050	0	0	d6111d648112cfb7348ff50ca68790d0	27	
383	2	appdata_oct85qsb3cn1/preview/0/1/3/8/6/b/d/348/1024-683.jpg	aa0ad6c8b4d517a88905eb216b0050b3	355	1024-683.jpg	6	5	91095	1730840050	1730840050	0	0	f5efb2a67323e8031013f1dd2ceecc85	27	
388	2	appdata_oct85qsb3cn1/preview/8/64-43.jpg	08a8af941f6a0b167c57de4dad7302a1	108	64-43.jpg	6	5	1296	1730840051	1730840051	0	0	d0b681ec3f05a14cf31bf990df15d47c	27	
429	2	appdata_oct85qsb3cn1/preview/4/f/4/a/d/c/b/404/1024-683.jpg	0cf412f0097e00d81d8c68f65647236e	411	1024-683.jpg	6	5	106046	1730840228	1730840228	0	0	067881986f28ea659b38d359a511eeef	27	
392	2	appdata_oct85qsb3cn1/preview/8/1024-683.jpg	3d0e28221e9ec4dc60c6bdd3a85d0858	108	1024-683.jpg	6	5	57466	1730840052	1730840052	0	0	5ecc9fa0fd547b88cf6a706dc3c1c3d5	27	
405	2	appdata_oct85qsb3cn1/preview/4/f	d62a130fdc79fee13a9381b0b7efa329	82	f	2	1	-1	1730840221	1730840221	0	0	672a869d1ba56	31	
406	2	appdata_oct85qsb3cn1/preview/4/f/4	f0a83b391470e2c9df8115ccfc935853	405	4	2	1	-1	1730840221	1730840221	0	0	672a869d1b75e	31	
407	2	appdata_oct85qsb3cn1/preview/4/f/4/a	620d90b06a085a7436083eb194f8acd2	406	a	2	1	-1	1730840221	1730840221	0	0	672a869d1b3dc	31	
408	2	appdata_oct85qsb3cn1/preview/4/f/4/a/d	cf2a11698fdb5c468e43ce678f551ee2	407	d	2	1	-1	1730840221	1730840221	0	0	672a869d1b15c	31	
409	2	appdata_oct85qsb3cn1/preview/4/f/4/a/d/c	5bb0579fa04f876735d99cf747732043	408	c	2	1	-1	1730840221	1730840221	0	0	672a869d1ae90	31	
410	2	appdata_oct85qsb3cn1/preview/4/f/4/a/d/c/b	d620e5bfb7a34e7b5c78a217419ae243	409	b	2	1	-1	1730840221	1730840221	0	0	672a869d1ab75	31	
412	2	appdata_oct85qsb3cn1/preview/4/f/4/a/d/c/b/404/3936-2624-max.jpg	32ef1eb710b1b0695f76591b0a90f29c	411	3936-2624-max.jpg	6	5	825629	1730840221	1730840221	0	0	891dc77642eec0e9a23cd5502df67590	27	
413	2	appdata_oct85qsb3cn1/preview/4/f/4/a/d/c/b/404/64-64-crop.jpg	b9023d80f7dc4ab339bccdfef170c683	411	64-64-crop.jpg	6	5	2196	1730840221	1730840221	0	0	39721abb2cae1da01aca7850c1fe9c7f	27	
424	2	appdata_oct85qsb3cn1/preview/7/0/c/6/3/9/d/393/683-1024.jpg	4368a302b5d01bab96808fedf6a9e666	401	683-1024.jpg	6	5	126668	1730840228	1730840228	0	0	08319825a023c8e749dc3d4026246b40	27	
427	2	appdata_oct85qsb3cn1/preview/4/f/4/a/d/c/b/404/64-43.jpg	705fe1faadf0f161a147f1017b2485f5	411	64-43.jpg	6	5	1751	1730840228	1730840228	0	0	ed5a3c47b22da599e9a85d5878f63e45	27	
411	2	appdata_oct85qsb3cn1/preview/4/f/4/a/d/c/b/404	4a4f7aae49bd626e5e2c3acf34733d84	410	404	2	1	0	1730840228	1730840228	0	0	672a869d1a72d	31	
108	2	appdata_oct85qsb3cn1/preview/8	7fce57dd77393d3476dbddb7cc5c5843	73	8	2	1	-1	1730840052	1730840052	0	0	672a87656da0a	31	
206	2	appdata_oct85qsb3cn1/preview/9/a/1/1/5/8/1	3bb90c383d37ff6ee10e4973717efa55	204	1	2	1	-1	1730839752	1730839752	0	0	672a84c8550ae	31	
208	2	appdata_oct85qsb3cn1/preview/9/a/1/1/5/8/1/52	9da311184dbaf25ddfbbebb25a1bfffe	206	52	2	1	0	1730839752	1730839752	0	0	672a84c854c75	31	
215	2	appdata_oct85qsb3cn1/preview/e/4	81fdd100a51b79990b4d01a20da619d9	171	4	2	1	-1	1730839753	1730839753	0	0	672a84c959dad	31	
216	2	appdata_oct85qsb3cn1/preview/e/4/d	562edc71e3cb98d74f246d40ba5cd0ef	215	d	2	1	-1	1730839753	1730839753	0	0	672a84c959a20	31	
217	2	appdata_oct85qsb3cn1/preview/8/f/1/4/e/4/5/7/64-64-crop.jpg	63f93c95c13d4e2a294feb1fcdaa9484	116	64-64-crop.jpg	6	5	1901	1730839753	1730839753	0	0	7981efa9cb8bdc368e1b531bd4c41970	27	
218	2	appdata_oct85qsb3cn1/preview/e/4/d/a	9ea4e4bb13177c15eb3d59f26e9121e1	216	a	2	1	-1	1730839753	1730839753	0	0	672a84c9596eb	31	
219	2	appdata_oct85qsb3cn1/preview/e/4/d/a/3	c94ea179a544a2d461e0e3f01bf30e15	218	3	2	1	-1	1730839753	1730839753	0	0	672a84c9593fb	31	
220	2	appdata_oct85qsb3cn1/preview/e/4/d/a/3/b	17539595dba4977ce189b107587a8cbe	219	b	2	1	-1	1730839753	1730839753	0	0	672a84c958f30	31	
221	2	appdata_oct85qsb3cn1/preview/e/4/d/a/3/b/7	20f85cb02a0fc84b928449ae4ad3606d	220	7	2	1	-1	1730839753	1730839753	0	0	672a84c957e30	31	
222	2	appdata_oct85qsb3cn1/preview/8/1600-1067-max.jpg	1f3cdefa099ce35914add1f866a418fe	108	1600-1067-max.jpg	6	5	147631	1730839753	1730839753	0	0	1626928a77a064cdc9a36d73261419c4	27	
223	2	appdata_oct85qsb3cn1/preview/e/4/d/a/3/b/7/5	13d29c0cf0ec86adff18020593b46ac3	221	5	2	1	0	1730840052	1730840052	0	0	672a84c956d5a	31	
224	2	appdata_oct85qsb3cn1/preview/8/64-64-crop.jpg	2c26b8f3539c05e471b75eaa709baf4c	108	64-64-crop.jpg	6	5	1492	1730839753	1730839753	0	0	fd6c792980e5b0fd016d0db4360b935f	27	
225	2	appdata_oct85qsb3cn1/preview/e/4/d/a/3/b/7/5/1600-1067-max.jpg	545cef247809e37dc8b409d8e11e39e1	223	1600-1067-max.jpg	6	5	165982	1730839753	1730839753	0	0	1c21c7aa7d4174208f4f5e2801618678	27	
226	2	appdata_oct85qsb3cn1/preview/e/4/d/a/3/b/7/5/64-64-crop.jpg	4196b1b1f71df8970b589609b2ac86ee	223	64-64-crop.jpg	6	5	1823	1730839753	1730839753	0	0	8aec5a3e0db98d0ca5bed5290587bd57	27	
227	2	appdata_oct85qsb3cn1/preview/d/3	ebe231d2ea05c604c9c901419b9e8f0e	123	3	2	1	-1	1730839753	1730839753	0	0	672a84c97b43e	31	
228	2	appdata_oct85qsb3cn1/preview/d/3/d	288b3dfdd432f37402a7156ba8ff68df	227	d	2	1	-1	1730839753	1730839753	0	0	672a84c97abd7	31	
229	2	appdata_oct85qsb3cn1/preview/d/3/d/9	cf681f667305bddea9d16f13d7e31a5f	228	9	2	1	-1	1730839753	1730839753	0	0	672a84c97a07e	31	
230	2	appdata_oct85qsb3cn1/preview/d/3/d/9/4	5804b3391734c9e2904df41d5f851dce	229	4	2	1	-1	1730839753	1730839753	0	0	672a84c9792da	31	
231	2	appdata_oct85qsb3cn1/preview/d/3/d/9/4/4	bbc0d4973c2f0acafd40d305671c8ff9	230	4	2	1	-1	1730839753	1730839753	0	0	672a84c978b11	31	
232	2	appdata_oct85qsb3cn1/preview/d/3/d/9/4/4/6	e0d64d513e224d9520cd9e4294489763	231	6	2	1	-1	1730839753	1730839753	0	0	672a84c978751	31	
430	3		d41d8cd98f00b204e9800998ecf8427e	-1		2	1	-1	1730840434	1730840434	0	0	672a8772612f9	23	
234	2	appdata_oct85qsb3cn1/preview/6/5/1/2/b/d/4/11/64-64-crop.jpg	ed7bb57ff1c497eb6882531c0602af29	81	64-64-crop.jpg	6	5	2201	1730839753	1730839753	0	0	00dc74b8bf981c8dcc31c6190737e525	27	
235	2	appdata_oct85qsb3cn1/preview/c/2	b0dd6315a0579a37988833efd61bcf55	97	2	2	1	-1	1730839753	1730839753	0	0	672a84c98561b	31	
236	2	appdata_oct85qsb3cn1/preview/c/2/0	e81e6ffa997a14c90ce27c35dc9889a0	235	0	2	1	-1	1730839753	1730839753	0	0	672a84c984628	31	
237	2	appdata_oct85qsb3cn1/preview/c/2/0/a	5c155aa09172c8465927947d30179010	236	a	2	1	-1	1730839753	1730839753	0	0	672a84c984414	31	
238	2	appdata_oct85qsb3cn1/preview/c/2/0/a/d	79b57a1a5780c11feed0ad85b1ca5664	237	d	2	1	-1	1730839753	1730839753	0	0	672a84c98420b	31	
239	2	appdata_oct85qsb3cn1/preview/c/2/0/a/d/4	cf0c1d0de2767de64b0f475b8bf07db3	238	4	2	1	-1	1730839753	1730839753	0	0	672a84c983e18	31	
240	2	appdata_oct85qsb3cn1/preview/c/2/0/a/d/4/d	4aa3e8cf0a9c74147a150dfa6671d561	239	d	2	1	-1	1730839753	1730839753	0	0	672a84c983808	31	
241	2	appdata_oct85qsb3cn1/preview/c/2/0/a/d/4/d/12	731559817ca3e75067db7113b544e0ad	240	12	2	1	0	1730839753	1730839753	0	0	672a84c9831af	31	
242	2	appdata_oct85qsb3cn1/preview/d/3/d/9/4/4/6/10/1600-1067-max.jpg	1f9965349ddb0b77c41f5549afde6a95	233	1600-1067-max.jpg	6	5	232378	1730839753	1730839753	0	0	28720fdfd4e0033a41ed3db6fdbdc0f2	27	
243	2	appdata_oct85qsb3cn1/preview/d/3/d/9/4/4/6/10/64-64-crop.jpg	122876c8ad33260a20aa672fe8de6fb2	233	64-64-crop.jpg	6	5	1613	1730839753	1730839753	0	0	2587f58a2c6061ee51c7fc9e0e7b4e09	27	
244	2	appdata_oct85qsb3cn1/preview/c/2/0/a/d/4/d/12/4096-4096-max.png	94eca7df74a38844851b6b1c46b1f658	241	4096-4096-max.png	11	5	37076	1730839753	1730839753	0	0	7804a3d753263d679b047e2b8125291f	27	
245	2	appdata_oct85qsb3cn1/preview/c/5/1/c/e/4/1/13/64-64-crop.jpg	38f0c24fe0e8dc7fff76a80a135bdf8c	104	64-64-crop.jpg	6	5	1313	1730839753	1730839753	0	0	ba7e731322c4c5123d4abe3aaf3b9856	27	
246	2	appdata_oct85qsb3cn1/preview/4/5/c/4/8/c/c/9/64-64-crop.jpg	15b1e3fa26755af4c5f75cb3289f35b9	89	64-64-crop.jpg	6	5	1936	1730839753	1730839753	0	0	091257eb791cea7553b74c03c6dfb622	27	
247	2	appdata_oct85qsb3cn1/preview/6/64-64-crop.jpg	f26fc86321d3eaa2a86a4e63bb9ea96b	74	64-64-crop.jpg	6	5	2099	1730839753	1730839753	0	0	ed1d68eac3c09d67e9f1bcf150a37afb	27	
359	2	appdata_oct85qsb3cn1/preview/a/a/9	3bfa53726f54ecb881289ee3a4b0f034	178	9	2	1	-1	1730840032	1730840032	0	0	672a85e0d0153	31	
360	2	appdata_oct85qsb3cn1/preview/a/a/9/4	673616706fc5ccf63056717243b74ab8	359	4	2	1	-1	1730840032	1730840032	0	0	672a85e0cffa9	31	
361	2	appdata_oct85qsb3cn1/preview/a/a/9/4/2	5ced830e5c1cdfa68ae7f6dfecb942a9	360	2	2	1	-1	1730840032	1730840032	0	0	672a85e0cfdae	31	
362	2	appdata_oct85qsb3cn1/preview/a/a/9/4/2/a	635e5d7c4beb3f43f0306db47a7d09a8	361	a	2	1	-1	1730840032	1730840032	0	0	672a85e0cfb71	31	
363	2	appdata_oct85qsb3cn1/preview/a/a/9/4/2/a/b	d0ecc966f65621ea77e1bf5dd0659459	362	b	2	1	-1	1730840032	1730840032	0	0	672a85e0cf895	31	
365	2	appdata_oct85qsb3cn1/preview/a/a/9/4/2/a/b/358/3000-2000-max.jpg	3b2e281e64e3940d650eccf79e6cf943	364	3000-2000-max.jpg	6	5	445790	1730840032	1730840032	0	0	b0eb1b398ccfafc3a32d523ec047d49e	27	
366	2	appdata_oct85qsb3cn1/preview/a/a/9/4/2/a/b/358/64-64-crop.jpg	dfdfceab1fab8ae5e2bac51d1cb5c128	364	64-64-crop.jpg	6	5	2266	1730840033	1730840033	0	0	938672fe4bc877a65e42aba55489b68d	27	
379	2	appdata_oct85qsb3cn1/preview/a/a/9/4/2/a/b/358/64-43.jpg	974e8e2fb9b97908e9adc07ff0ae62ec	364	64-43.jpg	6	5	1839	1730840050	1730840050	0	0	2e492ca9dc6dd122168b8c288540cdef	27	
364	2	appdata_oct85qsb3cn1/preview/a/a/9/4/2/a/b/358	4acfc5dbf70f5925d1972e417ffc2424	363	358	2	1	0	1730840050	1730840050	0	0	672a85e0cf3c3	31	
384	2	appdata_oct85qsb3cn1/preview/0/5/0/4/9/e/9/367/43-64.jpg	8b475f1b6e9c93932126f45eaf4b05ff	374	43-64.jpg	6	5	1619	1730840050	1730840050	0	0	33ec67676e9c08a8af2248397d71cba9	27	
387	2	appdata_oct85qsb3cn1/preview/d/3/d/9/4/4/6/10/64-43.jpg	79e98075218549ba3458cab7065f11bf	233	64-43.jpg	6	5	1279	1730840051	1730840051	0	0	388ad892524a4828f9b1dc0075c8372e	27	
233	2	appdata_oct85qsb3cn1/preview/d/3/d/9/4/4/6/10	ab09053a969c5f4d426710960292802a	232	10	2	1	0	1730840052	1730840052	0	0	672a84c9783e8	31	
393	1	files/Photos/minsk_halfmarathon2024-20240908143703-ff5fc7f117e2.jpg	4f5f9de3a6b5f4bcba44cb1b001d41e9	4	minsk_halfmarathon2024-20240908143703-ff5fc7f117e2.jpg	6	5	1576306	1728295918	1728295918	0	0	8985962d7838f51161593fefa9611e38	27	
414	1	files/Photos/photo_2024-07-23 11.36.51.jpeg	703633540ae2b7152a22ef66d6a99a0a	4	photo_2024-07-23 11.36.51.jpeg	6	5	182410	1721723805	1721723805	0	0	3df4d2b1e99bacde5f441678267b197f	27	
425	2	appdata_oct85qsb3cn1/preview/6/6/8/0/8/e/3/414/64-43.jpg	eb193615b76a3875ca66eb287d759ed9	421	64-43.jpg	6	5	1506	1730840228	1730840228	0	0	f89076897feabee6780faab1e9a30003	27	
433	3	appdata_ocm9gq0rvgvc/theming/global	1fbc767cac8f742eee7584892c6e3c6c	432	global	2	1	0	1730840434	1730840434	0	0	672a877267663	31	
75	2	appdata_oct85qsb3cn1/preview/6/5	3fa1fd4d675100cb029be405b55d8674	74	5	2	1	-1	1730839656	1730839656	0	0	672a876b4112f	31	
131	2	appdata_oct85qsb3cn1/preview/6/7	fbd757a2271ae1d58eb6ad54331e8d8b	74	7	2	1	-1	1730839751	1730839751	0	0	672a876b4113a	31	
431	3	appdata_ocm9gq0rvgvc	a1925f78d7dd8cf82679a611ef630daf	430	appdata_ocm9gq0rvgvc	2	1	0	1730840434	1730840434	0	0	672a877260b66	31	
432	3	appdata_ocm9gq0rvgvc/theming	759364fc0b37147b1b3e8dd88b22a31a	431	theming	2	1	0	1730840434	1730840434	0	0	672a877265f20	31	
248	2	appdata_oct85qsb3cn1/preview/c/2/0/a/d/4/d/12/64-64-crop.png	feb5b03451f7a96f00a5a7d8f217ca02	241	64-64-crop.png	11	5	843	1730839753	1730839753	0	0	e87b1bcc9a340fe08f81e5b4a9097f89	27	
249	1	files/Photos/6adf4d1b-fccd-49c9-bf71-b8b7efd5d1fc.jpg	5ca13e77507248db6a1eb9764ca340ed	4	6adf4d1b-fccd-49c9-bf71-b8b7efd5d1fc.jpg	6	5	517097	1729105512	1729105512	0	0	3cca596b10e2ff942f1625b1a4db6b43	27	
250	2	appdata_oct85qsb3cn1/preview/0	d54061e159eb7558c41896e03869a85f	73	0	2	1	-1	1730839761	1730839761	0	0	672a84d16f65f	31	
251	2	appdata_oct85qsb3cn1/preview/0/7	498d0c38904f20f102d3067a64545cbc	250	7	2	1	-1	1730839761	1730839761	0	0	672a84d16f2b4	31	
252	2	appdata_oct85qsb3cn1/preview/0/7/7	a39ef0e53dca92e7640f675bf14afe9a	251	7	2	1	-1	1730839761	1730839761	0	0	672a84d16edcc	31	
253	2	appdata_oct85qsb3cn1/preview/0/7/7/e	cbd2d9305efde821617694e19eccea41	252	e	2	1	-1	1730839761	1730839761	0	0	672a84d16ea92	31	
254	2	appdata_oct85qsb3cn1/preview/0/7/7/e/2	037449435f13803169e8bd0a6b3098d4	253	2	2	1	-1	1730839761	1730839761	0	0	672a84d16e776	31	
255	2	appdata_oct85qsb3cn1/preview/0/7/7/e/2/9	96fc80132316d79a52761607956f4adb	254	9	2	1	-1	1730839761	1730839761	0	0	672a84d16e52e	31	
256	2	appdata_oct85qsb3cn1/preview/0/7/7/e/2/9/b	4aacead69f5354a4ff91ccc70bfc2986	255	b	2	1	-1	1730839761	1730839761	0	0	672a84d16e2b0	31	
367	1	files/Photos/minsk_halfmarathon2024-20240908135734-d6a1fffb9855.jpg	3b95229a9416457cb8a432e0e0202652	4	minsk_halfmarathon2024-20240908135734-d6a1fffb9855.jpg	6	5	1261988	1728295916	1728295916	0	0	9575c4859beee1ec41a7c5a6010663d2	27	
380	2	appdata_oct85qsb3cn1/preview/a/a/9/4/2/a/b/358/1024-683.jpg	2c1fee7e315118ea22d15d69dd37b8a2	364	1024-683.jpg	6	5	87743	1730840050	1730840050	0	0	8fcc85023180ecf83ef9d70707206000	27	
258	2	appdata_oct85qsb3cn1/preview/0/7/7/e/2/9/b/249/3984-2656-max.jpg	3c34d36b0646ddf9eb8311fe3a3f3198	257	3984-2656-max.jpg	6	5	550490	1730839761	1730839761	0	0	e80788d8be12f175a46eb14d467eae5f	27	
259	2	appdata_oct85qsb3cn1/preview/0/7/7/e/2/9/b/249/64-64-crop.jpg	e1bbdafcf72b05932c61ed5e793b31f4	257	64-64-crop.jpg	6	5	1955	1730839761	1730839761	0	0	4e507644d07dd70b9edc8cc4d670a72e	27	
385	2	appdata_oct85qsb3cn1/preview/0/5/0/4/9/e/9/367/683-1024.jpg	3e7ffd636e5c1b6fbb289a598aeb4ef5	374	683-1024.jpg	6	5	75339	1730840050	1730840050	0	0	37fa188eee422265c74c05745d2a349e	27	
260	1	files/Photos/9c544df3-4f3c-46d6-9cf3-7c2ec1674262.jpg	1867d3f0fa6e6511edb5f66c9f4be2af	4	9c544df3-4f3c-46d6-9cf3-7c2ec1674262.jpg	6	5	736842	1728924608	1728924608	0	0	9ef12d4826a2d431433d6cfa526bd483	27	
261	2	appdata_oct85qsb3cn1/preview/a/4	b8e8325b02cda5de638dd507eaae3596	176	4	2	1	-1	1730839774	1730839774	0	0	672a84de5427b	31	
262	2	appdata_oct85qsb3cn1/preview/a/4/f	67d4a607d38c263002de1e61507f001c	261	f	2	1	-1	1730839774	1730839774	0	0	672a84de53ffd	31	
263	2	appdata_oct85qsb3cn1/preview/a/4/f/2	ecaddb337f8a96ed3f8a35ee013f8d41	262	2	2	1	-1	1730839774	1730839774	0	0	672a84de53da7	31	
264	2	appdata_oct85qsb3cn1/preview/a/4/f/2/3	cbe5d7dc4c686f96b9affdc4187865f9	263	3	2	1	-1	1730839774	1730839774	0	0	672a84de53b54	31	
265	2	appdata_oct85qsb3cn1/preview/a/4/f/2/3/6	b3ecf70ca394bf3023d407b2d4492eb2	264	6	2	1	-1	1730839774	1730839774	0	0	672a84de538fb	31	
266	2	appdata_oct85qsb3cn1/preview/a/4/f/2/3/6/7	b8e13c7f1af82660bb97f6ecaa23a78f	265	7	2	1	-1	1730839774	1730839774	0	0	672a84de53642	31	
389	2	appdata_oct85qsb3cn1/preview/e/4/d/a/3/b/7/5/64-43.jpg	0d8e5f3c4794b629175f72ecddfe23fc	223	64-43.jpg	6	5	1564	1730840051	1730840051	0	0	da337c5a8e420636a240f94f9bff6b3a	27	
394	2	appdata_oct85qsb3cn1/preview/7	25222b6ae562703fb89473c5e7a5853f	73	7	2	1	-1	1730840091	1730840091	0	0	672a861b7e156	31	
268	2	appdata_oct85qsb3cn1/preview/a/4/f/2/3/6/7/260/4096-2731-max.jpg	4e5c68013d24c3e4a6146abe5dac5b01	267	4096-2731-max.jpg	6	5	776082	1730839774	1730839774	0	0	b2d20ab1de14f57934a625d723d7b830	27	
269	2	appdata_oct85qsb3cn1/preview/a/4/f/2/3/6/7/260/64-64-crop.jpg	dc103834b71f5b6307ea45408d5a4764	267	64-64-crop.jpg	6	5	1817	1730839774	1730839774	0	0	66270a91f07dc120b3a93da1ef1078e5	27	
271	2	appdata_oct85qsb3cn1/preview/3	a942182896b22d271d61ee596a004551	73	3	2	1	-1	1730839792	1730839792	0	0	672a84f04b37c	31	
272	2	appdata_oct85qsb3cn1/preview/3/9	d336fb0a806b241ddbbf22f30a6033bf	271	9	2	1	-1	1730839792	1730839792	0	0	672a84f04b120	31	
273	2	appdata_oct85qsb3cn1/preview/3/9/0	e8d418dc43e54c7ddbfa95b7c7e3b717	272	0	2	1	-1	1730839792	1730839792	0	0	672a84f04aea5	31	
274	2	appdata_oct85qsb3cn1/preview/3/9/0/5	e3cafbb4d1bef22e1ec03801573568d0	273	5	2	1	-1	1730839792	1730839792	0	0	672a84f04ac3a	31	
275	2	appdata_oct85qsb3cn1/preview/3/9/0/5/9	b73f84b56db95fd9fbd346df4e95b713	274	9	2	1	-1	1730839792	1730839792	0	0	672a84f04aa03	31	
276	2	appdata_oct85qsb3cn1/preview/3/9/0/5/9/7	ccbdaa65f8f313b167f3f6c7bea6e629	275	7	2	1	-1	1730839792	1730839792	0	0	672a84f04a759	31	
257	2	appdata_oct85qsb3cn1/preview/0/7/7/e/2/9/b/249	7c14c32c88000bbe50c00bb4fc7c4fcd	256	249	2	1	0	1730839882	1730839882	0	0	672a84d16df43	31	
267	2	appdata_oct85qsb3cn1/preview/a/4/f/2/3/6/7/260	79d5974474310e86c4bc610859a90b70	266	260	2	1	0	1730839882	1730839882	0	0	672a84de53299	31	
270	1	files_trashbin/files/22a1d1ee-460d-4cb8-93c2-b84b3f79b9d3.jpg.d1730839908	1d403094acef326b6b645c1fdf16d0ed	324	22a1d1ee-460d-4cb8-93c2-b84b3f79b9d3.jpg.d1730839908	6	5	695414	1728924608	1728924608	0	0	42a1bb6d3a8ec151a9f30cbaf20f4203	27	
277	2	appdata_oct85qsb3cn1/preview/3/9/0/5/9/7/2	74b13a7d299e685ca7203760c9544288	276	2	2	1	-1	1730839792	1730839792	0	0	672a84f04a43a	31	
368	2	appdata_oct85qsb3cn1/preview/0/5	0c7c44b1f6b158d0d1ae4be9579f2a2a	250	5	2	1	-1	1730840048	1730840048	0	0	672a85f009ad4	31	
279	2	appdata_oct85qsb3cn1/preview/3/9/0/5/9/7/2/270/4096-2731-max.jpg	417b3b089080b758cb1704690cb219f7	278	4096-2731-max.jpg	6	5	735028	1730839792	1730839792	0	0	6f19ee12bf43f117f12877ff87bddb98	27	
280	2	appdata_oct85qsb3cn1/preview/3/9/0/5/9/7/2/270/64-64-crop.jpg	4513d3d305f79809d211e5995b7ab9e0	278	64-64-crop.jpg	6	5	1767	1730839792	1730839792	0	0	89cca235712ba5cc41b07747261dc5eb	27	
281	1	files/Photos/71371e82-e096-4916-acf5-680ab3bf84d5.jpg	13314cf1bf431a127449858e2da1cd6e	4	71371e82-e096-4916-acf5-680ab3bf84d5.jpg	6	5	941112	1728924606	1728924606	0	0	7c90f53eec20ed7941ed98a3f2e6676f	27	
282	2	appdata_oct85qsb3cn1/preview/e/3	3c110f803eb5ce9b6ce6ed5e20865b2a	171	3	2	1	-1	1730839815	1730839815	0	0	672a850734da6	31	
283	2	appdata_oct85qsb3cn1/preview/e/3/7	4781149606b3f68d345fa6ad9d93109a	282	7	2	1	-1	1730839815	1730839815	0	0	672a850734b6d	31	
284	2	appdata_oct85qsb3cn1/preview/e/3/7/9	51a697b1b3453c0d6da124201a825508	283	9	2	1	-1	1730839815	1730839815	0	0	672a8507348f5	31	
285	2	appdata_oct85qsb3cn1/preview/e/3/7/9/6	8902e9ff23af9dd85600eedb775112fe	284	6	2	1	-1	1730839815	1730839815	0	0	672a85073465b	31	
286	2	appdata_oct85qsb3cn1/preview/e/3/7/9/6/a	f623452895ca8b4da703be44ccc5fc13	285	a	2	1	-1	1730839815	1730839815	0	0	672a8507343c2	31	
287	2	appdata_oct85qsb3cn1/preview/e/3/7/9/6/a/e	9651dea3cfffcf7d5e37f8ce8327b67d	286	e	2	1	-1	1730839815	1730839815	0	0	672a85073407d	31	
289	2	appdata_oct85qsb3cn1/preview/e/3/7/9/6/a/e/281/2688-4032-max.jpg	71fcf3f75395912ab87ecd8c5cf174a7	288	2688-4032-max.jpg	6	5	963557	1730839815	1730839815	0	0	884deb8ab7480494461fd3c227fbbd71	27	
290	2	appdata_oct85qsb3cn1/preview/e/3/7/9/6/a/e/281/64-64-crop.jpg	c8d45b96ed3d6d056d2fa81ea0850cf1	288	64-64-crop.jpg	6	5	1900	1730839815	1730839815	0	0	f91d91a87322fb2959a8f8c68b8ad9e4	27	
292	2	appdata_oct85qsb3cn1/preview/9/c	eb61d15fa3a82919155a82682134814c	147	c	2	1	-1	1730839873	1730839873	0	0	672a8541a8293	31	
293	2	appdata_oct85qsb3cn1/preview/9/c/8	f0a0c1f6a32f49eab26a220450fcbe97	292	8	2	1	-1	1730839873	1730839873	0	0	672a8541a8049	31	
294	2	appdata_oct85qsb3cn1/preview/9/c/8/3	0bad2d940cb4b6a5254a19efc5d5b4c8	293	3	2	1	-1	1730839873	1730839873	0	0	672a8541a7e14	31	
295	2	appdata_oct85qsb3cn1/preview/9/c/8/3/8	56e90ac47c355ca35a5af68f07412114	294	8	2	1	-1	1730839873	1730839873	0	0	672a8541a7bcf	31	
296	2	appdata_oct85qsb3cn1/preview/9/c/8/3/8/d	f2f4da787492834a6798707d1815a386	295	d	2	1	-1	1730839873	1730839873	0	0	672a8541a7957	31	
297	2	appdata_oct85qsb3cn1/preview/9/c/8/3/8/d/2	0e9d08dab2ebb826b4b035f9c26d6173	296	2	2	1	-1	1730839873	1730839873	0	0	672a8541a7667	31	
299	2	appdata_oct85qsb3cn1/preview/9/c/8/3/8/d/2/291/853-1280-max.jpg	79066ecbed01f918680fe6841402c9cb	298	853-1280-max.jpg	6	5	98773	1730839873	1730839873	0	0	9e4bdf1289ef5b48b50ff621a16e7b20	27	
300	2	appdata_oct85qsb3cn1/preview/9/c/8/3/8/d/2/291/64-64-crop.jpg	096460db8fa7f75ce5cd23a76985bbd5	298	64-64-crop.jpg	6	5	1893	1730839873	1730839873	0	0	8af90bd72a7305185dc31a0426b21d1e	27	
301	1	files/Photos/2024-10-22 10.24.59.jpg	8e31923ecbb65502f25a605ca1699965	4	2024-10-22 10.24.59.jpg	6	5	190760	1729581896	1729581896	0	0	06685de8c0718854985cb18186b084bb	27	
302	2	appdata_oct85qsb3cn1/preview/3/4	9709c52a586c4e8100194d35e2a25caf	271	4	2	1	-1	1730839876	1730839876	0	0	672a8544edb02	31	
303	2	appdata_oct85qsb3cn1/preview/3/4/e	37e8e5f80f1fc1d7b65b867c4e0dfddc	302	e	2	1	-1	1730839876	1730839876	0	0	672a8544ed848	31	
304	2	appdata_oct85qsb3cn1/preview/3/4/e/d	8b3b2d75ca6d4f96c87c9ac091b32b2b	303	d	2	1	-1	1730839876	1730839876	0	0	672a8544ed5f4	31	
305	2	appdata_oct85qsb3cn1/preview/3/4/e/d/0	bde8cf9a80387a9e1a46ba1be3c873b3	304	0	2	1	-1	1730839876	1730839876	0	0	672a8544ed395	31	
306	2	appdata_oct85qsb3cn1/preview/3/4/e/d/0/6	d3e9696829e8f6c6b2fc741f1a1fc1a8	305	6	2	1	-1	1730839876	1730839876	0	0	672a8544ed112	31	
307	2	appdata_oct85qsb3cn1/preview/3/4/e/d/0/6/6	1d68bc8c8ba1ec4ac73223a6d83fb09b	306	6	2	1	-1	1730839876	1730839876	0	0	672a8544ece86	31	
309	2	appdata_oct85qsb3cn1/preview/3/4/e/d/0/6/6/301/853-1280-max.jpg	8083ab3e12b799031031d89df9189c0b	308	853-1280-max.jpg	6	5	166648	1730839877	1730839877	0	0	b5f79955214d1e9a2f713f4ce35c639f	27	
310	2	appdata_oct85qsb3cn1/preview/3/4/e/d/0/6/6/301/64-64-crop.jpg	ac3b2e979049be5b9d528099586d3474	308	64-64-crop.jpg	6	5	2327	1730839877	1730839877	0	0	bbca65d43c184686fa5b0731f2809a9d	27	
298	2	appdata_oct85qsb3cn1/preview/9/c/8/3/8/d/2/291	413ede12e246d75794716d8476379ed9	297	291	2	1	0	1730839881	1730839881	0	0	672a8541a72bd	31	
278	2	appdata_oct85qsb3cn1/preview/3/9/0/5/9/7/2/270	52bd9abb34dbfdcb2c12c154c76dd8e8	277	270	2	1	0	1730839882	1730839882	0	0	672a84f04a020	31	
288	2	appdata_oct85qsb3cn1/preview/e/3/7/9/6/a/e/281	dc6c956283aebf1f811e007503854283	287	281	2	1	0	1730839882	1730839882	0	0	672a850733c33	31	
291	1	files_trashbin/files/2024-10-22 10.24.36.jpg.d1730839898	da1a0dbb930db9899a2187f1693da023	324	2024-10-22 10.24.36.jpg.d1730839898	6	5	91445	1729581876	1729581876	0	0	5d8d0d9deb0104079a1fc66c239e0a55	27	
311	2	appdata_oct85qsb3cn1/preview/3/4/e/d/0/6/6/301/43-64.jpg	84ce2589c1f5febccddc98cc73b1303a	308	43-64.jpg	6	5	1764	1730839881	1730839881	0	0	7104c6d480ace3adcf30dec8e7858b4e	27	
308	2	appdata_oct85qsb3cn1/preview/3/4/e/d/0/6/6/301	4e0a14165c890253944339832f75e389	307	301	2	1	0	1730839881	1730839881	0	0	672a8544eca11	31	
312	2	appdata_oct85qsb3cn1/preview/9/c/8/3/8/d/2/291/43-64.jpg	898c9a093384030b7c0df5748badc3ff	298	43-64.jpg	6	5	1553	1730839881	1730839881	0	0	18ba2b2a99a36b26d3f143b53f0a0846	27	
313	2	appdata_oct85qsb3cn1/preview/3/4/e/d/0/6/6/301/682-1024.jpg	787e079341447fbf91bd648809fc5794	308	682-1024.jpg	6	5	106835	1730839881	1730839881	0	0	f9fa7e9e116c689e4fce99ef4b2c99b2	27	
314	2	appdata_oct85qsb3cn1/preview/9/c/8/3/8/d/2/291/682-1024.jpg	bcb94d36b595e3366a9a72f04ccd3914	298	682-1024.jpg	6	5	72370	1730839881	1730839881	0	0	25f044e9f983bfed8ba00fa80861c9e7	27	
315	2	appdata_oct85qsb3cn1/preview/0/7/7/e/2/9/b/249/64-43.jpg	bf99c0c22a70a323f7a7690c06596ff5	257	64-43.jpg	6	5	1666	1730839881	1730839881	0	0	1e5f4f735a10e3274b5ff4157f494fbd	27	
316	2	appdata_oct85qsb3cn1/preview/0/7/7/e/2/9/b/249/1024-683.jpg	068159887721f45c2d7b924139d26708	257	1024-683.jpg	6	5	82447	1730839882	1730839882	0	0	38e269e218b0a07cfbf991c1a56555b4	27	
317	2	appdata_oct85qsb3cn1/preview/3/9/0/5/9/7/2/270/64-43.jpg	44e5cacafcff8764cceec9239cdbbf12	278	64-43.jpg	6	5	1436	1730839882	1730839882	0	0	b3de5ee87dd5259d0894544f68b444ce	27	
318	2	appdata_oct85qsb3cn1/preview/3/9/0/5/9/7/2/270/1024-683.jpg	b14b1ee6478b6852cf77d90d7f108bbe	278	1024-683.jpg	6	5	78566	1730839882	1730839882	0	0	3fc93243365d01709d828f9350391bec	27	
319	2	appdata_oct85qsb3cn1/preview/a/4/f/2/3/6/7/260/1024-683.jpg	f53e121518ba1b61e4e114f8be98ab43	267	1024-683.jpg	6	5	82241	1730839882	1730839882	0	0	522ab3fe8900140f3e1682315b321735	27	
320	2	appdata_oct85qsb3cn1/preview/a/4/f/2/3/6/7/260/64-43.jpg	13f86cb3364afef09a9baa96b1fdb1cf	267	64-43.jpg	6	5	1486	1730839882	1730839882	0	0	c41a7211d7a215e209046d44ab997acc	27	
321	2	appdata_oct85qsb3cn1/preview/e/3/7/9/6/a/e/281/43-64.jpg	f672ecdc2cc82d1b0572298bc671def6	288	43-64.jpg	6	5	1555	1730839882	1730839882	0	0	398e727b5a94aa6ac0c35a47dce00a4f	27	
322	2	appdata_oct85qsb3cn1/preview/e/3/7/9/6/a/e/281/683-1024.jpg	2bc5587db38d5f5aa18f94b099ca9e76	288	683-1024.jpg	6	5	76190	1730839882	1730839882	0	0	4043e418a3a55699cd75e5f7b7981556	27	
339	2	appdata_oct85qsb3cn1/preview/8/1	00ec76b3a33d1b1800a1bdecbe5147ff	108	1	2	1	-1	1730840010	1730840010	0	0	672a87656c22d	31	
327	1	files/Photos/58add1a6-3046-4783-a9f2-3224facb28c7.jpg	1ffe3c87650fea18a1adbfe95c33b18b	4	58add1a6-3046-4783-a9f2-3224facb28c7.jpg	6	5	591805	1728924610	1728924610	0	0	846db9de0fc870288ac2124dbc3d6247	27	
325	1	files_trashbin/versions	c639d144d3f1014051e14a98beac5705	323	versions	2	1	0	1730839898	1730839898	0	0	672a855ab1216	31	
328	2	appdata_oct85qsb3cn1/preview/b	f938e6022da4fe68bcafe335bb06fb06	73	b	2	1	-1	1730839972	1730839972	0	0	672a85a4871db	31	
326	1	files_trashbin/keys	9195c7cfc1b867f229ac78cc1b6a0be3	323	keys	2	1	0	1730839898	1730839898	0	0	672a855ab1f9b	31	
329	2	appdata_oct85qsb3cn1/preview/b/8	5128a63e066324bc700a1cccaac66b6c	328	8	2	1	-1	1730839972	1730839972	0	0	672a85a487003	31	
330	2	appdata_oct85qsb3cn1/preview/b/8/3	4fc9eeef7fc6d2fe19a2b841a7dd5243	329	3	2	1	-1	1730839972	1730839972	0	0	672a85a486dec	31	
331	2	appdata_oct85qsb3cn1/preview/b/8/3/a	bcad4b5e9eca9cba0c4b1c63d467f386	330	a	2	1	-1	1730839972	1730839972	0	0	672a85a486bd5	31	
324	1	files_trashbin/files	3014a771cbe30761f2e9ff3272110dbf	323	files	2	1	786859	1730839908	1730839898	0	0	672a85649846d	31	
323	1	files_trashbin	fb66dca5f27af6f15c1d1d81e6f8d28b	1	files_trashbin	2	1	786859	1730839908	1730839898	0	0	672a85649846d	31	
332	2	appdata_oct85qsb3cn1/preview/b/8/3/a/a	8cfe68a2330b23d79d2e4d9d925099b8	331	a	2	1	-1	1730839972	1730839972	0	0	672a85a48699a	31	
333	2	appdata_oct85qsb3cn1/preview/b/8/3/a/a/c	f4327f398114c7aae6ae63d54d9b1e9b	332	c	2	1	-1	1730839972	1730839972	0	0	672a85a486762	31	
334	2	appdata_oct85qsb3cn1/preview/b/8/3/a/a/c/2	9fd82c415a0f400c9d0a84bca532458e	333	2	2	1	-1	1730839972	1730839972	0	0	672a85a4864b7	31	
336	2	appdata_oct85qsb3cn1/preview/b/8/3/a/a/c/2/327/2016-3024-max.jpg	c4bc570e1ea7912442d44cdc3ae49d7c	335	2016-3024-max.jpg	6	5	623271	1730839972	1730839972	0	0	c089f8bf3f3ca7646cf2fa5a9b81d665	27	
337	2	appdata_oct85qsb3cn1/preview/b/8/3/a/a/c/2/327/64-64-crop.jpg	ccf1734e04375d617733c466739d375a	335	64-64-crop.jpg	6	5	2188	1730839972	1730839972	0	0	402ac329a7f392ae470b1966738fd532	27	
338	1	files/Photos/minsk_halfmarathon2024-20240908132015-f0fb1b04cacd.jpg	c5253cacd8dfe72757e701a9165c5b61	4	minsk_halfmarathon2024-20240908132015-f0fb1b04cacd.jpg	6	5	1597551	1728295916	1728295916	0	0	6985f9c93b56f31955dcca57d787da34	27	
340	2	appdata_oct85qsb3cn1/preview/8/1/9	e18780c04a9f39ded12a5125ea51bb53	339	9	2	1	-1	1730840010	1730840010	0	0	672a85cacbc7b	31	
341	2	appdata_oct85qsb3cn1/preview/8/1/9/f	ad938d84689d96f05c7b1bbba1c4d705	340	f	2	1	-1	1730840010	1730840010	0	0	672a85cacb99c	31	
342	2	appdata_oct85qsb3cn1/preview/8/1/9/f/4	985dfcc30926556a286ed0933624a27e	341	4	2	1	-1	1730840010	1730840010	0	0	672a85cacb6dd	31	
343	2	appdata_oct85qsb3cn1/preview/8/1/9/f/4/6	c46ad4488497e3ee50cada3dabdf5651	342	6	2	1	-1	1730840010	1730840010	0	0	672a85cacb40a	31	
344	2	appdata_oct85qsb3cn1/preview/8/1/9/f/4/6/e	cb3f679fa8c428743b741e7a4010d770	343	e	2	1	-1	1730840010	1730840010	0	0	672a85cacb107	31	
369	2	appdata_oct85qsb3cn1/preview/0/5/0	44dd5bac652beaea323ae4bdcecbf0d6	368	0	2	1	-1	1730840048	1730840048	0	0	672a85f00990f	31	
370	2	appdata_oct85qsb3cn1/preview/0/5/0/4	fa185d3738a79118702b0b9cfdb173b5	369	4	2	1	-1	1730840048	1730840048	0	0	672a85f009740	31	
346	2	appdata_oct85qsb3cn1/preview/8/1/9/f/4/6/e/338/1999-3000-max.jpg	66c84f9eefe18664604de7210e5b6485	345	1999-3000-max.jpg	6	5	628131	1730840010	1730840010	0	0	bdc149ac4af370f03f559f2f72f3200b	27	
347	2	appdata_oct85qsb3cn1/preview/8/1/9/f/4/6/e/338/64-64-crop.jpg	d56f03483fd58fcefe7fc1423be4bdd5	345	64-64-crop.jpg	6	5	2225	1730840011	1730840011	0	0	e8f3a06958b6a217d0ba5d5cf74a560b	27	
371	2	appdata_oct85qsb3cn1/preview/0/5/0/4/9	21f5e9548675a8a9b98eae929cabb834	370	9	2	1	-1	1730840048	1730840048	0	0	672a85f009566	31	
372	2	appdata_oct85qsb3cn1/preview/0/5/0/4/9/e	4b5d5ba02d7b99f279d2677f05aeaca5	371	e	2	1	-1	1730840048	1730840048	0	0	672a85f009308	31	
373	2	appdata_oct85qsb3cn1/preview/0/5/0/4/9/e/9	4e6edc19309b59ea1b4bebd50010b2d2	372	9	2	1	-1	1730840048	1730840048	0	0	672a85f008f5c	31	
375	2	appdata_oct85qsb3cn1/preview/0/5/0/4/9/e/9/367/2000-3000-max.jpg	4ba6963b9ac819412af54273a26709d4	374	2000-3000-max.jpg	6	5	425834	1730840048	1730840048	0	0	49a897f6b332bcf891555dab107eb418	27	
376	2	appdata_oct85qsb3cn1/preview/0/5/0/4/9/e/9/367/64-64-crop.jpg	4f725de16dba6882afaf51620def7ac1	374	64-64-crop.jpg	6	5	2035	1730840048	1730840048	0	0	ca459bece2971a2ddcc6d44e806f5b9d	27	
381	2	appdata_oct85qsb3cn1/preview/0/1/3/8/6/b/d/348/64-43.jpg	3385fe5059e67ae6d15dc80af1a091f9	355	64-43.jpg	6	5	1707	1730840050	1730840050	0	0	6197d3330142169e7c560255c2cbf632	27	
374	2	appdata_oct85qsb3cn1/preview/0/5/0/4/9/e/9/367	5ed07e7ddd7a2e0b704b1fdac6f25241	373	367	2	1	0	1730840050	1730840050	0	0	672a85f008a6b	31	
345	2	appdata_oct85qsb3cn1/preview/8/1/9/f/4/6/e/338	3452a6a8631a4d5fa81912dc4e9ab17d	344	338	2	1	0	1730840051	1730840051	0	0	672a85cacacf9	31	
402	2	appdata_oct85qsb3cn1/preview/7/0/c/6/3/9/d/393/2000-3000-max.jpg	9c5adaedd554e89a17be89ceb29a35b7	401	2000-3000-max.jpg	6	5	655363	1730840091	1730840091	0	0	e9431f43affb7dfc8b58298a8bb6bdd5	27	
403	2	appdata_oct85qsb3cn1/preview/7/0/c/6/3/9/d/393/64-64-crop.jpg	7cd8edc8ef9e459e900739c00a49d8f7	401	64-64-crop.jpg	6	5	2369	1730840091	1730840091	0	0	5659d642af327cb6687c52b94e8c4281	27	
390	2	appdata_oct85qsb3cn1/preview/e/4/d/a/3/b/7/5/1024-683.jpg	0abdcb6854692cd68e7940c6359d835b	223	1024-683.jpg	6	5	84185	1730840052	1730840052	0	0	e5851f626b7abce166175ea36d458c97	27	
415	2	appdata_oct85qsb3cn1/preview/6/6	1720daf6c9c30bbd98d47792e670c4c0	74	6	2	1	-1	1730840224	1730840224	0	0	672a876b41114	31	
395	2	appdata_oct85qsb3cn1/preview/7/0	37256d6642c0f5cab880a784d1364f2b	394	0	2	1	-1	1730840091	1730840091	0	0	672a861b7ddc6	31	
396	2	appdata_oct85qsb3cn1/preview/7/0/c	30c006b49d72dbcccbf1c7d3d96d8db2	395	c	2	1	-1	1730840091	1730840091	0	0	672a861b7db3f	31	
397	2	appdata_oct85qsb3cn1/preview/7/0/c/6	8cf6e6cfffa210a3fff69aa98523bbaf	396	6	2	1	-1	1730840091	1730840091	0	0	672a861b7d8c6	31	
398	2	appdata_oct85qsb3cn1/preview/7/0/c/6/3	fda76606560f801ca21935c6bb195fed	397	3	2	1	-1	1730840091	1730840091	0	0	672a861b7d62b	31	
399	2	appdata_oct85qsb3cn1/preview/7/0/c/6/3/9	56c883a802600e66c568efed45d83219	398	9	2	1	-1	1730840091	1730840091	0	0	672a861b7d392	31	
400	2	appdata_oct85qsb3cn1/preview/7/0/c/6/3/9/d	0bd2ddbdcd5e53adb74a80eafafa7bdd	399	d	2	1	-1	1730840091	1730840091	0	0	672a861b7d0bb	31	
416	2	appdata_oct85qsb3cn1/preview/6/6/8	dc90f0bffb587e55266eb6c8e8c9315e	415	8	2	1	-1	1730840224	1730840224	0	0	672a86a03fef5	31	
417	2	appdata_oct85qsb3cn1/preview/6/6/8/0	c5c0a0f45c9042f5db02ea07fb95b416	416	0	2	1	-1	1730840224	1730840224	0	0	672a86a03fd02	31	
418	2	appdata_oct85qsb3cn1/preview/6/6/8/0/8	640ebc01c54dcc0db9e33e53c6a025e3	417	8	2	1	-1	1730840224	1730840224	0	0	672a86a03fb02	31	
419	2	appdata_oct85qsb3cn1/preview/6/6/8/0/8/e	1e6c073c723d8b93f0fe2c62614544cc	418	e	2	1	-1	1730840224	1730840224	0	0	672a86a03f8ef	31	
420	2	appdata_oct85qsb3cn1/preview/6/6/8/0/8/e/3	87d43a7d2f802a00f4909d0231b236b8	419	3	2	1	-1	1730840224	1730840224	0	0	672a86a03f64a	31	
422	2	appdata_oct85qsb3cn1/preview/6/6/8/0/8/e/3/414/1280-853-max.jpg	defe7f8b9acde31ddb1c8a07142f18ae	421	1280-853-max.jpg	6	5	158719	1730840224	1730840224	0	0	6e2a2d19d385f3df68a007cc8ebfa203	27	
401	2	appdata_oct85qsb3cn1/preview/7/0/c/6/3/9/d/393	bd83c102b893462583edc559cbddadc1	400	393	2	1	0	1730840228	1730840228	0	0	672a861b7cc57	31	
421	2	appdata_oct85qsb3cn1/preview/6/6/8/0/8/e/3/414	e46a639f19361744239afa11a5a24f60	420	414	2	1	0	1730840228	1730840228	0	0	672a86a03f2e6	31	
\.


--
-- Data for Name: oc_filecache_extended; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_filecache_extended (fileid, metadata_etag, creation_time, upload_time) FROM stdin;
249	\N	0	1730839761
260	\N	0	1730839774
270	\N	0	1730839791
281	\N	0	1730839814
291	\N	0	1730839873
301	\N	0	1730839876
327	\N	0	1730839972
338	\N	0	1730840010
348	\N	0	1730840017
358	\N	0	1730840032
367	\N	0	1730840047
393	\N	0	1730840091
404	\N	0	1730840220
414	\N	0	1730840224
\.


--
-- Data for Name: oc_files_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_files_metadata (id, file_id, json, sync_token, last_update) FROM stdin;
1	3	{"photos-original_date_time":{"value":1730839633,"type":"int","etag":"","indexed":true,"editPermission":0}}	gstSw4g	2024-11-05 23:47:13
2	5	{"photos-original_date_time":{"value":1341059531,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":{"ExposureTime":"1\\/125","FNumber":"28\\/5","ExposureProgram":3,"ISOSpeedRatings":320,"UndefinedTag__x____":320,"ExifVersion":"0230","DateTimeOriginal":"2012:06:30 12:32:11","DateTimeDigitized":"2012:06:30 12:32:11","ComponentsConfiguration":"","ShutterSpeedValue":"7\\/1","ApertureValue":"5\\/1","ExposureBiasValue":"0\\/1","MaxApertureValue":"189284\\/33461","MeteringMode":5,"Flash":16,"FocalLength":"280\\/1","SubSecTime":"83","SubSecTimeOriginal":"83","SubSecTimeDigitized":"83","FlashPixVersion":"0100","ColorSpace":1,"ExifImageWidth":1600,"ExifImageLength":1067,"FocalPlaneXResolution":"1920000\\/487","FocalPlaneYResolution":"320000\\/81","FocalPlaneResolutionUnit":2,"CustomRendered":0,"ExposureMode":0,"WhiteBalance":0,"SceneCaptureType":0,"UndefinedTag__xA___":"0000000000"},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":{"Make":"Canon","Model":"Canon EOS 5D Mark III","Orientation":1,"XResolution":"72\\/1","YResolution":"72\\/1","ResolutionUnit":2,"DateTime":"2012:06:30 12:32:11","Exif_IFD_Pointer":174},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":{"width":1600,"height":1067},"type":"array","etag":"","indexed":false,"editPermission":0}}	sdY2iKH	2024-11-05 23:47:13
3	6	{"photos-original_date_time":{"value":1444907264,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":{"ExposureTime":"1\\/320","FNumber":"4\\/1","ExposureProgram":3,"ISOSpeedRatings":640,"UndefinedTag__x____":640,"ExifVersion":"0230","DateTimeOriginal":"2015:10:15 11:07:44","DateTimeDigitized":"2015:10:15 11:07:44","ShutterSpeedValue":"27970\\/3361","ApertureValue":"4\\/1","ExposureBiasValue":"1\\/3","MaxApertureValue":"4\\/1","MeteringMode":5,"Flash":16,"FocalLength":"200\\/1","SubSecTimeOriginal":"63","SubSecTimeDigitized":"63","ColorSpace":1,"ExifImageWidth":1600,"ExifImageLength":1067,"FocalPlaneXResolution":"1600\\/1","FocalPlaneYResolution":"1600\\/1","FocalPlaneResolutionUnit":3,"CustomRendered":0,"ExposureMode":0,"WhiteBalance":0,"SceneCaptureType":0,"UndefinedTag__xA___":"000084121f"},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":{"Make":"Canon","Model":"Canon EOS 5D Mark III","Orientation":1,"XResolution":"240\\/1","YResolution":"240\\/1","ResolutionUnit":2,"Software":"Adobe Photoshop Lightroom 6.2.1 (Macintosh)","DateTime":"2015:10:16 14:40:21","Exif_IFD_Pointer":230},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":{"width":1600,"height":1067},"type":"array","etag":"","indexed":false,"editPermission":0}}	OOORfVW	2024-11-05 23:47:13
4	7	{"photos-original_date_time":{"value":1341258636,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":{"ExposureTime":"1\\/80","FNumber":"4\\/1","ExposureProgram":3,"ISOSpeedRatings":400,"ExifVersion":"0230","DateTimeOriginal":"2012:07:02 19:50:36","DateTimeDigitized":"2012:07:02 19:50:36","ComponentsConfiguration":"","ShutterSpeedValue":"51\\/8","ApertureValue":"4\\/1","ExposureBiasValue":"0\\/1","MaxApertureValue":"4\\/1","MeteringMode":5,"Flash":16,"FocalLength":"32\\/1","SubSecTime":"00","SubSecTimeOriginal":"00","SubSecTimeDigitized":"00","FlashPixVersion":"0100","ColorSpace":1,"ExifImageWidth":1600,"ExifImageLength":1066,"FocalPlaneXResolution":"382423\\/97","FocalPlaneYResolution":"185679\\/47","FocalPlaneResolutionUnit":2,"CustomRendered":0,"ExposureMode":0,"WhiteBalance":0,"SceneCaptureType":0},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":{"Make":"Canon","Model":"Canon EOS 5D Mark III","Orientation":1,"XResolution":"72\\/1","YResolution":"72\\/1","ResolutionUnit":2,"Software":"GIMP 2.8.0","DateTime":"2012:07:02 22:06:14","Exif_IFD_Pointer":198},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":{"width":1600,"height":1066},"type":"array","etag":"","indexed":false,"editPermission":0}}	eMRkM7P	2024-11-05 23:47:14
5	8	{"photos-original_date_time":{"value":1341072915,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":{"ExposureTime":"1\\/500","FNumber":"28\\/5","ExposureProgram":1,"ISOSpeedRatings":8000,"ExifVersion":"0230","DateTimeOriginal":"2012:06:30 16:15:15","DateTimeDigitized":"2012:06:30 16:15:15","ComponentsConfiguration":"","ShutterSpeedValue":"9\\/1","ApertureValue":"5\\/1","ExposureBiasValue":"0\\/1","MaxApertureValue":"6149\\/1087","MeteringMode":5,"Flash":16,"FocalLength":"280\\/1","SubSecTime":"00","SubSecTimeOriginal":"00","SubSecTimeDigitized":"00","FlashPixVersion":"0100","ColorSpace":1,"ExifImageWidth":1600,"ExifImageLength":1067,"FocalPlaneXResolution":"382423\\/97","FocalPlaneYResolution":"134321\\/34","FocalPlaneResolutionUnit":2,"CustomRendered":0,"ExposureMode":1,"WhiteBalance":0,"SceneCaptureType":0},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":{"Make":"Canon","Model":"Canon EOS 5D Mark III","Orientation":1,"XResolution":"72\\/1","YResolution":"72\\/1","ResolutionUnit":2,"Software":"Aperture 3.3.1","DateTime":"2012:06:30 16:15:15","Exif_IFD_Pointer":202},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":{"width":1600,"height":1067},"type":"array","etag":"","indexed":false,"editPermission":0}}	Duu5KQR	2024-11-05 23:47:14
22	393	{"photos-size":{"value":{"width":2000,"height":3000},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-original_date_time":{"value":1728295918,"type":"int","etag":"","indexed":true,"editPermission":0}}	WSlrgyw	2024-11-05 23:54:51
23	404	{"photos-size":{"value":{"width":3936,"height":2624},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-original_date_time":{"value":1721723704,"type":"int","etag":"","indexed":true,"editPermission":0}}	IUW8qpH	2024-11-05 23:57:01
24	414	{"photos-size":{"value":{"width":1280,"height":853},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-original_date_time":{"value":1721723805,"type":"int","etag":"","indexed":true,"editPermission":0}}	43uWWfI	2024-11-05 23:57:04
6	9	{"photos-original_date_time":{"value":1526500980,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":{"ExposureTime":"10\\/12500","FNumber":"35\\/10","ExposureProgram":3,"ISOSpeedRatings":100,"DateTimeOriginal":"2018:05:16 20:03:00","DateTimeDigitized":"2018:05:16 20:03:00","ExposureBiasValue":"0\\/6","MaxApertureValue":"30\\/10","MeteringMode":5,"LightSource":0,"Flash":16,"FocalLength":"700\\/10","MakerNote":"Nikon","UserComment":"Christoph WurstCC-SA 4.0","SubSecTime":"30","SubSecTimeOriginal":"30","SubSecTimeDigitized":"30","ColorSpace":1,"SensingMethod":2,"FileSource":"","SceneType":"","CustomRendered":0,"ExposureMode":0,"WhiteBalance":0,"DigitalZoomRatio":"1\\/1","FocalLengthIn__mmFilm":70,"SceneCaptureType":0,"GainControl":0,"Contrast":1,"Saturation":0,"Sharpness":1,"SubjectDistanceRange":0},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":{"ImageDescription":"Christoph WurstCC-SA 4.0","Make":"NIKON CORPORATION","Model":"NIKON D610","Orientation":1,"XResolution":"72\\/1","YResolution":"72\\/1","ResolutionUnit":2,"Software":"GIMP 2.10.14","DateTime":"2019:12:10 08:51:16","Artist":"Christoph Wurst                     ","Copyright":"Christoph Wurst                                       ","Exif_IFD_Pointer":402,"GPS_IFD_Pointer":13738,"DateTimeOriginal":"2018:05:16 20:03:00"},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":{"width":1920,"height":1281},"type":"array","etag":"","indexed":false,"editPermission":0}}	cAqXE2J	2024-11-05 23:47:14
7	10	{"photos-original_date_time":{"value":1341064060,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":{"ExposureTime":"1\\/640","FNumber":"28\\/5","ExposureProgram":1,"ISOSpeedRatings":12800,"ExifVersion":"0230","DateTimeOriginal":"2012:06:30 13:47:40","DateTimeDigitized":"2012:06:30 13:47:40","ComponentsConfiguration":"","ShutterSpeedValue":"75\\/8","ApertureValue":"5\\/1","ExposureBiasValue":"0\\/1","MaxApertureValue":"6149\\/1087","MeteringMode":5,"Flash":16,"FocalLength":"235\\/1","SubSecTime":"00","SubSecTimeOriginal":"00","SubSecTimeDigitized":"00","FlashPixVersion":"0100","ExifImageWidth":1600,"ExifImageLength":1067,"FocalPlaneXResolution":"382423\\/97","FocalPlaneYResolution":"134321\\/34","FocalPlaneResolutionUnit":2,"CustomRendered":0,"ExposureMode":1,"WhiteBalance":0,"SceneCaptureType":0},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":{"Make":"Canon","Model":"Canon EOS 5D Mark III","Orientation":1,"XResolution":"72\\/1","YResolution":"72\\/1","ResolutionUnit":2,"Software":"Aperture 3.3.1","DateTime":"2012:06:30 13:47:40","Exif_IFD_Pointer":202},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":{"width":1600,"height":1067},"type":"array","etag":"","indexed":false,"editPermission":0}}	FjIdMHz	2024-11-05 23:47:14
8	11	{"photos-original_date_time":{"value":1730839633,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-size":{"value":{"width":3000,"height":2000},"type":"array","etag":"","indexed":false,"editPermission":0}}	Enm4lsV	2024-11-05 23:47:14
9	13	{"photos-original_date_time":{"value":1372319469,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-exif":{"value":{"ExposureTime":"1\\/160","FNumber":"4\\/1","ExposureProgram":3,"ISOSpeedRatings":100,"ExifVersion":"0230","DateTimeOriginal":"2013:06:27 07:51:09","DateTimeDigitized":"2013:06:27 07:51:09","ComponentsConfiguration":"","ShutterSpeedValue":"59\\/8","ApertureValue":"4\\/1","ExposureBiasValue":"2\\/3","MaxApertureValue":"4\\/1","MeteringMode":5,"Flash":16,"FocalLength":"45\\/1","SubSecTime":"00","SubSecTimeOriginal":"00","SubSecTimeDigitized":"00","FlashPixVersion":"0100","ColorSpace":1,"ExifImageWidth":1200,"ExifImageLength":1800,"FocalPlaneXResolution":"382423\\/97","FocalPlaneYResolution":"185679\\/47","FocalPlaneResolutionUnit":2,"CustomRendered":0,"ExposureMode":0,"WhiteBalance":0,"SceneCaptureType":0,"UndefinedTag__xA___":"000052602c"},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-ifd0":{"value":{"Make":"Canon","Model":"Canon EOS 5D Mark III","Orientation":1,"XResolution":"72\\/1","YResolution":"72\\/1","ResolutionUnit":2,"Software":"Aperture 3.4.5","DateTime":"2013:06:27 07:51:09","Exif_IFD_Pointer":202},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-size":{"value":{"width":1200,"height":1800},"type":"array","etag":"","indexed":false,"editPermission":0}}	38NIRFp	2024-11-05 23:47:14
10	16	{"photos-original_date_time":{"value":1730839634,"type":"int","etag":"","indexed":true,"editPermission":0},"photos-size":{"value":{"width":500,"height":500},"type":"array","etag":"","indexed":false,"editPermission":0}}	NhgWF4s	2024-11-05 23:47:14
11	249	{"photos-size":{"value":{"width":3984,"height":2656},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-original_date_time":{"value":1729105512,"type":"int","etag":"","indexed":true,"editPermission":0}}	bLIMHr8	2024-11-05 23:49:21
12	260	{"photos-size":{"value":{"width":4128,"height":2752},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-original_date_time":{"value":1728924608,"type":"int","etag":"","indexed":true,"editPermission":0}}	h7dXDxY	2024-11-05 23:49:34
13	270	{"photos-size":{"value":{"width":4128,"height":2752},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-original_date_time":{"value":1728924608,"type":"int","etag":"","indexed":true,"editPermission":0}}	DtWiPQg	2024-11-05 23:49:52
14	281	{"photos-size":{"value":{"width":2688,"height":4032},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-original_date_time":{"value":1728924606,"type":"int","etag":"","indexed":true,"editPermission":0}}	w8xe2ev	2024-11-05 23:50:15
15	291	{"photos-size":{"value":{"width":853,"height":1280},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-original_date_time":{"value":1729581876,"type":"int","etag":"","indexed":true,"editPermission":0}}	6sq7ib8	2024-11-05 23:51:13
16	301	{"photos-size":{"value":{"width":853,"height":1280},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-original_date_time":{"value":1729581896,"type":"int","etag":"","indexed":true,"editPermission":0}}	1fN6Oa4	2024-11-05 23:51:17
17	327	{"photos-size":{"value":{"width":2016,"height":3024},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-original_date_time":{"value":1728924610,"type":"int","etag":"","indexed":true,"editPermission":0}}	oJfHlqd	2024-11-05 23:52:52
18	338	{"photos-size":{"value":{"width":1999,"height":3000},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-original_date_time":{"value":1728295916,"type":"int","etag":"","indexed":true,"editPermission":0}}	2MMY3ck	2024-11-05 23:53:31
19	348	{"photos-size":{"value":{"width":3000,"height":2000},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-original_date_time":{"value":1728295920,"type":"int","etag":"","indexed":true,"editPermission":0}}	WGsfmuN	2024-11-05 23:53:37
20	358	{"photos-size":{"value":{"width":3000,"height":2000},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-original_date_time":{"value":1728295920,"type":"int","etag":"","indexed":true,"editPermission":0}}	iQpWHIe	2024-11-05 23:53:53
21	367	{"photos-size":{"value":{"width":2000,"height":3000},"type":"array","etag":"","indexed":false,"editPermission":0},"photos-original_date_time":{"value":1728295916,"type":"int","etag":"","indexed":true,"editPermission":0}}	D9m1bzo	2024-11-05 23:54:08
\.


--
-- Data for Name: oc_files_metadata_index; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_files_metadata_index (id, file_id, meta_key, meta_value_string, meta_value_int) FROM stdin;
1	3	photos-original_date_time	\N	1730839633
3	5	photos-original_date_time	\N	1341059531
5	6	photos-original_date_time	\N	1444907264
7	7	photos-original_date_time	\N	1341258636
9	8	photos-original_date_time	\N	1341072915
11	9	photos-original_date_time	\N	1526500980
13	10	photos-original_date_time	\N	1341064060
15	11	photos-original_date_time	\N	1730839633
17	13	photos-original_date_time	\N	1372319469
19	16	photos-original_date_time	\N	1730839634
20	249	photos-original_date_time	\N	1729105512
21	260	photos-original_date_time	\N	1728924608
22	270	photos-original_date_time	\N	1728924608
23	281	photos-original_date_time	\N	1728924606
24	291	photos-original_date_time	\N	1729581876
25	301	photos-original_date_time	\N	1729581896
26	327	photos-original_date_time	\N	1728924610
27	338	photos-original_date_time	\N	1728295916
28	348	photos-original_date_time	\N	1728295920
29	358	photos-original_date_time	\N	1728295920
30	367	photos-original_date_time	\N	1728295916
31	393	photos-original_date_time	\N	1728295918
32	404	photos-original_date_time	\N	1721723704
33	414	photos-original_date_time	\N	1721723805
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
1	2024-10-22 10.24.36.jpg	admin	1730839898	Photos	\N	\N	admin
2	22a1d1ee-460d-4cb8-93c2-b84b3f79b9d3.jpg	admin	1730839908	Photos	\N	\N	admin
\.


--
-- Data for Name: oc_files_versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oc_files_versions (id, file_id, "timestamp", size, mimetype, metadata) FROM stdin;
59	327	1728924610	591805	6	{"author":"admin"}
1	3	1730839633	3963036	4	{"author":"admin"}
22	26	1730839634	81196	14	{"author":"admin"}
2	5	1730839633	593508	6	{"author":"admin"}
37	41	1730839635	88394	13	{"author":"admin"}
3	6	1730839633	167989	6	{"author":"admin"}
23	27	1730839634	16988	16	{"author":"admin"}
4	7	1730839633	2170375	6	{"author":"admin"}
48	52	1730839635	976625	10	{"author":"admin"}
5	8	1730839633	457744	6	{"author":"admin"}
24	28	1730839634	31325	15	{"author":"admin"}
6	9	1730839633	427030	6	{"author":"admin"}
38	42	1730839635	14810	14	{"author":"admin"}
7	10	1730839633	474653	6	{"author":"admin"}
25	29	1730839634	23359	15	{"author":"admin"}
8	11	1730839633	797325	6	{"author":"admin"}
60	338	1728295916	1597551	6	{"author":"admin"}
9	12	1730839633	150	8	{"author":"admin"}
26	30	1730839634	30290	15	{"author":"admin"}
10	13	1730839633	567689	6	{"author":"admin"}
39	43	1730839635	25621	15	{"author":"admin"}
11	14	1730839633	12860592	10	{"author":"admin"}
27	31	1730839634	13653	16	{"author":"admin"}
12	15	1730839633	206	8	{"author":"admin"}
49	54	1730839635	1095	8	{"author":"admin"}
13	16	1730839634	50598	11	{"author":"admin"}
28	32	1730839634	13378	13	{"author":"admin"}
14	18	1730839634	340061	12	{"author":"admin"}
40	44	1730839635	30354	12	{"author":"admin"}
15	19	1730839634	5155877	12	{"author":"admin"}
29	33	1730839634	13878	16	{"author":"admin"}
16	20	1730839634	52843	13	{"author":"admin"}
61	348	1728295920	1331710	6	{"author":"admin"}
17	21	1730839634	17276	12	{"author":"admin"}
30	34	1730839634	326	8	{"author":"admin"}
18	22	1730839634	317015	14	{"author":"admin"}
41	45	1730839635	15961	12	{"author":"admin"}
19	23	1730839634	39404	12	{"author":"admin"}
31	35	1730839634	30671	15	{"author":"admin"}
20	24	1730839634	30780	15	{"author":"admin"}
50	55	1730839635	1083339	10	{"author":"admin"}
21	25	1730839634	31132	15	{"author":"admin"}
32	36	1730839634	11836	16	{"author":"admin"}
42	46	1730839635	45778	15	{"author":"admin"}
33	37	1730839634	35657	15	{"author":"admin"}
62	358	1728295920	1336876	6	{"author":"admin"}
34	38	1730839635	27629	15	{"author":"admin"}
43	47	1730839635	14316	14	{"author":"admin"}
35	39	1730839635	554	8	{"author":"admin"}
51	56	1730839635	136	8	{"author":"admin"}
36	40	1730839635	573	8	{"author":"admin"}
44	48	1730839635	868111	12	{"author":"admin"}
63	367	1728295916	1261988	6	{"author":"admin"}
45	49	1730839635	3509628	14	{"author":"admin"}
52	57	1730839635	24295	17	{"author":"admin"}
46	50	1730839635	13441	13	{"author":"admin"}
53	249	1729105512	517097	6	{"author":"admin"}
47	51	1730839635	2403	8	{"author":"admin"}
54	260	1728924608	736842	6	{"author":"admin"}
64	393	1728295918	1576306	6	{"author":"admin"}
56	281	1728924606	941112	6	{"author":"admin"}
58	301	1729581896	190760	6	{"author":"admin"}
65	404	1721723704	795433	6	{"author":"admin"}
66	414	1721723805	182410	6	{"author":"admin"}
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
8	OCA\\Files_Versions\\BackgroundJob\\ExpireVersions	null	0	1730839627	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
9	OCA\\Federation\\SyncJob	null	0	1730839627	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
10	OCA\\Activity\\BackgroundJob\\EmailNotification	null	0	1730839628	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
11	OCA\\Activity\\BackgroundJob\\ExpireActivities	null	0	1730839628	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
12	OCA\\Activity\\BackgroundJob\\DigestMail	null	0	1730839628	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
13	OCA\\Activity\\BackgroundJob\\RemoveFormerActivitySettings	null	0	1730839628	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
14	OCA\\Files_Sharing\\DeleteOrphanedSharesJob	null	0	1730839628	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
15	OCA\\Files_Sharing\\ExpireSharesJob	null	0	1730839628	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
16	OCA\\Files_Sharing\\BackgroundJob\\FederatedSharesDiscoverJob	null	0	1730839628	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
17	OCA\\UpdateNotification\\BackgroundJob\\UpdateAvailableNotifications	null	0	1730839628	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
18	OCA\\OAuth2\\BackgroundJob\\CleanupExpiredAuthorizationCode	null	0	1730839629	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
19	OCA\\Photos\\Jobs\\AutomaticPlaceMapperJob	null	0	1730839629	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
20	OCA\\DAV\\BackgroundJob\\CleanupDirectLinksJob	null	0	1730839630	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
21	OCA\\DAV\\BackgroundJob\\UpdateCalendarResourcesRoomsBackgroundJob	null	0	1730839630	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
22	OCA\\DAV\\BackgroundJob\\CleanupInvitationTokenJob	null	0	1730839630	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
23	OCA\\DAV\\BackgroundJob\\EventReminderJob	null	0	1730839630	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
24	OCA\\DAV\\BackgroundJob\\CalendarRetentionJob	null	0	1730839630	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
25	OCA\\DAV\\BackgroundJob\\PruneOutdatedSyncTokensJob	null	0	1730839630	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
26	OCA\\UserStatus\\BackgroundJob\\ClearOldStatusesBackgroundJob	null	0	1730839631	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
27	OCA\\Notifications\\BackgroundJob\\GenerateUserSettings	null	0	1730839631	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
28	OCA\\Notifications\\BackgroundJob\\SendNotificationMails	null	0	1730839631	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
29	OCA\\NextcloudAnnouncements\\Cron\\Crawler	null	0	1730839631	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
30	OCA\\ContactsInteraction\\BackgroundJob\\CleanupJob	null	0	1730839632	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
31	OCA\\Files_Trashbin\\BackgroundJob\\ExpireTrash	null	0	1730839632	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
32	OCA\\ServerInfo\\Jobs\\UpdateStorageStats	null	0	1730839632	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
33	OCA\\Files\\BackgroundJob\\ScanFiles	null	0	1730839632	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
34	OCA\\Files\\BackgroundJob\\DeleteOrphanedItems	null	0	1730839632	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
35	OCA\\Files\\BackgroundJob\\CleanupFileLocks	null	0	1730839632	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
36	OCA\\Files\\BackgroundJob\\CleanupDirectEditingTokens	null	0	1730839632	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
37	OCA\\Files\\BackgroundJob\\DeleteExpiredOpenLocalEditor	null	0	1730839632	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
38	OCA\\Support\\BackgroundJobs\\CheckSubscription	null	0	1730839633	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
43	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",3]	0	1730839633	0	0	a324f9b0a0f981cbf0bb0042f95a5ab4456b471f080b49802cd060efc566f1da	1
44	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",5]	0	1730839633	0	0	bab5ba2238ecad63141db6c5f1608efc3b0efecc909f4f8d8e111e0d5c23edad	1
45	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",6]	0	1730839633	0	0	0d840fcf4d96c36eb80b922e14ca2b7aa5acaba8f61b45e2d8bd832199fe8c9d	1
40	OC\\Log\\Rotate	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
41	OC\\Preview\\BackgroundCleanupJob	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
39	OC\\Authentication\\Token\\TokenCleanupJob	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
42	OC\\TextProcessing\\RemoveOldTasksBackgroundJob	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
1	OCA\\AppAPI\\BackgroundJob\\ExAppInitStatusCheckJob	null	1730839656	1730839656	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
2	OCA\\AppAPI\\BackgroundJob\\ProvidersAICleanUpJob	null	1730839751	1730839751	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	0
3	OCA\\FilesReminders\\BackgroundJob\\CleanUpReminders	null	1730839881	1730839881	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	0
5	OCA\\WorkflowEngine\\BackgroundJobs\\Rotate	null	1730840049	1730840049	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
6	OCA\\Circles\\Cron\\Maintenance	null	1730840084	1730840084	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
7	OCA\\Text\\Cron\\Cleanup	null	1730840227	1730840227	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
46	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",7]	0	1730839633	0	0	5889fec72259069bfcddd1167dbbf1c854234eb06614dd8fd894eff7956192a7	1
47	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",8]	0	1730839633	0	0	075228ca5e1ab3f24fd39c1402e41a206a4afd78fc71b52f0021faaa6121c260	1
48	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",9]	0	1730839633	0	0	6aeb888c4dfdca1c745d4f2367a7386cf490285b3d961db0382c594a54c400a0	1
49	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",10]	0	1730839633	0	0	9e79a1d0a821264f3aa6269c1d3dba0f52274f57ff2819cc5c70f60300c2ec6c	1
50	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",11]	0	1730839633	0	0	32ea4cc1f86ec7aba234f815b18136b6eab27615e67f71a4f752e863214b3b22	1
51	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",12]	0	1730839633	0	0	2f60738088dd89b5b25465a7c6c482de073a21ffe62c3b8a3ec59ad5a1f4c15f	1
52	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",13]	0	1730839633	0	0	05b302cbd33b86157c9981f8eb4ab72466e203421a1a8d2b9d504b7ec7e17ea7	1
53	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",14]	0	1730839633	0	0	70e10015f10fbd6d13870e3908314ad4de673976fc3075d2eda0d7d4b2681dc6	1
54	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",15]	0	1730839633	0	0	22aa486f345e5794cae46ce5def4dd3810bcc6c191e1190594fcdcbfaf05c65f	1
55	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",16]	0	1730839634	0	0	cdf77c66ee9dc02019f56d1e8999668d813066995c75ab4c48ce506c209fe0f6	1
56	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",18]	0	1730839634	0	0	d6f63b0735f2a90b0ce0af8891b0398880b7399b786f84b0818adeeba359f1bb	1
57	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",19]	0	1730839634	0	0	27a2cbe5b547b14f49ab72b681e53a8a1e74f549192ae8898bb4c2f4f88555fd	1
58	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",20]	0	1730839634	0	0	876775feb13959831d8c7753e2a4abd552e03b394d84939656bb5dce9ce4f8f6	1
59	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",21]	0	1730839634	0	0	79363e541ba12589811d7a0d3403d97d4d60a73c91e92db043322e5ca990c8fb	1
60	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",22]	0	1730839634	0	0	830acf7a8ef52afbe08fc2713df540bc14c79f1a0f95c854da5e26b0386477f7	1
61	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",23]	0	1730839634	0	0	9cea6ce18595672d882c9d89a3acfbcf7958a0839bc4a5abaa9ef02d88aebaf1	1
62	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",24]	0	1730839634	0	0	727ef905962bfe27b36d943813e028d0e3664c929d5a714f0d7ac0d000ffa5fd	1
63	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",25]	0	1730839634	0	0	529311c9ad07ba8de6b18178dbcf95b582b72597ade6c56cf1d41d7c6d7397c9	1
64	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",26]	0	1730839634	0	0	003cfb4d3aba0fde31ba26c3b3a820a3d150ea868d5ee2c37c1a33771ef8e8b8	1
65	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",27]	0	1730839634	0	0	b0cc502625f847e1481b6d24d1eb94752736146434df36043a153c9b1ee284c5	1
66	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",28]	0	1730839634	0	0	2e1a9923add930564317a65c0bfc12ca3daa3e2530c1accdaf2277732f6ad934	1
67	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",29]	0	1730839634	0	0	128fb9e5163de0bb1da6d975fed7b8c360a97ec2b9fee149f4bb8aaa9598d2b4	1
68	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",30]	0	1730839634	0	0	e782f2107c9202401ac95b15d443e8da595c6bd92e26e8c5a086a268967794c9	1
69	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",31]	0	1730839634	0	0	86924dbd7b48f415fbf674a2669f36ccb651e936cda773d270e5342bc467d53b	1
70	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",32]	0	1730839634	0	0	ee02ec2ee4e390442f92c13e988ac867bb67074f52aecb22a05bdeee504d6e5f	1
71	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",33]	0	1730839634	0	0	d2fc6457a2d723b580d9219ce144539740f68beea42d1a1379b60ea972699109	1
72	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",34]	0	1730839634	0	0	154b723aa40ccca0c4ef5a72218d14f10a6618261e58095632eca79ecef12329	1
73	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",35]	0	1730839634	0	0	a0ef7cdcb39b887087357a25bd2c1da932604ad5db4388671a25dd4a8bd0317a	1
74	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",36]	0	1730839634	0	0	16df61184ae9e35c363a154732c7351c493d2a3ac34cdf8697fdfbc2da04f191	1
75	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",37]	0	1730839634	0	0	b1e224ce7c7b3a952f648379b84369decad2d9b9ff4206324f216da3fad24c68	1
76	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",38]	0	1730839635	0	0	57471075f497d1a8eadd28685fbd9bbf6da61a6c9440d215d823c6ffbd54d4e7	1
77	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",39]	0	1730839635	0	0	5ca6ac67eac9782f6f7a0b7771f087a2584e0241fb44c99c4743984285097b2e	1
78	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",40]	0	1730839635	0	0	07ba9c6a76e9b0c3a72981be352527e6b36975e7b0976a4fcb3bbc0559d2b542	1
79	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",41]	0	1730839635	0	0	4c14497df884240ef37196f1f3e78f9ecb5715d4e5e8155f4c866e4d45d1a9b2	1
80	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",42]	0	1730839635	0	0	d5a6a27596364bdb824290d1d838e04ef81f732a54d4af8b01a3ff7e4765c99c	1
81	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",43]	0	1730839635	0	0	b7e10b61bf98d5f2376b308c483713cefc1dde08cc62fa9525d280283ac00634	1
82	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",44]	0	1730839635	0	0	7f449813b099905192fcaeb5607970d09c4d8d0998bd58dd3621979f8cd11cb0	1
83	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",45]	0	1730839635	0	0	ba2ef4e3cfbade663cfae1431113a10c4d523728ac0ad237af333b584375ddb4	1
84	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",46]	0	1730839635	0	0	80ff70d0c920a046219b03ff7d3ad47cb1bf4a6208c3200dacf769b3fa6c748c	1
85	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",47]	0	1730839635	0	0	a3890d747cc802dba6a5bf5ea3bc64fa76642bfe22a036742524262b78e1fa00	1
86	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",48]	0	1730839635	0	0	37b98ebdecc5f0658741278c00b9b39e585ef51a5528ec2849a1f22fc65e6a68	1
87	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",49]	0	1730839635	0	0	e1d9319ef784d6e2697941e9c9b806eff09802f8c8b88681164e1fad8a195a2c	1
88	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",50]	0	1730839635	0	0	8737a4a10f2493722aef7c2c8e88401b265cddd3be46f68449a98ec3e63f972a	1
89	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",51]	0	1730839635	0	0	c7cc806c5e0ef963d164ac8ddbd45a0d07c20632a814374beba02523041e6366	1
90	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",52]	0	1730839635	0	0	fd7e2f45366cbfaa56418e9f66de32b1152ceff0b9e2a95c35f8ab9cf14e9ab3	1
91	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",54]	0	1730839635	0	0	377bbca9da63af8ce04de552dedba2ec51ab03dedabd1720fd8af9044500ec08	1
92	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",55]	0	1730839635	0	0	c0b05087e2b5a15f9e2889da4e63410fc313358d668337a87e0012a7d4a49abb	1
93	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",56]	0	1730839635	0	0	7c8bf950975a947a8c9ac0c21b5d220c756e025a71ae33a74845207900dfd749	1
94	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",57]	0	1730839635	0	0	56a538f0d0beb9c2a8fdea0f875b6ce62c5eaf8879ed9984caab1a5dec150bc5	1
95	OC\\Repair\\Owncloud\\MoveAvatarsBackgroundJob	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
96	OC\\Repair\\Owncloud\\CleanPreviewsBackgroundJob	{"uid":"admin"}	0	1730839637	0	0	70071f2985a39d9762e53229dd5125d134cd7601939c1a4d69cd99aa90057e8a	1
97	OC\\Core\\BackgroundJobs\\BackgroundCleanupUpdaterBackupsJob	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
98	OC\\Core\\BackgroundJobs\\CleanupLoginFlowV2	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
99	OC\\Security\\Bruteforce\\CleanupJob	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
100	OC\\Core\\BackgroundJobs\\LookupServerSendCheckBackgroundJob	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
101	OC\\TextToImage\\RemoveOldTasksBackgroundJob	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
102	OC\\TaskProcessing\\RemoveOldTasksBackgroundJob	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
103	OC\\Core\\BackgroundJobs\\GenerateMetadataJob	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
104	OCA\\DAV\\BackgroundJob\\DeleteOutdatedSchedulingObjects	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
105	OCA\\DAV\\BackgroundJob\\RegisterRegenerateBirthdayCalendars	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
106	OCA\\DAV\\Migration\\BuildCalendarSearchIndexBackgroundJob	{"offset":0,"stopAt":0}	0	1730839637	0	0	d7ef914db4e972cae9538992ce0e171fb0dabb1a1a12299524cae770170e1df8	1
107	OCA\\DAV\\BackgroundJob\\BuildReminderIndexBackgroundJob	{"offset":0,"stopAt":0}	0	1730839637	0	0	d7ef914db4e972cae9538992ce0e171fb0dabb1a1a12299524cae770170e1df8	1
108	OCA\\Survey_Client\\BackgroundJobs\\AdminNotification	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
109	OCA\\Theming\\Jobs\\MigrateBackgroundImages	{"stage":"prepare"}	0	1730839637	0	0	8760b159378869e104390034cc3e518ab586e37c5a611d0de8631b9b5053e699	1
110	OCA\\TwoFactorBackupCodes\\BackgroundJob\\CheckBackupCodes	null	0	1730839637	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
112	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",249]	0	1730839761	0	0	7c6295946da6dc5c2c7c91d36f924c8205fd414874ddcdf67eb3a74deddf7e67	1
113	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",260]	0	1730839774	0	0	f701e2672370cc5cb2714ccc93db9c9f03bd23ced13f2f2efab4b6b688b2d2dd	1
114	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",270]	0	1730839791	0	0	adab63e79ae26a5fdf9336353bdd23bab9c012182e92e97afadda1caafd62d6b	1
115	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",281]	0	1730839815	0	0	8589b9c3752b6dff3369b2771408b2f7623e9104aa3e03adc50d891c4bbbeff1	1
116	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",291]	0	1730839873	0	0	cce4134e41ae74bdb8bb8db16bbd376ab5abfeb136f81ccc59e84f3341b21b25	1
117	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",301]	0	1730839876	0	0	553118c83fa57d5a3733e52d091645c33673f0f3ae956828f83c5776105073a5	1
118	OC\\Command\\CommandJob	"O:33:\\"OCA\\\\Files_Trashbin\\\\Command\\\\Expire\\":1:{s:39:\\"\\u0000OCA\\\\Files_Trashbin\\\\Command\\\\Expire\\u0000user\\";s:5:\\"admin\\";}"	0	1730839908	0	0	210cdd5c1cc8185bfdcf2f1f58d9ba5ea15477e7fa4d5f6a314e8d84d9d6d8a9	1
4	OCA\\FilesReminders\\BackgroundJob\\ScheduledNotifications	null	1730839965	1730839965	0	0	74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b	1
119	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",327]	0	1730839972	0	0	3a9177e1573e078cc4895080bc2081d6f2174351ede04f679cfb107f0b479f6f	1
120	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",338]	0	1730840010	0	0	8fca24d756e00bcd44e45f87445954beee155c2f916e67792510aa6d34ac3fa2	1
121	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",348]	0	1730840017	0	0	a8e4e232f4fd85dea58961ff042c0c0ef07535bc14eaa81d6233fbcc76d35456	1
122	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",358]	0	1730840032	0	0	56c5b0b9f253ee36c0dfa66fbf8af59b5299437c31e78d6be6d3a3414118fa30	1
123	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",367]	0	1730840047	0	0	dc4a08ffbcfeeb9d70e8380b7ac4031cb4bb26b717ea45bc0ecb7c25c1a7f1a9	1
124	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",393]	0	1730840091	0	0	3e9cb10831f6a9a089badb62537dae71429b8c272e24c266f79e43cf095cc097	1
125	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",404]	0	1730840220	0	0	f92757eaae04a0b34467be5519b94ad339492820a42b737470232f81dbf44909	1
126	OC\\FilesMetadata\\Job\\UpdateSingleMetadata	["admin",414]	0	1730840224	0	0	69d18bc512ba1c91967bd67354370c4f99d14a87e9c167811b54c135648f6873	1
111	OCA\\FirstRunWizard\\Notification\\BackgroundJob	{"uid":"admin"}	0	1730840226	0	0	70071f2985a39d9762e53229dd5125d134cd7601939c1a4d69cd99aa90057e8a	1
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
18	application/javascript
19	application/octet-stream
20	application/gzip
21	image/heic
22	image/webp
23	image/svg+xml
24	video/quicktime
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
1	firstrunwizard	admin	1730839654	app	recognize	apphint-recognize	[]		[]			[]
2	firstrunwizard	admin	1730839654	app	groupfolders	apphint-groupfolders	[]		[]			[]
3	firstrunwizard	admin	1730839654	app	forms	apphint-forms	[]		[]			[]
4	firstrunwizard	admin	1730839654	app	deck	apphint-deck	[]		[]			[]
5	firstrunwizard	admin	1730839654	app	tasks	apphint-tasks	[]		[]			[]
6	firstrunwizard	admin	1730839654	app	whiteboard	apphint-whiteboard	[]		[]			[]
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
admin	login	lastLogin	1730839633
admin	activity	configured	yes
admin	notifications	sound_notification	no
admin	notifications	sound_talk	no
admin	password_policy	failedLoginAttempts	0
admin	core	templateDirectory	Templates/
admin	core	timezone	Europe/Moscow
admin	login_token	Dyw68SJt3ynoFV0EMDWTa7UKkTUNT1ar	1730839654
admin	firstrunwizard	apphint	19
admin	core	lang	ru
admin	avatar	generated	true
admin	files	lastSeenQuotaUsage	0.2
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
2	local::/var/www/nextcloud/data/	1	\N
3	local::/mnt/nextcloud/data/	1	\N
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
1	admin	online	1730839655	f	\N	\N	\N	\N	f	0
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
admin	\N	3|$argon2id$v=19$m=65536,t=4,p=1$WUtvdFJYWHpXV2I1am4xbg$sARmSOAntvGU/HAyVeZtqiMMooWe0o8YU9fPrbjmdtU	admin
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

SELECT pg_catalog.setval('public.oc_activity_activity_id_seq', 123, true);


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

SELECT pg_catalog.setval('public.oc_file_locks_id_seq', 535, true);


--
-- Name: oc_filecache_fileid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_filecache_fileid_seq', 433, true);


--
-- Name: oc_files_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_files_metadata_id_seq', 24, true);


--
-- Name: oc_files_metadata_index_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_files_metadata_index_id_seq', 33, true);


--
-- Name: oc_files_reminders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_files_reminders_id_seq', 1, false);


--
-- Name: oc_files_trash_auto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_files_trash_auto_id_seq', 2, true);


--
-- Name: oc_files_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oc_files_versions_id_seq', 66, true);


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

SELECT pg_catalog.setval('public.oc_jobs_id_seq', 126, true);


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

SELECT pg_catalog.setval('public.oc_mimetypes_id_seq', 24, true);


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

SELECT pg_catalog.setval('public.oc_storages_numeric_id_seq', 3, true);


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
-- Name: fs_storage_path_prefix; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fs_storage_path_prefix ON public.oc_filecache USING btree (storage, path);


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
-- Name: systag_by_objectid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX systag_by_objectid ON public.oc_systemtag_object_mapping USING btree (objectid);


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

