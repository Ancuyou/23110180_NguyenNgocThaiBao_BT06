package org.example.demospringboot.utils;

import java.io.File;

public class Constant {
    public static final String SESSION_USERNAME = "username";
    public static final String COOKIE_REMEMBER = "username";
    public static final String DIR = System.getProperty("user.dir")
            + File.separator + "uploads";
    public static class Path {
        public static final String REGISTER = "/view/register.jsp";
        public static final String LOGIN = "/view/login.jsp";
        public static final String HOME = "/view/home.jsp";
    }
}