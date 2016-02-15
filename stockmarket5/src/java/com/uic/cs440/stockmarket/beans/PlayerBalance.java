/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.uic.cs440.stockmarket.beans;


/**
 *
 * @author Milind
 */
public class PlayerBalance {

    private String email;
    private double balance;
    
    public PlayerBalance(){
        super();
    }
    
    public PlayerBalance(String email, double balance){
        this.email = email;
        this.balance = balance;
    }

    public String getEmail() {
        return email;
    }

    public double getBalance() {
        return balance;
    }
    
     public void setEmail(String email) {
        this.email = email;
    }
    
    public void setBalance(double balance) {
        this.balance = balance;
    }
    
    
}
