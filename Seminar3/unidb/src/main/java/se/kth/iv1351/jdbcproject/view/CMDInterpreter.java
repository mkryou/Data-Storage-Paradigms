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
package se.kth.iv1351.jdbcproject.view;

import java.util.List;
import java.util.Scanner;

import se.kth.iv1351.jdbcproject.controller.Controller;
import se.kth.iv1351.jdbcproject.model.CourseInstanceDTO;
import se.kth.iv1351.jdbcproject.model.CourseInstanceException;

public class CMDInterpreter {
    private static final String PROMPT = "<>";
    private final Scanner console = new Scanner(System.in);
    private Controller ctrl;
    private boolean keepReceivingCmds = false;

    public CMDInterpreter(Controller ctrl) {
        this.ctrl = ctrl;
    }

    public void stop() {
        keepReceivingCmds = false;
    }

    public void handleCmds() {
        keepReceivingCmds = true;
        while (keepReceivingCmds) {
            try {
                CmdLine cmdLine = new CmdLine(readNextLine());
                switch (cmdLine.getCmd()) {
                    case HELP:
                        for (Command command : Command.values()) {
                            if (command != Command.ILLEGAL_COMMAND) {
                                System.out.println(command.toString().toLowerCase());
                            }
                        }
                        break;

                    case QUIT:
                        keepReceivingCmds = false;
                        break;

                    case COSTCI:
                    try {
                String courseInstanceId = cmdLine.getParameter(0);
                List<CourseInstanceDTO> instances = ctrl.getTeachingCost(courseInstanceId);
                if (instances != null && !instances.isEmpty()) {
                    for (CourseInstanceDTO ci : instances) {
                        System.out.println("Course instance: " + courseInstanceId +
                                        ", Teaching cost: " + ci.getTeachingCost() +
                                        ", Number of students: " + ci.getNumberOfStudents());
                    }
                } else {
                    System.out.println("No such course instance: " + courseInstanceId);
                }
            } catch (CourseInstanceException e) {
                System.out.println("Failed to calculate teaching cost");
                e.printStackTrace();
            }
            break;


                    case INCSTU:
                        try {
                            String courseId = cmdLine.getParameter(0);
                            ctrl.incStu(courseId);
                            System.out.println("Increased number of students for " + courseId);
                        } catch (CourseInstanceException e) {
                            System.out.println("Failed to increase number of students");
                            System.out.println(e.getMessage());
                            e.printStackTrace();
                        }
                        break;

                    case ALLOC:
                        try {
                            String courseInstance = cmdLine.getParameter(0);
                            System.out.print("Enter employee ID: ");
                            int employeeId = Integer.parseInt(console.nextLine());
                            System.out.print("Enter planned activity: ");
                            String plannedActivity = console.nextLine();
                            ctrl.alloc(employeeId, courseInstance, plannedActivity);
                            System.out.println("Allocated teaching activity " + plannedActivity + " for " + courseInstance);
                        } catch (CourseInstanceException e) {
                            System.out.println("Failed to allocate teaching activities");
                            System.out.println(e.getMessage());
                            e.printStackTrace();
                        }
                        break;


                            case DEALLOC:
                        try {
                            String courseInstance = cmdLine.getParameter(0);
                            System.out.print("Enter employee ID: ");
                            int employeeId = Integer.parseInt(console.nextLine());
                            System.out.print("Enter planned activity: ");
                            String plannedActivity = console.nextLine();
                            ctrl.dealloc(employeeId, courseInstance, plannedActivity);
                            System.out.println("Deallocated teaching activity " + plannedActivity + " for " + courseInstance);
                        } catch (CourseInstanceException e) {
                            System.out.println("Failed to deallocate teaching activities");
                            System.out.println(e.getMessage());
                            e.printStackTrace();
                        }
                        break;

                    case EXERCISE:
    try {
        System.out.print("Enter activity name: ");
        String activityName = console.nextLine();
        List<String> details = ctrl.exercise(activityName);
        if (details.isEmpty()) {
            System.out.println("No exercise activities found for: " + activityName);
        } else {
            System.out.println("Exercise activities:");
            for (String detail : details) {
                System.out.println(detail);
            }
        }
    } catch (CourseInstanceException e) {
        System.out.println("Failed to show exercise details");
        e.printStackTrace();
    }
    break;

                    default:
                        System.out.println("Illegal command");
                }
            } catch (Exception e) {
                System.out.println("Operation failed");
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
        }
    }

    private String readNextLine() {
        System.out.print(PROMPT);
        return console.nextLine();
    }
}
