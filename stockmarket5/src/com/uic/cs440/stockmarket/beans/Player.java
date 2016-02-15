package com.uic.cs440.stockmarket.beans;

/**
 * @author Milind
 *
 */
public class Player {
	private String fName, lName, bDate, country, state, city, email, password, sQuest, sAnswer, ownQuest;
    private long contact, uid;
    private boolean valid;
    
    public Player() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Player(String fName, String lName, String bDate, String country, String state, String city, String email,
			 String password, long contact, boolean valid) {
		super();
		this.fName = fName;
		this.lName = lName;
		this.bDate = bDate;
		this.country = country;
		this.state = state;
		this.city = city;
		this.email = email;
		this.password = password;
		this.contact = contact;
		this.valid = valid;
	}
    
	public String getfName() {
		return fName;
	}
	public void setfName(String fName) {
		this.fName = fName;
	}
	public String getlName() {
		return lName;
	}
	public void setlName(String lName) {
		this.lName = lName;
	}
	public String getbDate() {
		return bDate;
	}
	public void setbDate(String bDate) {
		this.bDate = bDate;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public long getUid() {
		return uid;
	}
	public void setUid(long uid) {
		this.uid = uid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getsQuest() {
		return sQuest;
	}
	public void setsQuest(String sQuest) {
		this.sQuest = sQuest;
	}
	public String getsAnswer() {
		return sAnswer;
	}
	public void setsAnswer(String sAnswer) {
		this.sAnswer = sAnswer;
	}
	public String getOwnQuest() {
		return ownQuest;
	}
	public void setOwnQuest(String ownQuest) {
		this.ownQuest = ownQuest;
	}
	public long getContact() {
		return contact;
	}
	public void setContact(long contact) {
		this.contact = contact;
	}
	public boolean isValid() {
		return valid;
	}
	public void setValid(boolean valid) {
		this.valid = valid;
	}
    
}
