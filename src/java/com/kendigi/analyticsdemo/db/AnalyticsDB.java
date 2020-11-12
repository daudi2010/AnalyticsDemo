/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.kendigi.analyticsdemo.db;
import com.kendigi.analyticsdemo.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class AnalyticsDB {
        private java.sql.Statement stmt;
	private java.sql.Connection conn;
	private java.sql.ResultSet rs;
	/**
	* Constructor creates a live connection ready for use
	*/
	public AnalyticsDB()	 {
		try	{
			Class.forName("org.postgresql.Driver").newInstance();
			//conn =  java.sql.DriverManager.getConnection("jdbc:postgresql://localhost:5432/analytics_coke?user=postgres&password=postgres");
			conn =  java.sql.DriverManager.getConnection("jdbc:postgresql://kendigi.com:5432/davidka_analytics?user=davidka&password=qK11sh8Em3");
			
                        stmt = conn.createStatement();
			}
		catch (java.sql.SQLException sqle)	{
			sqle.printStackTrace();
			}
		catch (Exception e)	{
			e.printStackTrace();
			}
		}

	/**
	* Method kills the open statement & connection object
	*/
	public void killOpenObjects()	{
		try	{
			if (stmt != null)	 {
				stmt.close();
				}
			if (conn != null)	 {
				conn.close();
				}
			}
		catch (java.sql.SQLException e)	 {
			System.out.println("Exception in killOpenObjects");
			e.printStackTrace();
			}
		}

	/**
	* @param query A String containing the query to be executed
	* @param killTrigger A boolean that signifys whether to call the killOpenObjects or leave the connection live
	* @returns rs A java.sql.ResultSet containing the required data
	* It should be noted that the connection may be killed even thought the resultset is still to be used in MySQL ONLY
	*/
	public java.sql.ResultSet getResultSet(String query, boolean killTrigger)	{
		try	{
			rs = stmt.executeQuery(query);
			}
		catch (java.sql.SQLException e)	{
			System.out.println(query);
			System.out.println("Exception in DataConnection get ResultSet");
			e.printStackTrace();
			}
		finally	{
			if (killTrigger)	{
				killOpenObjects();
				}
			}
		return rs;
		}

	/**
	* @param query A String containing the query to be executed
	* @param killTrigger A boolean that signifys whether to call the killOpenObjects or leave the connection live
	* @returns rows An integer signifying how many rows were effected by the query
	* It should be noted that the connection may be killed even thought the resultset is still to be used in MySQL ONLY
	*/
	public int updateTable(String query, boolean killTrigger)	{
		int rows = 0;
		try	{
			rows = stmt.executeUpdate(query);
			}
		catch (java.sql.SQLException e)	{
			if (e.getMessage().indexOf("Invalid argument value: Duplicate entry") == -1)	 {
				System.out.println(e.getMessage());
				System.out.println(query);
				}
			}
		finally	{
			if (killTrigger)	{
				killOpenObjects();
				}
			}
		return rows;
		}

        
    public int insertUser(User us) {
        int rows = 0;
    try { 
        System.out.println("inserting user");
        PreparedStatement st = conn.prepareStatement("INSERT INTO users ( email, phone, dob,password) VALUES (?, ?, ?, ?)");
        st.setString(1,us.getEmail() );
        st.setString(2, us.getPhoneNo());
        st.setObject(3, us.getDob());
        st.setString(4, us.getPassword());
        rows=st.executeUpdate();
        System.out.println("inserted user");
        st.close();

    } catch (SQLException e) {
        System.out.println(e.getMessage());
    }
return rows;
}
    
     public int saveUser(String email,String phone, Date dob,String pass) {
         int rows = 0;
    try {
     PreparedStatement st = conn.prepareStatement("INSERT INTO users ( email, phone, dob,password) VALUES (?, ?, ?, ?)");
        st.setString(1,email );
        st.setString(2, phone);
        st.setObject(3, dob);
        st.setString(4, pass);
        rows= st.executeUpdate();
        st.close();

    } catch (SQLException e) {
        System.out.println(e.getMessage());
    }
return rows;
}
    public boolean validate(User loginBean) throws SQLException {
        boolean status = false;
         System.out.println("connecting to db!!!");
         try {
         PreparedStatement preparedStatement = conn.prepareStatement("SELECT FROM users where email = ? and password = ?");
         preparedStatement.setString(1, loginBean.getEmail());
         preparedStatement.setString(2, loginBean.getPassword());

         //System.out.println(preparedStatement);
         ResultSet rs = preparedStatement.executeQuery();
         status= rs.next();
         System.out.println("user found?:"+status);

    } catch (SQLException e) {
         // process sql exception
            printSQLException(e);
    }
        
      return status;  
        
    }
    
    public boolean checkEmailExist(String email) throws SQLException {
        boolean status = false;
         System.out.println("connecting to db!!!");
         try {
         PreparedStatement preparedStatement = conn.prepareStatement("SELECT FROM users where email = ? ");
         preparedStatement.setString(1, email);
       
         ResultSet rs = preparedStatement.executeQuery();
         status= rs.next();
         System.out.println("Email exists?:"+status);

    } catch (SQLException e) {
         // process sql exception
            printSQLException(e);
    }
        
      return status;  
        
    }
    
     public boolean updateUserPassword(String email,String pass) throws SQLException {
        boolean status = false;
         System.out.println("Updateing user with new password");
         try {
         PreparedStatement preparedStatement = conn.prepareStatement("UPDATE users SET password=? where email = ? ");
         preparedStatement.setString(1, pass);
          preparedStatement.setString(2, email);
         ResultSet rs = preparedStatement.executeQuery();
         status= rs.next();
         System.out.println("User updated:"+status);

    } catch (SQLException e) {
         // process sql exception
            printSQLException(e);
    }
        
      return status;  
        
    }
   private void printSQLException(SQLException ex) {
        for (Throwable e: ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    } 
        
}
