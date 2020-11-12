<%-- 
    Document   : map
    Created on : Jun 17, 2020, 1:00:53 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
   if (session.getAttribute("userName") == null || session.getAttribute("userName").equals("")){
     // take to login
      response.sendRedirect("index.jsp");   
  }
    %>

<!DOCTYPE html>
<html>
    <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
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
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="js/bootstrap/css/bootstrap.min.css">
  
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://openlayers.org/en/v6.1.1/css/ol.css" />
    <link rel="stylesheet" href="js2/ol3-sidebar.css" />
    <link rel="stylesheet" href="js2/ol-layerswitcher.css" />
    <link rel="stylesheet" href="js2/sidebar.css" />
	<!--<link rel="stylesheet" href="mystyle.css">-->

    <title>Analytics-GIS</title>
  </head>
  <body>
    <div class="container-fluid">
     
    <div id="wrap">	
	
	 <nav class="navbar navbar-default">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
					
                    <a class="navbar-brand" href="#"><img src="images/favicon-32x32.png" alt="Analytics Logo"  /> </a>
                
				
                    <a class="navbar-brand" href="#">Analytics GIS Demo </a>
             </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#">Home <span class="sr-only">(current)</span></a></li>
                       
						
						
					</ul>

                  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#uploadXlsModal" style="margin :10px;">
  Upload Xls
</button>
                    
                  <button type="button" class="btn btn-success" data-toggle="modal" data-target="#uploadComment" style="margin :10px;">
  Leave a Comment
</button>
                        <ul class="nav navbar-nav navbar-right">
                          <li><a href="#"><span class="glyphicon glyphicon-user"></span> <%= (String)session.getAttribute("userName") %> </a> </li>
                                               
                          <li><a href="LoginServlet?action=logout" id="logoutBtn"><span class="glyphicon glyphicon-log-out"></span> Log Out </a></li>
                       </ul>
                     
					
					

                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
	
	
	
 <div class="row" >
 
 <!-- Modal -->
<div class="modal fade" id="uploadXlsModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Upload xls file</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <h6> Ensure The XLS file has field headers and 'Lat','long' fields for Mapping if needed!<h6>
	  <div class="file-upload-wrapper">
       <input type="file" id="fileUpload" class="file-upload" data-max-file-size="2M" accept=".xls,.xlsx" />
      </div>
		<div id ="uploadinfo"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="button" class="btn btn-primary">Upload</button>
      </div>
    </div>
  </div>
</div>
 
 <!-- Modal -->
<div class="modal fade" id="uploadComment" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Leave a Comment</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <h6> Please write a brief comment on the  data or map etc <h6>
	 
              <form  id="commentform">
                  
               <div class="form-group row">
              <textarea name="ucomment" id ="ucomment" class="form-control" rows="5" form="commentform">Comment.</textarea> 
        
              </div>
              </form>
	    <div id ="commentinfo"></div>
                
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="ubutton" class="btn btn-primary">Submit</button>
      </div>
    </div>
  </div>
</div>
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
  <!--<aside class="sidebar">Sidebar-->
  <!-- START OF SIDEBAR DIV -->
    <div id="sidebar" class="sidebar collapsed">

      <!-- Nav tabs -->
      <div class="sidebar-tabs">
        <ul role="tablist">
          <li><a href="#home" role="tab"><i class="fa fa-bars"></i></a></li>
          <li><a href="#profile" role="tab"><i class="fa fa-info-circle"></i></a></li>
        <!--  <li class="disabled"><a href="#messages" role="tab"><i class="fa fa-map-o"></i></a></li>
          -->
          <li ><a href="#messages" role="tab"><i class="fa fa-wrench"></i></a></li>
          <li><a href="https://kendigi.com" role="tab" target="_blank"><i class="fa fa-home"></i></a></li>
        </ul>

        <ul role="tablist">
          <li><a href="#settings" role="tab"><i class="fa fa-gear"></i></a></li>
        </ul>
      </div>

      <!-- Tab panes -->
      <div class="sidebar-content">
        <div class="sidebar-pane" id="home">
          <h1 class="sidebar-header">
          Layers
            <span class="sidebar-close"><i class="fa fa-caret-left"></i></span>
          </h1>
          <!-- !!! HERE WILL GO THE CONTENT OF LAYERSWITCHER !!! -->
          <div id="layers" class="layer-switcher"></div>
        </div>

        <div class="sidebar-pane" id="profile">
          <h1 class="sidebar-header">Legend<span class="sidebar-close"><i class="fa fa-caret-left"></i></span></h1>
		 <h6><b>Bill boards</b> </h6>
	      <img src="../geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=15&HEIGHT=15&LAYER=analytics:billboard_locations&legend_options=fontName:Times%20New%20Roman;fontAntiAliasing:true;fontColor:0x000033;fontSize:8;bgColor:0xFFFFFF;dpi:180" />
       	   
		  <h6><b>Points of Interest (POI)</b> </h6>
	      <img src="../geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=15&HEIGHT=15&LAYER=analytics:poi&legend_options=fontName:Times%20New%20Roman;fontAntiAliasing:true;fontColor:0x000033;fontSize:8;bgColor:0xFFFFFF;dpi:180" />
        		  <h6><b>Population Density </b> </h6>
          <img src="../geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=15&HEIGHT=15&LAYER=analytics:pop_density&legend_options=fontName:Times%20New%20Roman;fontAntiAliasing:true;fontColor:0x000033;fontSize:8;bgColor:0xFFFFFF;dpi:180" />
         	  <h6><b>Uber Mean travel_Time </b> </h6>
          <img src="../geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=15&HEIGHT=15&LAYER=analytics:uber_mean_travel_time&legend_options=fontName:Times%20New%20Roman;fontAntiAliasing:true;fontColor:0x000033;fontSize:8;bgColor:0xFFFFFF;dpi:180" />
         
	   
	   </div>
        
        <div class="sidebar-pane" id="messages">
          <h1 class="sidebar-header">Filters | Search <span class="sidebar-close"><i class="fa fa-caret-left"></i></span></h1>
                
          <h4>POI</h4>
          <h5> Filter your POI by Type</h5>
          <div class="form-check">
            <label class="form-check-label">
              <input type="checkbox" class="form-check-input"  name="poifilter" value="Tow Truck Service"> Tow Truck Service
            </label>
          </div>
          <div class="form-check">
            <label class="form-check-label">
              <input type="checkbox" class="form-check-input" name="poifilter" value="Accomodation"> Accomodation
            </label>
          </div>
          <div class="form-check">
            <label class="form-check-label">
              <input type="checkbox" class="form-check-input"  name="poifilter" value="Health Facilities" > Health Facilities
            </label>
          </div>
          <div class="form-check">
            <label class="form-check-label">
              <input type="checkbox" class="form-check-input"  name="poifilter" value="Fuel Stations" > Fuel Stations
            </label>
          </div>
          <button type="button"  class="btn btn-success" id="submitFilter">Update</button>
          <button type="button"  class="btn btn-light" id="resetFilter">Reset</button>
          <br>
         <div id="err" ></div>
          </div>

        <div class="sidebar-pane" id="settings">
          <h1 class="sidebar-header">Settings<span class="sidebar-close"><i class="fa fa-caret-left"></i></span></h1>
          <p>Define your New settings here</p> 
		  
		      
        </div>
      </div>
    </div>
    <!-- END OF SIDEBAR DIV -->  
  
  
  
  
    <div id="map" class="sidebar-map"></div>
   <div id="popup" class="ol-popup"></div>

 



</div>

 </div>
</div> <!--wrapper-->
  <!--<footer class="footer">My footer</footer>-->


    <!-- Optional JavaScript -->
   <script src="js/jquery/jquery-3.4.1.min.js"></script>
   <script src="js/bootstrap/js/bootstrap.min.js"></script>
  <script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
   <script src="https://openlayers.org/en/v6.1.1/build/ol.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.3/xlsx.full.min.js"></script>
    <script>
     
      if (window.ol && !window.ol.inherits) {
        ol.inherits = function inherits(childCtor, parentCtor) {
          childCtor.prototype = Object.create(parentCtor.prototype);
          childCtor.prototype.constructor = childCtor;
        }
      }
    </script>
    <script src="js2/ol3-sidebar.js"></script>
    <script src="js2/ol-layerswitcher.js"></script>
    <script src="js2/sidebar.js"></script>
    <script>
      let selectedp= [];
      let poi_st="";
      $(function() { 
          
        $("#submitFilter").click(function(e){
            e.preventDefault();
            selectedp= [];
            poi_st="";
            $.each($("input[name='poifilter']:checked"), function(){
                selectedp.push($(this).val());
                poi_st+="'"+$(this).val()+"',";
                
            });
          
           //update poi filter
           if(selectedp.length >0){
               
           updateFilter("type IN ("+ poi_st.substring(0, poi_st.length - 1)+")");
          }else{
              $("#err").html('<div class=\"alert alert-warning\" role=\"alert\">'+
               'Nothing Selected.Nothing to update</div>'); 
           }
        
        });
    
        
        $("#resetFilter").click(function(e){
            e.preventDefault();
            resetFilter( "type IS NOT NULL");
            $("input[name='poifilter']").prop('checked',false);
        });
        
        
        
        
        $("#ubutton").click(function(e){ 
        
             e.preventDefault();
         if ( $("#ucomment").val().length > 10){ 
            
               $.ajax({type: "POST",
                url: "LoginServlet",//#LoginServlet
                data: { ucomment: $("#ucomment").val()},
                success:function(result){
        
               if(result==="success"){
                $("#commentinfo").html('<div class=\"alert alert-success\" role=\"alert\">'+
                'Thanks.Comment submitted.We value your feedback!</div>');
                $("#ucomment").val("");
                
                 }else{
                 $("#commentinfo").html('<div class=\"alert alert-warning\" role=\"alert\">'+
               'Failed! Comment not submitted!</div>');
              }
            }
        
    
           });
           
        }else{
             $("#commentinfo").html('<div class=\"alert alert-warning\" role=\"alert\">'+
               'Failed! Comment is too Short!</div>');
              }
      
      });
          
      });   
         
  </script>
    
    
    <script>
  
  
  function updateFilter(filter){
	   
           var params = poi.getSource().getParams();
			
                        params.CQL_FILTER = filter;
	   poi.getSource().updateParams(params);
          
	}

  function resetFilter(p){
	       var params = poi.getSource().getParams();
			    params.CQL_FILTER =p;
	       poi.getSource().updateParams(params);
	       	
	}
  
    
    $(function() {
      
      
     
     out_fields=[
      'Condition',
      'Height',
      'MediaOwner',
      //'Photo',
      'SelectMedium'
      ];
  
    
	// Overlay to manage popup on the top of the map
      var popup = document.getElementById('popup');
      var overLay = new ol.Overlay({
        element: popup
      });
	
	map.addOverlay(overLay);
	// display popup on click
	/*
  map.on('click', function(evt) {
  var feature = map.forEachFeatureAtPixel(evt.pixel,
  function(feature, layer) {
    return feature;
  });
  */
   	
var billBSource = new ol.source.Vector();

    function biilBStyle(feature) {
      var style = new ol.style.Style({
        image: new ol.style.Circle({
          radius: 6,
          stroke: new ol.style.Stroke({
            color: 'white',
            width: 2
          }),
          fill: new ol.style.Fill({
            color: 'orange'
          })
        })
      });
      return [style];
    }

    var BillboardLayer = new ol.layer.Vector({
      source: billBSource,
      style: biilBStyle
    });	
	
	let JsonData;
	let selectedFile;
    console.log(window.XLSX);
    document.getElementById('fileUpload').addEventListener("change", (event) => {
             selectedFile = event.target.files[0];
     });

    var transform = ol.proj.getTransform('EPSG:4326', 'EPSG:3857');

    document.getElementById('button').addEventListener("click", () => {
    
    if(selectedFile){
        let fileReader = new FileReader();
        fileReader.readAsBinaryString(selectedFile);
        fileReader.onload = (event)=>{
         let data = event.target.result;
         let workbook = XLSX.read(data,{type:"binary"});
         console.log(workbook);
         workbook.SheetNames.forEach(sheet => {
              let rowObject = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheet]);
              console.log(rowObject);
			  JsonData=JSON.stringify(rowObject);
            
			 document.getElementById("uploadinfo").innerHTML = '<div class=\"alert alert-success\" role=\"alert\"> upload Successful!</div>';
			
			 //Do mapping
                         valid=false;
			rowObject.forEach(function(item) {
					// create a new feature with the item as the properties
					var feature = new ol.Feature(item);
					// add a url property for later ease of access
					feature.set('url', item.Photo);
					feature.set('id', item.BillboardID);
					 console.log(item.BillboardID);
					// create an appropriate geometry and add it to the feature
					try{
                                         var coordinate = transform([parseFloat(item.long), parseFloat(item.Lat)]);
					 var geometry = new ol.geom.Point(coordinate);
					feature.setGeometry(geometry);
					// add the feature to the source
					billBSource.addFeature(feature);
                                        valid=true;
                                        }catch(err) {
                                            
                                        document.getElementById("uploadinfo").innerHTML = '<div class=\"alert alert-warning\" role=\"alert\"> Invalid XlS file!</div>';
			                      
                                        }
				  });	
				
				if(valid){
                                    
                                    BillboardLayer.getSource().on('addfeature', function(){
                                        map.getView().fit(
                                            BillboardLayer.getSource().getExtent(),
                                            { duration: 1590, size: map.getSize() }
                                        );
                                     });
				map.addLayer(BillboardLayer);
				//zoom to layer
                               // map.getView().fit(BillboardLayer.getSource().getExtent());
                                let extent = ol.extent.createEmpty();
                                BillboardLayer.getSource().forEachFeature(function(feature) {
                                  
                                     ol.extent.extend(extent, feature.getGeometry().getExtent());
                                
                                });
                                map.getView().fit(extent, { duration: 2200, size: map.getSize() });
                                
                                $('#uploadXlsModal').modal('hide');
                                 }
			 
			 
         });
        };
		
		//fileReader.readAsBinaryString(selectedFile);
    }
});



// Manage click on the map to display/hide popup

      map.on('click', function(e) {
        var info = [];
        var coordinate = e.coordinate;
        map.forEachFeatureAtPixel(e.pixel, function (feature) {
          info.push('<table class=\"table table-dark table-striped table-sm table-responsive\" bgcolor=\"gray\" ><tbody>' + feature.getKeys().slice(1).map((k, i) => {
		   console.log(k +":"+ feature.get(k));
		   let h;
		   if (out_fields.includes(k)){
		   let g;
	
		    if (k==='Photo'){
		       g = '<img src=\"'+feature.get(k)+'\" height=\"200px\" width=\"200px\" />';
			    console.log(g);
		     } else{
		       g=feature.get(k);
		      }
			 
             h= '<tr><th>' + k + '</th>'
            + '<td>' + g + '</td>' + '</tr>';
			}
			return h;
          }).join('') + '</tbody></table>');
        });
        if (info.length > 0) {
          // console.log(info);
          popup.innerHTML = info.join(',').replace(/<img[^>]*>/g,"");
          popup.style.display = 'inline';
          overLay.setPosition(coordinate);
        } else {
          popup.innerHTML = '&nbsp;';
          popup.style.display = 'none';
        }
      });
	  
	/*  
	  // change mouse cursor when over marker
		map.on('pointermove', function(e) {
		  if (e.dragging) {
			$(element).popover('destroy');
			return;
		  }
		  var pixel = map.getEventPixel(e.originalEvent);
		  var hit = map.hasFeatureAtPixel(pixel);
		  map.getTarget().style.cursor = hit ? 'pointer' : '';
		});
*/
	
	
});



  
  </script>
  </body>
</html>