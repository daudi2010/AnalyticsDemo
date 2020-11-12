<%-- 
    Document   : index
    Created on : Jun 17, 2020, 11:04:45 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
   
<title>AnalyticKEDemo - Login</title>
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
                    <a class="nav-link" href="#">Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.jsp">Register</a>
                </li>
            </ul>

        </div>
    </div>
</nav>

<main class="login-form">
    <div class="cotainer">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">Login</div>
                    <div class="card-body">
                        <form id ="loginForm" name ="loginForm">
                            <br>
	
                            <div class="form-group row">
                                <label for="email_address" class="col-md-4 col-form-label text-md-right">E-Mail Address</label>
                                <div class="col-md-6">
                                    <input type="email" id="email" class="form-control" name="email" required autofocus>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="password" class="col-md-4 col-form-label text-md-right">Password</label>
                                <div class="col-md-6">
                                    <input type="password" id="password" class="form-control" name="password" required>
                                </div>
                            </div>
                         <div class="col-md-6 offset-md-4">
                             
                           
                              <fb:login-button 
                                
                                scope="public_profile,email"
                                onlogin="checkLoginState();"
                                class="loginBtn loginBtn--facebook">
                              </fb:login-button>
                               <br>
                             
                                  <br>
                             <div class="g-signin2" data-onsuccess="onSignIn"></div>
                                 
                             <br>
                                <button  id="loginBtn"  class="btn btn-primary">
                                  Login
                                </button>
                                 <a href="register.jsp" class="btn btn-link">
                                    Register
                                 <a href="forgotp.jsp" class="btn btn-link">
                                    Forgot Your Password?
                                </a>
                            </div>
                    </div>
                    </form>
                        <div id="errors"></div>
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
      
      function onSignIn(googleUser) {
         var profile = googleUser.getBasicProfile();
         console.log('ID: ' + profile.getId());
         console.log('Name: ' + profile.getName());
         console.log('Image URL: ' + profile.getImageUrl());
         console.log('Email: ' + profile.getEmail());
         console.log('id_token: ' + googleUser.getAuthResponse().id_token);

         //do not post all above info to the server because that is not secure.
         //just send the id_token

         var redirectUrl = 'LoginServlet';

         //using jquery to post data dynamically
         var form = $('<form action="' + redirectUrl + '" method="post">' +
                          '<input type="text" name="id_token" value="' +
                           googleUser.getAuthResponse().id_token + '" />' +
                                                                '</form>');
         $('body').append(form);
         form.submit();
      }

        function signOut() {
            var auth2 = gapi.auth2.getAuthInstance();
            auth2.signOut().then(function () {
              console.log('User signed out.');
              setTimeout(function () {
                    window.location.href = "index.jsp"; //will redirect to your blog page (an ex: blog.html)
                 }, 2000); //will call the function after 
            });
          }



   </script>
   <script>
      $(function() { 
       
      $("#loginBtn").click(function(e){
            e.preventDefault();
           if ( $("#password").val().length===0){ 
             $("#errors").html('<div class=\"alert alert-warning\" role=\"alert\">'+
               'Key in your password!</div>');
         } 
        
         if(ValidateEmail($("#email").val())){
          
          
         // alert ("clicked");
       
        $.ajax({type: "POST",
                url: "LoginServlet",//#LoginServlet
                data: { email: $("#email").val(), password: $("#password").val() },
                success:function(result){
                    
            if(result==="success"){
            $("#errors").html('<div class=\"alert alert-success\" role=\"alert\">'+
               'Success</div>');
       
                  setTimeout(function () {
                    window.location.href = "map.jsp"; //will redirect to your blog page (an ex: blog.html)
                 }, 2000); //will call the function after 2 secs.
            //errors
             }else{
                 $("#errors").html('<div class=\"alert alert-warning\" role=\"alert\">'+
               'Login Failed!</div>');
         }
            }
        
    
           });
           
        }
      });
       
       
       function ValidateEmail(mail) {
{
        if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(mail))
         {
           return (true);
         }
           $("#errors").html('<div class=\"alert alert-warning\" role=\"alert\">'+
               'Invalid Email!</div>');
           return (false);
}
       }
       
       
       
      });    
   </script>  
   
<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '299552111172765',
      cookie     : true,
      xfbml      : true,
      version    : 'v7.0'
    });
      
    FB.AppEvents.logPageView();   
      
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "https://connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
   
   
   function checkLoginState() {
  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });
}


function statusChangeCallback(response) {
 console.log('statusChangeCallback');
 console.log(response);
 console.log(response.authResponse.accessToken);
 //
 if (response.status === 'connected') {
     
 window.location.href='LoginServlet?access_token='+response.authResponse.accessToken; 
 } else {
 // The person is not logged into your app or we are unable to tell.
 document.getElementById('errors').innerHTML = '<div class=\"alert alert-warning\" role=\"alert\">'+
               'Login Failed!</div>';
 }
 }
</script>
   
   
    </body>
</html>
