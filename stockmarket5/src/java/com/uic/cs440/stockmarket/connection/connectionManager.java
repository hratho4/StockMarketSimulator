/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.uic.cs440.stockmarket.connection;

/**
 *
 * @author Bhavin
 */
import java.sql.Connection;
import java.sql.DriverManager;

public class connectionManager {
     static Connection con;
     
     public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        
        con = DriverManager.getConnection("jdbc:mysql://stockmarket5.mysql.uic.edu:3306/stockmarket5", "bchauh2", "ilove440"); //UIC server
        //con = DriverManager.getConnection("jdbc:mysql://localhost:3306/stockmarket5", "root", ""); // local system
        return con;
    }
    
}
