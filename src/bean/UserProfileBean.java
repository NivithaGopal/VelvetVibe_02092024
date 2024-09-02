package bean;

import java.sql.Date;

public class UserProfileBean {
	private int userId;
    private String fullName;
    private java.sql.Date dob;
    private String email;
    private String address;
	public UserProfileBean() {
		super();
	}
	public UserProfileBean(int userId, String fullName, Date dob, String email, String address) {
		super();
		this.userId = userId;
		this.fullName = fullName;
		this.dob = dob;
		this.email = email;
		this.address = address;
	}
	@Override
	public String toString() {
		return "UserProfileBean [userId=" + userId + ", fullName=" + fullName + ", dob=" + dob + ", email=" + email
				 + ", address=" + address + "]";
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public java.sql.Date getDob() {
		return dob;
	}
	public void setDob(java.sql.Date dob) {
		this.dob = dob;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
   
    

}
