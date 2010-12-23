var dot_size = 3;
var longitude_shift = 55;   // number of pixels your map's prime meridian is off-center.
var x_pos = 54;
var y_pos = 19;
var map_width = 430;
var map_height = 332;
var half_dot = Math.floor(dot_size / 2);
var projection = function plot_point(lat, lng) {
    // Mercator projection
    // longitude: just scale and shift
    x = (map_width * (180 + lng) / 360 + longitude_shift) % map_width;
    // latitude: using the Mercator projection
    lat = lat * Math.PI / 180;  // convert from degrees to radians
    y = Math.log(Math.tan((lat/2) + (Math.PI/4)));  // do the Mercator projection (w/ equator of 2pi units)
    y = (map_height / 2) - (map_width * y / (2 * Math.PI)) + y_pos;   // fit it to our map
    return [x - half_dot, y - half_dot];
};
var po = org.polymaps;
var map = po.map()
    .container(document.getElementById("map").appendChild(po.svg("svg")))
    .add(po.interact())
    .add(po.hash());
361.4738888888889,155.43406264857708
map.add(po.image()
    .url(po.url("http://{S}tile.cloudmade.com"
    + "/faafe9689df04f458ab92901e6ed2ff4" // http://cloudmade.com/register
    + "/998/256/{Z}/{X}/{Y}.png")
    .hosts(["a.", "b.", "c.", ""])));

map.add(po.compass().pan("none"));
