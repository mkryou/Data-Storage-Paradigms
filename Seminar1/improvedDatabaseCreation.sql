CREATE TABLE course_layout (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    course_code VARCHAR(50) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    min_students VARCHAR(50) NOT NULL,
    max_students VARCHAR(50) NOT NULL,
    hp VARCHAR(50) NOT NULL,
    layout_version INT NOT NULL
);

CREATE TABLE department (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    department_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE job_title (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    job_title VARCHAR(50) NOT NULL
);

CREATE TABLE max_course_instance (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    max_instance INT NOT NULL
);

CREATE TABLE person (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    personal_number VARCHAR(12) UNIQUE,
    first_name VARCHAR(500),
    last_name VARCHAR(500),
    street VARCHAR(100),
    zip VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE phone_number (
    phone_no VARCHAR(500) NOT NULL,
    person_id INT NOT NULL,
    PRIMARY KEY (phone_no, person_id),
    FOREIGN KEY (person_id) REFERENCES person(id)
);

CREATE TABLE skill (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    skill_name VARCHAR(50) NOT NULL
);

CREATE TABLE teaching_activity (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    activity_name VARCHAR(100) NOT NULL,
    factor VARCHAR(10) NOT NULL
);

CREATE TABLE course_instance (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    instance_id VARCHAR(500) UNIQUE NOT NULL,
    study_period VARCHAR(100) NOT NULL,
    study_year DATE NOT NULL,
    course_layout_id INT NOT NULL,
    num_students VARCHAR(100) NOT NULL,
    FOREIGN KEY (course_layout_id) REFERENCES course_layout(id)
);

CREATE TABLE email (
    email VARCHAR(500) NOT NULL,
    person_id INT NOT NULL,
    PRIMARY KEY (email, person_id),
    FOREIGN KEY (person_id) REFERENCES person(id)
);

CREATE TABLE employee (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employment_id VARCHAR(500) UNIQUE NOT NULL,
    person_id INT NOT NULL,
    job_title_id INT NOT NULL,
    department_id INT NOT NULL,
    max_course_instance_id INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (job_title_id) REFERENCES job_title(id),
    FOREIGN KEY (department_id) REFERENCES department(id),
    FOREIGN KEY (max_course_instance_id) REFERENCES max_course_instance(id)
);

CREATE TABLE employee_skill (
    skill_id INT NOT NULL,
    employee_id INT NOT NULL,
    PRIMARY KEY (skill_id, employee_id),
    FOREIGN KEY (skill_id) REFERENCES skill(id),
    FOREIGN KEY (employee_id) REFERENCES employee(id)
);

CREATE TABLE planned_activity (
    planned_activity VARCHAR(500) NOT NULL,
    course_instance_id INT NOT NULL,
    teaching_activity_id INT NOT NULL,
    planned_hours VARCHAR(10) NOT NULL,
    PRIMARY KEY (planned_activity, course_instance_id),
    FOREIGN KEY (course_instance_id) REFERENCES course_instance(id),
    FOREIGN KEY (teaching_activity_id) REFERENCES teaching_activity(id)
);

CREATE TABLE salary_history (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employee_id INT NOT NULL,
    monthly_salary VARCHAR(300) NOT NULL,
    salary_version INT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employee(id)
);

CREATE TABLE allocation (
    employee_id INT NOT NULL,
    planned_activity VARCHAR(500) NOT NULL,
    course_instance_id INT NOT NULL,
    PRIMARY KEY (employee_id, planned_activity, course_instance_id),
    FOREIGN KEY (employee_id) REFERENCES employee(id),
    FOREIGN KEY (planned_activity, course_instance_id) REFERENCES planned_activity(planned_activity, course_instance_id)
);

CREATE TABLE department_manager (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employee_id INT NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employee(id),
    FOREIGN KEY (department_id) REFERENCES department(id)
);
