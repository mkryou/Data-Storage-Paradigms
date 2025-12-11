/*
 * The MIT License
 *
 * Copyright 2017 Leif Lindbäck <leifl@kth.se>.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package se.kth.iv1351.jdbcproject.integration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import se.kth.iv1351.jdbcproject.model.CourseInstance;
import se.kth.iv1351.jdbcproject.model.CourseInstanceDTO;

public class UniDAO {
    private Connection connection;

    public UniDAO() throws UniDBException {
        // Call the method to connect to the database
        connectToDatabase();
    }

    /**
     * Establishes a connection to the uni database and disables auto-commit.
     */
    private void connectToDatabase() throws UniDBException {
        try {
            connection = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/uni", 
                "melissakryou", 
                "password"
            );
            connection.setAutoCommit(false);
        } catch (SQLException e) {
            throw new UniDBException("Could not connect to DB", e);
        }
    }

    public List<CourseInstanceDTO> findTeachingCostPerCI(String instanceId) throws UniDBException {
        String sql = "SELECT ci.instance_id, cl.course_code, cl.hp, ci.num_students, " +
                     "(cl.hp * ci.num_students * 100) AS teaching_cost " +
                     "FROM course_instance ci " +
                     "JOIN course_layout cl ON ci.course_layout_id = cl.id " +
                     "WHERE ci.instance_id = ?";
        List<CourseInstanceDTO> list = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, instanceId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new CourseInstance(
                    rs.getString("instance_id"),
                    rs.getString("course_code"),
                    rs.getDouble("hp"),
                    rs.getInt("num_students"),
                    rs.getDouble("teaching_cost")
                ));
            }
        } catch (SQLException e) {
            throw new UniDBException("Error fetching teaching cost", e);
        }
        return list;
    }

    public void incStu(String instanceId) throws UniDBException {
        String sql = "UPDATE course_instance SET num_students = num_students + 1 WHERE instance_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, instanceId);
            int updated = stmt.executeUpdate();
            if (updated == 0) throw new UniDBException("No course instance found: " + instanceId);
            connection.commit(); // commit after successful update
        } catch (SQLException e) {
            try { connection.rollback(); } catch (SQLException ex) { /* ignore */ }
            throw new UniDBException("Failed to increment students", e);
        }
    }

 public void allocate(int employeeId, String courseInstanceId, String plannedActivity) throws UniDBException {
    int ciId = getCourseInstanceId(courseInstanceId);
    String sql = "INSERT INTO allocation(employee_id, course_instance_id, planned_activity) VALUES (?, ?, ?)";
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, employeeId);
        stmt.setInt(2, ciId);
        stmt.setString(3, plannedActivity);
        stmt.executeUpdate();
        connection.commit(); 
    } catch (SQLException e) {
        try { 
            connection.rollback(); 
        } catch (SQLException ex) { 
        }
        throw new UniDBException("Failed to allocate employee", e); 
    }
}


    public void deallocate(int employeeId, String courseInstanceId, String plannedActivity) throws UniDBException {
        int ciId = getCourseInstanceId(courseInstanceId);
        String sql = "DELETE FROM allocation WHERE employee_id = ? AND course_instance_id = ? AND planned_activity = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, employeeId);
            stmt.setInt(2, ciId);
            stmt.setString(3, plannedActivity);
            stmt.executeUpdate();
            connection.commit(); 
        } catch (SQLException e) {
            try { connection.rollback(); } catch (SQLException ex) { /* ignore */ }
            throw new UniDBException("Failed to deallocate employee", e);
        }
    }

    public List<String> exercise(String activityName) throws UniDBException {
        String sql = "SELECT DISTINCT ci.instance_id " +
                     "FROM planned_activity pa " +
                     "JOIN course_instance ci ON pa.course_instance_id = ci.id " +
                     "JOIN teaching_activity ta ON pa.teaching_activity_id = ta.id " +
                     "WHERE ta.activity_name = ?";
        List<String> list = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, activityName);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("instance_id"));
            }
        } catch (SQLException e) {
            throw new UniDBException("Failed to fetch exercises", e);
        }
        return list;
    }

    private int getCourseInstanceId(String instanceId) throws UniDBException {
        String sql = "SELECT id FROM course_instance WHERE instance_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, instanceId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt("id");
            throw new UniDBException("Course instance not found: " + instanceId);
        } catch (SQLException e) {
            throw new UniDBException("Failed to fetch course instance ID", e);
        }
    }
}
