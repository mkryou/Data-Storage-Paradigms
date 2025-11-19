CREATE DATABASE uni;

CREATE TABLE course_layout (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    course_code UNIQUE VARCHAR(50) NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    min_students VARCHAR(50) NOT NULL,
    max_students VARCHAR(50) NOT NULL,
    hp VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE department (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    department_name UNIQUE VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE job_title (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE person (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    personal_number UNIQUE VARCHAR(12),
    first_name VARCHAR(500),
    last_name VARCHAR(500),
    street VARCHAR(100),
    zip VARCHAR(100),
    city VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE phone_number (
    phone_no VARCHAR(500) NOT NULL,
    person_id INT NOT NULL,
    PRIMARY KEY (phone_no, person_id),
    FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE
);

CREATE TABLE email (
    email VARCHAR(500) NOT NULL,
    person_id INT NOT NULL,
    PRIMARY KEY (email, person_id),
    FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE
);

CREATE TABLE skill (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    skill_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE teaching_activity (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    activity_name VARCHAR(100) NOT NULL,
    factor VARCHAR(10) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE course_instance (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    instance_id UNIQUE VARCHAR(500) NOT NULL,
    study_period VARCHAR(100) NOT NULL,
    study_year DATE NOT NULL,
    course_layout_id INT NOT NULL,
    num_students VARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (course_layout_id) REFERENCES course_layout(id)
);

CREATE TABLE employee (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    employment_id UNIQUE VARCHAR(500) NOT NULL,
    salary VARCHAR(500),
    person_id INT NOT NULL,
    job_title_id INT NOT NULL,
    department_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (job_title_id) REFERENCES job_title(id),
    FOREIGN KEY (department_id) REFERENCES department(id)
);

CREATE TABLE employee_skill (
    skill_id INT NOT NULL,
    employee_id INT NOT NULL,
    PRIMARY KEY (skill_id, employee_id),
    FOREIGN KEY (skill_id) REFERENCES skill(id),
    FOREIGN KEY (employee_id) REFERENCES employee(id) ON DELETE CASCADE
);

CREATE TABLE planned_activity (
    planned_activity VARCHAR(500) NOT NULL,
    course_instance_id INT NOT NULL,
    teaching_activity_id INT NOT NULL,
    planned_hours VARCHAR(10) NOT NULL,
    PRIMARY KEY (planned_activity, course_instance_id),
    FOREIGN KEY (course_instance_id) REFERENCES course_instance(id) ON DELETE CASCADE,
    FOREIGN KEY (teaching_activity_id) REFERENCES teaching_activity(id)
);

CREATE TABLE allocation (
    teaching_activity_id INT NOT NULL,
    employee_id INT NOT NULL,
    course_instance_id INT NOT NULL,
    PRIMARY KEY (teaching_activity_id, employee_id, course_instance_id),
    FOREIGN KEY (teaching_activity_id) REFERENCES teaching_activity(id),
    FOREIGN KEY (employee_id) REFERENCES employee(id) ON DELETE CASCADE,
    FOREIGN KEY (course_instance_id) REFERENCES course_instance(id) ON DELETE CASCADE
);

CREATE TABLE course_instance_employee (
    employee_id INT NOT NULL,
    course_instance_id INT NOT NULL,
    PRIMARY KEY (employee_id, course_instance_id),
    FOREIGN KEY (employee_id) REFERENCES employee(id) ON DELETE CASCADE,
    FOREIGN KEY (course_instance_id) REFERENCES course_instance(id) ON DELETE CASCADE
);

CREATE TABLE department_manager (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    employee_id INT,
    department_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (employee_id) REFERENCES employee(id),
    FOREIGN KEY (department_id) REFERENCES department(id)
);
