/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.kendigi.analyticsdemo;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class User implements Serializable {
    
     private String email;
     private String password;
     private String dob;
     private String phoneNo;
     private static final long serialVersionUID = 1L;

    public User(String email, String password, String dob, String phoneNo) {
        this.email = email;
        this.password = password;
        this.dob = dob;
        this.phoneNo = phoneNo;
    }

    public User() {
        //To change body of generated methods, choose Tools | Templates.
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }
    
    
}
