SELECT
    course_layout.course_code,
     course_layout.hp,
     course_instance.instance_id,
     course_instance.study_period,
     course_instance.num_students,
     SUM(CASE WHEN planned_activity.teaching_activity_id = 1 THEN planned_activity.planned_hours::INT ELSE 0 END) AS lecture_hours,
     SUM(CASE WHEN planned_activity.teaching_activity_id = 2 THEN planned_activity.planned_hours::INT ELSE 0 END) AS lab_hours,
     SUM(CASE WHEN planned_activity.teaching_activity_id = 3 THEN planned_activity.planned_hours::INT ELSE 0 END) AS seminar_hours,
     SUM(CASE WHEN planned_activity.teaching_activity_id = 4 THEN planned_activity.planned_hours::INT ELSE 0 END) AS tutorial_hours,
     (2 * course_layout.hp::NUMERIC + 28 + 0.2 * course_instance.num_students::NUMERIC) AS admin_hours,
     (32 + 0.725 * course_instance.num_students::NUMERIC) AS examination_hours,
     (
        SUM(planned_activity.planned_hours::INT * teaching_activity.factor::NUMERIC)
        + (2 * course_layout.hp::NUMERIC + 28 + 0.2 * course_instance.num_students::NUMERIC)
        + (32 + 0.725 * course_instance.num_students::NUMERIC)
    ) AS total_hours
    FROM 
     planned_activity, course_layout, course_instance, teaching_activity
 WHERE 
     course_layout.id = course_instance.course_layout_id
     AND course_instance.id = planned_activity.course_instance_id
     AND planned_activity.teaching_activity_id = teaching_activity.id
     AND course_instance.study_year = '2025-01-01'
 GROUP BY 
     course_layout.course_code, course_layout.hp, course_instance.instance_id, course_instance.study_period, course_instance.num_students;