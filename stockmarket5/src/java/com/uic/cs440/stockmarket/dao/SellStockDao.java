/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.uic.cs440.stockmarket.dao;

import com.uic.cs440.stockmarket.beans.StockInfo;
import com.uic.cs440.stockmarket.connection.connectionManager;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.*;
import java.util.StringTokenizer;
import javax.swing.JOptionPane;
/**
 *
 * @author Bhavin
 */
public class SellStockDao {
static Connection con1;
    static Statement st;
    static PreparedStatement pt;
    public static StockInfo sellStock(StockInfo stock, int sellquantity) {
       String stcknm = stock.getStockSymbol();
       String buid = stock.getEmail();
        int quantity = stock.getStockQuantity();
        String qry = "";
        int k = 0;
        BufferedReader bf;
        String dataRow;
        String liv;
        float live = 0;
        System.out.println("inside dao "+stcknm);

        try {
               URL url = new URL("http://quote.yahoo.com/d/quotes.csv?s=" + stcknm + "&f=sl1d1t1c1ohgv&e=.csv");
                                            URLConnection urlConn = url.openConnection();
                                            InputStreamReader inStream = new InputStreamReader(urlConn.getInputStream());
                                            BufferedReader buff = new BufferedReader(inStream);
                                            String csvString = buff.readLine();
                                            StringTokenizer tokenizer = new StringTokenizer(csvString, ",");
            tokenizer.nextToken();
            live=(float) Double.parseDouble(tokenizer.nextToken());
        } catch (Exception e1) {
            System.out.println("Price Not Found"+e1);
        }

        try {
            con1 = connectionManager.getConnection();
            st = con1.createStatement();
            float income= sellquantity * live;
            pt = con1.prepareStatement("Insert into stock_transactions(email,stock_sym,tdate,price,quantity,type) values(?,?,CURDATE(),?,?,?)");
            pt.setString(1, stock.getEmail());
            pt.setString(2, stock.getStockSymbol());
            pt.setFloat(3, live);
            pt.setInt(4, sellquantity);
            pt.setInt(5, 1);
            System.out.print(k+"fff"+ pt.toString());
        
                k = pt.executeUpdate();
                        System.out.print(k+"fff"+ pt.toString());
                if (k!= 0) {
              
                qry = "update stock_info set quantity="+(quantity-sellquantity)+ " where stock_sym='" + stock.getStockSymbol()+"' and email='"+stock.getEmail()+"'";
                    int j = st.executeUpdate(qry);

                    if (j != 0) {
                        System.out.println("Row Updated !!");
                        stock.setValid(true);
                          } else {
                        System.out.println("Row not Updated !!");
                        stock.setValid(true);
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
    
