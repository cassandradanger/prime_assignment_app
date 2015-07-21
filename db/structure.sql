--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
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
-- Name: admins; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admins (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    first_name character varying(255),
    last_name character varying(255),
    status character varying(255) DEFAULT 'Active'::character varying
);


--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admins_id_seq OWNED BY admins.id;


--
-- Name: admission_applications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admission_applications (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    city character varying(255),
    state character varying(255),
    zip_code character varying(255),
    legal_status character varying(255),
    education character varying(255),
    employment_status character varying(255),
    linkedin_account character varying(255),
    twitter_account character varying(255),
    github_account character varying(255),
    website_link character varying(255),
    resume_link character varying(255),
    referral_source character varying(255),
    question_reason_for_applying text,
    question_why_prime text,
    question_intensity text,
    question_technology_background text,
    question_self_differentiation text,
    question_three_month_prediction text,
    question_three_year_aspiration text,
    question_actions_toward_goals text,
    application_status character varying(255),
    application_step character varying(255),
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    completed_at timestamp without time zone,
    address character varying(255),
    phone character varying(255),
    income integer,
    goal character varying(255),
    payment_option character varying(255),
    resume_score integer,
    resume_notes text,
    interview_score integer DEFAULT 0,
    assigned_cohort_id integer,
    gender character varying(255),
    dependents integer,
    geography character varying(255),
    birthdate date,
    veteran boolean,
    race_hispanic boolean,
    race_nativeamerican boolean,
    race_asian boolean,
    race_black boolean,
    race_islander boolean,
    race_white boolean,
    race_other boolean,
    application_status_updated_at timestamp without time zone,
    date_of_birth date,
    course_id integer
);


--
-- Name: admission_applications_cohorts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admission_applications_cohorts (
    id integer NOT NULL,
    admission_application_id integer,
    cohort_id integer
);


--
-- Name: admission_applications_cohorts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admission_applications_cohorts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admission_applications_cohorts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admission_applications_cohorts_id_seq OWNED BY admission_applications_cohorts.id;


--
-- Name: admission_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admission_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admission_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admission_applications_id_seq OWNED BY admission_applications.id;


--
-- Name: audits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE audits (
    id integer NOT NULL,
    auditable_id integer,
    auditable_type character varying(255),
    associated_id integer,
    associated_type character varying(255),
    user_id integer,
    user_type character varying(255),
    username character varying(255),
    action character varying(255),
    audited_changes text,
    version integer DEFAULT 0,
    comment character varying(255),
    remote_address character varying(255),
    request_uuid character varying(255),
    created_at timestamp without time zone
);


--
-- Name: audits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE audits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE audits_id_seq OWNED BY audits.id;


--
-- Name: cohorts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cohorts (
    id integer NOT NULL,
    prework_start date,
    classroom_start date,
    graduation date,
    applications_open date,
    applications_close date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    target_size integer DEFAULT 20,
    earnest_application_code character varying(255),
    course_id integer
);


--
-- Name: cohorts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cohorts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cohorts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cohorts_id_seq OWNED BY cohorts.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    content text,
    sub_type character varying(255),
    admin_id integer,
    is_commentable_id integer,
    is_commentable_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    archived boolean DEFAULT false
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE courses (
    id integer NOT NULL,
    code character varying,
    name character varying,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    active boolean DEFAULT true
);


--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE courses_id_seq OWNED BY courses.id;


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    handler text NOT NULL,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying,
    queue character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    delayed_reference_id integer,
    delayed_reference_type character varying
);


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: logic_question_answers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE logic_question_answers (
    id integer NOT NULL,
    logic_question_id integer,
    admission_application_id integer,
    answer character varying(255),
    explanation text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: logic_question_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE logic_question_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: logic_question_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE logic_question_answers_id_seq OWNED BY logic_question_answers.id;


--
-- Name: logic_questions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE logic_questions (
    id integer NOT NULL,
    question text,
    solution character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    question_image_file_name character varying(255),
    question_image_content_type character varying(255),
    question_image_file_size integer,
    question_image_updated_at timestamp without time zone,
    published boolean,
    "position" integer,
    course_id integer,
    active boolean DEFAULT true
);


--
-- Name: logic_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE logic_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: logic_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE logic_questions_id_seq OWNED BY logic_questions.id;


--
-- Name: profile_question_answers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE profile_question_answers (
    id integer NOT NULL,
    answer text,
    score integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    admission_application_id integer,
    profile_question_id integer
);


--
-- Name: profile_question_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE profile_question_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: profile_question_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE profile_question_answers_id_seq OWNED BY profile_question_answers.id;


--
-- Name: profile_questions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE profile_questions (
    id integer NOT NULL,
    question text,
    published boolean,
    scoring_guideline_1 text,
    scoring_guideline_2 text,
    scoring_guideline_3 text,
    scoring_guideline_4 text,
    scoring_guideline_5 text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    "position" integer,
    course_id integer,
    active boolean DEFAULT true
);


--
-- Name: profile_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE profile_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: profile_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE profile_questions_id_seq OWNED BY profile_questions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    created_at timestamp without time zone
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admins ALTER COLUMN id SET DEFAULT nextval('admins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admission_applications ALTER COLUMN id SET DEFAULT nextval('admission_applications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admission_applications_cohorts ALTER COLUMN id SET DEFAULT nextval('admission_applications_cohorts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY audits ALTER COLUMN id SET DEFAULT nextval('audits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cohorts ALTER COLUMN id SET DEFAULT nextval('cohorts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY courses ALTER COLUMN id SET DEFAULT nextval('courses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY logic_question_answers ALTER COLUMN id SET DEFAULT nextval('logic_question_answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY logic_questions ALTER COLUMN id SET DEFAULT nextval('logic_questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY profile_question_answers ALTER COLUMN id SET DEFAULT nextval('profile_question_answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY profile_questions ALTER COLUMN id SET DEFAULT nextval('profile_questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Name: admins_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: admission_applications_cohorts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admission_applications_cohorts
    ADD CONSTRAINT admission_applications_cohorts_pkey PRIMARY KEY (id);


--
-- Name: admission_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admission_applications
    ADD CONSTRAINT admission_applications_pkey PRIMARY KEY (id);


--
-- Name: audits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY audits
    ADD CONSTRAINT audits_pkey PRIMARY KEY (id);


--
-- Name: cohorts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cohorts
    ADD CONSTRAINT cohorts_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: logic_question_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY logic_question_answers
    ADD CONSTRAINT logic_question_answers_pkey PRIMARY KEY (id);


--
-- Name: logic_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY logic_questions
    ADD CONSTRAINT logic_questions_pkey PRIMARY KEY (id);


--
-- Name: profile_question_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY profile_question_answers
    ADD CONSTRAINT profile_question_answers_pkey PRIMARY KEY (id);


--
-- Name: profile_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY profile_questions
    ADD CONSTRAINT profile_questions_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: associated_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX associated_index ON audits USING btree (associated_id, associated_type);


--
-- Name: auditable_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX auditable_index ON audits USING btree (auditable_id, auditable_type);


--
-- Name: delayed_jobs_delayed_reference_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_delayed_reference_id ON delayed_jobs USING btree (delayed_reference_id);


--
-- Name: delayed_jobs_delayed_reference_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_delayed_reference_type ON delayed_jobs USING btree (delayed_reference_type);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: delayed_jobs_queue; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_queue ON delayed_jobs USING btree (queue);


--
-- Name: index_admins_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_email ON admins USING btree (email);


--
-- Name: index_admins_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_reset_password_token ON admins USING btree (reset_password_token);


--
-- Name: index_admission_applications_on_course_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_admission_applications_on_course_id ON admission_applications USING btree (course_id);


--
-- Name: index_audits_on_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_audits_on_created_at ON audits USING btree (created_at);


--
-- Name: index_audits_on_request_uuid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_audits_on_request_uuid ON audits USING btree (request_uuid);


--
-- Name: index_cohorts_on_course_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cohorts_on_course_id ON cohorts USING btree (course_id);


--
-- Name: index_comments_on_admin_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_admin_id ON comments USING btree (admin_id);


--
-- Name: index_comments_on_is_commentable_id_and_is_commentable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_is_commentable_id_and_is_commentable_type ON comments USING btree (is_commentable_id, is_commentable_type);


--
-- Name: index_logic_questions_on_course_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_logic_questions_on_course_id ON logic_questions USING btree (course_id);


--
-- Name: index_profile_questions_on_course_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_profile_questions_on_course_id ON profile_questions USING btree (course_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_versions_on_item_type_and_item_id ON versions USING btree (item_type, item_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: user_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX user_index ON audits USING btree (user_id, user_type);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20141115204549');

INSERT INTO schema_migrations (version) VALUES ('20141115222047');

INSERT INTO schema_migrations (version) VALUES ('20141116035126');

INSERT INTO schema_migrations (version) VALUES ('20141116040109');

INSERT INTO schema_migrations (version) VALUES ('20141116052739');

INSERT INTO schema_migrations (version) VALUES ('20141116054919');

INSERT INTO schema_migrations (version) VALUES ('20141120171436');

INSERT INTO schema_migrations (version) VALUES ('20141120225729');

INSERT INTO schema_migrations (version) VALUES ('20141120231656');

INSERT INTO schema_migrations (version) VALUES ('20141120232643');

INSERT INTO schema_migrations (version) VALUES ('20141120232739');

INSERT INTO schema_migrations (version) VALUES ('20141121045322');

INSERT INTO schema_migrations (version) VALUES ('20141121052729');

INSERT INTO schema_migrations (version) VALUES ('20141122235506');

INSERT INTO schema_migrations (version) VALUES ('20141123020114');

INSERT INTO schema_migrations (version) VALUES ('20141126005557');

INSERT INTO schema_migrations (version) VALUES ('20141202052403');

INSERT INTO schema_migrations (version) VALUES ('20141202160839');

INSERT INTO schema_migrations (version) VALUES ('20141204054212');

INSERT INTO schema_migrations (version) VALUES ('20141206061851');

INSERT INTO schema_migrations (version) VALUES ('20141208154450');

INSERT INTO schema_migrations (version) VALUES ('20141208154458');

INSERT INTO schema_migrations (version) VALUES ('20150105163524');

INSERT INTO schema_migrations (version) VALUES ('20150105164321');

INSERT INTO schema_migrations (version) VALUES ('20150105174950');

INSERT INTO schema_migrations (version) VALUES ('20150113030034');

INSERT INTO schema_migrations (version) VALUES ('20150115162229');

INSERT INTO schema_migrations (version) VALUES ('20150126202815');

INSERT INTO schema_migrations (version) VALUES ('20150127213515');

INSERT INTO schema_migrations (version) VALUES ('20150127234918');

INSERT INTO schema_migrations (version) VALUES ('20150202230819');

INSERT INTO schema_migrations (version) VALUES ('20150203231505');

INSERT INTO schema_migrations (version) VALUES ('20150205194010');

INSERT INTO schema_migrations (version) VALUES ('20150207035249');

INSERT INTO schema_migrations (version) VALUES ('20150309152201');

INSERT INTO schema_migrations (version) VALUES ('20150422180646');

INSERT INTO schema_migrations (version) VALUES ('20150427175943');

INSERT INTO schema_migrations (version) VALUES ('20150515162424');

INSERT INTO schema_migrations (version) VALUES ('20150527025016');

INSERT INTO schema_migrations (version) VALUES ('20150716175829');

INSERT INTO schema_migrations (version) VALUES ('20150716180445');

INSERT INTO schema_migrations (version) VALUES ('20150717135750');

INSERT INTO schema_migrations (version) VALUES ('20150720160555');

