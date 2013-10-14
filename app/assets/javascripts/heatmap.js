// Adding 500 Data Points
var map, heatmap, parkingData;
var pointArray = [];
var home = new google.maps.LatLng(40.7833, -73.9667);
var my_location = new google.maps.LatLng(40.7833, -73.9667);


function convertResponseToLatLong(response){
  for (var i=0; i<response.length; i++){
    parkingData[i] = new google.maps.LatLng(response[i][0], response[i][1]);
  }
  pointArray = new google.maps.MVCArray(parkingData);
  heatmap.setData(pointArray);
  heatmap.setMap(map);
}

function updateMap(){
  var bounds = map.getBounds();
  var northEastCorner = bounds.getNorthEast();
  var southWestCorner = bounds.getSouthWest();
  var latitude = northEastCorner.lb;
  var longitude = northEastCorner.mb;
  var northEastCoordinates = [northEastCorner.lb, northEastCorner.mb];
  var southWestCoordinates = [southWestCorner.lb, southWestCorner.mb];


  var latitudeLongitudeData = {
    maxLat: northEastCoordinates[0],
    maxLong: northEastCoordinates[1],
    minLat: southWestCoordinates[0],
    minLong: southWestCoordinates[1]
  };

  $.post('/map_data_tile', latitudeLongitudeData, function(response) {
    parkingData = [];
    convertResponseToLatLong(response);
  });
}

function HomeControl(controlDiv, map, label, new_location) {

  // Set CSS styles for the DIV containing the control
  // Setting padding to 5 px will offset the control
  // from the edge of the map
  controlDiv.style.padding = '5px';

  // Set CSS for the control border
  var controlUI = document.createElement('div');
  controlUI.style.backgroundColor = 'white';
  controlUI.style.borderStyle = 'solid';
  controlUI.style.borderWidth = '1px';
  controlUI.style.cursor = 'pointer';
  controlUI.style.textAlign = 'center';
  controlUI.title = 'Click to set the map to Home';
  controlDiv.appendChild(controlUI);

  // Set CSS for the control interior
  var controlText = document.createElement('div');
  controlText.style.fontFamily = 'Arial,sans-serif';
  controlText.style.fontSize = '12px';
  controlText.style.paddingLeft = '4px';
  controlText.style.paddingRight = '4px';
  controlText.innerHTML = label;
  controlUI.appendChild(controlText);

  // Setup the click event listeners: simply set the map to home
  google.maps.event.addDomListener(controlUI, 'click', function() {
    map.setCenter(new_location);
  });

}

function locateMe(){
  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      my_location = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
    },function() {
      my_location = new google.maps.LatLng(40.7833, -73.9667);
    });
  }
  else {
    my_location = new google.maps.LatLng(40.7833, -73.9667);
  }
}


function addInfoMarker(titleString, contentString, positionCoords){
  var infowindow = new google.maps.InfoWindow({
      content: contentString,
      maxWidth: 200
  });

  var marker = new google.maps.Marker({
      position: positionCoords,
      map: map,
      title: 'titleString'
  });
  google.maps.event.addListener(marker, 'click', function() {
    infowindow.open(map,marker);
  });
}


function initialize() {
  locateMe();
  var mapOptions = {
    zoom: 12,
    center: my_location,
    mapTypeId: google.maps.MapTypeId.MAP
  };


  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  parkingData = [];

  heatmap = new google.maps.visualization.HeatmapLayer({
    data: pointArray
  });

  changeGradient();
  changeRadius(40);


  google.maps.event.addListener(map, "click", function(event) {
    var lat = event.latLng.lat();
    var lng = event.latLng.lng();
    $("#location").val(lat + '; ' + lng);
  });

  moving = null;

  google.maps.event.addListener(map, 'bounds_changed', function(){
    clearTimeout(moving);
  });

  google.maps.event.addListener(map, 'idle', function() {
    clearTimeout(moving);
    moving = setTimeout("updateMap()", 750);
  });

  var homeControlDiv = document.createElement('div');
  var homeControl = new HomeControl(homeControlDiv, map, "Locate Me", my_location);
  homeControlDiv.index = 1;
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(homeControlDiv);

  var nycControlDiv = document.createElement('div');
  var nycControl = new HomeControl(nycControlDiv, map, "NYC", home);
  nycControlDiv.index = 1;
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(nycControlDiv);

}

google.maps.event.addDomListener(window, 'load', initialize);




// function toggleHeatmap() {
//   heatmap.setMap(heatmap.getMap() ? null : map);
// }

function changeGradient() {
  var gradient = [
    'rgba(0, 255, 255, 0)',
    'rgba(0, 255, 255, 1)',
    'rgba(0, 191, 255, 1)',
    'rgba(0, 127, 255, 1)',
    'rgba(0, 63, 255, 1)',
    'rgba(0, 0, 255, 1)',
    'rgba(0, 0, 223, 1)',
    'rgba(0, 0, 191, 1)',
    'rgba(0, 0, 159, 1)',
    'rgba(0, 0, 127, 1)',
    'rgba(63, 0, 91, 1)',
    'rgba(127, 0, 63, 1)',
    'rgba(191, 0, 31, 1)',
    'rgba(255, 0, 0, 1)'
  ];
  heatmap.setOptions({
    gradient: heatmap.get('gradient') ? null : gradient
  });
}

function changeRadius() {
  heatmap.setOptions({radius: heatmap.get('radius') ? null : 20});
}

function changeOpacity() {
  heatmap.setOptions({opacity: heatmap.get('opacity') ? null : 0.2});
}
















