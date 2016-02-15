package com.uic.cs440.stockmarket.dao;

import com.uic.cs440.stockmarket.beans.Player;
import com.uic.cs440.stockmarket.connection.connectionManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class UserLoginDAO {
    static Connection con1;
    static Statement st;
    static ResultSet rs;
    static String qry;

    public Player login(String email, String password) {
        
        Player player = new Player();
        
        try {
            con1 = connectionManager.getConnection();
            st = con1.createStatement();
            qry = "select * from player_registration where email=\'" + email + "\' and password=\'" + password + "\'";
            System.out.println(qry);

            rs = st.executeQuery(qry);

            boolean more = false;
            while (rs.next()) {
                more = true;
            	player = new Player(rs.getString("fname"), rs.getString("lname"), rs.getString("bdate"), rs.getString("country"), rs.getString("state"), rs.getString("city"),rs.getString("email"), rs.getString("password"), rs.getLong("contactno"), rs.getBoolean("permission") );
		//return player;
            }
            if (more) {
                player.setValid(true);
                System.out.println("valid");
            } else {
                player.setValid(false);
            }

        } catch (Exception e) {
            System.out.println("Error in LoginDAO" + e.getMessage());
            e.printStackTrace();
        }
        return player;
    }
}