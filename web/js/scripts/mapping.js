let p_arrray=[];
let b_array=[];
let r_array=[];
var geo;
let build;
let road;
var selections=[]; 
let map; 
$(document).ready(function () {
	
	
	        let neCorner =  L.latLng(0.068149, 35.437222);
            let swCorner =  L.latLng(-1.049190, 33.917049);
                        
            
            function checkBounds (marker){
               if( L.latLngBounds(swCorner, neCorner).contains(marker)){
                   return true;
                  }else{
                  return false;
                  } 
            }
           
            let buildings = L.layerGroup();
            let roads = L.layerGroup();
			
			var selection;
            var selectedLayer;
			var theMarker = {};
			var theCircle = {};
            var m;
           
			 
		 // function to eliminate duplicates in an array 
		   function uniq(a) {
              return Array.from(new Set(a));
               }
			
			function arrayRemove(arr, value) {

              return arr.filter(function(ele){
               return ele != value;
                });

              }
			  //Hide  Edit divs
            document.getElementById('buildings').style.display = "block";
            document.getElementById('roads').style.display = "none";
            //document.getElementById('randomPoint').style.display = "none";

            var mbAttr = 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
                '<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
                'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
                mbUrl = 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiZGF2aWRrYSIsImEiOiJjanh5bHp1cWYwYXMwM2Jtdmc4aW1pazBsIn0.EAfNj4ZRn1V5atLW75Cq8A';

            var osmUrl = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
            var osmAttrib = 'Map data © <a href="https://openstreetmap.org">OpenStreetMap</a> contributors';
            let osm = new L.TileLayer(osmUrl, { attribution: osmAttrib });

            let grayscale = L.tileLayer(mbUrl, { id: 'mapbox.light', attribution: mbAttr }),
                streets = L.tileLayer(mbUrl, { id: 'mapbox.streets', attribution: mbAttr });


   
      
            let burl = "geojson\/buildings\/V"+villageCode+".geojson";
         // Buildings
		    document.getElementById('bld_table').value = "buildings";
							    
            $.ajax({
                url: burl,
                contentType: "application/json; charset=utf-8",
                cache: false,
                dataType: "json",
                data: {
                },
                responseType: "json",
                success: function (geojson) {
					
                 buildings.clearLayers();
				 selections.length=0;
                 build=L.geoJSON(geojson, {
                        style: function (feature) {
                           lx = feature.properties.occupancy;
                           return !lx ? { color: '#8c8c8c', opacity: 0.4, fillColor: 'blue', fillOpacity: 0.4 } : { color: '#8c8c8c', opacity: 0.4, fillColor: '#408000', fillOpacity: 0.4 };

                       },
                        onEachFeature: function (feature, layer) {
                            buildings.addLayer(layer);
                            layer.bindPopup("Building :" + feature.properties.BD_CODE);
                            layer.on('click', function (e) {
								
								selection = e.target;
								if (selection.options.color == '#AFEEEE') {  //color of highlighted
								    build.resetStyle(e.target);
							        e.target.feature.properties.selected = false;
									
									//remove from array
                                    b_array = arrayRemove(b_array, layer.feature.properties.BD_CODE);
                                  
								 }else{
								 selections.push(selection);
								 e.target.setStyle({fillColor: '#66CDAA',color: '#AFEEEE',fillOpacity: 0.5});
                                 b_array.push(layer.feature.properties.BD_CODE);
								}
							
							    document.getElementById('buildings').style.display = "block";
							    document.getElementById('parcels_b').innerText ="Selected : "+uniq(b_array).length+" Buildings(s)";
								document.getElementById('bld_id').value = uniq(b_array).join();
						        document.getElementById('roads').style.display = "none";
                                L.DomEvent.stopPropagation(e);
                            });
                        }
						
                    });
					
                  map.fitBounds(build.getBounds());// fit geojson!!
                },
                error: function () {
                    //alert('ERROR.');
                },
            });
      


 

        document.getElementById('road_table').value = "roads";
        let url = "geojson\/roads\/"+villageCode+".geojson";
        $.getJSON(url, function (data) {
            selections.length = 0;
             roads.clearLayers();
                road=L.geoJson(data, {
                    style: function (feature) {

                        sf = feature.properties.surface_type;
                        return !sf ? { color: 'orange', opacity: 0.4, weight: 4 } : { color: '#339933', opacity: 0.4, weight: 5 };

                    },
                    onEachFeature: function (feature, layer) {
                        roads.addLayer(layer);
                        layer.bindPopup("Road :" + feature.properties.RID);
                        layer.on('click', function (e) {
							
							     selection = e.target;
							
								if (selection.options.color == '#AFEEEE') {  //color of highlighted
								    road.resetStyle(e.target);
							        e.target.feature.properties.selected = false;
									
									//remove from array
								 r_array=arrayRemove(r_arrray,layer.feature.properties.RID);
                                  
								 }else{
								 selections.push(selection);
								 e.target.setStyle({fillColor: '#66CDAA',color: '#AFEEEE',fillOpacity: 0.5,weight: 4});
								 r_array.push(layer.feature.properties.RID);
								}
								
								
								//
							document.getElementById('road_id').value = uniq(r_array).join();
							document.getElementById('roads').style.display = "block";
                           
                            document.getElementById('buildings').style.display = "none";
                            
							document.getElementById('parcels_r').innerText ="Selected : "+uniq(r_array).length+" Road(s)";
							
							
                            // L.DomEvent.stopPropagation(e);
						});
                        //layer.bindPopup(feature.properties.rd_id);

                    }
                });

            });//ajax
			
			

	var villa=L.geoJSON(villages_geojson, {
				filter: function(feature, layer) {
					if (feature.properties.VCODE==villageCode) return true;
				
				},
				
				style: { color: 'red', opacity: 0.3, fillColor: 'blue', fillOpacity: 0.0 }
			});
						
   

            map = L.map('map', {
                center: [-0.1009306, 34.755408],
                zoom: 16,
				//layers: [grayscale, osm, streets, parcels]// showing parcel form on default
                layers: [grayscale,streets,buildings,roads,villa]
				
				,fullscreenControl: true,
			    fullscreenControlOptions: {
                position:"topleft"	,				// optional
				 title:"Show me fullscreen  Map!",
				titleCancel:"Exit fullscreen mode"
				
			} 
			
            });


            let baseMaps = {
                "Grayscale": grayscale,
                "Streets": streets
                //'OSM': osm

            };

            let overlayMaps = {
                //"Parcels": parcels,
                "Buildings": buildings,
                "Roads": roads,
                "Village":villa
            };


            L.control.layers(baseMaps, overlayMaps).addTo(map);

           // if (build){
             // map.fitBounds(build.getBounds());// fit geojson!!
			//}



		  //map.locate({ setView: true, watch: false, maxZoom: 18 });//watch: true for tracking

			
			
			
			
			
			
			var locator = L.control.locate({
						position: 'bottomleft',
						icon: 'glyphicon glyphicon-record',
						flyTo: true,
						strings: {
							title: "Locate Me"
						},
						locateOptions: {
							maxZoom: 18,
                           enableHighAccuracy: true
                     }
					}).addTo(map);
							
			// detect fullscreen toggling
		    map.on('enterFullscreen', function(){
			if(window.console) window.console.log('enterFullscreen');
		      });
		        map.on('exitFullscreen', function(){
			if(window.console) window.console.log('exitFullscreen');
		});
			
			

        });//doc ready
