package se.kth.iv1351.jdbcproject.controller;

import java.util.ArrayList;
import java.util.List;

import se.kth.iv1351.jdbcproject.integration.UniDAO;
import se.kth.iv1351.jdbcproject.integration.UniDBException;
import se.kth.iv1351.jdbcproject.model.CourseInstance;
import se.kth.iv1351.jdbcproject.model.CourseInstanceDTO;
import se.kth.iv1351.jdbcproject.model.CourseInstanceException;

public class Controller {
    private final UniDAO uniDb;

    public Controller() throws UniDBException {
        uniDb = new UniDAO();
    }

    public List<CourseInstanceDTO> getTeachingCost(String courseInstanceId) throws CourseInstanceException {
        try {
            var list = uniDb.findTeachingCostPerCI(courseInstanceId);
            List<CourseInstanceDTO> dtoList = new ArrayList<>();
            if (list != null) {
                for (var ci : list) {
                    dtoList.add(new CourseInstance(
                        ci.getInstanceId(),
                        ci.getCourseCode() != null ? ci.getCourseCode() : "UNKNOWN",
                        ci.getHp(),
                        ci.getNumberOfStudents(),
                        ci.getTeachingCost()
                    ));
                }
            }
            return dtoList;
        } catch (UniDBException e) {
            throw new CourseInstanceException("Could not get teaching cost", e);
        }
    }

    public void incStu(String courseInstanceId) throws CourseInstanceException {
        if (courseInstanceId == null || courseInstanceId.isBlank()) {
            throw new CourseInstanceException("Course instance cannot be null or blank");
        }
        try {
            uniDb.incStu(courseInstanceId);
        } catch (UniDBException e) {
            throw new CourseInstanceException("Could not increment students for: " + courseInstanceId, e);
        }
    }

    public void alloc(int employeeId, String courseInstanceId, String plannedActivity) throws CourseInstanceException {
        if (courseInstanceId == null || courseInstanceId.isBlank() || plannedActivity == null || plannedActivity.isBlank()) {
            throw new CourseInstanceException("Invalid input for allocation");
        }
        try {
            uniDb.allocate(employeeId, courseInstanceId, plannedActivity);
        } catch (UniDBException e) {
            throw new CourseInstanceException(
                "Could not allocate employee " + employeeId + " to activity " + plannedActivity + " in course " + courseInstanceId, e
            );
        }
    }

    public void dealloc(int employeeId, String courseInstanceId, String plannedActivity) throws CourseInstanceException {
        if (courseInstanceId == null || courseInstanceId.isBlank() || plannedActivity == null || plannedActivity.isBlank()) {
            throw new CourseInstanceException("Invalid input for deallocation");
        }
        try {
            uniDb.deallocate(employeeId, courseInstanceId, plannedActivity);
        } catch (UniDBException e) {
            throw new CourseInstanceException(
                "Could not deallocate employee " + employeeId + " from activity " + plannedActivity + " in course " + courseInstanceId, e
            );
        }
    }

    public List<String> exercise(String activityName) throws CourseInstanceException {
        if (activityName == null || activityName.isBlank()) {
            throw new CourseInstanceException("Activity name cannot be null or blank");
        }
        try {
            return uniDb.exercise(activityName);
        } catch (UniDBException e) {
            throw new CourseInstanceException(
                "Could not fetch exercise details for activity: " + activityName, e
            );
        }
    }
}
