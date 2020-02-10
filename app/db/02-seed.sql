SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

-- member

COPY public.member (id, uuid, first_name, last_name, email, ssn, created_at, updated_at) FROM stdin;
1	4a99d2ac-2c3b-46a5-a9b6-f9e251049f58	Joe	Jones	joe.jones@test.com	111111111	2019-12-20 12:00:00+00	2019-12-20 12:00:00+00
2	86741127-447a-4701-8a45-e492ff5bb088	John	Smith	john.smith@test.com	222222222	2019-12-21 12:00:00+00	2019-12-21 12:00:00+00
3	fb376452-a212-49aa-993e-2e9e877d3547	Jane	Doe	jane.doe@test.com	3333333333	2019-12-22 12:00:00+00	2019-12-22 12:00:00+00
\.

SELECT pg_catalog.setval('public.member_id_seq', 3, true);

-- note

COPY public.note (id, author_id, content, created_at, updated_at) FROM stdin;
1	1	First note	2019-12-20 12:00:00+00	2019-12-20 12:00:00+00
2	2	Second note	2019-12-21 12:00:00+00	2019-12-21 12:00:00+00
3	3	Third note	2019-12-22 12:00:00+00	2019-12-22 12:00:00+00
4	1	Fourth note	2019-12-23 12:00:00+00	2019-12-23 12:00:00+00
\.

SELECT pg_catalog.setval('public.note_id_seq', 4, true);