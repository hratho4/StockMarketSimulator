package com.uic.cs440.stockmarket.beans;

import java.sql.Date;

public class StockTransaction {
	
	int transactionId;
	int uId;
	String stockSymbol;
	Date tDate;
	int quantity;
	float price;
	int type;
	
	public StockTransaction() {
		super();
		// TODO Auto-generated constructor stub
	}
		
	public StockTransaction(String stockSymbol, Date tDate, int quantity, float price, int type) {
		super();
		this.stockSymbol = stockSymbol;
		this.tDate = tDate;
		this.quantity = quantity;
		this.price = price;
		this.type = type;
	}


	public int getTransactionId() {
		return transactionId;
	}
	public void setTransactionId(int transactionId) {
		this.transactionId = transactionId;
	}
	public int getuId() {
		return uId;
	}
	public void setuId(int uId) {
		this.uId = uId;
	}
	public String getStockSymbol() {
		return stockSymbol;
	}
	public void setStockSymbol(String stockSymbol) {
		this.stockSymbol = stockSymbol;
	}
	public Date gettDate() {
		return tDate;
	}
	public void settDate(Date tDate) {
		this.tDate = tDate;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	
	
}
