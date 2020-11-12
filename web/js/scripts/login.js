$(document).ready(function () {
   function between(x, min, max) {
       return x >= min && x <= max;
       }
    $('#login_btn').click(function () {
        var x=parseInt($('#surveyID').val());
		var y=parseInt($('#deviceD').val());
        if ($('#fname').val().length < 3) {

            $('#error_log').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Short or Empty<strong> Name</strong>.</div>");
        } else if ($('#deviceD').val().length < 0 ) {
            $('#error_log').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Empty/Invalid <strong>Device ID</strong>.</div>");

		}else if (!between(y, 1, 55) ) {
            $('#error_log').html("<div class=\"alert alert-warning\"><strong>Fail!</strong>Empty/Invalid <strong>Device ID</strong>.</div>");
		}else if ($('#surveyID').val().length < 0 ) {
			$('#error_log').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Empty/Invalid <strong>Village Code</strong>.</div>");
		
					
		 }else if (!between(x, 1, 650)) {
            $('#error_log').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Empty/Invalid <strong>Village Code</strong>.</div>");

		 
		 }else if ($('#username').val().length < 3) {

            $('#error_log').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Short or Empty<strong> User Name</strong>.</div>");
        }

        else if ($('#p2').val().length < 4) {
            $('#error_log').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Short or Empty <strong>Password</strong>.</div>");


        } else {
             
                    var areacode=$('#surveyID').val();
                   // var jsonData = JSON.parse(JSON.stringify(response));
					var index = jsonData.findIndex(function(item, i){
						
						  return item.VCODE==areacode
						});
					
                   					
                    if (index) {
                         var village=jsonData[index].Village;
					     var vcode=jsonData[index].VCODE;
                         var code=index+1;
						 var subloc=jsonData[index].Subloc;
						 //alert(" vcode:"+vcode+" code:"+code);
						// login
							$.ajax({
								type: "POST",
								url: 'login.php',
								data: $('#login_form').serialize(),
								success: function (response) {
									
									var jsonData = JSON.parse(response);
								 

									if (jsonData.success == "1") {

										$('#error_log').html("<div class=\"alert alert-success\"><strong>Success!</strong>Welcome " + jsonData.fname + "</div>");
										setTimeout(function () {
											window.location.href ="editData.php?vcode="+vcode+"&village="+village+"&subloc="+subloc; 
										}, 2000); //will call the function after 2 secs.

									}
									else {
										$('#error_log').html("<div class=\"alert alert-warning\"><strong>Login Failed</strong> Check your Credentials</div>");
									}
								}
							});
									   }
                    else {
                        $('#error_log').html("<div class=\"alert alert-warning\"><strong>Failed</strong> Check your Village Code</div>");
                    }
             

        }

    });
});