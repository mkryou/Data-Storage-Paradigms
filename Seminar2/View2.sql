CREATE MATERIALIZED VIEW teacher_view AS
SELECT
    course_layout.course_code,
    course_layout.hp,
    course_instance.instance_id,
    course_instance.study_period,
    person.first_name,
    person.last_name,
    job_title.job_title,

    SUM(CASE WHEN planned_activity.teaching_activity_id = 1 THEN planned_activity.planned_hours ELSE 0 END) AS lecture_hours,
    SUM(CASE WHEN planned_activity.teaching_activity_id = 2 THEN planned_activity.planned_hours ELSE 0 END) AS lab_hours,
    SUM(CASE WHEN planned_activity.teaching_activity_id = 3 THEN planned_activity.planned_hours ELSE 0 END) AS seminar_hours,
    SUM(CASE WHEN planned_activity.teaching_activity_id = 4 THEN planned_activity.planned_hours ELSE 0 END) AS tutorial_hours,

    (2 * course_layout.hp + 28 + 0.2 * course_instance.num_students) AS admin_hours,
    (32 + 0.725 * course_instance.num_students) AS examination_hours,

    (
        SUM(planned_activity.planned_hours * teaching_activity.factor)
        + (2 * course_layout.hp + 28 + 0.2 * course_instance.num_students)
        + (32 + 0.725 * course_instance.num_students)
    ) AS total_hours

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
JOIN person
    ON person.id = employee.person_id
JOIN job_title
    ON job_title.id = employee.job_title_id
    
WHERE course_instance.study_year = '2025-01-01'

GROUP BY
    course_layout.course_code, 
    course_layout.hp, 
    course_instance.instance_id, 
    course_instance.study_period, 
    course_instance.num_students,
    person.first_name,
    person.last_name,
    job_title.job_title;

SELECT * FROM teacher_view WHERE course_code ='CS101';