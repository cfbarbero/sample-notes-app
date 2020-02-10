
-- Roles
CREATE ROLE devops_admin LOGIN;

-- Schema
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

-- member table
CREATE TABLE public.member (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    email text NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    ssn text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);

CREATE SEQUENCE public.member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.member_id_seq OWNED BY public.member.id;
ALTER TABLE ONLY public.member ALTER COLUMN id SET DEFAULT nextval('public.member_id_seq'::regclass);
ALTER TABLE ONLY public.member ADD CONSTRAINT member_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.member ADD CONSTRAINT member_uuid_key UNIQUE (uuid);
ALTER TABLE ONLY public.member ADD CONSTRAINT member_email_key UNIQUE (email);


-- note table
CREATE TABLE public.note (
    id integer NOT NULL,
    author_id integer NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);

CREATE SEQUENCE public.note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.note_id_seq OWNED BY public.note.id;
ALTER TABLE ONLY public.note ALTER COLUMN id SET DEFAULT nextval('public.note_id_seq'::regclass);
ALTER TABLE ONLY public.note ADD CONSTRAINT note_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.note ADD CONSTRAINT note_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.member(id);


-- Permissions
GRANT ALL PRIVILEGES ON DATABASE devops TO devops_admin;
GRANT ALL ON ALL TABLES IN SCHEMA public TO devops_admin;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO devops_admin;