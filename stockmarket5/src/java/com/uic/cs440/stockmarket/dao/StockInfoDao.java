package com.uic.cs440.stockmarket.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.uic.cs440.stockmarket.beans.StockInfo;

public class StockInfoDao {
	
	public StockInfo getStockInfoByPlayer(int uid) throws SQLException, ClassNotFoundException{
		
		String query = "SELECT p.fname, s.quantity, s.stock_sym FROM stock_info s, player_registration p WHERE s.uid = \'" + uid +"\' and s.uid = p.uid";
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://stockmarket5.mysql.uic.edu:3306/stockmarket5", "mmilin2", "ilove440"); //UIC server
			Statement statement = conn.createStatement();

			ResultSet rs = statement.executeQuery(query);
			while(rs.next()){
				StockInfo si = new StockInfo(rs.getString("stock_sym"), rs.getInt("quantity"));
				return si;
			}
		}
		
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public void insertIntoStockInfo(StockInfo si) throws SQLException, ClassNotFoundException{
		
		String query = "Insert into stock_info (stock_sym, quantity, uid) values (?,?,?)";

		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://stockmarket5.mysql.uic.edu:3306/stockmarket5", "mmilin2", "ilove440"); //UIC server
			//Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/stockmarket", "root", "");
			PreparedStatement statement = conn.prepareStatement(query);

			statement.setString(1, si.getStockSymbol());
			statement.setInt(2, si.getStockQuantity());
			statement.setInt(3, 4);
		}
	
		catch(Exception e){
			e.printStackTrace();
		}
	}	
}
