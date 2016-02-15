/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.uic.cs440.stockmarket.dao;

import com.uic.cs440.stockmarket.beans.PlayerBalance;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Locale;

/**
 *
 * @author Milind
 */
public class PlayerbalanceDao {
    
    public PlayerBalance getBalanceInfo(String email){
        String query = "Select * from player_balance where email = \'" + email + "\'";

		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://stockmarket5.mysql.uic.edu:3306/stockmarket5", "mmilin2", "ilove440");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(query);
			while(rs.next()){
				PlayerBalance pBalance = new PlayerBalance(rs.getString("email"), rs.getDouble("balance"));
				return pBalance;
			}
                }
                catch(ClassNotFoundException | SQLException e){
                    e.printStackTrace();
                }
                return null;
    }
    
    public void setInitialBalance(PlayerBalance pb){
        
        String query = "Insert into player_balance (email, balance) values (?,?)";

		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://stockmarket5.mysql.uic.edu:3306/stockmarket5", "mmilin2", "ilove440"); //UIC server
			//Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/stockmarket", "root", "");
			PreparedStatement statement = conn.prepareStatement(query);
                        
			statement.setString(1, pb.getEmail());
			statement.setDouble(2, pb.getBalance());
                           statement.executeUpdate();
                           System.out.printf(query);
		}
	
		catch(ClassNotFoundException | SQLException e){
			e.printStackTrace();
		}
    }
    
    public void setBalance(Double balance, String email){
        
        String query = "Update player_balance set balance = (balance + " + balance + ") where email = \'"+email+"\'";

		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://stockmarket5.mysql.uic.edu:3306/stockmarket5", "mmilin2", "ilove440"); //UIC server
			//Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/stockmarket", "root", "");
			Statement statement = conn.prepareStatement(query);

			statement.executeUpdate(query);
                }
	
		catch(ClassNotFoundException | SQLException e){
			e.printStackTrace();
		}
    }
}
