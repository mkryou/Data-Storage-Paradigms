
SELECT
    course_layout.course_code,
    course_instance.instance_id,
    course_instance.study_period,
    SUM(planned_activity.planned_hours * (employee.salary / 240)) AS planned_cost,
        SUM(
            planned_activity.planned_hours * teaching_activity.factor * (employee.salary / 240)
            )
        + (2 * course_layout.hp + 28 + 0.2 * course_instance.num_students)
        + (32 + 0.725 * course_instance.num_students) AS total_cost
FROM course_instance
JOIN course_layout 
    ON course_layout.id = course_instance.course_layout_id
JOIN planned_activity 
    ON planned_activity.course_instance_id = course_instance.id
JOIN teaching_activity
    ON teaching_activity.id = planned_activity.teaching_activity_id
JOIN allocation
    ON allocation.course_instance_id = course_instance.id
   AND allocation.planned_activity = planned_activity.planned_activity
JOIN employee
    ON employee.id = allocation.employee_id
    
WHERE course_instance.study_year = '2025-01-01'
    AND course_code ='CS101'

GROUP BY
    course_layout.course_code,  
    course_instance.instance_id, 
    course_instance.study_period,
    course_instance.num_students,
    course_layout.hp;

SELECT
    cl.course_code,
    ci.instance_id,
    ci.study_period,
    COALESCE(SUM(pa.planned_hours * (e.salary / 240)), 0) AS planned_cost,
    COALESCE(
        SUM(pa.planned_hours * ta.factor * (e.salary / 240)), 0
    ) + (2 * cl.hp + 28 + 0.2 * ci.num_students) + (32 + 0.725 * ci.num_students) AS total_cost
FROM course_instance ci
JOIN course_layout cl ON cl.id = ci.course_layout_id
LEFT JOIN planned_activity pa ON pa.course_instance_id = ci.id
LEFT JOIN teaching_activity ta ON ta.id = pa.teaching_activity_id
LEFT JOIN allocation a ON a.course_instance_id = ci.id AND a.planned_activity = pa.planned_activity
LEFT JOIN employee e ON e.id = a.employee_id
WHERE ci.instance_id = 'MA101-2025-P1'
GROUP BY
    cl.course_code,
    ci.instance_id,
    ci.study_period,
    ci.num_students,
    cl.hp;


teaching_activity -> Add new teaching_activity

INSERT INTO teaching_activity (name, factor)
VALUES ('Exercise', 1.4);

SELECT course_instance_id,
course_layout.course_code,
teaching_activity.activity_name,
planned_activity.pl

INSERT INTO teaching_activity (activity_name, factor)
VALUES ('Exercise', 1.4);

SELECT teaching_activity.id FROM teaching_activity WHERE activity_name = "Exercise" ;

INSERT INTO planned_activity (planned_activity, course_instance_id, teaching_activity_id, planned_hours)
VALUES ('EX1', 3, 8, 12);


INSERT INTO allocation (employee_id, course_instance_id, planned_activity)
VALUES (3, 3, 'EX1');

SELECT
    course_instance.instance_id,
    course_layout.course_code,
    person.first_name,
    person.last_name,
    teaching_activity.activity_name AS teaching_activity,
    planned_activity.planned_activity,
    planned_activity.planned_hours
FROM planned_activity
JOIN teaching_activity
    ON planned_activity.teaching_activity_id = teaching_activity.id
JOIN course_instance
    ON course_instance.id = planned_activity.course_instance_id
JOIN course_layout
    ON course_layout.id = course_instance.course_layout_id
JOIN allocation
    ON allocation.course_instance_id = course_instance.id
   AND allocation.planned_activity = planned_activity.planned_activity
JOIN employee
    ON employee.id = allocation.employee_id
JOIN person
    ON person.id = employee.person_id
WHERE teaching_activity.activity_name = 'Exercise';
