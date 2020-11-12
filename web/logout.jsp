<%-- 
    Document   : index
    Created on : Jun 17, 2020, 11:04:45 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "javax.servlet.http.*,java.io.*,java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="google-signin-client_id" content="97508483717-op0a7bp9vc1g569gqme33qj82nkbh60c.apps.googleusercontent.com">        
        


<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="JqEAi2_O9GGcDThOWn7W7GbL">
<meta name="author" content="David Kanyari , https://kendigi.com" />
   <meta name="keywords" content="Web GIS,Live Map Data Update, Field Data Collection Using Live map, Live Map Update, leaflet-ajax-php-postgis" />
    <link rel="apple-touch-icon" sizes="57x57" href="images/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="images/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="images/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="images/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="images/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="images/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="images/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="images/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="images/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192" href="images/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="images/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="images/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon-16x16.png">

    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="images/ms-icon-144x144.png">
    <meta name="theme-color" content="#ffffff">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
     <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <!-- Bootstrap CSS -->
   
  <!-- Fonts -->
    <link rel="dns-prefetch" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css?family=Raleway:300,400,600" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="js2/style2.css">
    <!-- Bootstrap CSS -->
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
   <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
   
<title>AnalyticKEDemo - Register</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light navbar-laravel">
    <div class="container">
         <a class="navbar-brand" href="#"><img src="images/favicon-32x32.png" alt="Analytics Logo"  /> </a>
                
				
         <a class="navbar-brand" href="#">Analytics GIS Demo </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.jsp">Register</a>
                </li>
            </ul>

        </div>
    </div>
</nav>
    
    
    <%  //HttpServletRequest req2 ;
        //HttpSession session3 = req.getSession(true);
       
        session.invalidate(); 
        response.sendRedirect("index.jsp");
       
    %>

<main class="login-form">
    <div class="cotainer">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                  <div class="card-header">Log Out </div>
                  <div class="card-body">
                        <form action="LoginServlet" method="post" id ="loginForm">
                            <br>
                            <div class="form-group row">
                                 <div class="col-md-6">
                                     <p class="form-control">You have been logged out.</p>
                                </div>
                            </div>
	                            
                            <div class="col-md-6 offset-md-4">
                             
                                <a href="index.jsp" class="btn btn-sucess">
                                   Login
                                 
                               
                            </div>
                    </div>
                    </form>
                        <div id=errors"></div>
                </div>
            </div>
        </div>
    </div>
    </div>

</main>
<!-- Optional JavaScript -->
  <script src="js/jquery/jquery-3.4.1.min.js"></script>
  <script src="js/bootstrap/js/bootstrap.min.js"></script>
  <script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
  <script src="https://apis.google.com/js/platform.js" async defer></script>
  
   <script>
      $(function() { 
       
         setTimeout(function () {
                    window.location.href = "index.jsp"; //will redirect to your blog page (an ex: blog.html)
                 }, 2000); //will call the function after 2 secs.
            //errors
        
       
      });    
   </script>  
   
   
   
    </body>
</html>
