WITH allocated_per_instance AS (
    SELECT
        course_code,
        instance_id,
        SUM(total_hours) AS total_allocated_hours
    FROM allocated_hours_view
    GROUP BY course_code, instance_id
)
SELECT
    p.course_code,
    p.instance_id,
    p.total_hours AS planned_hours,
    a.total_allocated_hours,
    ((a.total_allocated_hours - p.total_hours) / p.total_hours) * 100 AS difference_percent
FROM planned_hours_view p
JOIN allocated_per_instance a
    ON p.instance_id = a.instance_id
WHERE p.study_year = '2025-01-01'
  AND ABS((a.total_allocated_hours - p.total_hours) / p.total_hours) > 0.15
ORDER BY difference_percent DESC;
