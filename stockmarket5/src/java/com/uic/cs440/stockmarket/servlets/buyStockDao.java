/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.uic.cs440.stockmarket.servlets;

import com.uic.cs440.stockmarket.beans.StockInfo;
import com.uic.cs440.stockmarket.connection.connectionManager;
import java.io.BufferedReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author Bhavin
 */
public class buyStockDao {
static Connection con1;
    static Statement st;
    static PreparedStatement pt;
    static StockInfo buyStock(StockInfo stock, int buy_quantity, float price) {
  
    String stcknm = stock.getStockSymbol();
    String email = stock.getEmail();
    String qry = "";
    int k = 0;
    System.out.println("inside dao "+stcknm);
        try {
            con1 = connectionManager.getConnection();
            st = con1.createStatement();
            float deduct= buy_quantity * price;
            pt = con1.prepareStatement("Insert into stock_transactions(email,stock_sym,tdate,price,quantity,type) values(?,?,CURDATE(),?,?,?)");
            pt.setString(1, stock.getEmail());
            pt.setString(2, stock.getStockSymbol());
            pt.setFloat(3, price);
            pt.setInt(4, buy_quantity);
            pt.setInt(5, 0);
            k = pt.executeUpdate();
            System.out.print(k+"fff"+ pt.toString());
            if (k!= 0) {
                qry="select * from stock_info where stock_sym='" + stock.getStockSymbol()+"' and email='"+stock.getEmail()+"'";
                Statement s1 = con1.createStatement();
                ResultSet rs=s1.executeQuery(qry);
                int tot_quantity=0;
                if(rs.next())
                {
                    tot_quantity = buy_quantity+Integer.parseInt(rs.getString("quantity"));
                    price=((price*buy_quantity)+(Float.parseFloat(rs.getString("price"))*Integer.parseInt(rs.getString("quantity"))))/tot_quantity;
                qry = "update stock_info set quantity="+tot_quantity+ ",price="+price+" where stock_sym='" + stock.getStockSymbol()+"' and email='"+stock.getEmail()+"'";
                System.out.println(qry);
                int j = st.executeUpdate(qry);

                    if (j != 0) {
                        System.out.println("Row Updated !!");
                        stock.setValid(true);
                          } else {
                        System.out.println("Row not Updated !!");
                        stock.setValid(true);
                       }

                }
                else
                {
                qry = "insert into stock_info (stock_sym,quantity,price,email) values ('"+stock.getStockSymbol()+"',"+buy_quantity+ ","+price+
                        ",'"+stock.getEmail()+"')";
                System.out.println(qry);
                int j = st.executeUpdate(qry);
                if(j==0)
                    stock.setValid(false);
                }
                
            
            } else {
                stock.setValid(false);
            }
        } catch (Exception e) {
            System.out.println("Error is--" + e.getMessage());
            e.printStackTrace();
        }
        return stock;
    }
    
}
