package com.uic.cs440.stockmarket.dao;

import java.sql.SQLException;

import com.uic.cs440.stockmarket.beans.Player;

public class TestCOnnectionDb {

	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		Player player1 = new Player("Milind", "Sapra", "27-01-1991", "India", "Karnataka", "Bangalore", "email@email.com", "ilove440", 1234567890, true);

		PlayerDao dao = new PlayerDao();
		//player1 = dao.fetchPlayerDetails("email@email.com", "ilove440");
		dao.insertPlayer(player1);
		//System.out.println(player1.getContact());
		
		new StockInfoDao().getStockInfoByPlayer(2);
		
	}

}
