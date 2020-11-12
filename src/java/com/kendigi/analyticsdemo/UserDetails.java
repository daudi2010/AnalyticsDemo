/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.kendigi.analyticsdemo;

import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.Version;



/**
 *
 * @author Admin
 */
public class UserDetails {
           public User_Profile Get_Profile_info(String accesstoken) {
		User_Profile fb_User_Profile=new User_Profile();
		FacebookClient facebookClient = new DefaultFacebookClient(accesstoken, Version.VERSION_7_0);
		com.restfb.types.User user = facebookClient.fetchObject("me", com.restfb.types.User.class);
		System.out.println("User name: " + user.getName());
		fb_User_Profile.setUser_name(user.getName());
                System.out.println("Email: " + user.getEmail());
		fb_User_Profile.setUser_email(user.getEmail());
                System.out.println("Dob: " + user.getBirthday());
		fb_User_Profile.setUser_dob(user.getBirthday());
                 
		return fb_User_Profile;
	}
    
}
