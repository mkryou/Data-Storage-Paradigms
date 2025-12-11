package se.kth.iv1351.jdbcproject.model;

/**
 * Data Transfer Object representing a Course Instance.
 * This class is now concrete and can be instantiated directly.
 */
public interface CourseInstanceDTO {
  String getInstanceId();

    String getCourseCode();

     double getHp();

     int getNumberOfStudents();
     double getTeachingCost();
}
