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

