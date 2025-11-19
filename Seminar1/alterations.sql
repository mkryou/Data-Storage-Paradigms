-- Schema altercations:

-- phone_number TO person
ALTER TABLE phone_number DROP CONSTRAINT FK_phone_number_0;
ALTER TABLE phone_number
ADD CONSTRAINT FK_phone_number_0 FOREIGN KEY (person_id)
REFERENCES person(id) ON DELETE CASCADE;

-- email TO person
ALTER TABLE email DROP CONSTRAINT FK_email_0;
ALTER TABLE email
ADD CONSTRAINT FK_email_0 FOREIGN KEY (person_id)
REFERENCES person(id) ON DELETE CASCADE;

-- employee_skill TO employee
ALTER TABLE employee_skill DROP CONSTRAINT FK_employee_skill_1;
ALTER TABLE employee_skill
ADD CONSTRAINT FK_employee_skill_1 FOREIGN KEY (employee_id)
REFERENCES employee(id) ON DELETE CASCADE;

-- planned_activity TO course_instance
ALTER TABLE planned_activity DROP CONSTRAINT FK_planned_activity_0;
ALTER TABLE planned_activity
ADD CONSTRAINT FK_planned_activity_0 FOREIGN KEY (course_instance_id)
REFERENCES course_instance(id) ON DELETE CASCADE;

-- allocation TO employee
ALTER TABLE allocation DROP CONSTRAINT FK_allocation_1;
ALTER TABLE allocation
ADD CONSTRAINT FK_allocation_1 FOREIGN KEY (employee_id)
REFERENCES employee(id) ON DELETE CASCADE;

-- allocation TO course_instance
ALTER TABLE allocation DROP CONSTRAINT FK_allocation_2;
ALTER TABLE allocation
ADD CONSTRAINT FK_allocation_2 FOREIGN KEY (course_instance_id)
REFERENCES course_instance(id) ON DELETE CASCADE;

-- course_instance_employee TO employee
ALTER TABLE course_instance_employee DROP CONSTRAINT FK_course_instance_employee_0;
ALTER TABLE course_instance_employee
ADD CONSTRAINT FK_course_instance_employee_0 FOREIGN KEY (employee_id)
REFERENCES employee(id) ON DELETE CASCADE;

-- course_instance_employee TO course_instance
ALTER TABLE course_instance_employee DROP CONSTRAINT FK_course_instance_employee_1;
ALTER TABLE course_instance_employee
ADD CONSTRAINT FK_course_instance_employee_1 FOREIGN KEY (course_instance_id)
REFERENCES course_instance(id) ON DELETE CASCADE;

