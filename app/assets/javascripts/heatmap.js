// Adding 500 Data Points
var map, heatmap, parkingData;
var pointArray = [];
var home = new google.maps.LatLng(40.7833, -73.9667);


function convertResponseToLatLong(response){
  for (var i=0; i<response.length; i++){
    parkingData[i] = new google.maps.LatLng(response[i][0], response[i][1]);
  }
  pointArray = new google.maps.MVCArray(parkingData);

  heatmap.setData(pointArray);

  heatmap.setMap(map);

}

function updateMap(){

  console.log("calling the update map function");

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

function HomeControl(controlDiv, map) {

  // Set CSS styles for the DIV containing the control
  // Setting padding to 5 px will offset the control
  // from the edge of the map
  controlDiv.style.padding = '5px';

  // Set CSS for the control border
  var controlUI = document.createElement('div');
  controlUI.style.backgroundColor = 'white';
  controlUI.style.borderStyle = 'solid';
  controlUI.style.borderWidth = '2px';
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
  controlText.innerHTML = '<b>Home</b>';
  controlUI.appendChild(controlText);

  // Setup the click event listeners: simply set the map to
  // Chicago
  google.maps.event.addDomListener(controlUI, 'click', function() {
    map.setCenter(home);
  });

}



function initialize() {
  var mapOptions = {
    zoom: 12,
    center: home,
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
    // populate yor box/field with lat, lng
    $("#location").val(lat + '; ' + lng);
    // alert("Lat=" + lat + "; Lng=" + lng);
  });

  moving = null;

  google.maps.event.addListener(map, 'bounds_changed', function(){
    clearTimeout(moving);
  });

  google.maps.event.addListener(map, 'idle', function() {
    clearTimeout(moving);
    moving = setTimeout("updateMap()", 1200);
  });

  var homeControlDiv = document.createElement('div');
  var homeControl = new HomeControl(homeControlDiv, map);

  homeControlDiv.index = 1;
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(homeControlDiv);


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
















