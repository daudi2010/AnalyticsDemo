/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.kendigi.analyticsdemo;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.kendigi.analyticsdemo.db.AnalyticsDB;
import com.kendigi.analyticsdemo.mail.EmailUtility;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
//@WebServlet(name = "/LoginServlet", urlPatterns = {"/Login"})
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
private String host;
    private String port;
    private String user;
    private String pass;
 
    public void init() {
        // reads SMTP server setting from web.xml file
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        user = context.getInitParameter("user");
        pass = context.getInitParameter("pass");
    }
   
    protected void processRequest(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
            
        try {
           
             req.getServletContext()
            .getRequestDispatcher("/index.jsp").forward(req, resp);
 
             
        
        } finally {
             req.getServletContext()
            .getRequestDispatcher("/index.jsp").forward(req, resp);
        }
    }

   
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        //fb
       if (req.getParameter("access_token")!=null &&!req.getParameter("access_token").isEmpty()){
           
            String access_token=(String)req.getParameter("access_token");
            UserDetails fb_Get_User_Details=new UserDetails();
            User_Profile fb_User_Profile=fb_Get_User_Details.Get_Profile_info(access_token);

            User us= new User();
            us.setPassword("");
            us.setEmail(fb_User_Profile.getUser_email());
            us.setDob(fb_User_Profile.getUser_dob());
            System.out.println("Facebook login started");
            AnalyticsDB db= new AnalyticsDB();
            String tr="";  
            HttpSession session = req.getSession(true);
            
           try {
               if (!db.checkEmailExist(us.getEmail())){
                   try {
                       if (db.insertUser(us) > 0){
                           tr="success";
                           System.out.println("User Inserted");
                       }else{ tr="fail";
                       System.out.println("user NOT Inserted");
                       }
                       
                   } catch (Exception ex) {
                       tr="fail";
                       System.out.println("Exceptions thrown during insert!!");
                       Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
                       //resp.getWriter().write("fail");
                       
                   }
                 session.setAttribute("userName",fb_User_Profile.getUser_name() );
                 session.setAttribute("Email", fb_User_Profile.getUser_email());   
                   req.getServletContext()
                 .getRequestDispatcher("/map.jsp").forward(req, resp); 
               }else{
                   session.setAttribute("userName",fb_User_Profile.getUser_name() );
                   session.setAttribute("Email", fb_User_Profile.getUser_email()); 
                   
                  tr="success";
                  req.getServletContext()
            .getRequestDispatcher("/map.jsp").forward(req, resp);
               }
           } catch (SQLException ex) {
               Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
           }
         
            resp.setContentType("text/plain");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(tr);
      
         
         
         }else if (req.getParameter("email")!=null &&!req.getParameter("email").isEmpty()&&
                !req.getParameter("password").isEmpty()){
           String U_email=req.getParameter("email").trim();
           String U_pass=req.getParameter("password").trim();
           
           String rt="";
           //do login
            User us= new User();
            us.setPassword(U_pass);
            us.setEmail(U_email);
            
            AnalyticsDB db= new AnalyticsDB();
             
           try {
               if(db.validate(us)){
                  
                   rt="success";
               }else{
                   rt= "fail";
               }
           } catch (SQLException ex) {
               Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
           }
           
            resp.setContentType("text/plain");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(rt);
        
           //logout
       }else if (req.getParameter("action")!=null&& !req.getParameter("action").isEmpty() ){      
            System.out.println("Logging out!!"); 
            HttpSession session = req.getSession(false);
            if(session != null){
             session.invalidate();
             req.getRequestDispatcher("/index.jsp").forward(req,resp);
             System.out.println("Logout!!"); 
            }
       
       }else{
             req.getServletContext()
            .getRequestDispatcher("/index.jsp").forward(req, resp);
 
             
         }
       
       
      
    }

   
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
       
        //google
       if(  req.getParameter("id_token")!=null && !req.getParameter("id_token").isEmpty()) {
        String tr="" ;
        try {
            
             //posted from user onlogin
            String idToken = req.getParameter("id_token");
            
            GoogleIdToken.Payload payLoad = IdTokenVerifierAndParser.getPayload(idToken);
           // get user details
            
            String name = (String) payLoad.get("name");
            String email = payLoad.getEmail();
                      
             User usr=new User(email,"","","");
           
             AnalyticsDB db= new AnalyticsDB();
             
             //new user
             if (!db.checkEmailExist(email)&& !email.isEmpty()){
                   try {
                        // add to database
                       if (db.insertUser(usr) > 0){
                           tr="success";
                           System.out.println("User Inserted");
                       }else{
                           tr="fail";
                          System.out.println("user NOT Inserted");
                       }
                       
                   } catch (Exception ex) {
                       tr="User Email Exists";
                       System.out.println(tr);
                       Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
                       //resp.getWriter().write("fail");
                       
                }
             }else{
                 //User exists
                 tr="success";
             }   
           
            HttpSession session = req.getSession(true);
            session.setAttribute("userName", name.split("@")[0]);
             session.setAttribute("Email", email);
            req.getServletContext()
            .getRequestDispatcher("/map.jsp").forward(req, resp);

        } catch (Exception e) {
            throw new RuntimeException(e);
            
        }
             resp.setContentType("text/plain");
             resp.getWriter().write(tr);
        
   
        //login
       }else if (req.getParameter("email")!=null &&!req.getParameter("email").isEmpty()&&
                !req.getParameter("password").isEmpty()){
           
            String U_email=req.getParameter("email").trim();
            String U_pass=req.getParameter("password").trim();
            System.out.println("User name: " + U_email);
            System.out.println("User email: " + U_pass);
          
           //do login
            User us= new User();
            us.setPassword(U_pass);
            us.setEmail(U_email);
            AnalyticsDB db= new AnalyticsDB();
            String rt="";
           try {
               if(db.validate(us)){
                  
                   rt="success";
                   
                   HttpSession session = req.getSession(true);
                   session.setAttribute("userName", U_email.split("@")[0]);
                   session.setAttribute("Email", U_email);
               }else{
                   rt= "fail";
               }
           } catch (SQLException ex) {
               Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
           }
           
            resp.setContentType("text/plain");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(rt);  
            
       //register
       }else if (req.getParameter("remail")!=null&& !req.getParameter("remail").isEmpty()&&
                 !req.getParameter("rpassword").isEmpty()
                && !req.getParameter("tel").isEmpty()
               ){
           System.out.println("form arrived");
            
           
           String r_email=req.getParameter("remail").trim();
           String r_pass=req.getParameter("rpassword").trim();
           String r_date=req.getParameter("date").trim();
           String r_tel=req.getParameter("tel").trim();
          
          
            User us= new User();
            us.setPassword(r_pass);
            us.setEmail(r_email);
            us.setPhoneNo(r_tel);
            us.setDob(r_date);// to be fixed later
            
            AnalyticsDB db= new AnalyticsDB();
            
           String tr="";  
           try {
               if (db.insertUser(us) > 0){
                  tr="success";
                  System.out.println("User Inserted");
               }else{ tr="fail";
                 System.out.println("user NOT Inserted");
               }
                  
           } catch (Exception ex) {
                 tr="fail";
               System.out.println("Exceptions thrown during insert!!");
               Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
              
            }
         
            resp.setContentType("text/plain");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(tr);
      
 //forgot password*******send email
    }else if (req.getParameter("femail")!=null&& !req.getParameter("femail").isEmpty()  ){
    
          String f_email=req.getParameter("femail").trim();
           // check if email exists
           String tr=""; 
           AnalyticsDB db= new AnalyticsDB();
           try {
               if (db.checkEmailExist(f_email)&& f_email != null){
                   //send email
                                // reads form fields
                     String recipient = req.getParameter("femail");
                     String subject = "AnalyticsDemo-Password Reset";
                     String content = "<p>Hi</p>"; 
                     content+="<h6>Password Reset link has  been sent here</h6>"; 
                     content+="<p>We recieved your password reset request.</p>"; 
                     content+="<a href=\"?rcvemail="+f_email+" \">Click here to reset your password</a>"; 
                     content+="<p>Never share your password with anybody!</p>"; 

                     content+="<p>Best Regards<br><br>AnalyticsKEDemo <br></p>";
                    
                     String resultMessage = "";
 
             try {
                 EmailUtility.sendEmail(host, port, user, pass, recipient, subject,
                    content);
                   tr="success";
                  // getServletContext().getRequestDispatcher("/index.jsp").forward(
                 //   req, resp);
                  resultMessage = "The e-mail was sent successfully";
             } catch (Exception ex) {
             ex.printStackTrace();
             resultMessage = "There were an error: " + ex.getMessage();
             } finally {
            req.setAttribute("Message", resultMessage);
            System.out.println(resultMessage);
           
              }
                    
             }else{
            //Email not sent
             tr="fail";
                   
               }
           
            } catch (SQLException ex) {
               Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
               tr="fail";
           }
            
            //send email
            resp.setContentType("text/plain");
            resp.getWriter().write(tr);
            System.out.println(tr);
    //reset password
    }else if (req.getParameter("rcvDemail")!=null&& !req.getParameter("rcvDemail").isEmpty() 
            &&req.getParameter("pass1")!=null ){     
    
           String rc_email=req.getParameter("rcvDemail").trim();
           String new_pass=req.getParameter("pass1").trim();
         // update password
           AnalyticsDB db= new AnalyticsDB();
           String tr="";  
           try {
               if (db.updateUserPassword(rc_email, new_pass)){
                  tr="success";
                  System.out.println("User Updated");
               }else{ 
                   tr="fail";
                 System.out.println("user NOT Updated");
               }
                  
           } catch (Exception ex) {
                tr="fail";
               System.out.println("Exceptions thrown during Update!!");
               Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
           
       }
         
            resp.setContentType("text/plain");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(tr);
          
        // 
    //Submit comment
    }else if (req.getParameter("ucomment")!=null&& !req.getParameter("ucomment").isEmpty() 
            ){     
           System.out.println("Comment has come");
          
           String comment=req.getParameter("ucomment").trim();
            System.out.println(comment);
           HttpSession session = req.getSession(true);
           String from_user=(String) session.getAttribute("Email");
           String subject = "AnalyticsDemo-User Comment";
           String content = "<p>Hi</p>"; 
                  content+="<p>"+comment+"</p>";
                  content+="<br><br><p>Regards</p>";
                  content+="<br><br><p>"+from_user+"</p>";
           String recipient=user;  //send email to oneself      
           String tr="", resultMessage="";  
           try {
               EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
               tr="success";
               System.out.println("Comment Email sent");
                   
          } catch (Exception ex) {
              resultMessage = "There were an error: " + ex.getMessage();
              tr="fail";
           } finally {
            req.setAttribute("Message", resultMessage);
            System.out.println(resultMessage);
            }
          
            resp.setContentType("text/plain");
            resp.getWriter().write(tr);
          
       
   
     //Default 
        
    }else{
             req.getServletContext()
            .getRequestDispatcher("/index.jsp").forward(req, resp);
           
         }
    
    }
    
   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
