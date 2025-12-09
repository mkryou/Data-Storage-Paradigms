package se.kth.iv1351.jdbcproject.view;

public enum Command {

    /**
     * checks cost of one course instance
     */
    COSTCI,

    /**
     * Help, commands become visible
     */
    HELP,

    /**
     * increases number of students for a specific course instance by 100
     */
    INCSTU,

    /**
     * allocate teaching activities for various course instances
     */
    ALLOC,
    /**
     * deallocate teaching activities for various course instances
     */ 
    DEALLOC,
    /**
     * Adds teaching activity called "Execise", associated with one course instance and one teacher
     */
    EXERCISE,
    /**
     * none of the above
     */
    ILLEGAL_COMMAND
}