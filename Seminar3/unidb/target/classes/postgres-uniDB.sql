CREATE FUNCTION public.check_max_courses_per_teacher() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    course_count INT;
    new_period VARCHAR;
BEGIN
    SELECT study_period
    INTO new_period
    FROM course_instance
    WHERE id = NEW.course_instance_id;
    SELECT COUNT(*)
    INTO course_count
    FROM allocation
    JOIN course_instance ON allocation.course_instance_id = course_instance.id 
    WHERE allocation.employee_id = NEW.employee_id
      AND course_instance.study_period = new_period;

    IF course_count >= 4 THEN
        RAISE EXCEPTION 'Employee % is already assigned to 4 courses in period %',
            NEW.employee_id, new_period;
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_max_courses_per_teacher() OWNER TO melissakryou;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: allocation; Type: TABLE; Schema: public; Owner: melissakryou
--

CREATE TABLE public.allocation (
    employee_id integer NOT NULL,
    course_instance_id integer NOT NULL,
    planned_activity character varying(500) NOT NULL
);


ALTER TABLE public.allocation OWNER TO melissakryou;

--
-- Name: course_instance; Type: TABLE; Schema: public; Owner: melissakryou
--

CREATE TABLE public.course_instance (
    id integer NOT NULL,
    instance_id character varying(500) NOT NULL,
    study_period character varying(100) NOT NULL,
    study_year date NOT NULL,
    course_layout_id integer NOT NULL,
    num_students integer NOT NULL
);


ALTER TABLE public.course_instance OWNER TO melissakryou;

--
-- Name: course_instance_id_seq; Type: SEQUENCE; Schema: public; Owner: melissakryou
--

ALTER TABLE public.course_instance ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.course_instance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: course_layout; Type: TABLE; Schema: public; Owner: melissakryou
--

CREATE TABLE public.course_layout (
    id integer NOT NULL,
    course_code character varying(50) NOT NULL,
    course_name character varying(100) NOT NULL,
    min_students integer NOT NULL,
    max_students integer NOT NULL,
    hp numeric NOT NULL
);


ALTER TABLE public.course_layout OWNER TO melissakryou;

--
-- Name: course_layout_id_seq; Type: SEQUENCE; Schema: public; Owner: melissakryou
--

ALTER TABLE public.course_layout ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.course_layout_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: department; Type: TABLE; Schema: public; Owner: melissakryou
--

CREATE TABLE public.department (
    id integer NOT NULL,
    department_name character varying(100) NOT NULL
);


ALTER TABLE public.department OWNER TO melissakryou;

--
-- Name: department_id_seq; Type: SEQUENCE; Schema: public; Owner: melissakryou
--

ALTER TABLE public.department ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: department_manager; Type: TABLE; Schema: public; Owner: melissakryou
--

CREATE TABLE public.department_manager (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    department_id integer NOT NULL
);


ALTER TABLE public.department_manager OWNER TO melissakryou;

--
-- Name: department_manager_id_seq; Type: SEQUENCE; Schema: public; Owner: melissakryou
--

ALTER TABLE public.department_manager ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.department_manager_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: email; Type: TABLE; Schema: public; Owner: melissakryou
--

CREATE TABLE public.email (
    email character varying(500) NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.email OWNER TO melissakryou;

--
-- Name: employee; Type: TABLE; Schema: public; Owner: melissakryou
--

CREATE TABLE public.employee (
    id integer NOT NULL,
    employment_id character varying(500) NOT NULL,
    salary numeric,
    person_id integer NOT NULL,
    job_title_id integer NOT NULL,
    department_id integer NOT NULL
);


ALTER TABLE public.employee OWNER TO melissakryou;

--
-- Name: employee_id_seq; Type: SEQUENCE; Schema: public; Owner: melissakryou
--

ALTER TABLE public.employee ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: employee_skill; Type: TABLE; Schema: public; Owner: melissakryou
--

CREATE TABLE public.employee_skill (
    skill_id integer NOT NULL,
    employee_id integer NOT NULL
);


ALTER TABLE public.employee_skill OWNER TO melissakryou;

--
-- Name: job_title; Type: TABLE; Schema: public; Owner: melissakryou
--

CREATE TABLE public.job_title (
    id integer NOT NULL,
    job_title character varying(50) NOT NULL
);


ALTER TABLE public.job_title OWNER TO melissakryou;

--
-- Name: job_title_id_seq; Type: SEQUENCE; Schema: public; Owner: melissakryou
--

ALTER TABLE public.job_title ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.job_title_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: person; Type: TABLE; Schema: public; Owner: melissakryou
--

CREATE TABLE public.person (
    id integer NOT NULL,
    personal_number character varying(12),
    first_name character varying(500),
    last_name character varying(500),
    street character varying(100),
    zip character varying(100),
    city character varying(100)
);


ALTER TABLE public.person OWNER TO melissakryou;

--
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: melissakryou
--

ALTER TABLE public.person ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: phone_number; Type: TABLE; Schema: public; Owner: melissakryou
--

CREATE TABLE public.phone_number (
    phone_no character varying(500) NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.phone_number OWNER TO melissakryou;

--
-- Name: planned_activity; Type: TABLE; Schema: public; Owner: melissakryou
--

CREATE TABLE public.planned_activity (
    planned_activity character varying(500) NOT NULL,
    course_instance_id integer NOT NULL,
    teaching_activity_id integer NOT NULL,
    planned_hours integer NOT NULL
);


ALTER TABLE public.planned_activity OWNER TO melissakryou;

--
-- Name: skill; Type: TABLE; Schema: public; Owner: melissakryou
--

CREATE TABLE public.skill (
    id integer NOT NULL,
    skill_name character varying(50) NOT NULL
);


ALTER TABLE public.skill OWNER TO melissakryou;

--
-- Name: skill_id_seq; Type: SEQUENCE; Schema: public; Owner: melissakryou
--

ALTER TABLE public.skill ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.skill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: teaching_activity; Type: TABLE; Schema: public; Owner: melissakryou
--

CREATE TABLE public.teaching_activity (
    id integer NOT NULL,
    activity_name character varying(100) NOT NULL,
    factor numeric(4,2) NOT NULL
);


ALTER TABLE public.teaching_activity OWNER TO melissakryou;

--
-- Name: teacher_view; Type: MATERIALIZED VIEW; Schema: public; Owner: melissakryou
--

--
-- Name: teaching_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: melissakryou
--

ALTER TABLE public.teaching_activity ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.teaching_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: v_workload; Type: MATERIALIZED VIEW; Schema: public; Owner: melissakryou
--



--
-- Data for Name: course_instance; Type: TABLE DATA; Schema: public; Owner: melissakryou
--



--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: melissakryou
--


SELECT pg_catalog.setval('public.teaching_activity_id_seq', 4, true);


--
-- Name: course_instance course_instance_instance_id_key; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.course_instance
    ADD CONSTRAINT course_instance_instance_id_key UNIQUE (instance_id);


--
-- Name: course_layout course_layout_course_code_key; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.course_layout
    ADD CONSTRAINT course_layout_course_code_key UNIQUE (course_code);


--
-- Name: department department_department_name_key; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_department_name_key UNIQUE (department_name);


--
-- Name: employee employee_employment_id_key; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_employment_id_key UNIQUE (employment_id);


--
-- Name: person person_personal_number_key; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_personal_number_key UNIQUE (personal_number);


--
-- Name: allocation pk_allocation; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.allocation
    ADD CONSTRAINT pk_allocation PRIMARY KEY (employee_id, course_instance_id, planned_activity);


--
-- Name: course_instance pk_course_instance; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.course_instance
    ADD CONSTRAINT pk_course_instance PRIMARY KEY (id);


--
-- Name: course_layout pk_course_layout; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.course_layout
    ADD CONSTRAINT pk_course_layout PRIMARY KEY (id);


--
-- Name: department pk_department; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT pk_department PRIMARY KEY (id);


--
-- Name: department_manager pk_department_manager; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.department_manager
    ADD CONSTRAINT pk_department_manager PRIMARY KEY (id);


--
-- Name: email pk_email; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT pk_email PRIMARY KEY (email, person_id);


--
-- Name: employee pk_employee; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT pk_employee PRIMARY KEY (id);


--
-- Name: employee_skill pk_employee_skill; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.employee_skill
    ADD CONSTRAINT pk_employee_skill PRIMARY KEY (skill_id, employee_id);


--
-- Name: job_title pk_job_title; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.job_title
    ADD CONSTRAINT pk_job_title PRIMARY KEY (id);


--
-- Name: person pk_person; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT pk_person PRIMARY KEY (id);


--
-- Name: phone_number pk_phone_number; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.phone_number
    ADD CONSTRAINT pk_phone_number PRIMARY KEY (phone_no, person_id);


--
-- Name: planned_activity pk_planned_activity; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.planned_activity
    ADD CONSTRAINT pk_planned_activity PRIMARY KEY (planned_activity, course_instance_id);


--
-- Name: skill pk_skill; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.skill
    ADD CONSTRAINT pk_skill PRIMARY KEY (id);


--
-- Name: teaching_activity pk_teaching_activity; Type: CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.teaching_activity
    ADD CONSTRAINT pk_teaching_activity PRIMARY KEY (id);


--
-- Name: allocation trg_max_courses_per_teacher; Type: TRIGGER; Schema: public; Owner: melissakryou
--

CREATE TRIGGER trg_max_courses_per_teacher BEFORE INSERT OR UPDATE ON public.allocation FOR EACH ROW EXECUTE FUNCTION public.check_max_courses_per_teacher();


--
-- Name: allocation fk_allocation_0; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.allocation
    ADD CONSTRAINT fk_allocation_0 FOREIGN KEY (employee_id) REFERENCES public.employee(id);


--
-- Name: allocation fk_allocation_1; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.allocation
    ADD CONSTRAINT fk_allocation_1 FOREIGN KEY (course_instance_id) REFERENCES public.course_instance(id);


--
-- Name: allocation fk_allocation_2; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.allocation
    ADD CONSTRAINT fk_allocation_2 FOREIGN KEY (planned_activity, course_instance_id) REFERENCES public.planned_activity(planned_activity, course_instance_id);


--
-- Name: course_instance fk_course_instance_0; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.course_instance
    ADD CONSTRAINT fk_course_instance_0 FOREIGN KEY (course_layout_id) REFERENCES public.course_layout(id);


--
-- Name: department_manager fk_department_manager_0; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.department_manager
    ADD CONSTRAINT fk_department_manager_0 FOREIGN KEY (employee_id) REFERENCES public.employee(id);


--
-- Name: department_manager fk_department_manager_1; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.department_manager
    ADD CONSTRAINT fk_department_manager_1 FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: email fk_email_0; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT fk_email_0 FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: employee fk_employee_0; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT fk_employee_0 FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: employee fk_employee_1; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT fk_employee_1 FOREIGN KEY (job_title_id) REFERENCES public.job_title(id);


--
-- Name: employee fk_employee_2; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT fk_employee_2 FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: employee_skill fk_employee_skill_0; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.employee_skill
    ADD CONSTRAINT fk_employee_skill_0 FOREIGN KEY (skill_id) REFERENCES public.skill(id);


--
-- Name: employee_skill fk_employee_skill_1; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.employee_skill
    ADD CONSTRAINT fk_employee_skill_1 FOREIGN KEY (employee_id) REFERENCES public.employee(id);


--
-- Name: phone_number fk_phone_number_0; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.phone_number
    ADD CONSTRAINT fk_phone_number_0 FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: planned_activity fk_planned_activity_0; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.planned_activity
    ADD CONSTRAINT fk_planned_activity_0 FOREIGN KEY (course_instance_id) REFERENCES public.course_instance(id);


--
-- Name: planned_activity fk_planned_activity_1; Type: FK CONSTRAINT; Schema: public; Owner: melissakryou
--

ALTER TABLE ONLY public.planned_activity
    ADD CONSTRAINT fk_planned_activity_1 FOREIGN KEY (teaching_activity_id) REFERENCES public.teaching_activity(id);
INSERT INTO course_layout (course_code, course_name, min_students, max_students, hp) VALUES
('CS101', 'Intro to Programming', '10', '100', '7.5'),
('CS201', 'Data Structures', '15', '80', '7.5'),
('MA101', 'Calculus I', '20', '120', '10'),
('IX1500', 'Discrete Mathematics', '20', '80', '7.5'),
('IX1351', 'Data Storage Paradigms', '15', '100','7.5');

INSERT INTO department (department_name) VALUES
('Computer Science'),
('Mathematics'),
('Physics');

INSERT INTO job_title (job_title) VALUES
('Professor'),
('Lecturer'),
('Teaching Assistant')

INSERT INTO person (personal_number, first_name, last_name, street, zip, city) VALUES
('198001019999', 'Alice', 'Johnson', 'Maple St 10', '12345', 'Springfield'),
('197505058888', 'Robert', 'Brown', 'Oak St 22', '54321', 'Springfield'),
('199203036666', 'Emily', 'Clark', 'Pine St 5', '67890', 'Shelbyville'),
('199511224444', 'Daniel', 'Smith', 'Elm St 8', '11223', 'Springfield'),
('198805057777', 'Laura', 'White', 'Cedar St 9', '13579', 'Shelbyville');

INSERT INTO phone_number (phone_no, person_id) VALUES
('555-1001', 1),
('555-2002', 2),
('555-3003', 3),
('555-4004', 4),
('555-5005', 5);

INSERT INTO email (email, person_id) VALUES
('alice.johnson@univ.edu', 1),
('robert.brown@univ.edu', 2),
('emily.clark@univ.edu', 3),
('daniel.smith@univ.edu', 4),
('laura.white@univ.edu', 5);

INSERT INTO employee (employment_id, salary, person_id, job_title_id, department_id) VALUES
('EMP001', '52000', 1, 1, 1),
('EMP002', '48000', 2, 1, 2),
('EMP003', '39000', 3, 2, 1),
('EMP004', '32000', 4, 3, 1),
('EMP005', '45000', 5, 2, 2);

INSERT INTO department_manager (employee_id, department_id) VALUES
(1, 1),
(2, 2);

INSERT INTO teaching_activity (activity_name, factor) VALUES
('Lecture', '3.60'),
('Lab', '2.40'),
('Seminar', '1.80'),
('Tutorial', '2.40');

INSERT INTO course_instance (instance_id, study_period, study_year, course_layout_id, course_layout_version, num_students) VALUES
('CS101-2025-P1', 'P1', '2025-01-01', 1, 1, '85'),
('CS201-2025-P2', 'P2', '2025-01-01', 2, 1, '60'),
('MA101-2025-P1', 'P1', '2025-01-01', 3, 1, '110'),
('IV1351-2024-P1', 'P1', '2024-01-01', 5, '76'),
('IV1351-2025-P1', 'P1', '2025-01-01', 5, '66'),
('IX1500-2025-P1', 'P1', '2025-01-01', 4, '69'),
('CS201-2025-P1', 'P1', '2025-01-01', 2, '73');


INSERT INTO planned_activity (planned_activity, course_instance_id, teaching_activity_id, planned_hours) VALUES
('Intro Lecture', 1, 1, '10'),
('Programming Lab A', 1, 2, '20'),
('Data Structures Lecture', 2, 1, '12'),
('Calculus Seminar', 3, 3, '15'),
('Lecture 1.1', 5, 1,'13'),
('Seminar1', 5, 1, '0'),
('Graphs Lecture', 6, 1, '11'),
('DBMS Tutorial', 7, 4, '8');

INSERT INTO skill (skill_name) VALUES
('Programming'),
('Mathematics'),
('Java'),
('Lab Assistance');

INSERT INTO employee_skill (skill_id, employee_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(2, 5);

INSERT INTO allocation (employee_id, course_instance_id, planned_activity) VALUES
(1, 1, 'Intro Lecture'),
(1, 1, 'Programming Lab A'),
(2, 3, 'Calculus Seminar'),
(3, 1, 'Programming Lab A'),
(4, 5, 'Seminar1'),
(4, 5, 'Lecture 1.1'),
(5, 2, 'Data Structure Lecture'),
(1, 6, 'Graphs Lecture'),
(1, 5, 'Seminar1');
