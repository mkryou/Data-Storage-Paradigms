SELECT
    course_layout.course_code,
    course_layout.hp,
    course_instance.instance_id,
    course_instance.study_period,
    course_instance.num_students,
    person.first_name,
    person.last_name,
job_title,
    SUM(CASE WHEN planned_activity.teaching_activity_id = 1 THEN CAST(planned_activity.planned_hours AS DECIMAL) ELSE 0 END) AS lecture_hours,
    SUM(CASE WHEN planned_activity.teaching_activity_id = 2 THEN CAST(planned_activity.planned_hours AS DECIMAL) ELSE 0 END) AS lab_hours,
    SUM(CASE WHEN planned_activity.teaching_activity_id = 3 THEN CAST(planned_activity.planned_hours AS DECIMAL) ELSE 0 END) AS seminar_hours,
    SUM(CASE WHEN planned_activity.teaching_activity_id = 4 THEN CAST(planned_activity.planned_hours AS DECIMAL) ELSE 0 END) AS tutorial_hours,
    (2 * CAST(course_layout.hp AS DECIMAL) + 28 + 0.2 * CAST(course_instance.num_students AS INTEGER)) AS admin_hours,
    (32 + 0.725 * CAST(course_instance.num_students AS INTEGER)) AS examination_hours,
(
        SUM(planned_activity.planned_hours::INT * teaching_activity.factor::NUMERIC)
        + (2 * course_layout.hp::NUMERIC + 28 + 0.2 * course_instance.num_students::NUMERIC)
        + (32 + 0.725 * course_instance.num_students::NUMERIC)
    ) AS total_hours

FROM 
    planned_activity, 
    course_layout, 
    course_instance, 
    person, 
    employee, 
    allocation,
    teaching_activity,
job_title
WHERE 
    course_layout.id = course_instance.course_layout_id
    AND course_instance.id = planned_activity.course_instance_id
    AND course_instance.study_year = '2025-01-01'
    AND person.id = employee.person_id
    AND employee.id = allocation.employee_id
    AND allocation.course_instance_id = planned_activity.course_instance_id
    AND allocation.teaching_activity_id = planned_activity.teaching_activity_id
    AND planned_activity.teaching_activity_id = teaching_activity.id
AND person.first_name ='Robert'
AND employee.job_title_id = job_title.id
GROUP BY 
    course_layout.course_code, 
    course_layout.hp, 
    course_instance.instance_id, 
    course_instance.study_period, 
    course_instance.num_students,
    person.first_name,
    person.last_name,
job_title.job_title;