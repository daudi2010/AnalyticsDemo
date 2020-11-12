  $(document).ready(function () {

  
  var landuse={
	'Residential': ['Single Household living', 'Multiple Household living', 'Hotels, boarding and guest houses', 'Institutional living'],
	'Industrial': ['Mining and quarrying', 'Maintenance and repair of motor vehicles', 'Manufacture of wood and products of wood', 'Manufacture of furniture', 'Manufacture of fabricated metal products', 'Other manufacturing'],
	'Educational': ['Pre - primary education', 'Primary education', 'Secondary education', 'Technical and vocational education', 'Higher education', 'Other education'],
	'Recreational': ['Outdoor amenity and open spaces', 'Creative, arts and entertainment activities', 'Libraries, museums and gallery activities', 'Other amusement and recreation activities'],
	'Public_Purpose': ['Medical and health care services', 'Sports activities, amusement and recreation activities', 'Social, Cultural or religious assembly', 'Public administration and defence', 'Other public purpose activities'],
	'Commercial': ['Professional, scientific and technical activities', 'Financial and insurance activities', 'Food and beverage service activities', 'Wholesale and retail trade', 'Informal Retail sale via stalls and markets', 'Other commercial activities'],
	'Public_Utility': ['Electric power generation, transmission and distribution', 'Water collection, treatment and supply', 'Sewerage', 'Solid Waste collection, treatment and disposal activities', 'Cemeteries and crematoria'],
	'Transportation': ['Transport tracks and ways', 'Transport terminals and interchanges', 'Car parks and holding grounds', 'Warehousing support activities for transportation', 'Other transportation activities'],
	'Conservation': ['Managed Conservation', 'Unmanaged Conservation'],
	'Agriculture': ['Fishing and aquaculture', 'Forestry and logging', 'Crop and animal production', 'Other Agricultural activities'],
	'Water_Bodies': ['Lake', 'River', 'Dams and Ponds', 'Wetlands'],
};

   var $activity = $('#activity');
   
    $('#blanduse').change(function () {
		
        var act = ($(this).val()).trim(), lcns = landuse[act] || [];
        
        var html = $.map(lcns, function(lcn){
			
            return '<option value="' + lcn + '">' + lcn + '</option>'
        }).join('');
        $activity.html(html);
    });
  
  $('#submit_buildings').click(function () {

                //validate inuts
                if ($('#bld_id').val().length < 1) {

                    $('#bld_error').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Click on a Building to get<strong> Building ID</strong>.</div>");
                }

                else if ($('#wallmat').val().length < 1) {
                    $('#bld_error').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Please select <strong>Wall Material</strong>.</div>");
                } else if ($('#roofmat').val().length < 1) {

                    $('#bld_error').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Please select <strong>Roof Material</strong>.</div>");


                } else if ($('#floors').val().length < 1) {

                    $('#bld_error').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Please enter  No of <strong>Floors</strong>.</div>");

               } else if ($('#typology').val().length < 1) {

                    $('#bld_error').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Please select <strong>Typology</strong>.</div>");
               } else if ($('#landuse').val().length < 1) {

                    $('#bld_error').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Please select <strong>landuse</strong>.</div>");
               
			   } else if ($('#activity').val().length < 1) {

                    $('#bld_error').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Please select <strong>Activity</strong>.</div>");

                }else if ($('#occupancy').val().length < 1) {

                    $('#bld_error').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Please select <strong> Occupancy</strong>.</div>");

                }
                else {

                    $.ajax({
                        type: "POST",
                        url: 'UpdateBuildings.php',
                        data: $('#bldform').serialize(),
                        success: function (response) {
                            // alert(response);
                            var jsonData = JSON.parse(response);

                            if (jsonData.success == "1") {

                                $('#bld_error').html("<div class=\"alert alert-success\"><strong>Success!</strong>"+b_array.length+ " Building(s) Updated.</div>");
                                $('#bldform :input').attr('value', '');
                                $('#typology').prop('selectedIndex', 0);
                                $('#occupancy').prop('selectedIndex', 0);
                                $('#roofmat').prop('selectedIndex', 0);
                                $('#wallmat').prop('selectedIndex', 0);

                                $('select').prop('selectedIndex', 0);

                                document.getElementById('bldname').value = '';
                                document.getElementById('floors').value = '';
                                document.getElementById('bld_id').value = '';
								
								
								//unselect selections
								var i;
								for (i = 0; i < selections.length; i++) { 
								  build.resetStyle(selections[i]);
								   selections[i].setStyle({fillColor: 'purple',color: 'purple',fillOpacity: 0.5});
							        selections[i].feature.properties.selected = false;
								}
								
								b_array.length=0;  //empty array
								
								document.getElementById('parcels_b').innerText ="Selected : 0 Building(s)";
								
                            } else {
                                $('#bld_error').html("<div class=\"alert alert-warning\"><strong>Fail!</strong>Duplicate/Failed to Update Building info.</div>");
                            }
                        }
                    });
                }

            });


            $('#submit_roads').click(function () {

                //validate inputs
                if ($('#road_id').val().length < 1) {

                    $('#road_error').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Click on a Road to get <strong>Road ID</strong>.</div>");
                }

                else if ($('#roadname').val().length < 1) {

                    $('#road_error').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Road Name required.</div>");
                }
                else if ($('#surfacetype').val().length < 1) {
                    $('#road_error').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Please select <strong>Surface Type</strong>.</div>");
                } else if ($('#condition').val().length < 1) {

                    $('#road_error').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Please select <strong>Condition</strong>.</div>");
                } else {
                     //alert("you are submitting" + $('#roadform2').serialize());
                    $.ajax({
                        type: "POST",
                        url: 'UpdateRoads.php',
                        data: $('#roadform2').serialize(),
                        success: function (response) {
                           // alert(response);
                            var jsonData = JSON.parse(response);


                            if (jsonData.success == "1") {

                                $('#road_error').html("<div class=\"alert alert-success\"><strong>Success!</strong>"+r_array.length+" Record(s) Updated.</div>");
                                $('#roadform :input').attr('value', '');
                                $('#surfacetype').prop('selectedIndex', 0);
                                $('#condition').prop('selectedIndex', 0);
                                $('#road_id').attr('value', '');
                                $('#roadname').attr('value', '');
                                document.getElementById('roadname').value = '';
                                document.getElementById('road_id').value = '';
                                $('select').prop('selectedIndex', 0);
								
								
								//unselect selections
								var i;
								for (i = 0; i < selections.length; i++) { 
								  road.resetStyle(selections[i]);
							        selections[i].feature.properties.selected = false;
									selections[i].setStyle({fillColor: 'green',color: 'green',fillOpacity: 0.5});
								}
								
								r_array.length=0;  //empty array
								
								document.getElementById('parcels_r').innerText ="Selected : 0 Road(s)";
								
                            }
                            else {
                                $('#road_error').html("<div class=\"alert alert-warning\"><strong>Fail!</strong> Updating Road Failed.</div>");
                            }
                        }
                    });

                }
            });


           
			//
			//Upload
            $('#upload_btn').click(function () {
                 alert('Submit data to Server?');

                       $.ajax({
                         type: "POST",
                         url: 'upload.php',
                         success: function (response) {
                             alert(response);
                            var jsonData = JSON.parse(response);

                            if (jsonData.success) {
                               // alert(jsonData.success);
                            }
                            else {
                                
                               //  alert(jsonData.fail);
								}
                        }
                    });

                
            });

        //
        });