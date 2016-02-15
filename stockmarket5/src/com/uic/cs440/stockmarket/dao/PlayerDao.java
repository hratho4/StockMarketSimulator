package com.uic.cs440.stockmarket.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.uic.cs440.stockmarket.beans.Player;

public class PlayerDao {

	public void insertPlayer(Player player) throws SQLException, ClassNotFoundException {
		
		String query = "Insert into player_registration(fname, lname, bdate, country, state, city, contactno, email, password, permission) values (?,?,?,?,?,?,?,?,?,?)";
		boolean valid = true;

		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://stockmarket5.mysql.uic.edu:3306/stockmarket5", "mmilin2", "ilove440"); //UIC server
			//Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/stockmarket", "root", "");
			// con = new DbConnectionManager().establishConnection();
			PreparedStatement statement = conn.prepareStatement(query);

			statement.setString(1, player.getfName());
			statement.setString(2, player.getlName());
			statement.setString(3, player.getbDate());
			statement.setString(4, player.getCountry());
			statement.setString(5, player.getState());
			statement.setString(6, player.getCity());
			statement.setLong(7, player.getContact());
			statement.setString(8, player.getEmail());
			statement.setString(9, player.getPassword());
			statement.setBoolean(10, valid);

			int i = statement.executeUpdate();
			if(i !=0){
				System.out.println("Player inserted into the DB");
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
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
				player.setUid(rs.getLong("uid"));
				return player;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}	
}
