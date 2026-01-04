CREATE INDEX idx_course_instance_study_year
ON course_instance(study_year);

CREATE INDEX idx_planned_activity_course_instance_id 
ON planned_activity(course_instance_id);

CREATE INDEX idx_course_layout_course_code 
ON course_layout(course_code);

CREATE INDEX idx_allocation_employee
ON allocation(employee_id);
 
