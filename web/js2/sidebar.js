var map;
var poi;
(function() {
	/*
      var sourced = new ol.source.OSM();
       
      var overviewMapControl = new ol.control.OverviewMap({
                  layers: [
                    new ol.layer.Tile({
                      source: sourced
                    })
                  ]
                });
                
                */
	var control = new ol.control.ScaleLine({
                    units: 'metric',
                    text: 'scaleline',
                    minWidth: 140
                  });
	var url ='../geoserver/analytics/wms';
	var format = 'image/png';
	
	poi=new ol.layer.Tile({
                               visible: true,
							   title: 'POI',
                               source: new ol.source.TileWMS({
                               url: url,
							  
                               params: {'FORMAT': format, "LAYERS": 'analytics:poi','VERSION':'1.1.1'}
                   
                             })
                            });
							 
	
        map = new ol.Map({
         controls: new ol.control.defaults().extend([
                    control,new ol.control.ZoomSlider()
          ]),
        target: 'map',
        layers: [
            new ol.layer.Group({
                // A layer must have a title to appear in the layerswitcher
                'title': 'Base Maps',
                layers: [
                    new ol.layer.Group({
                       
                        title: 'Water color & labels',
                       // collapsible
                        fold: 'open',
                        type: 'base',
                       
                        combine: true,
                        visible: false,
                        layers: [
                            new ol.layer.Tile({
                                source: new ol.source.Stamen({
                                    layer: 'watercolor'
                                })
                            }),
                            new ol.layer.Tile({
                                source: new ol.source.Stamen({
                                    layer: 'terrain-labels'
                                })
                            })
                        ]
                    }),
					new ol.layer.Tile({
                       
                        title: 'Esri',
                        
                        type: 'base',
                        visible: false,
                        source:new ol.source.XYZ({
							attributions: 'Tiles © <a href="https://services.arcgisonline.com/ArcGIS/' +
								'rest/services/World_Topo_Map/MapServer">ArcGIS</a>',
							url: 'https://server.arcgisonline.com/ArcGIS/rest/services/' +
								'World_Topo_Map/MapServer/tile/{z}/{y}/{x}'
						  })
					}),
					new ol.layer.Tile({
                      
                        title: 'Esri Imagery',
                        // Again set this layer as a base layer
                        type: 'base',
                        visible: false,
                        source:new ol.source.XYZ({
							attributions: 'Tiles © <a href="https://services.arcgisonline.com/ArcGIS/' +
								'rest/services/World_Topo_Map/MapServer">ArcGIS</a>',
							url: 'https://services.arcgisonline.com/arcgis/rest/services/' +
                                 'ESRI_Imagery_World_2D/MapServer/tile/{z}/{y}/{x}'
						  })
					}),
					
										
                   
                    new ol.layer.Tile({
                        // A layer must have a title to appear in the layerswitcher
                        title: 'OSM',
                        // Again set this layer as a base layer
                        type: 'base',
                        visible: true,
                        source: new ol.source.OSM()
                    })
                ]
            }),
			
		
            new ol.layer.Group({
                // A layer must have a title to appear in the layerswitcher
                title: 'Layers',
                // Adding a 'fold' property set to either 'open' or 'close' makes the group layer
                // collapsible
                fold: 'open',
                layers: [
                    
					
				new ol.layer.Group({
                        // A layer must have a title to appear in the layerswitcher
                        title: 'Bill Boards',
                        fold: 'open',
                        layers: [
                            new ol.layer.Image({
                                // A layer must have a title to appear in the layerswitcher
                                title: 'Bill Boards',
								visible: true,
                                source: new ol.source.ImageWMS({
                                    params: {'LAYERS': 'analytics:billboard_locations','VERSION':'1.1.1'},
                                    url: url ,
									 
									})
                            })
							
							
                        ]
                    })

  ,       
				new ol.layer.Group({
                        // A layer must have a title to appear in the layerswitcher
                        title: 'Other',
                        fold: 'open',
                        layers: [
                            new ol.layer.Image({
                                // A layer must have a title to appear in the layerswitcher
                                title: 'Uber Mean travel Time',
								visible: false,
                                source: new ol.source.ImageWMS({
                                    params: {'LAYERS': 'analytics:uber_mean_travel_time','VERSION':'1.1.1'},
                                    url: url ,
									 
									})
                            }),
                            new ol.layer.Tile({
                               visible: false,
							   title: 'Population',
                               source: new ol.source.TileWMS({
                               url: url,
							  
                               params: {'FORMAT': format, "LAYERS": 'analytics:pop_density','VERSION':'1.1.1'}
             
                                 
                             })
                            }),
							poi
							
                        ]
                    })







				
                ]
            })
		
			
			
			
        ],
        view: new ol.View({
			
          center: ol.proj.transform([ 36.823,-1.292 ], 'EPSG:4326', 'EPSG:3857'),
	 
           zoom: 11
        })
    });

  
    var sidebar = new ol.control.Sidebar({ element: 'sidebar', position: 'left' });
    var toc = document.getElementById("layers");
    ol.control.LayerSwitcher.renderPanel(map, toc);
    map.addControl(sidebar);
	

})();
