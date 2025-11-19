INSERT INTO course_layout (course_code, course_name, min_students, max_students, hp, version) VALUES
('CS101', 'Intro to Programming', '10', '100', '7.5', 1),
('CS201', 'Data Structures', '15', '80', '7.5', 1),
('MA101', 'Calculus I', '20', '120', '10', 1);

INSERT INTO department (department_name) VALUES
('Computer Science'),
('Mathematics');

INSERT INTO job_title (job_title) VALUES
('Professor'),
('Lecturer'),
('Teaching Assistant');

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

INSERT INTO employee_salary_history (employee_id, salary, valid_from, valid_to) VALUES
(1, 52000, '2025-01-01', NULL),
(2, 48000, '2025-01-01', NULL),
(3, 39000, '2025-01-01', NULL),
(4, 32000, '2025-01-01', NULL),
(5, 45000, '2025-01-01', NULL);

INSERT INTO department_manager (employee_id, department_id) VALUES
(1, 1),
(2, 2);

INSERT INTO teaching_activity (activity_name, factor) VALUES
('Lecture', '1.0'),
('Lab', '0.5'),
('Seminar', '0.7'),
('Tutorial', '0.4');

INSERT INTO course_instance (instance_id, study_period, study_year, course_layout_id, course_layout_version, num_students) VALUES
('CS101-2025-P1', 'P1', '2025-01-01', 1, 1, '85'),
('CS201-2025-P2', 'P2', '2025-01-01', 2, 1, '60'),
('MA101-2025-P1', 'P1', '2025-01-01', 3, 1, '110');

INSERT INTO planned_activity (planned_activity, course_instance_id, teaching_activity_id, planned_hours) VALUES
('Intro Lecture', 1, 1, '10'),
('Programming Lab A', 1, 2, '20'),
('Data Structures Lecture', 2, 1, '12'),
('Calculus Seminar', 3, 3, '15');

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

INSERT INTO allocation (teaching_activity_id, employee_id, course_instance_id) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 2, 3),
(2, 3, 1),
(4, 5, 2);

INSERT INTO course_instance_employee (employee_id, course_instance_id) VALUES
(1, 1),
(3, 1),
(2, 3),
(4, 1),
(5, 2);
