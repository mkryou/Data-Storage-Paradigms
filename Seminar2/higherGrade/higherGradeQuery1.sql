CREATE VIEW planned_hours_view AS
SELECT
    course_layout.course_code,
    course_layout.hp,
    course_instance.instance_id,
    course_instance.study_period,
    course_instance.study_year,
    course_instance.num_students,
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
FROM course_layout 
JOIN course_instance 
    ON course_layout.id = course_instance.course_layout_id
JOIN planned_activity 
    ON course_instance.id = planned_activity.course_instance_id
JOIN teaching_activity 
    ON planned_activity.teaching_activity_id = teaching_activity.id
GROUP BY 
    course_layout.course_code, 
    course_layout.hp, 
    course_instance.instance_id, 
    course_instance.study_period, 
    course_instance.num_students,
course_instance.study_year;


SELECT * FROM planned_hours_view WHERE study_year = '2025-01-01';
