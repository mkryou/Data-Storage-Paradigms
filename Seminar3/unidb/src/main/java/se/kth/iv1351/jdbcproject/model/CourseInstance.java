

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
package se.kth.iv1351.jdbcproject.model;

public class CourseInstance implements CourseInstanceDTO {
    private String instanceId;
    private String courseCode;
    private double hp;
    private int numStudents;
    private String studyPeriod;
    private int courseLayoutId;
    private String studyYear;
    private int id;
    private double teachingCost; 

    public CourseInstance(String instanceId, String courseCode, double hp, int numStudents, double teachingCost) {
        this.instanceId = instanceId;
        this.courseCode = courseCode;
        this.hp = hp;
        this.numStudents = numStudents;
        this.teachingCost = teachingCost;
    }

    public CourseInstance() {}

    @Override
    public String getInstanceId() { return instanceId; }

    @Override
    public String getCourseCode() { return courseCode; }

    @Override
    public double getHp() { return hp; }

    @Override
    public int getNumberOfStudents() { return numStudents; }

    @Override
    public double getTeachingCost() { return teachingCost; }

    @Override
    public String toString() {
        return "CourseInstance{" +
                "instanceId='" + instanceId + '\'' +
                ", courseCode='" + courseCode + '\'' +
                ", hp=" + hp +
                ", numStudents=" + numStudents +
                ", teachingCost=" + teachingCost +
                '}';
    }

    public void setInstanceId(String instanceId) { this.instanceId = instanceId; }
    public void setCourseCode(String courseCode) { this.courseCode = courseCode; }
    public void setHp(double hp) { this.hp = hp; }
    public void setNumStudents(int numStudents) { 
        this.numStudents = numStudents; 
    }
    public void setTeachingCost(double teachingCost) { this.teachingCost = teachingCost; }
    public void setStudyPeriod(String studyPeriod) { this.studyPeriod = studyPeriod; }
    public void setCourseLayoutId(int courseLayoutId) { this.courseLayoutId = courseLayoutId; }
    public void setStudyYear(String studyYear) { this.studyYear = studyYear; }
    public void setId(int id) { this.id = id; }

}
