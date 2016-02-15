/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.uic.cs440.stockmarket.beans;

import java.sql.Date;

/**
 *
 * @author Bhavin
 */
public class Player {

    private String fname, lname, bdate, country, state, city, email, uid, password, squest, sanswer, ownquest;
    private long contactno;
    private boolean valid;

    public Player(String fName, String lName, String bDate, String country, String state, String city, String email,
			 String password, long contact, boolean valid) {
		super();
		this.fname = fName;
		this.lname = lName;
		this.bdate = bDate;
		this.country = country;
		this.state = state;
		this.city = city;
		this.email = email;
		this.password = password;
		this.contactno = contact;
		this.valid = valid;
	}

    public Player() {
       // throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    /**
     * @return the fname
     */
    public String getFname() {
        return fname;
    }

    /**
     * @param fname the fname to set
     */
    public void setFname(String fname) {
        this.fname = fname;
    }

    /**
     * @return the lname
     */
    public String getLname() {
        return lname;
    }

    /**
     * @param lname the lname to set
     */
    public void setLname(String lname) {
        this.lname = lname;
    }

    /**
     * @return the bdate
     */
    public String getBdate() {
        return bdate;
    }

    /**
     * @param bdate the bdate to set
     */
    public void setBdate(String bdate) {
        this.bdate = bdate;
    }

    /**
     * @return the country
     */
    public String getCountry() {
        return country;
    }

    /**
     * @param country the country to set
     */
    public void setCountry(String country) {
        this.country = country;
    }

    /**
     * @return the state
     */
    public String getState() {
        return state;
    }

    /**
     * @param state the state to set
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * @param city the city to set
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the uid
     */
    public String getUid() {
        return uid;
    }

    /**
     * @param uid the uid to set
     */
    public void setUid(String uid) {
        this.uid = uid;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the squest
     */
    public String getSquest() {
        return squest;
    }

    /**
     * @param squest the squest to set
     */
    public void setSquest(String squest) {
        this.squest = squest;
    }

    /**
     * @return the sanswer
     */
    public String getSanswer() {
        return sanswer;
    }

    /**
     * @param sanswer the sanswer to set
     */
    public void setSanswer(String sanswer) {
        this.sanswer = sanswer;
    }

    /**
     * @return the phoneno
     */
    public long getContactno() {
        return contactno;
    }

    /**
     * @param phoneno the phoneno to set
     */
    public void setContactno(long contactno) {
        this.contactno = contactno;
    }

    /**
     * @return the valid
     */
    public boolean isValid() {
        return valid;
    }

    /**
     * @param valid the valid to set
     */
    public void setValid(boolean valid) {
        this.valid = valid;
    }

    /**
     * @return the ownquest
     */
    public String getOwnquest() {
        return ownquest;
    }

    /**
     * @param ownquest the ownquest to set
     */
    public void setOwnquest(String ownquest) {
        this.ownquest = ownquest;
    }

}
