/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.uic.cs440.stockmarket.dao;

import com.uic.cs440.stockmarket.beans.Player;
import com.uic.cs440.stockmarket.connection.connectionManager;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Bhavin
 */
public class PlayerDao {

    static Connection con1;
    static Statement st;
    static ResultSet rs;
    static String qry;

    public static Player register(Player player) {
        String fname = player.getFname();
        String lname = player.getLname();
        String bdate = player.getBdate();
        String country = player.getCountry();
        String state = player.getState();
        String city = player.getCity();
        long contactno = player.getContactno();
        String email = player.getEmail();
        String password = player.getPassword();
        String squest = player.getSquest();
        String sanswer = player.getSanswer();
        boolean permiss = false;

        try {
            con1 = connectionManager.getConnection();
            st = con1.createStatement();

            PreparedStatement pt = con1.prepareStatement("Insert into player_registration(fname,lname,bdate,country,state,city,contactno,email,"
                    +"password,permission) values(?,?,?,?,?,?,?,?,?,?)");
            pt.setString(1, fname);
            pt.setString(2, lname);
            pt.setString(3, bdate);
            pt.setString(4, country);
            pt.setString(5, state);
            pt.setString(6, city);
            pt.setLong(7, contactno);
            pt.setString(8, email);
            pt.setString(9, password);
            pt.setBoolean(10, permiss);

            System.out.println(pt);

            int i = pt.executeUpdate();

            if (i != 0) {
                player.setValid(true);
                System.out.println("player Inserted");
            } else {
                player.setValid(false);
              }
        } catch (Exception e) {
            System.out.println("Error is" + e.getMessage());
            e.printStackTrace();
        }

        return player;
    }
    
    public Player fetchPlayerDetails(String email, String password){

		String query = "Select * from player_registration where email = \'" + email + "\' and password = \'" + password +"\'";

		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://stockmarket5.mysql.uic.edu:3306/stockmarket5", "mmilin2", "ilove440"); //UIC server
			//Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/stockmarket", "root", "");
			Statement statement = conn.createStatement();

			ResultSet rs = statement.executeQuery(query);
			while(rs.next()){
				Player player = new Player(rs.getString("fname"), rs.getString("lname"), rs.getString("bdate"), rs.getString("country"), rs.getString("state"), rs.getString("city"),rs.getString("email"), rs.getString("password"), rs.getLong("contactno"), rs.getBoolean("permission") );
				return player;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
    
    public void updatePlayerDetails(String contactNo, String oldEmail, String newEmail, String newPassword) throws ClassNotFoundException, SQLException{
        
        String query = "Update player_registration set email = \'" + newEmail + "\',password = \'" + newPassword + "\', contactno = \'" + contactNo +
                " where email = \'" + oldEmail + "\'";

		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://stockmarket5.mysql.uic.edu:3306/stockmarket5", "mmilin2", "ilove440"); //UIC server
			//Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/stockmarket", "root", "");
			Statement statement = conn.createStatement();
                        statement.executeQuery(query);
                }    
                catch(Exception e){
			e.printStackTrace();
                }            
        
    }
}
