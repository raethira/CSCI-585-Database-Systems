BONUS QUESTION:
==============

https://jsfiddle.net/td9uo4jm/2/


var R=8, r=1, a=4;
var x0=R+r-a, y0=0;
var cos=Math.cos, sin=Math.sin, pi=Math.PI, nRev=16;
for(var t=0.0; t < (pi*nRev); t+=0.01)
{
  var x = (R+r)*cos((r/R)*t) - a*cos((1+r/R)*t);
  var y = (R+r)*sin((r/R)*t) - a*sin((1+r/R)*t);
  var coords = ((-122.028556+x/10000)+','+(37.382472+y/10000)+',17');
  console.log(coords);
} 