CREATE MATERIALIZED VIEW allocated_teacher_view AS

SELECT employment_id , first_name, last_name, study_period, COUNT(DISTINCT course_instance.id) FROM employee, person, course_instance, allocation
WHERE person.id = employee.person_id
AND study_period = 'P1'
AND employee.id = allocation.employee_id
AND allocation.course_instance_id = course_instance.id
AND study_year = '2025-01-01'
GROUP BY employee.employment_id, 
    person.first_name, 
    person.last_name, 
    course_instance.study_period
HAVING COUNT(DISTINCT course_instance.id) > 0;

SELECT * FROM allocated_teacher_view;