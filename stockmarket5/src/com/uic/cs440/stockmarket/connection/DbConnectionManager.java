package com.uic.cs440.stockmarket.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnectionManager {
	
	Connection conn;
	
	public DbConnectionManager(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/stockmarket", "root", "@mtt58qBN");
		}
		catch(Exception e){
			System.out.println("Couldn't find connection.");
		}
	}
}
