package com.uic.cs440.stockmarket.beans;

public class StockInfo {
	
	int stockId;
	String stockSymbol;
	int stockQuantity;
        private boolean valid;
	String email;
	
	public StockInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public StockInfo(String stockSymbol, int stockQuantity) {
		super();
		this.stockSymbol = stockSymbol;
		this.stockQuantity = stockQuantity;
	}
	
	public int getStockId() {
		return stockId;
	}
	public void setStockId(int stockId) {
		this.stockId = stockId;
	}
	public String getStockSymbol() {
		return stockSymbol;
	}
	public void setStockSymbol(String stockSymbol) {
		this.stockSymbol = stockSymbol;
	}
	public int getStockQuantity() {
		return stockQuantity;
	}
	public void setStockQuantity(int stockQuantity) {
		this.stockQuantity = stockQuantity;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}	
        
         public boolean isValid() {
        return valid;
    }

    /**
     * @param valid the valid to set
     */
    public void setValid(boolean valid) {
        this.valid = valid;
    }

}
