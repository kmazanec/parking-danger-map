// Adding 500 Data Points
var map, heatmap;

 var taxiData = [
    new google.maps.LatLng(23.56765,-110.45654),
    new google.maps.LatLng(24.4565,-112.34545),
    new google.maps.LatLng(22.54343,-111.34544),
    new google.maps.LatLng(21.45434,-109.65465)
    
  ];

function initialize() {
  var mapOptions = {
    zoom: 13,
    center: new google.maps.LatLng(37.774546, -122.433523),
    mapTypeId: google.maps.MapTypeId.SATELLITE
  };

  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  var pointArray = new google.maps.MVCArray(taxiData);

  heatmap = new google.maps.visualization.HeatmapLayer({
    data: pointArray
  });

  heatmap.setMap(map);
}



google.maps.event.addDomListener(window, 'load', initialize);


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
