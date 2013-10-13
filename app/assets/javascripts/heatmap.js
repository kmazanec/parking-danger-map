// Adding 500 Data Points
var map, heatmap;

function initialize() {
  var mapOptions = {
    zoom: 12,
    center: new google.maps.LatLng(40.7833, -73.9667),
    mapTypeId: google.maps.MapTypeId.MAP
  };


  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  var pointArray = new google.maps.MVCArray(parkingData);

  heatmap = new google.maps.visualization.HeatmapLayer({
    data: pointArray
  });

  heatmap.setMap(map);

  google.maps.event.addListener(map, "click", function(event) {
    var lat = event.latLng.lat();
    var lng = event.latLng.lng();
    // populate yor box/field with lat, lng
    $("#location").val(lat + '; ' + lng);
    // alert("Lat=" + lat + "; Lng=" + lng);
  });

  var parkingData = [];

  $.get('/map_data', function(response){
    console.log(response);

    // var parkingData =
        for (var i=0; i<response.length; i++){
          parkingData[i] = new google.maps.LatLng(response[i][0], response[i][1]);
        }


  });
   google.maps.event.addListener(map, 'idle', function() {
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
            minLong: southWestCoordinates[1]};
          $.post('/map_data_tile', latitudeLongitudeData, function(){

          });

         });
}


// var bounds = map.getBounds();
// console.log(bounds);
// var ne = bounds.getNorthEast();
// console.log(ne);
google.maps.event.addDomListener(window, 'load', initialize);




// console.log(ne)
// console.log(sw)



// function toggleHeatmap() {
//   heatmap.setMap(heatmap.getMap() ? null : map);
// }

// function changeGradient() {
//   var gradient = [
//     'rgba(0, 255, 255, 0)',
//     'rgba(0, 255, 255, 1)',
//     'rgba(0, 191, 255, 1)',
//     'rgba(0, 127, 255, 1)',
//     'rgba(0, 63, 255, 1)',
//     'rgba(0, 0, 255, 1)',
//     'rgba(0, 0, 223, 1)',
//     'rgba(0, 0, 191, 1)',
//     'rgba(0, 0, 159, 1)',
//     'rgba(0, 0, 127, 1)',
//     'rgba(63, 0, 91, 1)',
//     'rgba(127, 0, 63, 1)',
//     'rgba(191, 0, 31, 1)',
//     'rgba(255, 0, 0, 1)'
//   ]
//   heatmap.setOptions({
//     gradient: heatmap.get('gradient') ? null : gradient
//   });
// }

// function changeRadius() {
//   heatmap.setOptions({radius: heatmap.get('radius') ? null : 20});
// }

// function changeOpacity() {
//   heatmap.setOptions({opacity: heatmap.get('opacity') ? null : 0.2});
// }
