
---
output:
  html_document:
    self_contained: no
---

## The Cowboy Hat  

I've been a SAS user for about 30 years and when I was learning to use the 3D graphics procs in SAS I was introduced to a little program called the "Cowboy Hat". It creates a data set of values that when plotted look vaguely like a stylized 10 gallon cowboy hat. (sort of)

The code can be found here along with a simple graphic in SAS.

[Cowboy Hat](http://support.sas.com/documentation/cdl/en/hostwin/63285/HTML/default/viewer.htm#prodgraph.htm)

I've been taking the Data Science classes from Johns Hopkins on Coursera so I thought I'd try my hand at reproducing it here in R.


## The Data

Now lets run the code to create a data set of x, y and z values. I used for loops because that is what I know! I'm sure there are more than one way to accomplish this task....just like in SAS. The algorithm I used for coloring came from a comment on the blog Ripples by Andrew Wyer. Thanks Andrew!

[Ripples Post](https://aschinchon.wordpress.com/myself/#comments)


```r
library(rgl)
```

```
## Warning: package 'rgl' was built under R version 3.1.1
```

```r
library(evd)
```

```
## Warning: package 'evd' was built under R version 3.1.1
```

```r
df <- data.frame(x=numeric(),
                 y=numeric(), 
                 z=numeric(), 
                 stringsAsFactors=FALSE) 

cnti <- 0


for (i in seq(-5, 5 ,by=.25) )
  
{ 
    
    for (j in  seq(-5 , 5,by=.25))
    {
      cnti <- cnti +1      
      z <- 4 * (sin(sqrt(i*i+j*j)))
      
      df[cnti,1] <- i
      df[cnti,2] <- j
      df[cnti,3] <- z
    }
}


cr <- abs(df$z)/max(abs(df$z))
cg <- abs(df$x)/max(abs(df$x))
cb <- abs(df$y)/max(abs(df$y))
```

## The Graphic

Now lets look at the graphic. You should be able to interact with it using your mouse scroll wheel and right click button.



```r
library(knitr)
knit_hooks$set(webgl = hook_webgl)
cat('<script type="text/javascript">', readLines(system.file('WebGL', 'CanvasMatrix.js', package = 'rgl')), '</script>', sep = '\n')
```

<script type="text/javascript">
CanvasMatrix4=function(m){if(typeof m=='object'){if("length"in m&&m.length>=16){this.load(m[0],m[1],m[2],m[3],m[4],m[5],m[6],m[7],m[8],m[9],m[10],m[11],m[12],m[13],m[14],m[15]);return}else if(m instanceof CanvasMatrix4){this.load(m);return}}this.makeIdentity()};CanvasMatrix4.prototype.load=function(){if(arguments.length==1&&typeof arguments[0]=='object'){var matrix=arguments[0];if("length"in matrix&&matrix.length==16){this.m11=matrix[0];this.m12=matrix[1];this.m13=matrix[2];this.m14=matrix[3];this.m21=matrix[4];this.m22=matrix[5];this.m23=matrix[6];this.m24=matrix[7];this.m31=matrix[8];this.m32=matrix[9];this.m33=matrix[10];this.m34=matrix[11];this.m41=matrix[12];this.m42=matrix[13];this.m43=matrix[14];this.m44=matrix[15];return}if(arguments[0]instanceof CanvasMatrix4){this.m11=matrix.m11;this.m12=matrix.m12;this.m13=matrix.m13;this.m14=matrix.m14;this.m21=matrix.m21;this.m22=matrix.m22;this.m23=matrix.m23;this.m24=matrix.m24;this.m31=matrix.m31;this.m32=matrix.m32;this.m33=matrix.m33;this.m34=matrix.m34;this.m41=matrix.m41;this.m42=matrix.m42;this.m43=matrix.m43;this.m44=matrix.m44;return}}this.makeIdentity()};CanvasMatrix4.prototype.getAsArray=function(){return[this.m11,this.m12,this.m13,this.m14,this.m21,this.m22,this.m23,this.m24,this.m31,this.m32,this.m33,this.m34,this.m41,this.m42,this.m43,this.m44]};CanvasMatrix4.prototype.getAsWebGLFloatArray=function(){return new WebGLFloatArray(this.getAsArray())};CanvasMatrix4.prototype.makeIdentity=function(){this.m11=1;this.m12=0;this.m13=0;this.m14=0;this.m21=0;this.m22=1;this.m23=0;this.m24=0;this.m31=0;this.m32=0;this.m33=1;this.m34=0;this.m41=0;this.m42=0;this.m43=0;this.m44=1};CanvasMatrix4.prototype.transpose=function(){var tmp=this.m12;this.m12=this.m21;this.m21=tmp;tmp=this.m13;this.m13=this.m31;this.m31=tmp;tmp=this.m14;this.m14=this.m41;this.m41=tmp;tmp=this.m23;this.m23=this.m32;this.m32=tmp;tmp=this.m24;this.m24=this.m42;this.m42=tmp;tmp=this.m34;this.m34=this.m43;this.m43=tmp};CanvasMatrix4.prototype.invert=function(){var det=this._determinant4x4();if(Math.abs(det)<1e-8)return null;this._makeAdjoint();this.m11/=det;this.m12/=det;this.m13/=det;this.m14/=det;this.m21/=det;this.m22/=det;this.m23/=det;this.m24/=det;this.m31/=det;this.m32/=det;this.m33/=det;this.m34/=det;this.m41/=det;this.m42/=det;this.m43/=det;this.m44/=det};CanvasMatrix4.prototype.translate=function(x,y,z){if(x==undefined)x=0;if(y==undefined)y=0;if(z==undefined)z=0;var matrix=new CanvasMatrix4();matrix.m41=x;matrix.m42=y;matrix.m43=z;this.multRight(matrix)};CanvasMatrix4.prototype.scale=function(x,y,z){if(x==undefined)x=1;if(z==undefined){if(y==undefined){y=x;z=x}else z=1}else if(y==undefined)y=x;var matrix=new CanvasMatrix4();matrix.m11=x;matrix.m22=y;matrix.m33=z;this.multRight(matrix)};CanvasMatrix4.prototype.rotate=function(angle,x,y,z){angle=angle/180*Math.PI;angle/=2;var sinA=Math.sin(angle);var cosA=Math.cos(angle);var sinA2=sinA*sinA;var length=Math.sqrt(x*x+y*y+z*z);if(length==0){x=0;y=0;z=1}else if(length!=1){x/=length;y/=length;z/=length}var mat=new CanvasMatrix4();if(x==1&&y==0&&z==0){mat.m11=1;mat.m12=0;mat.m13=0;mat.m21=0;mat.m22=1-2*sinA2;mat.m23=2*sinA*cosA;mat.m31=0;mat.m32=-2*sinA*cosA;mat.m33=1-2*sinA2;mat.m14=mat.m24=mat.m34=0;mat.m41=mat.m42=mat.m43=0;mat.m44=1}else if(x==0&&y==1&&z==0){mat.m11=1-2*sinA2;mat.m12=0;mat.m13=-2*sinA*cosA;mat.m21=0;mat.m22=1;mat.m23=0;mat.m31=2*sinA*cosA;mat.m32=0;mat.m33=1-2*sinA2;mat.m14=mat.m24=mat.m34=0;mat.m41=mat.m42=mat.m43=0;mat.m44=1}else if(x==0&&y==0&&z==1){mat.m11=1-2*sinA2;mat.m12=2*sinA*cosA;mat.m13=0;mat.m21=-2*sinA*cosA;mat.m22=1-2*sinA2;mat.m23=0;mat.m31=0;mat.m32=0;mat.m33=1;mat.m14=mat.m24=mat.m34=0;mat.m41=mat.m42=mat.m43=0;mat.m44=1}else{var x2=x*x;var y2=y*y;var z2=z*z;mat.m11=1-2*(y2+z2)*sinA2;mat.m12=2*(x*y*sinA2+z*sinA*cosA);mat.m13=2*(x*z*sinA2-y*sinA*cosA);mat.m21=2*(y*x*sinA2-z*sinA*cosA);mat.m22=1-2*(z2+x2)*sinA2;mat.m23=2*(y*z*sinA2+x*sinA*cosA);mat.m31=2*(z*x*sinA2+y*sinA*cosA);mat.m32=2*(z*y*sinA2-x*sinA*cosA);mat.m33=1-2*(x2+y2)*sinA2;mat.m14=mat.m24=mat.m34=0;mat.m41=mat.m42=mat.m43=0;mat.m44=1}this.multRight(mat)};CanvasMatrix4.prototype.multRight=function(mat){var m11=(this.m11*mat.m11+this.m12*mat.m21+this.m13*mat.m31+this.m14*mat.m41);var m12=(this.m11*mat.m12+this.m12*mat.m22+this.m13*mat.m32+this.m14*mat.m42);var m13=(this.m11*mat.m13+this.m12*mat.m23+this.m13*mat.m33+this.m14*mat.m43);var m14=(this.m11*mat.m14+this.m12*mat.m24+this.m13*mat.m34+this.m14*mat.m44);var m21=(this.m21*mat.m11+this.m22*mat.m21+this.m23*mat.m31+this.m24*mat.m41);var m22=(this.m21*mat.m12+this.m22*mat.m22+this.m23*mat.m32+this.m24*mat.m42);var m23=(this.m21*mat.m13+this.m22*mat.m23+this.m23*mat.m33+this.m24*mat.m43);var m24=(this.m21*mat.m14+this.m22*mat.m24+this.m23*mat.m34+this.m24*mat.m44);var m31=(this.m31*mat.m11+this.m32*mat.m21+this.m33*mat.m31+this.m34*mat.m41);var m32=(this.m31*mat.m12+this.m32*mat.m22+this.m33*mat.m32+this.m34*mat.m42);var m33=(this.m31*mat.m13+this.m32*mat.m23+this.m33*mat.m33+this.m34*mat.m43);var m34=(this.m31*mat.m14+this.m32*mat.m24+this.m33*mat.m34+this.m34*mat.m44);var m41=(this.m41*mat.m11+this.m42*mat.m21+this.m43*mat.m31+this.m44*mat.m41);var m42=(this.m41*mat.m12+this.m42*mat.m22+this.m43*mat.m32+this.m44*mat.m42);var m43=(this.m41*mat.m13+this.m42*mat.m23+this.m43*mat.m33+this.m44*mat.m43);var m44=(this.m41*mat.m14+this.m42*mat.m24+this.m43*mat.m34+this.m44*mat.m44);this.m11=m11;this.m12=m12;this.m13=m13;this.m14=m14;this.m21=m21;this.m22=m22;this.m23=m23;this.m24=m24;this.m31=m31;this.m32=m32;this.m33=m33;this.m34=m34;this.m41=m41;this.m42=m42;this.m43=m43;this.m44=m44};CanvasMatrix4.prototype.multLeft=function(mat){var m11=(mat.m11*this.m11+mat.m12*this.m21+mat.m13*this.m31+mat.m14*this.m41);var m12=(mat.m11*this.m12+mat.m12*this.m22+mat.m13*this.m32+mat.m14*this.m42);var m13=(mat.m11*this.m13+mat.m12*this.m23+mat.m13*this.m33+mat.m14*this.m43);var m14=(mat.m11*this.m14+mat.m12*this.m24+mat.m13*this.m34+mat.m14*this.m44);var m21=(mat.m21*this.m11+mat.m22*this.m21+mat.m23*this.m31+mat.m24*this.m41);var m22=(mat.m21*this.m12+mat.m22*this.m22+mat.m23*this.m32+mat.m24*this.m42);var m23=(mat.m21*this.m13+mat.m22*this.m23+mat.m23*this.m33+mat.m24*this.m43);var m24=(mat.m21*this.m14+mat.m22*this.m24+mat.m23*this.m34+mat.m24*this.m44);var m31=(mat.m31*this.m11+mat.m32*this.m21+mat.m33*this.m31+mat.m34*this.m41);var m32=(mat.m31*this.m12+mat.m32*this.m22+mat.m33*this.m32+mat.m34*this.m42);var m33=(mat.m31*this.m13+mat.m32*this.m23+mat.m33*this.m33+mat.m34*this.m43);var m34=(mat.m31*this.m14+mat.m32*this.m24+mat.m33*this.m34+mat.m34*this.m44);var m41=(mat.m41*this.m11+mat.m42*this.m21+mat.m43*this.m31+mat.m44*this.m41);var m42=(mat.m41*this.m12+mat.m42*this.m22+mat.m43*this.m32+mat.m44*this.m42);var m43=(mat.m41*this.m13+mat.m42*this.m23+mat.m43*this.m33+mat.m44*this.m43);var m44=(mat.m41*this.m14+mat.m42*this.m24+mat.m43*this.m34+mat.m44*this.m44);this.m11=m11;this.m12=m12;this.m13=m13;this.m14=m14;this.m21=m21;this.m22=m22;this.m23=m23;this.m24=m24;this.m31=m31;this.m32=m32;this.m33=m33;this.m34=m34;this.m41=m41;this.m42=m42;this.m43=m43;this.m44=m44};CanvasMatrix4.prototype.ortho=function(left,right,bottom,top,near,far){var tx=(left+right)/(left-right);var ty=(top+bottom)/(top-bottom);var tz=(far+near)/(far-near);var matrix=new CanvasMatrix4();matrix.m11=2/(left-right);matrix.m12=0;matrix.m13=0;matrix.m14=0;matrix.m21=0;matrix.m22=2/(top-bottom);matrix.m23=0;matrix.m24=0;matrix.m31=0;matrix.m32=0;matrix.m33=-2/(far-near);matrix.m34=0;matrix.m41=tx;matrix.m42=ty;matrix.m43=tz;matrix.m44=1;this.multRight(matrix)};CanvasMatrix4.prototype.frustum=function(left,right,bottom,top,near,far){var matrix=new CanvasMatrix4();var A=(right+left)/(right-left);var B=(top+bottom)/(top-bottom);var C=-(far+near)/(far-near);var D=-(2*far*near)/(far-near);matrix.m11=(2*near)/(right-left);matrix.m12=0;matrix.m13=0;matrix.m14=0;matrix.m21=0;matrix.m22=2*near/(top-bottom);matrix.m23=0;matrix.m24=0;matrix.m31=A;matrix.m32=B;matrix.m33=C;matrix.m34=-1;matrix.m41=0;matrix.m42=0;matrix.m43=D;matrix.m44=0;this.multRight(matrix)};CanvasMatrix4.prototype.perspective=function(fovy,aspect,zNear,zFar){var top=Math.tan(fovy*Math.PI/360)*zNear;var bottom=-top;var left=aspect*bottom;var right=aspect*top;this.frustum(left,right,bottom,top,zNear,zFar)};CanvasMatrix4.prototype.lookat=function(eyex,eyey,eyez,centerx,centery,centerz,upx,upy,upz){var matrix=new CanvasMatrix4();var zx=eyex-centerx;var zy=eyey-centery;var zz=eyez-centerz;var mag=Math.sqrt(zx*zx+zy*zy+zz*zz);if(mag){zx/=mag;zy/=mag;zz/=mag}var yx=upx;var yy=upy;var yz=upz;xx=yy*zz-yz*zy;xy=-yx*zz+yz*zx;xz=yx*zy-yy*zx;yx=zy*xz-zz*xy;yy=-zx*xz+zz*xx;yx=zx*xy-zy*xx;mag=Math.sqrt(xx*xx+xy*xy+xz*xz);if(mag){xx/=mag;xy/=mag;xz/=mag}mag=Math.sqrt(yx*yx+yy*yy+yz*yz);if(mag){yx/=mag;yy/=mag;yz/=mag}matrix.m11=xx;matrix.m12=xy;matrix.m13=xz;matrix.m14=0;matrix.m21=yx;matrix.m22=yy;matrix.m23=yz;matrix.m24=0;matrix.m31=zx;matrix.m32=zy;matrix.m33=zz;matrix.m34=0;matrix.m41=0;matrix.m42=0;matrix.m43=0;matrix.m44=1;matrix.translate(-eyex,-eyey,-eyez);this.multRight(matrix)};CanvasMatrix4.prototype._determinant2x2=function(a,b,c,d){return a*d-b*c};CanvasMatrix4.prototype._determinant3x3=function(a1,a2,a3,b1,b2,b3,c1,c2,c3){return a1*this._determinant2x2(b2,b3,c2,c3)-b1*this._determinant2x2(a2,a3,c2,c3)+c1*this._determinant2x2(a2,a3,b2,b3)};CanvasMatrix4.prototype._determinant4x4=function(){var a1=this.m11;var b1=this.m12;var c1=this.m13;var d1=this.m14;var a2=this.m21;var b2=this.m22;var c2=this.m23;var d2=this.m24;var a3=this.m31;var b3=this.m32;var c3=this.m33;var d3=this.m34;var a4=this.m41;var b4=this.m42;var c4=this.m43;var d4=this.m44;return a1*this._determinant3x3(b2,b3,b4,c2,c3,c4,d2,d3,d4)-b1*this._determinant3x3(a2,a3,a4,c2,c3,c4,d2,d3,d4)+c1*this._determinant3x3(a2,a3,a4,b2,b3,b4,d2,d3,d4)-d1*this._determinant3x3(a2,a3,a4,b2,b3,b4,c2,c3,c4)};CanvasMatrix4.prototype._makeAdjoint=function(){var a1=this.m11;var b1=this.m12;var c1=this.m13;var d1=this.m14;var a2=this.m21;var b2=this.m22;var c2=this.m23;var d2=this.m24;var a3=this.m31;var b3=this.m32;var c3=this.m33;var d3=this.m34;var a4=this.m41;var b4=this.m42;var c4=this.m43;var d4=this.m44;this.m11=this._determinant3x3(b2,b3,b4,c2,c3,c4,d2,d3,d4);this.m21=-this._determinant3x3(a2,a3,a4,c2,c3,c4,d2,d3,d4);this.m31=this._determinant3x3(a2,a3,a4,b2,b3,b4,d2,d3,d4);this.m41=-this._determinant3x3(a2,a3,a4,b2,b3,b4,c2,c3,c4);this.m12=-this._determinant3x3(b1,b3,b4,c1,c3,c4,d1,d3,d4);this.m22=this._determinant3x3(a1,a3,a4,c1,c3,c4,d1,d3,d4);this.m32=-this._determinant3x3(a1,a3,a4,b1,b3,b4,d1,d3,d4);this.m42=this._determinant3x3(a1,a3,a4,b1,b3,b4,c1,c3,c4);this.m13=this._determinant3x3(b1,b2,b4,c1,c2,c4,d1,d2,d4);this.m23=-this._determinant3x3(a1,a2,a4,c1,c2,c4,d1,d2,d4);this.m33=this._determinant3x3(a1,a2,a4,b1,b2,b4,d1,d2,d4);this.m43=-this._determinant3x3(a1,a2,a4,b1,b2,b4,c1,c2,c4);this.m14=-this._determinant3x3(b1,b2,b3,c1,c2,c3,d1,d2,d3);this.m24=this._determinant3x3(a1,a2,a3,c1,c2,c3,d1,d2,d3);this.m34=-this._determinant3x3(a1,a2,a3,b1,b2,b3,d1,d2,d3);this.m44=this._determinant3x3(a1,a2,a3,b1,b2,b3,c1,c2,c3)}
</script>





```r
# clear scene:

open3d()
```

```
## wgl 
##   1
```

```r
# draw shperes in an rgl window
spheres3d(df$x, df$y, df$z, radius=0.05, color=rgb(cr,cg,cb), zlim=range(df$z))
```

<canvas id="testgltextureCanvas" style="display: none;" width="256" height="256">
Your browser does not support the HTML5 canvas element.</canvas>
<!-- ****** spheres object 7 ****** -->
<script id="testglvshader7" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec3 aNorm;
uniform mat4 normMatrix;
varying vec3 vNormal;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
vNormal = normalize((normMatrix * vec4(aNorm, 1.)).xyz);
}
</script>
<script id="testglfshader7" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec3 vNormal;
void main(void) {
vec3 eye = normalize(-vPosition.xyz);
const vec3 emission = vec3(0., 0., 0.);
const vec3 ambient1 = vec3(0., 0., 0.);
const vec3 specular1 = vec3(1., 1., 1.);// light*material
const float shininess1 = 50.;
vec4 colDiff1 = vec4(vCol.rgb * vec3(1., 1., 1.), vCol.a);
const vec3 lightDir1 = vec3(0., 0., 1.);
vec3 halfVec1 = normalize(lightDir1 + eye);
vec4 lighteffect = vec4(emission, 0.);
vec3 n = normalize(vNormal);
n = -faceforward(n, n, eye);
vec3 col1 = ambient1;
float nDotL1 = dot(n, lightDir1);
col1 = col1 + max(nDotL1, 0.) * colDiff1.rgb;
col1 = col1 + pow(max(dot(halfVec1, n), 0.), shininess1) * specular1;
lighteffect = lighteffect + vec4(col1, colDiff1.a);
gl_FragColor = lighteffect;
}
</script> 
<script type="text/javascript"> 
function getShader ( gl, id ){
var shaderScript = document.getElementById ( id );
var str = "";
var k = shaderScript.firstChild;
while ( k ){
if ( k.nodeType == 3 ) str += k.textContent;
k = k.nextSibling;
}
var shader;
if ( shaderScript.type == "x-shader/x-fragment" )
shader = gl.createShader ( gl.FRAGMENT_SHADER );
else if ( shaderScript.type == "x-shader/x-vertex" )
shader = gl.createShader(gl.VERTEX_SHADER);
else return null;
gl.shaderSource(shader, str);
gl.compileShader(shader);
if (gl.getShaderParameter(shader, gl.COMPILE_STATUS) == 0)
alert(gl.getShaderInfoLog(shader));
return shader;
}
var min = Math.min;
var max = Math.max;
var sqrt = Math.sqrt;
var sin = Math.sin;
var acos = Math.acos;
var tan = Math.tan;
var SQRT2 = Math.SQRT2;
var PI = Math.PI;
var log = Math.log;
var exp = Math.exp;
function testglwebGLStart() {
var debug = function(msg) {
document.getElementById("testgldebug").innerHTML = msg;
}
debug("");
var canvas = document.getElementById("testglcanvas");
if (!window.WebGLRenderingContext){
debug(" Your browser does not support WebGL. See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
return;
}
var gl;
try {
// Try to grab the standard context. If it fails, fallback to experimental.
gl = canvas.getContext("webgl") 
|| canvas.getContext("experimental-webgl");
}
catch(e) {}
if ( !gl ) {
debug(" Your browser appears to support WebGL, but did not create a WebGL context.  See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
return;
}
var width = 505;  var height = 505;
canvas.width = width;   canvas.height = height;
var prMatrix = new CanvasMatrix4();
var mvMatrix = new CanvasMatrix4();
var normMatrix = new CanvasMatrix4();
var saveMat = new CanvasMatrix4();
saveMat.makeIdentity();
var distance;
var posLoc = 0;
var colLoc = 1;
var zoom = new Object();
var fov = new Object();
var userMatrix = new Object();
var activeSubscene = 1;
zoom[1] = 1;
fov[1] = 30;
userMatrix[1] = new CanvasMatrix4();
userMatrix[1].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
function getPowerOfTwo(value) {
var pow = 1;
while(pow<value) {
pow *= 2;
}
return pow;
}
function handleLoadedTexture(texture, textureCanvas) {
gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true);
gl.bindTexture(gl.TEXTURE_2D, texture);
gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, textureCanvas);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST);
gl.generateMipmap(gl.TEXTURE_2D);
gl.bindTexture(gl.TEXTURE_2D, null);
}
function loadImageToTexture(filename, texture) {   
var canvas = document.getElementById("testgltextureCanvas");
var ctx = canvas.getContext("2d");
var image = new Image();
image.onload = function() {
var w = image.width;
var h = image.height;
var canvasX = getPowerOfTwo(w);
var canvasY = getPowerOfTwo(h);
canvas.width = canvasX;
canvas.height = canvasY;
ctx.imageSmoothingEnabled = true;
ctx.drawImage(image, 0, 0, canvasX, canvasY);
handleLoadedTexture(texture, canvas);
drawScene();
}
image.src = filename;
}  	   
// ****** sphere object ******
var v=new Float32Array([
-1, 0, 0,
1, 0, 0,
0, -1, 0,
0, 1, 0,
0, 0, -1,
0, 0, 1,
-0.7071068, 0, -0.7071068,
-0.7071068, -0.7071068, 0,
0, -0.7071068, -0.7071068,
-0.7071068, 0, 0.7071068,
0, -0.7071068, 0.7071068,
-0.7071068, 0.7071068, 0,
0, 0.7071068, -0.7071068,
0, 0.7071068, 0.7071068,
0.7071068, -0.7071068, 0,
0.7071068, 0, -0.7071068,
0.7071068, 0, 0.7071068,
0.7071068, 0.7071068, 0,
-0.9349975, 0, -0.3546542,
-0.9349975, -0.3546542, 0,
-0.77044, -0.4507894, -0.4507894,
0, -0.3546542, -0.9349975,
-0.3546542, 0, -0.9349975,
-0.4507894, -0.4507894, -0.77044,
-0.3546542, -0.9349975, 0,
0, -0.9349975, -0.3546542,
-0.4507894, -0.77044, -0.4507894,
-0.9349975, 0, 0.3546542,
-0.77044, -0.4507894, 0.4507894,
0, -0.9349975, 0.3546542,
-0.4507894, -0.77044, 0.4507894,
-0.3546542, 0, 0.9349975,
0, -0.3546542, 0.9349975,
-0.4507894, -0.4507894, 0.77044,
-0.9349975, 0.3546542, 0,
-0.77044, 0.4507894, -0.4507894,
0, 0.9349975, -0.3546542,
-0.3546542, 0.9349975, 0,
-0.4507894, 0.77044, -0.4507894,
0, 0.3546542, -0.9349975,
-0.4507894, 0.4507894, -0.77044,
-0.77044, 0.4507894, 0.4507894,
0, 0.3546542, 0.9349975,
-0.4507894, 0.4507894, 0.77044,
0, 0.9349975, 0.3546542,
-0.4507894, 0.77044, 0.4507894,
0.9349975, -0.3546542, 0,
0.9349975, 0, -0.3546542,
0.77044, -0.4507894, -0.4507894,
0.3546542, -0.9349975, 0,
0.4507894, -0.77044, -0.4507894,
0.3546542, 0, -0.9349975,
0.4507894, -0.4507894, -0.77044,
0.9349975, 0, 0.3546542,
0.77044, -0.4507894, 0.4507894,
0.3546542, 0, 0.9349975,
0.4507894, -0.4507894, 0.77044,
0.4507894, -0.77044, 0.4507894,
0.9349975, 0.3546542, 0,
0.77044, 0.4507894, -0.4507894,
0.4507894, 0.4507894, -0.77044,
0.3546542, 0.9349975, 0,
0.4507894, 0.77044, -0.4507894,
0.77044, 0.4507894, 0.4507894,
0.4507894, 0.77044, 0.4507894,
0.4507894, 0.4507894, 0.77044
]);
var f=new Uint16Array([
0, 18, 19,
6, 20, 18,
7, 19, 20,
19, 18, 20,
4, 21, 22,
8, 23, 21,
6, 22, 23,
22, 21, 23,
2, 24, 25,
7, 26, 24,
8, 25, 26,
25, 24, 26,
7, 20, 26,
6, 23, 20,
8, 26, 23,
26, 20, 23,
0, 19, 27,
7, 28, 19,
9, 27, 28,
27, 19, 28,
2, 29, 24,
10, 30, 29,
7, 24, 30,
24, 29, 30,
5, 31, 32,
9, 33, 31,
10, 32, 33,
32, 31, 33,
9, 28, 33,
7, 30, 28,
10, 33, 30,
33, 28, 30,
0, 34, 18,
11, 35, 34,
6, 18, 35,
18, 34, 35,
3, 36, 37,
12, 38, 36,
11, 37, 38,
37, 36, 38,
4, 22, 39,
6, 40, 22,
12, 39, 40,
39, 22, 40,
6, 35, 40,
11, 38, 35,
12, 40, 38,
40, 35, 38,
0, 27, 34,
9, 41, 27,
11, 34, 41,
34, 27, 41,
5, 42, 31,
13, 43, 42,
9, 31, 43,
31, 42, 43,
3, 37, 44,
11, 45, 37,
13, 44, 45,
44, 37, 45,
11, 41, 45,
9, 43, 41,
13, 45, 43,
45, 41, 43,
1, 46, 47,
14, 48, 46,
15, 47, 48,
47, 46, 48,
2, 25, 49,
8, 50, 25,
14, 49, 50,
49, 25, 50,
4, 51, 21,
15, 52, 51,
8, 21, 52,
21, 51, 52,
15, 48, 52,
14, 50, 48,
8, 52, 50,
52, 48, 50,
1, 53, 46,
16, 54, 53,
14, 46, 54,
46, 53, 54,
5, 32, 55,
10, 56, 32,
16, 55, 56,
55, 32, 56,
2, 49, 29,
14, 57, 49,
10, 29, 57,
29, 49, 57,
14, 54, 57,
16, 56, 54,
10, 57, 56,
57, 54, 56,
1, 47, 58,
15, 59, 47,
17, 58, 59,
58, 47, 59,
4, 39, 51,
12, 60, 39,
15, 51, 60,
51, 39, 60,
3, 61, 36,
17, 62, 61,
12, 36, 62,
36, 61, 62,
17, 59, 62,
15, 60, 59,
12, 62, 60,
62, 59, 60,
1, 58, 53,
17, 63, 58,
16, 53, 63,
53, 58, 63,
3, 44, 61,
13, 64, 44,
17, 61, 64,
61, 44, 64,
5, 55, 42,
16, 65, 55,
13, 42, 65,
42, 55, 65,
16, 63, 65,
17, 64, 63,
13, 65, 64,
65, 63, 64
]);
var sphereBuf = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, sphereBuf);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var sphereIbuf = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, sphereIbuf);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
// ****** spheres object 7 ******
var prog7  = gl.createProgram();
gl.attachShader(prog7, getShader( gl, "testglvshader7" ));
gl.attachShader(prog7, getShader( gl, "testglfshader7" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog7, 0, "aPos");
gl.bindAttribLocation(prog7, 1, "aCol");
gl.linkProgram(prog7);
var v=new Float32Array([
-5, -5, 2.835445, 0.7098039, 1, 1, 1, 0.05,
-5, -4.75, 2.302511, 0.5764706, 1, 0.9490196, 1, 0.05,
-5, -4.5, 1.716872, 0.427451, 1, 0.9019608, 1, 0.05,
-5, -4.25, 1.101643, 0.2745098, 1, 0.8509804, 1, 0.05,
-5, -4, 0.4786063, 0.1215686, 1, 0.8, 1, 0.05,
-5, -3.75, -0.1327169, 0.03137255, 1, 0.7490196, 1, 0.05,
-5, -3.5, -0.7157543, 0.1803922, 1, 0.7019608, 1, 0.05,
-5, -3.25, -1.257336, 0.3137255, 1, 0.6509804, 1, 0.05,
-5, -3, -1.747902, 0.4352941, 1, 0.6, 1, 0.05,
-5, -2.75, -2.181476, 0.5450981, 1, 0.5490196, 1, 0.05,
-5, -2.5, -2.555439, 0.6392157, 1, 0.5019608, 1, 0.05,
-5, -2.25, -2.870141, 0.7176471, 1, 0.4509804, 1, 0.05,
-5, -2, -3.12838, 0.7803922, 1, 0.4, 1, 0.05,
-5, -1.75, -3.334813, 0.8352941, 1, 0.3490196, 1, 0.05,
-5, -1.5, -3.495335, 0.8745098, 1, 0.3019608, 1, 0.05,
-5, -1.25, -3.616459, 0.9058824, 1, 0.2509804, 1, 0.05,
-5, -1, -3.704739, 0.9254902, 1, 0.2, 1, 0.05,
-5, -0.75, -3.766262, 0.9411765, 1, 0.1490196, 1, 0.05,
-5, -0.5, -3.806212, 0.9529412, 1, 0.1019608, 1, 0.05,
-5, -0.25, -3.828535, 0.9568627, 1, 0.05098039, 1, 0.05,
-5, 0, -3.835697, 0.9607843, 1, 0, 1, 0.05,
-5, 0.25, -3.828535, 0.9568627, 1, 0.05098039, 1, 0.05,
-5, 0.5, -3.806212, 0.9529412, 1, 0.1019608, 1, 0.05,
-5, 0.75, -3.766262, 0.9411765, 1, 0.1490196, 1, 0.05,
-5, 1, -3.704739, 0.9254902, 1, 0.2, 1, 0.05,
-5, 1.25, -3.616459, 0.9058824, 1, 0.2509804, 1, 0.05,
-5, 1.5, -3.495335, 0.8745098, 1, 0.3019608, 1, 0.05,
-5, 1.75, -3.334813, 0.8352941, 1, 0.3490196, 1, 0.05,
-5, 2, -3.12838, 0.7803922, 1, 0.4, 1, 0.05,
-5, 2.25, -2.870141, 0.7176471, 1, 0.4509804, 1, 0.05,
-5, 2.5, -2.555439, 0.6392157, 1, 0.5019608, 1, 0.05,
-5, 2.75, -2.181476, 0.5450981, 1, 0.5490196, 1, 0.05,
-5, 3, -1.747902, 0.4352941, 1, 0.6, 1, 0.05,
-5, 3.25, -1.257336, 0.3137255, 1, 0.6509804, 1, 0.05,
-5, 3.5, -0.7157543, 0.1803922, 1, 0.7019608, 1, 0.05,
-5, 3.75, -0.1327169, 0.03137255, 1, 0.7490196, 1, 0.05,
-5, 4, 0.4786063, 0.1215686, 1, 0.8, 1, 0.05,
-5, 4.25, 1.101643, 0.2745098, 1, 0.8509804, 1, 0.05,
-5, 4.5, 1.716872, 0.427451, 1, 0.9019608, 1, 0.05,
-5, 4.75, 2.302511, 0.5764706, 1, 0.9490196, 1, 0.05,
-5, 5, 2.835445, 0.7098039, 1, 1, 1, 0.05,
-4.75, -5, 2.302511, 0.5764706, 0.9490196, 1, 1, 0.05,
-4.75, -4.75, 1.683208, 0.4196078, 0.9490196, 0.9490196, 1, 0.05,
-4.75, -4.5, 1.028094, 0.2588235, 0.9490196, 0.9019608, 1, 0.05,
-4.75, -4.25, 0.3618609, 0.09019608, 0.9490196, 0.8509804, 1, 0.05,
-4.75, -4, -0.2929939, 0.07450981, 0.9490196, 0.8, 1, 0.05,
-4.75, -3.75, -0.917074, 0.227451, 0.9490196, 0.7490196, 1, 0.05,
-4.75, -3.5, -1.494721, 0.372549, 0.9490196, 0.7019608, 1, 0.05,
-4.75, -3.25, -2.014374, 0.5019608, 0.9490196, 0.6509804, 1, 0.05,
-4.75, -3, -2.468658, 0.6156863, 0.9490196, 0.6, 1, 0.05,
-4.75, -2.75, -2.854224, 0.7137255, 0.9490196, 0.5490196, 1, 0.05,
-4.75, -2.5, -3.171366, 0.7921569, 0.9490196, 0.5019608, 1, 0.05,
-4.75, -2.25, -3.423492, 0.854902, 0.9490196, 0.4509804, 1, 0.05,
-4.75, -2, -3.616459, 0.9058824, 0.9490196, 0.4, 1, 0.05,
-4.75, -1.75, -3.757868, 0.9411765, 0.9490196, 0.3490196, 1, 0.05,
-4.75, -1.5, -3.856334, 0.9647059, 0.9490196, 0.3019608, 1, 0.05,
-4.75, -1.25, -3.920797, 0.9803922, 0.9490196, 0.2509804, 1, 0.05,
-4.75, -1, -3.959891, 0.9882353, 0.9490196, 0.2, 1, 0.05,
-4.75, -0.75, -3.981406, 0.9960784, 0.9490196, 0.1490196, 1, 0.05,
-4.75, -0.5, -3.991848, 0.9960784, 0.9490196, 0.1019608, 1, 0.05,
-4.75, -0.25, -3.996096, 1, 0.9490196, 0.05098039, 1, 0.05,
-4.75, 0, -3.997171, 1, 0.9490196, 0, 1, 0.05,
-4.75, 0.25, -3.996096, 1, 0.9490196, 0.05098039, 1, 0.05,
-4.75, 0.5, -3.991848, 0.9960784, 0.9490196, 0.1019608, 1, 0.05,
-4.75, 0.75, -3.981406, 0.9960784, 0.9490196, 0.1490196, 1, 0.05,
-4.75, 1, -3.959891, 0.9882353, 0.9490196, 0.2, 1, 0.05,
-4.75, 1.25, -3.920797, 0.9803922, 0.9490196, 0.2509804, 1, 0.05,
-4.75, 1.5, -3.856334, 0.9647059, 0.9490196, 0.3019608, 1, 0.05,
-4.75, 1.75, -3.757868, 0.9411765, 0.9490196, 0.3490196, 1, 0.05,
-4.75, 2, -3.616459, 0.9058824, 0.9490196, 0.4, 1, 0.05,
-4.75, 2.25, -3.423492, 0.854902, 0.9490196, 0.4509804, 1, 0.05,
-4.75, 2.5, -3.171366, 0.7921569, 0.9490196, 0.5019608, 1, 0.05,
-4.75, 2.75, -2.854224, 0.7137255, 0.9490196, 0.5490196, 1, 0.05,
-4.75, 3, -2.468658, 0.6156863, 0.9490196, 0.6, 1, 0.05,
-4.75, 3.25, -2.014374, 0.5019608, 0.9490196, 0.6509804, 1, 0.05,
-4.75, 3.5, -1.494721, 0.372549, 0.9490196, 0.7019608, 1, 0.05,
-4.75, 3.75, -0.917074, 0.227451, 0.9490196, 0.7490196, 1, 0.05,
-4.75, 4, -0.2929939, 0.07450981, 0.9490196, 0.8, 1, 0.05,
-4.75, 4.25, 0.3618609, 0.09019608, 0.9490196, 0.8509804, 1, 0.05,
-4.75, 4.5, 1.028094, 0.2588235, 0.9490196, 0.9019608, 1, 0.05,
-4.75, 4.75, 1.683208, 0.4196078, 0.9490196, 0.9490196, 1, 0.05,
-4.75, 5, 2.302511, 0.5764706, 0.9490196, 1, 1, 0.05,
-4.5, -5, 1.716872, 0.427451, 0.9019608, 1, 1, 0.05,
-4.5, -4.75, 1.028094, 0.2588235, 0.9019608, 0.9490196, 1, 0.05,
-4.5, -4.5, 0.3227516, 0.08235294, 0.9019608, 0.9019608, 1, 0.05,
-4.5, -4.25, -0.3733602, 0.09411765, 0.9019608, 0.8509804, 1, 0.05,
-4.5, -4, -1.03755, 0.2588235, 0.9019608, 0.8, 1, 0.05,
-4.5, -3.75, -1.651098, 0.4117647, 0.9019608, 0.7490196, 1, 0.05,
-4.5, -3.5, -2.199813, 0.5490196, 0.9019608, 0.7019608, 1, 0.05,
-4.5, -3.25, -2.674281, 0.6666667, 0.9019608, 0.6509804, 1, 0.05,
-4.5, -3, -3.069811, 0.7686275, 0.9019608, 0.6, 1, 0.05,
-4.5, -2.75, -3.386113, 0.8470588, 0.9019608, 0.5490196, 1, 0.05,
-4.5, -2.5, -3.626762, 0.9058824, 0.9019608, 0.5019608, 1, 0.05,
-4.5, -2.25, -3.798494, 0.9490196, 0.9019608, 0.4509804, 1, 0.05,
-4.5, -2, -3.910414, 0.9764706, 0.9019608, 0.4, 1, 0.05,
-4.5, -1.75, -3.973158, 0.9921569, 0.9019608, 0.3490196, 1, 0.05,
-4.5, -1.5, -3.998075, 1, 0.9019608, 0.3019608, 1, 0.05,
-4.5, -1.25, -3.996472, 1, 0.9019608, 0.2509804, 1, 0.05,
-4.5, -1, -3.978958, 0.9960784, 0.9019608, 0.2, 1, 0.05,
-4.5, -0.75, -3.954895, 0.9882353, 0.9019608, 0.1490196, 1, 0.05,
-4.5, -0.5, -3.931968, 0.9843137, 0.9019608, 0.1019608, 1, 0.05,
-4.5, -0.25, -3.915877, 0.9803922, 0.9019608, 0.05098039, 1, 0.05,
-4.5, 0, -3.91012, 0.9764706, 0.9019608, 0, 1, 0.05,
-4.5, 0.25, -3.915877, 0.9803922, 0.9019608, 0.05098039, 1, 0.05,
-4.5, 0.5, -3.931968, 0.9843137, 0.9019608, 0.1019608, 1, 0.05,
-4.5, 0.75, -3.954895, 0.9882353, 0.9019608, 0.1490196, 1, 0.05,
-4.5, 1, -3.978958, 0.9960784, 0.9019608, 0.2, 1, 0.05,
-4.5, 1.25, -3.996472, 1, 0.9019608, 0.2509804, 1, 0.05,
-4.5, 1.5, -3.998075, 1, 0.9019608, 0.3019608, 1, 0.05,
-4.5, 1.75, -3.973158, 0.9921569, 0.9019608, 0.3490196, 1, 0.05,
-4.5, 2, -3.910414, 0.9764706, 0.9019608, 0.4, 1, 0.05,
-4.5, 2.25, -3.798494, 0.9490196, 0.9019608, 0.4509804, 1, 0.05,
-4.5, 2.5, -3.626762, 0.9058824, 0.9019608, 0.5019608, 1, 0.05,
-4.5, 2.75, -3.386113, 0.8470588, 0.9019608, 0.5490196, 1, 0.05,
-4.5, 3, -3.069811, 0.7686275, 0.9019608, 0.6, 1, 0.05,
-4.5, 3.25, -2.674281, 0.6666667, 0.9019608, 0.6509804, 1, 0.05,
-4.5, 3.5, -2.199813, 0.5490196, 0.9019608, 0.7019608, 1, 0.05,
-4.5, 3.75, -1.651098, 0.4117647, 0.9019608, 0.7490196, 1, 0.05,
-4.5, 4, -1.03755, 0.2588235, 0.9019608, 0.8, 1, 0.05,
-4.5, 4.25, -0.3733602, 0.09411765, 0.9019608, 0.8509804, 1, 0.05,
-4.5, 4.5, 0.3227516, 0.08235294, 0.9019608, 0.9019608, 1, 0.05,
-4.5, 4.75, 1.028094, 0.2588235, 0.9019608, 0.9490196, 1, 0.05,
-4.5, 5, 1.716872, 0.427451, 0.9019608, 1, 1, 0.05,
-4.25, -5, 1.101643, 0.2745098, 0.8509804, 1, 1, 0.05,
-4.25, -4.75, 0.3618609, 0.09019608, 0.8509804, 0.9490196, 1, 0.05,
-4.25, -4.5, -0.3733602, 0.09411765, 0.8509804, 0.9019608, 1, 0.05,
-4.25, -4.25, -1.07763, 0.2705882, 0.8509804, 0.8509804, 1, 0.05,
-4.25, -4, -1.728604, 0.4313726, 0.8509804, 0.8, 1, 0.05,
-4.25, -3.75, -2.308792, 0.5764706, 0.8509804, 0.7490196, 1, 0.05,
-4.25, -3.5, -2.806018, 0.7019608, 0.8509804, 0.7019608, 1, 0.05,
-4.25, -3.25, -3.213524, 0.8039216, 0.8509804, 0.6509804, 1, 0.05,
-4.25, -3, -3.529757, 0.8823529, 0.8509804, 0.6, 1, 0.05,
-4.25, -2.75, -3.757868, 0.9411765, 0.8509804, 0.5490196, 1, 0.05,
-4.25, -2.5, -3.904997, 0.9764706, 0.8509804, 0.5019608, 1, 0.05,
-4.25, -2.25, -3.981406, 0.9960784, 0.8509804, 0.4509804, 1, 0.05,
-4.25, -2, -3.999531, 1, 0.8509804, 0.4, 1, 0.05,
-4.25, -1.75, -3.973028, 0.9921569, 0.8509804, 0.3490196, 1, 0.05,
-4.25, -1.5, -3.915877, 0.9803922, 0.8509804, 0.3019608, 1, 0.05,
-4.25, -1.25, -3.841583, 0.9607843, 0.8509804, 0.2509804, 1, 0.05,
-4.25, -1, -3.762504, 0.9411765, 0.8509804, 0.2, 1, 0.05,
-4.25, -0.75, -3.689333, 0.9215686, 0.8509804, 0.1490196, 1, 0.05,
-4.25, -0.5, -3.630713, 0.9058824, 0.8509804, 0.1019608, 1, 0.05,
-4.25, -0.25, -3.59297, 0.8980392, 0.8509804, 0.05098039, 1, 0.05,
-4.25, 0, -3.579957, 0.8941177, 0.8509804, 0, 1, 0.05,
-4.25, 0.25, -3.59297, 0.8980392, 0.8509804, 0.05098039, 1, 0.05,
-4.25, 0.5, -3.630713, 0.9058824, 0.8509804, 0.1019608, 1, 0.05,
-4.25, 0.75, -3.689333, 0.9215686, 0.8509804, 0.1490196, 1, 0.05,
-4.25, 1, -3.762504, 0.9411765, 0.8509804, 0.2, 1, 0.05,
-4.25, 1.25, -3.841583, 0.9607843, 0.8509804, 0.2509804, 1, 0.05,
-4.25, 1.5, -3.915877, 0.9803922, 0.8509804, 0.3019608, 1, 0.05,
-4.25, 1.75, -3.973028, 0.9921569, 0.8509804, 0.3490196, 1, 0.05,
-4.25, 2, -3.999531, 1, 0.8509804, 0.4, 1, 0.05,
-4.25, 2.25, -3.981406, 0.9960784, 0.8509804, 0.4509804, 1, 0.05,
-4.25, 2.5, -3.904997, 0.9764706, 0.8509804, 0.5019608, 1, 0.05,
-4.25, 2.75, -3.757868, 0.9411765, 0.8509804, 0.5490196, 1, 0.05,
-4.25, 3, -3.529757, 0.8823529, 0.8509804, 0.6, 1, 0.05,
-4.25, 3.25, -3.213524, 0.8039216, 0.8509804, 0.6509804, 1, 0.05,
-4.25, 3.5, -2.806018, 0.7019608, 0.8509804, 0.7019608, 1, 0.05,
-4.25, 3.75, -2.308792, 0.5764706, 0.8509804, 0.7490196, 1, 0.05,
-4.25, 4, -1.728604, 0.4313726, 0.8509804, 0.8, 1, 0.05,
-4.25, 4.25, -1.07763, 0.2705882, 0.8509804, 0.8509804, 1, 0.05,
-4.25, 4.5, -0.3733602, 0.09411765, 0.8509804, 0.9019608, 1, 0.05,
-4.25, 4.75, 0.3618609, 0.09019608, 0.8509804, 0.9490196, 1, 0.05,
-4.25, 5, 1.101643, 0.2745098, 0.8509804, 1, 1, 0.05,
-4, -5, 0.4786063, 0.1215686, 0.8, 1, 1, 0.05,
-4, -4.75, -0.2929939, 0.07450981, 0.8, 0.9490196, 1, 0.05,
-4, -4.5, -1.03755, 0.2588235, 0.8, 0.9019608, 1, 0.05,
-4, -4.25, -1.728604, 0.4313726, 0.8, 0.8509804, 1, 0.05,
-4, -4, -2.344705, 0.5843138, 0.8, 0.8, 1, 0.05,
-4, -3.75, -2.870141, 0.7176471, 0.8, 0.7490196, 1, 0.05,
-4, -3.5, -3.295269, 0.8235294, 0.8, 0.7019608, 1, 0.05,
-4, -3.25, -3.616459, 0.9058824, 0.8, 0.6509804, 1, 0.05,
-4, -3, -3.835697, 0.9607843, 0.8, 0.6, 1, 0.05,
-4, -2.75, -3.959891, 0.9882353, 0.8, 0.5490196, 1, 0.05,
-4, -2.5, -3.999958, 1, 0.8, 0.5019608, 1, 0.05,
-4, -2.25, -3.969781, 0.9921569, 0.8, 0.4509804, 1, 0.05,
-4, -2, -3.885111, 0.972549, 0.8, 0.4, 1, 0.05,
-4, -1.75, -3.762504, 0.9411765, 0.8, 0.3490196, 1, 0.05,
-4, -1.5, -3.618347, 0.9058824, 0.8, 0.3019608, 1, 0.05,
-4, -1.25, -3.468042, 0.8666667, 0.8, 0.2509804, 1, 0.05,
-4, -1, -3.325357, 0.8313726, 0.8, 0.2, 1, 0.05,
-4, -0.75, -3.20196, 0.8, 0.8, 0.1490196, 1, 0.05,
-4, -0.5, -3.107119, 0.7764706, 0.8, 0.1019608, 1, 0.05,
-4, -0.25, -3.047524, 0.7607843, 0.8, 0.05098039, 1, 0.05,
-4, 0, -3.02721, 0.7568628, 0.8, 0, 1, 0.05,
-4, 0.25, -3.047524, 0.7607843, 0.8, 0.05098039, 1, 0.05,
-4, 0.5, -3.107119, 0.7764706, 0.8, 0.1019608, 1, 0.05,
-4, 0.75, -3.20196, 0.8, 0.8, 0.1490196, 1, 0.05,
-4, 1, -3.325357, 0.8313726, 0.8, 0.2, 1, 0.05,
-4, 1.25, -3.468042, 0.8666667, 0.8, 0.2509804, 1, 0.05,
-4, 1.5, -3.618347, 0.9058824, 0.8, 0.3019608, 1, 0.05,
-4, 1.75, -3.762504, 0.9411765, 0.8, 0.3490196, 1, 0.05,
-4, 2, -3.885111, 0.972549, 0.8, 0.4, 1, 0.05,
-4, 2.25, -3.969781, 0.9921569, 0.8, 0.4509804, 1, 0.05,
-4, 2.5, -3.999958, 1, 0.8, 0.5019608, 1, 0.05,
-4, 2.75, -3.959891, 0.9882353, 0.8, 0.5490196, 1, 0.05,
-4, 3, -3.835697, 0.9607843, 0.8, 0.6, 1, 0.05,
-4, 3.25, -3.616459, 0.9058824, 0.8, 0.6509804, 1, 0.05,
-4, 3.5, -3.295269, 0.8235294, 0.8, 0.7019608, 1, 0.05,
-4, 3.75, -2.870141, 0.7176471, 0.8, 0.7490196, 1, 0.05,
-4, 4, -2.344705, 0.5843138, 0.8, 0.8, 1, 0.05,
-4, 4.25, -1.728604, 0.4313726, 0.8, 0.8509804, 1, 0.05,
-4, 4.5, -1.03755, 0.2588235, 0.8, 0.9019608, 1, 0.05,
-4, 4.75, -0.2929939, 0.07450981, 0.8, 0.9490196, 1, 0.05,
-4, 5, 0.4786063, 0.1215686, 0.8, 1, 1, 0.05,
-3.75, -5, -0.1327169, 0.03137255, 0.7490196, 1, 1, 0.05,
-3.75, -4.75, -0.917074, 0.227451, 0.7490196, 0.9490196, 1, 0.05,
-3.75, -4.5, -1.651098, 0.4117647, 0.7490196, 0.9019608, 1, 0.05,
-3.75, -4.25, -2.308792, 0.5764706, 0.7490196, 0.8509804, 1, 0.05,
-3.75, -4, -2.870141, 0.7176471, 0.7490196, 0.8, 1, 0.05,
-3.75, -3.75, -3.321732, 0.8313726, 0.7490196, 0.7490196, 1, 0.05,
-3.75, -3.5, -3.656937, 0.9137255, 0.7490196, 0.7019608, 1, 0.05,
-3.75, -3.25, -3.87568, 0.9686275, 0.7490196, 0.6509804, 1, 0.05,
-3.75, -3, -3.983827, 0.9960784, 0.7490196, 0.6, 1, 0.05,
-3.75, -2.75, -3.992285, 1, 0.7490196, 0.5490196, 1, 0.05,
-3.75, -2.5, -3.915877, 0.9803922, 0.7490196, 0.5019608, 1, 0.05,
-3.75, -2.25, -3.772118, 0.9411765, 0.7490196, 0.4509804, 1, 0.05,
-3.75, -2, -3.579957, 0.8941177, 0.7490196, 0.4, 1, 0.05,
-3.75, -1.75, -3.358611, 0.8392157, 0.7490196, 0.3490196, 1, 0.05,
-3.75, -1.5, -3.126535, 0.7803922, 0.7490196, 0.3019608, 1, 0.05,
-3.75, -1.25, -2.900606, 0.7254902, 0.7490196, 0.2509804, 1, 0.05,
-3.75, -1, -2.69553, 0.6745098, 0.7490196, 0.2, 1, 0.05,
-3.75, -0.75, -2.523474, 0.6313726, 0.7490196, 0.1490196, 1, 0.05,
-3.75, -0.5, -2.393892, 0.6, 0.7490196, 0.1019608, 1, 0.05,
-3.75, -0.25, -2.313487, 0.5764706, 0.7490196, 0.05098039, 1, 0.05,
-3.75, 0, -2.286245, 0.572549, 0.7490196, 0, 1, 0.05,
-3.75, 0.25, -2.313487, 0.5764706, 0.7490196, 0.05098039, 1, 0.05,
-3.75, 0.5, -2.393892, 0.6, 0.7490196, 0.1019608, 1, 0.05,
-3.75, 0.75, -2.523474, 0.6313726, 0.7490196, 0.1490196, 1, 0.05,
-3.75, 1, -2.69553, 0.6745098, 0.7490196, 0.2, 1, 0.05,
-3.75, 1.25, -2.900606, 0.7254902, 0.7490196, 0.2509804, 1, 0.05,
-3.75, 1.5, -3.126535, 0.7803922, 0.7490196, 0.3019608, 1, 0.05,
-3.75, 1.75, -3.358611, 0.8392157, 0.7490196, 0.3490196, 1, 0.05,
-3.75, 2, -3.579957, 0.8941177, 0.7490196, 0.4, 1, 0.05,
-3.75, 2.25, -3.772118, 0.9411765, 0.7490196, 0.4509804, 1, 0.05,
-3.75, 2.5, -3.915877, 0.9803922, 0.7490196, 0.5019608, 1, 0.05,
-3.75, 2.75, -3.992285, 1, 0.7490196, 0.5490196, 1, 0.05,
-3.75, 3, -3.983827, 0.9960784, 0.7490196, 0.6, 1, 0.05,
-3.75, 3.25, -3.87568, 0.9686275, 0.7490196, 0.6509804, 1, 0.05,
-3.75, 3.5, -3.656937, 0.9137255, 0.7490196, 0.7019608, 1, 0.05,
-3.75, 3.75, -3.321732, 0.8313726, 0.7490196, 0.7490196, 1, 0.05,
-3.75, 4, -2.870141, 0.7176471, 0.7490196, 0.8, 1, 0.05,
-3.75, 4.25, -2.308792, 0.5764706, 0.7490196, 0.8509804, 1, 0.05,
-3.75, 4.5, -1.651098, 0.4117647, 0.7490196, 0.9019608, 1, 0.05,
-3.75, 4.75, -0.917074, 0.227451, 0.7490196, 0.9490196, 1, 0.05,
-3.75, 5, -0.1327169, 0.03137255, 0.7490196, 1, 1, 0.05,
-3.5, -5, -0.7157543, 0.1803922, 0.7019608, 1, 1, 0.05,
-3.5, -4.75, -1.494721, 0.372549, 0.7019608, 0.9490196, 1, 0.05,
-3.5, -4.5, -2.199813, 0.5490196, 0.7019608, 0.9019608, 1, 0.05,
-3.5, -4.25, -2.806018, 0.7019608, 0.7019608, 0.8509804, 1, 0.05,
-3.5, -4, -3.295269, 0.8235294, 0.7019608, 0.8, 1, 0.05,
-3.5, -3.75, -3.656937, 0.9137255, 0.7019608, 0.7490196, 1, 0.05,
-3.5, -3.5, -3.88785, 0.972549, 0.7019608, 0.7019608, 1, 0.05,
-3.5, -3.25, -3.991848, 0.9960784, 0.7019608, 0.6509804, 1, 0.05,
-3.5, -3, -3.978958, 0.9960784, 0.7019608, 0.6, 1, 0.05,
-3.5, -2.75, -3.864255, 0.9647059, 0.7019608, 0.5490196, 1, 0.05,
-3.5, -2.5, -3.666525, 0.9176471, 0.7019608, 0.5019608, 1, 0.05,
-3.5, -2.25, -3.406833, 0.8509804, 0.7019608, 0.4509804, 1, 0.05,
-3.5, -2, -3.107119, 0.7764706, 0.7019608, 0.4, 1, 0.05,
-3.5, -1.75, -2.788921, 0.6980392, 0.7019608, 0.3490196, 1, 0.05,
-3.5, -1.5, -2.472307, 0.6196079, 0.7019608, 0.3019608, 1, 0.05,
-3.5, -1.25, -2.175086, 0.5450981, 0.7019608, 0.2509804, 1, 0.05,
-3.5, -1, -1.912302, 0.4784314, 0.7019608, 0.2, 1, 0.05,
-3.5, -0.75, -1.696019, 0.4235294, 0.7019608, 0.1490196, 1, 0.05,
-3.5, -0.5, -1.535323, 0.3843137, 0.7019608, 0.1019608, 1, 0.05,
-3.5, -0.25, -1.436479, 0.3607843, 0.7019608, 0.05098039, 1, 0.05,
-3.5, 0, -1.403133, 0.3490196, 0.7019608, 0, 1, 0.05,
-3.5, 0.25, -1.436479, 0.3607843, 0.7019608, 0.05098039, 1, 0.05,
-3.5, 0.5, -1.535323, 0.3843137, 0.7019608, 0.1019608, 1, 0.05,
-3.5, 0.75, -1.696019, 0.4235294, 0.7019608, 0.1490196, 1, 0.05,
-3.5, 1, -1.912302, 0.4784314, 0.7019608, 0.2, 1, 0.05,
-3.5, 1.25, -2.175086, 0.5450981, 0.7019608, 0.2509804, 1, 0.05,
-3.5, 1.5, -2.472307, 0.6196079, 0.7019608, 0.3019608, 1, 0.05,
-3.5, 1.75, -2.788921, 0.6980392, 0.7019608, 0.3490196, 1, 0.05,
-3.5, 2, -3.107119, 0.7764706, 0.7019608, 0.4, 1, 0.05,
-3.5, 2.25, -3.406833, 0.8509804, 0.7019608, 0.4509804, 1, 0.05,
-3.5, 2.5, -3.666525, 0.9176471, 0.7019608, 0.5019608, 1, 0.05,
-3.5, 2.75, -3.864255, 0.9647059, 0.7019608, 0.5490196, 1, 0.05,
-3.5, 3, -3.978958, 0.9960784, 0.7019608, 0.6, 1, 0.05,
-3.5, 3.25, -3.991848, 0.9960784, 0.7019608, 0.6509804, 1, 0.05,
-3.5, 3.5, -3.88785, 0.972549, 0.7019608, 0.7019608, 1, 0.05,
-3.5, 3.75, -3.656937, 0.9137255, 0.7019608, 0.7490196, 1, 0.05,
-3.5, 4, -3.295269, 0.8235294, 0.7019608, 0.8, 1, 0.05,
-3.5, 4.25, -2.806018, 0.7019608, 0.7019608, 0.8509804, 1, 0.05,
-3.5, 4.5, -2.199813, 0.5490196, 0.7019608, 0.9019608, 1, 0.05,
-3.5, 4.75, -1.494721, 0.372549, 0.7019608, 0.9490196, 1, 0.05,
-3.5, 5, -0.7157543, 0.1803922, 0.7019608, 1, 1, 0.05,
-3.25, -5, -1.257336, 0.3137255, 0.6509804, 1, 1, 0.05,
-3.25, -4.75, -2.014374, 0.5019608, 0.6509804, 0.9490196, 1, 0.05,
-3.25, -4.5, -2.674281, 0.6666667, 0.6509804, 0.9019608, 1, 0.05,
-3.25, -4.25, -3.213524, 0.8039216, 0.6509804, 0.8509804, 1, 0.05,
-3.25, -4, -3.616459, 0.9058824, 0.6509804, 0.8, 1, 0.05,
-3.25, -3.75, -3.87568, 0.9686275, 0.6509804, 0.7490196, 1, 0.05,
-3.25, -3.5, -3.991848, 0.9960784, 0.6509804, 0.7019608, 1, 0.05,
-3.25, -3.25, -3.973028, 0.9921569, 0.6509804, 0.6509804, 1, 0.05,
-3.25, -3, -3.833618, 0.9568627, 0.6509804, 0.6, 1, 0.05,
-3.25, -2.75, -3.59297, 0.8980392, 0.6509804, 0.5490196, 1, 0.05,
-3.25, -2.5, -3.273809, 0.8196079, 0.6509804, 0.5019608, 1, 0.05,
-3.25, -2.25, -2.900606, 0.7254902, 0.6509804, 0.4509804, 1, 0.05,
-3.25, -2, -2.498002, 0.6235294, 0.6509804, 0.4, 1, 0.05,
-3.25, -1.75, -2.089429, 0.5215687, 0.6509804, 0.3490196, 1, 0.05,
-3.25, -1.5, -1.696019, 0.4235294, 0.6509804, 0.3019608, 1, 0.05,
-3.25, -1.25, -1.33585, 0.3333333, 0.6509804, 0.2509804, 1, 0.05,
-3.25, -1, -1.023586, 0.254902, 0.6509804, 0.2, 1, 0.05,
-3.25, -0.75, -0.7704483, 0.1921569, 0.6509804, 0.1490196, 1, 0.05,
-3.25, -0.5, -0.5844758, 0.145098, 0.6509804, 0.1019608, 1, 0.05,
-3.25, -0.25, -0.4709394, 0.1176471, 0.6509804, 0.05098039, 1, 0.05,
-3.25, 0, -0.4327805, 0.1098039, 0.6509804, 0, 1, 0.05,
-3.25, 0.25, -0.4709394, 0.1176471, 0.6509804, 0.05098039, 1, 0.05,
-3.25, 0.5, -0.5844758, 0.145098, 0.6509804, 0.1019608, 1, 0.05,
-3.25, 0.75, -0.7704483, 0.1921569, 0.6509804, 0.1490196, 1, 0.05,
-3.25, 1, -1.023586, 0.254902, 0.6509804, 0.2, 1, 0.05,
-3.25, 1.25, -1.33585, 0.3333333, 0.6509804, 0.2509804, 1, 0.05,
-3.25, 1.5, -1.696019, 0.4235294, 0.6509804, 0.3019608, 1, 0.05,
-3.25, 1.75, -2.089429, 0.5215687, 0.6509804, 0.3490196, 1, 0.05,
-3.25, 2, -2.498002, 0.6235294, 0.6509804, 0.4, 1, 0.05,
-3.25, 2.25, -2.900606, 0.7254902, 0.6509804, 0.4509804, 1, 0.05,
-3.25, 2.5, -3.273809, 0.8196079, 0.6509804, 0.5019608, 1, 0.05,
-3.25, 2.75, -3.59297, 0.8980392, 0.6509804, 0.5490196, 1, 0.05,
-3.25, 3, -3.833618, 0.9568627, 0.6509804, 0.6, 1, 0.05,
-3.25, 3.25, -3.973028, 0.9921569, 0.6509804, 0.6509804, 1, 0.05,
-3.25, 3.5, -3.991848, 0.9960784, 0.6509804, 0.7019608, 1, 0.05,
-3.25, 3.75, -3.87568, 0.9686275, 0.6509804, 0.7490196, 1, 0.05,
-3.25, 4, -3.616459, 0.9058824, 0.6509804, 0.8, 1, 0.05,
-3.25, 4.25, -3.213524, 0.8039216, 0.6509804, 0.8509804, 1, 0.05,
-3.25, 4.5, -2.674281, 0.6666667, 0.6509804, 0.9019608, 1, 0.05,
-3.25, 4.75, -2.014374, 0.5019608, 0.6509804, 0.9490196, 1, 0.05,
-3.25, 5, -1.257336, 0.3137255, 0.6509804, 1, 1, 0.05,
-3, -5, -1.747902, 0.4352941, 0.6, 1, 1, 0.05,
-3, -4.75, -2.468658, 0.6156863, 0.6, 0.9490196, 1, 0.05,
-3, -4.5, -3.069811, 0.7686275, 0.6, 0.9019608, 1, 0.05,
-3, -4.25, -3.529757, 0.8823529, 0.6, 0.8509804, 1, 0.05,
-3, -4, -3.835697, 0.9607843, 0.6, 0.8, 1, 0.05,
-3, -3.75, -3.983827, 0.9960784, 0.6, 0.7490196, 1, 0.05,
-3, -3.5, -3.978958, 0.9960784, 0.6, 0.7019608, 1, 0.05,
-3, -3.25, -3.833618, 0.9568627, 0.6, 0.6509804, 1, 0.05,
-3, -3, -3.566729, 0.8901961, 0.6, 0.6, 1, 0.05,
-3, -2.75, -3.20196, 0.8, 0.6, 0.5490196, 1, 0.05,
-3, -2.5, -2.76591, 0.6901961, 0.6, 0.5019608, 1, 0.05,
-3, -2.25, -2.286245, 0.572549, 0.6, 0.4509804, 1, 0.05,
-3, -2, -1.789967, 0.4470588, 0.6, 0.4, 1, 0.05,
-3, -1.75, -1.301916, 0.3254902, 0.6, 0.3490196, 1, 0.05,
-3, -1.5, -0.8436537, 0.2117647, 0.6, 0.3019608, 1, 0.05,
-3, -1.25, -0.4327805, 0.1098039, 0.6, 0.2509804, 1, 0.05,
-3, -1, -0.08273412, 0.01960784, 0.6, 0.2, 1, 0.05,
-3, -0.75, 0.196974, 0.05098039, 0.6, 0.1490196, 1, 0.05,
-3, -0.5, 0.400175, 0.1019608, 0.6, 0.1019608, 1, 0.05,
-3, -0.25, 0.5232719, 0.1294118, 0.6, 0.05098039, 1, 0.05,
-3, 0, 0.56448, 0.1411765, 0.6, 0, 1, 0.05,
-3, 0.25, 0.5232719, 0.1294118, 0.6, 0.05098039, 1, 0.05,
-3, 0.5, 0.400175, 0.1019608, 0.6, 0.1019608, 1, 0.05,
-3, 0.75, 0.196974, 0.05098039, 0.6, 0.1490196, 1, 0.05,
-3, 1, -0.08273412, 0.01960784, 0.6, 0.2, 1, 0.05,
-3, 1.25, -0.4327805, 0.1098039, 0.6, 0.2509804, 1, 0.05,
-3, 1.5, -0.8436537, 0.2117647, 0.6, 0.3019608, 1, 0.05,
-3, 1.75, -1.301916, 0.3254902, 0.6, 0.3490196, 1, 0.05,
-3, 2, -1.789967, 0.4470588, 0.6, 0.4, 1, 0.05,
-3, 2.25, -2.286245, 0.572549, 0.6, 0.4509804, 1, 0.05,
-3, 2.5, -2.76591, 0.6901961, 0.6, 0.5019608, 1, 0.05,
-3, 2.75, -3.20196, 0.8, 0.6, 0.5490196, 1, 0.05,
-3, 3, -3.566729, 0.8901961, 0.6, 0.6, 1, 0.05,
-3, 3.25, -3.833618, 0.9568627, 0.6, 0.6509804, 1, 0.05,
-3, 3.5, -3.978958, 0.9960784, 0.6, 0.7019608, 1, 0.05,
-3, 3.75, -3.983827, 0.9960784, 0.6, 0.7490196, 1, 0.05,
-3, 4, -3.835697, 0.9607843, 0.6, 0.8, 1, 0.05,
-3, 4.25, -3.529757, 0.8823529, 0.6, 0.8509804, 1, 0.05,
-3, 4.5, -3.069811, 0.7686275, 0.6, 0.9019608, 1, 0.05,
-3, 4.75, -2.468658, 0.6156863, 0.6, 0.9490196, 1, 0.05,
-3, 5, -1.747902, 0.4352941, 0.6, 1, 1, 0.05,
-2.75, -5, -2.181476, 0.5450981, 0.5490196, 1, 1, 0.05,
-2.75, -4.75, -2.854224, 0.7137255, 0.5490196, 0.9490196, 1, 0.05,
-2.75, -4.5, -3.386113, 0.8470588, 0.5490196, 0.9019608, 1, 0.05,
-2.75, -4.25, -3.757868, 0.9411765, 0.5490196, 0.8509804, 1, 0.05,
-2.75, -4, -3.959891, 0.9882353, 0.5490196, 0.8, 1, 0.05,
-2.75, -3.75, -3.992285, 1, 0.5490196, 0.7490196, 1, 0.05,
-2.75, -3.5, -3.864255, 0.9647059, 0.5490196, 0.7019608, 1, 0.05,
-2.75, -3.25, -3.59297, 0.8980392, 0.5490196, 0.6509804, 1, 0.05,
-2.75, -3, -3.20196, 0.8, 0.5490196, 0.6, 1, 0.05,
-2.75, -2.75, -2.719214, 0.6784314, 0.5490196, 0.5490196, 1, 0.05,
-2.75, -2.5, -2.175086, 0.5450981, 0.5490196, 0.5019608, 1, 0.05,
-2.75, -2.25, -1.600213, 0.4, 0.5490196, 0.4509804, 1, 0.05,
-2.75, -2, -1.023586, 0.254902, 0.5490196, 0.4, 1, 0.05,
-2.75, -1.75, -0.4709394, 0.1176471, 0.5490196, 0.3490196, 1, 0.05,
-2.75, -1.5, 0.03640603, 0.007843138, 0.5490196, 0.3019608, 1, 0.05,
-2.75, -1.25, 0.4821494, 0.1215686, 0.5490196, 0.2509804, 1, 0.05,
-2.75, -1, 0.8550219, 0.2156863, 0.5490196, 0.2, 1, 0.05,
-2.75, -0.75, 1.148232, 0.2862745, 0.5490196, 0.1490196, 1, 0.05,
-2.75, -0.5, 1.358461, 0.3411765, 0.5490196, 0.1019608, 1, 0.05,
-2.75, -0.25, 1.484619, 0.372549, 0.5490196, 0.05098039, 1, 0.05,
-2.75, 0, 1.526644, 0.3803922, 0.5490196, 0, 1, 0.05,
-2.75, 0.25, 1.484619, 0.372549, 0.5490196, 0.05098039, 1, 0.05,
-2.75, 0.5, 1.358461, 0.3411765, 0.5490196, 0.1019608, 1, 0.05,
-2.75, 0.75, 1.148232, 0.2862745, 0.5490196, 0.1490196, 1, 0.05,
-2.75, 1, 0.8550219, 0.2156863, 0.5490196, 0.2, 1, 0.05,
-2.75, 1.25, 0.4821494, 0.1215686, 0.5490196, 0.2509804, 1, 0.05,
-2.75, 1.5, 0.03640603, 0.007843138, 0.5490196, 0.3019608, 1, 0.05,
-2.75, 1.75, -0.4709394, 0.1176471, 0.5490196, 0.3490196, 1, 0.05,
-2.75, 2, -1.023586, 0.254902, 0.5490196, 0.4, 1, 0.05,
-2.75, 2.25, -1.600213, 0.4, 0.5490196, 0.4509804, 1, 0.05,
-2.75, 2.5, -2.175086, 0.5450981, 0.5490196, 0.5019608, 1, 0.05,
-2.75, 2.75, -2.719214, 0.6784314, 0.5490196, 0.5490196, 1, 0.05,
-2.75, 3, -3.20196, 0.8, 0.5490196, 0.6, 1, 0.05,
-2.75, 3.25, -3.59297, 0.8980392, 0.5490196, 0.6509804, 1, 0.05,
-2.75, 3.5, -3.864255, 0.9647059, 0.5490196, 0.7019608, 1, 0.05,
-2.75, 3.75, -3.992285, 1, 0.5490196, 0.7490196, 1, 0.05,
-2.75, 4, -3.959891, 0.9882353, 0.5490196, 0.8, 1, 0.05,
-2.75, 4.25, -3.757868, 0.9411765, 0.5490196, 0.8509804, 1, 0.05,
-2.75, 4.5, -3.386113, 0.8470588, 0.5490196, 0.9019608, 1, 0.05,
-2.75, 4.75, -2.854224, 0.7137255, 0.5490196, 0.9490196, 1, 0.05,
-2.75, 5, -2.181476, 0.5450981, 0.5490196, 1, 1, 0.05,
-2.5, -5, -2.555439, 0.6392157, 0.5019608, 1, 1, 0.05,
-2.5, -4.75, -3.171366, 0.7921569, 0.5019608, 0.9490196, 1, 0.05,
-2.5, -4.5, -3.626762, 0.9058824, 0.5019608, 0.9019608, 1, 0.05,
-2.5, -4.25, -3.904997, 0.9764706, 0.5019608, 0.8509804, 1, 0.05,
-2.5, -4, -3.999958, 1, 0.5019608, 0.8, 1, 0.05,
-2.5, -3.75, -3.915877, 0.9803922, 0.5019608, 0.7490196, 1, 0.05,
-2.5, -3.5, -3.666525, 0.9176471, 0.5019608, 0.7019608, 1, 0.05,
-2.5, -3.25, -3.273809, 0.8196079, 0.5019608, 0.6509804, 1, 0.05,
-2.5, -3, -2.76591, 0.6901961, 0.5019608, 0.6, 1, 0.05,
-2.5, -2.75, -2.175086, 0.5450981, 0.5019608, 0.5490196, 1, 0.05,
-2.5, -2.5, -1.535323, 0.3843137, 0.5019608, 0.5019608, 1, 0.05,
-2.5, -2.25, -0.8799956, 0.2196078, 0.5019608, 0.4509804, 1, 0.05,
-2.5, -2, -0.2397341, 0.05882353, 0.5019608, 0.4, 1, 0.05,
-2.5, -1.75, 0.3593299, 0.09019608, 0.5019608, 0.3490196, 1, 0.05,
-2.5, -1.5, 0.8967791, 0.2235294, 0.5019608, 0.3019608, 1, 0.05,
-2.5, -1.25, 1.358461, 0.3411765, 0.5019608, 0.2509804, 1, 0.05,
-2.5, -1, 1.736296, 0.4352941, 0.5019608, 0.2, 1, 0.05,
-2.5, -0.75, 2.027363, 0.5058824, 0.5019608, 0.1490196, 1, 0.05,
-2.5, -0.5, 2.232362, 0.5568628, 0.5019608, 0.1019608, 1, 0.05,
-2.5, -0.25, 2.353746, 0.5882353, 0.5019608, 0.05098039, 1, 0.05,
-2.5, 0, 2.393888, 0.6, 0.5019608, 0, 1, 0.05,
-2.5, 0.25, 2.353746, 0.5882353, 0.5019608, 0.05098039, 1, 0.05,
-2.5, 0.5, 2.232362, 0.5568628, 0.5019608, 0.1019608, 1, 0.05,
-2.5, 0.75, 2.027363, 0.5058824, 0.5019608, 0.1490196, 1, 0.05,
-2.5, 1, 1.736296, 0.4352941, 0.5019608, 0.2, 1, 0.05,
-2.5, 1.25, 1.358461, 0.3411765, 0.5019608, 0.2509804, 1, 0.05,
-2.5, 1.5, 0.8967791, 0.2235294, 0.5019608, 0.3019608, 1, 0.05,
-2.5, 1.75, 0.3593299, 0.09019608, 0.5019608, 0.3490196, 1, 0.05,
-2.5, 2, -0.2397341, 0.05882353, 0.5019608, 0.4, 1, 0.05,
-2.5, 2.25, -0.8799956, 0.2196078, 0.5019608, 0.4509804, 1, 0.05,
-2.5, 2.5, -1.535323, 0.3843137, 0.5019608, 0.5019608, 1, 0.05,
-2.5, 2.75, -2.175086, 0.5450981, 0.5019608, 0.5490196, 1, 0.05,
-2.5, 3, -2.76591, 0.6901961, 0.5019608, 0.6, 1, 0.05,
-2.5, 3.25, -3.273809, 0.8196079, 0.5019608, 0.6509804, 1, 0.05,
-2.5, 3.5, -3.666525, 0.9176471, 0.5019608, 0.7019608, 1, 0.05,
-2.5, 3.75, -3.915877, 0.9803922, 0.5019608, 0.7490196, 1, 0.05,
-2.5, 4, -3.999958, 1, 0.5019608, 0.8, 1, 0.05,
-2.5, 4.25, -3.904997, 0.9764706, 0.5019608, 0.8509804, 1, 0.05,
-2.5, 4.5, -3.626762, 0.9058824, 0.5019608, 0.9019608, 1, 0.05,
-2.5, 4.75, -3.171366, 0.7921569, 0.5019608, 0.9490196, 1, 0.05,
-2.5, 5, -2.555439, 0.6392157, 0.5019608, 1, 1, 0.05,
-2.25, -5, -2.870141, 0.7176471, 0.4509804, 1, 1, 0.05,
-2.25, -4.75, -3.423492, 0.854902, 0.4509804, 0.9490196, 1, 0.05,
-2.25, -4.5, -3.798494, 0.9490196, 0.4509804, 0.9019608, 1, 0.05,
-2.25, -4.25, -3.981406, 0.9960784, 0.4509804, 0.8509804, 1, 0.05,
-2.25, -4, -3.969781, 0.9921569, 0.4509804, 0.8, 1, 0.05,
-2.25, -3.75, -3.772118, 0.9411765, 0.4509804, 0.7490196, 1, 0.05,
-2.25, -3.5, -3.406833, 0.8509804, 0.4509804, 0.7019608, 1, 0.05,
-2.25, -3.25, -2.900606, 0.7254902, 0.4509804, 0.6509804, 1, 0.05,
-2.25, -3, -2.286245, 0.572549, 0.4509804, 0.6, 1, 0.05,
-2.25, -2.75, -1.600213, 0.4, 0.4509804, 0.5490196, 1, 0.05,
-2.25, -2.5, -0.8799956, 0.2196078, 0.4509804, 0.5019608, 1, 0.05,
-2.25, -2.25, -0.1615075, 0.03921569, 0.4509804, 0.4509804, 1, 0.05,
-2.25, -2, 0.5232719, 0.1294118, 0.4509804, 0.4, 1, 0.05,
-2.25, -1.75, 1.148232, 0.2862745, 0.4509804, 0.3490196, 1, 0.05,
-2.25, -1.5, 1.694448, 0.4235294, 0.4509804, 0.3019608, 1, 0.05,
-2.25, -1.25, 2.150727, 0.5372549, 0.4509804, 0.2509804, 1, 0.05,
-2.25, -1, 2.513238, 0.627451, 0.4509804, 0.2, 1, 0.05,
-2.25, -0.75, 2.784209, 0.6941177, 0.4509804, 0.1490196, 1, 0.05,
-2.25, -0.5, 2.969763, 0.7411765, 0.4509804, 0.1019608, 1, 0.05,
-2.25, -0.25, 3.077204, 0.7686275, 0.4509804, 0.05098039, 1, 0.05,
-2.25, 0, 3.112293, 0.7764706, 0.4509804, 0, 1, 0.05,
-2.25, 0.25, 3.077204, 0.7686275, 0.4509804, 0.05098039, 1, 0.05,
-2.25, 0.5, 2.969763, 0.7411765, 0.4509804, 0.1019608, 1, 0.05,
-2.25, 0.75, 2.784209, 0.6941177, 0.4509804, 0.1490196, 1, 0.05,
-2.25, 1, 2.513238, 0.627451, 0.4509804, 0.2, 1, 0.05,
-2.25, 1.25, 2.150727, 0.5372549, 0.4509804, 0.2509804, 1, 0.05,
-2.25, 1.5, 1.694448, 0.4235294, 0.4509804, 0.3019608, 1, 0.05,
-2.25, 1.75, 1.148232, 0.2862745, 0.4509804, 0.3490196, 1, 0.05,
-2.25, 2, 0.5232719, 0.1294118, 0.4509804, 0.4, 1, 0.05,
-2.25, 2.25, -0.1615075, 0.03921569, 0.4509804, 0.4509804, 1, 0.05,
-2.25, 2.5, -0.8799956, 0.2196078, 0.4509804, 0.5019608, 1, 0.05,
-2.25, 2.75, -1.600213, 0.4, 0.4509804, 0.5490196, 1, 0.05,
-2.25, 3, -2.286245, 0.572549, 0.4509804, 0.6, 1, 0.05,
-2.25, 3.25, -2.900606, 0.7254902, 0.4509804, 0.6509804, 1, 0.05,
-2.25, 3.5, -3.406833, 0.8509804, 0.4509804, 0.7019608, 1, 0.05,
-2.25, 3.75, -3.772118, 0.9411765, 0.4509804, 0.7490196, 1, 0.05,
-2.25, 4, -3.969781, 0.9921569, 0.4509804, 0.8, 1, 0.05,
-2.25, 4.25, -3.981406, 0.9960784, 0.4509804, 0.8509804, 1, 0.05,
-2.25, 4.5, -3.798494, 0.9490196, 0.4509804, 0.9019608, 1, 0.05,
-2.25, 4.75, -3.423492, 0.854902, 0.4509804, 0.9490196, 1, 0.05,
-2.25, 5, -2.870141, 0.7176471, 0.4509804, 1, 1, 0.05,
-2, -5, -3.12838, 0.7803922, 0.4, 1, 1, 0.05,
-2, -4.75, -3.616459, 0.9058824, 0.4, 0.9490196, 1, 0.05,
-2, -4.5, -3.910414, 0.9764706, 0.4, 0.9019608, 1, 0.05,
-2, -4.25, -3.999531, 1, 0.4, 0.8509804, 1, 0.05,
-2, -4, -3.885111, 0.972549, 0.4, 0.8, 1, 0.05,
-2, -3.75, -3.579957, 0.8941177, 0.4, 0.7490196, 1, 0.05,
-2, -3.5, -3.107119, 0.7764706, 0.4, 0.7019608, 1, 0.05,
-2, -3.25, -2.498002, 0.6235294, 0.4, 0.6509804, 1, 0.05,
-2, -3, -1.789967, 0.4470588, 0.4, 0.6, 1, 0.05,
-2, -2.75, -1.023586, 0.254902, 0.4, 0.5490196, 1, 0.05,
-2, -2.5, -0.2397341, 0.05882353, 0.4, 0.5019608, 1, 0.05,
-2, -2.25, 0.5232719, 0.1294118, 0.4, 0.4509804, 1, 0.05,
-2, -2, 1.232287, 0.3098039, 0.4, 0.4, 1, 0.05,
-2, -1.75, 1.861493, 0.4666667, 0.4, 0.3490196, 1, 0.05,
-2, -1.5, 2.393888, 0.6, 0.4, 0.3019608, 1, 0.05,
-2, -1.25, 2.821912, 0.7058824, 0.4, 0.2509804, 1, 0.05,
-2, -1, 3.146996, 0.7882353, 0.4, 0.2, 1, 0.05,
-2, -0.75, 3.377916, 0.8431373, 0.4, 0.1490196, 1, 0.05,
-2, -0.5, 3.527906, 0.8823529, 0.4, 0.1019608, 1, 0.05,
-2, -0.25, 3.610842, 0.9019608, 0.4, 0.05098039, 1, 0.05,
-2, 0, 3.63719, 0.9098039, 0.4, 0, 1, 0.05,
-2, 0.25, 3.610842, 0.9019608, 0.4, 0.05098039, 1, 0.05,
-2, 0.5, 3.527906, 0.8823529, 0.4, 0.1019608, 1, 0.05,
-2, 0.75, 3.377916, 0.8431373, 0.4, 0.1490196, 1, 0.05,
-2, 1, 3.146996, 0.7882353, 0.4, 0.2, 1, 0.05,
-2, 1.25, 2.821912, 0.7058824, 0.4, 0.2509804, 1, 0.05,
-2, 1.5, 2.393888, 0.6, 0.4, 0.3019608, 1, 0.05,
-2, 1.75, 1.861493, 0.4666667, 0.4, 0.3490196, 1, 0.05,
-2, 2, 1.232287, 0.3098039, 0.4, 0.4, 1, 0.05,
-2, 2.25, 0.5232719, 0.1294118, 0.4, 0.4509804, 1, 0.05,
-2, 2.5, -0.2397341, 0.05882353, 0.4, 0.5019608, 1, 0.05,
-2, 2.75, -1.023586, 0.254902, 0.4, 0.5490196, 1, 0.05,
-2, 3, -1.789967, 0.4470588, 0.4, 0.6, 1, 0.05,
-2, 3.25, -2.498002, 0.6235294, 0.4, 0.6509804, 1, 0.05,
-2, 3.5, -3.107119, 0.7764706, 0.4, 0.7019608, 1, 0.05,
-2, 3.75, -3.579957, 0.8941177, 0.4, 0.7490196, 1, 0.05,
-2, 4, -3.885111, 0.972549, 0.4, 0.8, 1, 0.05,
-2, 4.25, -3.999531, 1, 0.4, 0.8509804, 1, 0.05,
-2, 4.5, -3.910414, 0.9764706, 0.4, 0.9019608, 1, 0.05,
-2, 4.75, -3.616459, 0.9058824, 0.4, 0.9490196, 1, 0.05,
-2, 5, -3.12838, 0.7803922, 0.4, 1, 1, 0.05,
-1.75, -5, -3.334813, 0.8352941, 0.3490196, 1, 1, 0.05,
-1.75, -4.75, -3.757868, 0.9411765, 0.3490196, 0.9490196, 1, 0.05,
-1.75, -4.5, -3.973158, 0.9921569, 0.3490196, 0.9019608, 1, 0.05,
-1.75, -4.25, -3.973028, 0.9921569, 0.3490196, 0.8509804, 1, 0.05,
-1.75, -4, -3.762504, 0.9411765, 0.3490196, 0.8, 1, 0.05,
-1.75, -3.75, -3.358611, 0.8392157, 0.3490196, 0.7490196, 1, 0.05,
-1.75, -3.5, -2.788921, 0.6980392, 0.3490196, 0.7019608, 1, 0.05,
-1.75, -3.25, -2.089429, 0.5215687, 0.3490196, 0.6509804, 1, 0.05,
-1.75, -3, -1.301916, 0.3254902, 0.3490196, 0.6, 1, 0.05,
-1.75, -2.75, -0.4709394, 0.1176471, 0.3490196, 0.5490196, 1, 0.05,
-1.75, -2.5, 0.3593299, 0.09019608, 0.3490196, 0.5019608, 1, 0.05,
-1.75, -2.25, 1.148232, 0.2862745, 0.3490196, 0.4509804, 1, 0.05,
-1.75, -2, 1.861493, 0.4666667, 0.3490196, 0.4, 1, 0.05,
-1.75, -1.75, 2.473644, 0.6196079, 0.3490196, 0.3490196, 1, 0.05,
-1.75, -1.5, 2.969763, 0.7411765, 0.3490196, 0.3019608, 1, 0.05,
-1.75, -1.25, 3.346322, 0.8352941, 0.3490196, 0.2509804, 1, 0.05,
-1.75, -1, 3.610842, 0.9019608, 0.3490196, 0.2, 1, 0.05,
-1.75, -0.75, 3.780072, 0.945098, 0.3490196, 0.1490196, 1, 0.05,
-1.75, -0.5, 3.87641, 0.9686275, 0.3490196, 0.1019608, 1, 0.05,
-1.75, -0.25, 3.922656, 0.9803922, 0.3490196, 0.05098039, 1, 0.05,
-1.75, 0, 3.935944, 0.9843137, 0.3490196, 0, 1, 0.05,
-1.75, 0.25, 3.922656, 0.9803922, 0.3490196, 0.05098039, 1, 0.05,
-1.75, 0.5, 3.87641, 0.9686275, 0.3490196, 0.1019608, 1, 0.05,
-1.75, 0.75, 3.780072, 0.945098, 0.3490196, 0.1490196, 1, 0.05,
-1.75, 1, 3.610842, 0.9019608, 0.3490196, 0.2, 1, 0.05,
-1.75, 1.25, 3.346322, 0.8352941, 0.3490196, 0.2509804, 1, 0.05,
-1.75, 1.5, 2.969763, 0.7411765, 0.3490196, 0.3019608, 1, 0.05,
-1.75, 1.75, 2.473644, 0.6196079, 0.3490196, 0.3490196, 1, 0.05,
-1.75, 2, 1.861493, 0.4666667, 0.3490196, 0.4, 1, 0.05,
-1.75, 2.25, 1.148232, 0.2862745, 0.3490196, 0.4509804, 1, 0.05,
-1.75, 2.5, 0.3593299, 0.09019608, 0.3490196, 0.5019608, 1, 0.05,
-1.75, 2.75, -0.4709394, 0.1176471, 0.3490196, 0.5490196, 1, 0.05,
-1.75, 3, -1.301916, 0.3254902, 0.3490196, 0.6, 1, 0.05,
-1.75, 3.25, -2.089429, 0.5215687, 0.3490196, 0.6509804, 1, 0.05,
-1.75, 3.5, -2.788921, 0.6980392, 0.3490196, 0.7019608, 1, 0.05,
-1.75, 3.75, -3.358611, 0.8392157, 0.3490196, 0.7490196, 1, 0.05,
-1.75, 4, -3.762504, 0.9411765, 0.3490196, 0.8, 1, 0.05,
-1.75, 4.25, -3.973028, 0.9921569, 0.3490196, 0.8509804, 1, 0.05,
-1.75, 4.5, -3.973158, 0.9921569, 0.3490196, 0.9019608, 1, 0.05,
-1.75, 4.75, -3.757868, 0.9411765, 0.3490196, 0.9490196, 1, 0.05,
-1.75, 5, -3.334813, 0.8352941, 0.3490196, 1, 1, 0.05,
-1.5, -5, -3.495335, 0.8745098, 0.3019608, 1, 1, 0.05,
-1.5, -4.75, -3.856334, 0.9647059, 0.3019608, 0.9490196, 1, 0.05,
-1.5, -4.5, -3.998075, 1, 0.3019608, 0.9019608, 1, 0.05,
-1.5, -4.25, -3.915877, 0.9803922, 0.3019608, 0.8509804, 1, 0.05,
-1.5, -4, -3.618347, 0.9058824, 0.3019608, 0.8, 1, 0.05,
-1.5, -3.75, -3.126535, 0.7803922, 0.3019608, 0.7490196, 1, 0.05,
-1.5, -3.5, -2.472307, 0.6196079, 0.3019608, 0.7019608, 1, 0.05,
-1.5, -3.25, -1.696019, 0.4235294, 0.3019608, 0.6509804, 1, 0.05,
-1.5, -3, -0.8436537, 0.2117647, 0.3019608, 0.6, 1, 0.05,
-1.5, -2.75, 0.03640603, 0.007843138, 0.3019608, 0.5490196, 1, 0.05,
-1.5, -2.5, 0.8967791, 0.2235294, 0.3019608, 0.5019608, 1, 0.05,
-1.5, -2.25, 1.694448, 0.4235294, 0.3019608, 0.4509804, 1, 0.05,
-1.5, -2, 2.393888, 0.6, 0.3019608, 0.4, 1, 0.05,
-1.5, -1.75, 2.969763, 0.7411765, 0.3019608, 0.3490196, 1, 0.05,
-1.5, -1.5, 3.409002, 0.8509804, 0.3019608, 0.3019608, 1, 0.05,
-1.5, -1.25, 3.712032, 0.9294118, 0.3019608, 0.2509804, 1, 0.05,
-1.5, -1, 3.892853, 0.972549, 0.3019608, 0.2, 1, 0.05,
-1.5, -0.75, 3.977441, 0.9960784, 0.3019608, 0.1490196, 1, 0.05,
-1.5, -0.5, 3.999786, 1, 0.3019608, 0.1019608, 1, 0.05,
-1.5, -0.25, 3.99498, 1, 0.3019608, 0.05098039, 1, 0.05,
-1.5, 0, 3.98998, 0.9960784, 0.3019608, 0, 1, 0.05,
-1.5, 0.25, 3.99498, 1, 0.3019608, 0.05098039, 1, 0.05,
-1.5, 0.5, 3.999786, 1, 0.3019608, 0.1019608, 1, 0.05,
-1.5, 0.75, 3.977441, 0.9960784, 0.3019608, 0.1490196, 1, 0.05,
-1.5, 1, 3.892853, 0.972549, 0.3019608, 0.2, 1, 0.05,
-1.5, 1.25, 3.712032, 0.9294118, 0.3019608, 0.2509804, 1, 0.05,
-1.5, 1.5, 3.409002, 0.8509804, 0.3019608, 0.3019608, 1, 0.05,
-1.5, 1.75, 2.969763, 0.7411765, 0.3019608, 0.3490196, 1, 0.05,
-1.5, 2, 2.393888, 0.6, 0.3019608, 0.4, 1, 0.05,
-1.5, 2.25, 1.694448, 0.4235294, 0.3019608, 0.4509804, 1, 0.05,
-1.5, 2.5, 0.8967791, 0.2235294, 0.3019608, 0.5019608, 1, 0.05,
-1.5, 2.75, 0.03640603, 0.007843138, 0.3019608, 0.5490196, 1, 0.05,
-1.5, 3, -0.8436537, 0.2117647, 0.3019608, 0.6, 1, 0.05,
-1.5, 3.25, -1.696019, 0.4235294, 0.3019608, 0.6509804, 1, 0.05,
-1.5, 3.5, -2.472307, 0.6196079, 0.3019608, 0.7019608, 1, 0.05,
-1.5, 3.75, -3.126535, 0.7803922, 0.3019608, 0.7490196, 1, 0.05,
-1.5, 4, -3.618347, 0.9058824, 0.3019608, 0.8, 1, 0.05,
-1.5, 4.25, -3.915877, 0.9803922, 0.3019608, 0.8509804, 1, 0.05,
-1.5, 4.5, -3.998075, 1, 0.3019608, 0.9019608, 1, 0.05,
-1.5, 4.75, -3.856334, 0.9647059, 0.3019608, 0.9490196, 1, 0.05,
-1.5, 5, -3.495335, 0.8745098, 0.3019608, 1, 1, 0.05,
-1.25, -5, -3.616459, 0.9058824, 0.2509804, 1, 1, 0.05,
-1.25, -4.75, -3.920797, 0.9803922, 0.2509804, 0.9490196, 1, 0.05,
-1.25, -4.5, -3.996472, 1, 0.2509804, 0.9019608, 1, 0.05,
-1.25, -4.25, -3.841583, 0.9607843, 0.2509804, 0.8509804, 1, 0.05,
-1.25, -4, -3.468042, 0.8666667, 0.2509804, 0.8, 1, 0.05,
-1.25, -3.75, -2.900606, 0.7254902, 0.2509804, 0.7490196, 1, 0.05,
-1.25, -3.5, -2.175086, 0.5450981, 0.2509804, 0.7019608, 1, 0.05,
-1.25, -3.25, -1.33585, 0.3333333, 0.2509804, 0.6509804, 1, 0.05,
-1.25, -3, -0.4327805, 0.1098039, 0.2509804, 0.6, 1, 0.05,
-1.25, -2.75, 0.4821494, 0.1215686, 0.2509804, 0.5490196, 1, 0.05,
-1.25, -2.5, 1.358461, 0.3411765, 0.2509804, 0.5019608, 1, 0.05,
-1.25, -2.25, 2.150727, 0.5372549, 0.2509804, 0.4509804, 1, 0.05,
-1.25, -2, 2.821912, 0.7058824, 0.2509804, 0.4, 1, 0.05,
-1.25, -1.75, 3.346322, 0.8352941, 0.2509804, 0.3490196, 1, 0.05,
-1.25, -1.5, 3.712032, 0.9294118, 0.2509804, 0.3019608, 1, 0.05,
-1.25, -1.25, 3.922656, 0.9803922, 0.2509804, 0.2509804, 1, 0.05,
-1.25, -1, 3.998202, 1, 0.2509804, 0.2, 1, 0.05,
-1.25, -0.75, 3.974463, 0.9921569, 0.2509804, 0.1490196, 1, 0.05,
-1.25, -0.5, 3.899618, 0.9764706, 0.2509804, 0.1019608, 1, 0.05,
-1.25, -0.25, 3.825995, 0.9568627, 0.2509804, 0.05098039, 1, 0.05,
-1.25, 0, 3.795938, 0.9490196, 0.2509804, 0, 1, 0.05,
-1.25, 0.25, 3.825995, 0.9568627, 0.2509804, 0.05098039, 1, 0.05,
-1.25, 0.5, 3.899618, 0.9764706, 0.2509804, 0.1019608, 1, 0.05,
-1.25, 0.75, 3.974463, 0.9921569, 0.2509804, 0.1490196, 1, 0.05,
-1.25, 1, 3.998202, 1, 0.2509804, 0.2, 1, 0.05,
-1.25, 1.25, 3.922656, 0.9803922, 0.2509804, 0.2509804, 1, 0.05,
-1.25, 1.5, 3.712032, 0.9294118, 0.2509804, 0.3019608, 1, 0.05,
-1.25, 1.75, 3.346322, 0.8352941, 0.2509804, 0.3490196, 1, 0.05,
-1.25, 2, 2.821912, 0.7058824, 0.2509804, 0.4, 1, 0.05,
-1.25, 2.25, 2.150727, 0.5372549, 0.2509804, 0.4509804, 1, 0.05,
-1.25, 2.5, 1.358461, 0.3411765, 0.2509804, 0.5019608, 1, 0.05,
-1.25, 2.75, 0.4821494, 0.1215686, 0.2509804, 0.5490196, 1, 0.05,
-1.25, 3, -0.4327805, 0.1098039, 0.2509804, 0.6, 1, 0.05,
-1.25, 3.25, -1.33585, 0.3333333, 0.2509804, 0.6509804, 1, 0.05,
-1.25, 3.5, -2.175086, 0.5450981, 0.2509804, 0.7019608, 1, 0.05,
-1.25, 3.75, -2.900606, 0.7254902, 0.2509804, 0.7490196, 1, 0.05,
-1.25, 4, -3.468042, 0.8666667, 0.2509804, 0.8, 1, 0.05,
-1.25, 4.25, -3.841583, 0.9607843, 0.2509804, 0.8509804, 1, 0.05,
-1.25, 4.5, -3.996472, 1, 0.2509804, 0.9019608, 1, 0.05,
-1.25, 4.75, -3.920797, 0.9803922, 0.2509804, 0.9490196, 1, 0.05,
-1.25, 5, -3.616459, 0.9058824, 0.2509804, 1, 1, 0.05,
-1, -5, -3.704739, 0.9254902, 0.2, 1, 1, 0.05,
-1, -4.75, -3.959891, 0.9882353, 0.2, 0.9490196, 1, 0.05,
-1, -4.5, -3.978958, 0.9960784, 0.2, 0.9019608, 1, 0.05,
-1, -4.25, -3.762504, 0.9411765, 0.2, 0.8509804, 1, 0.05,
-1, -4, -3.325357, 0.8313726, 0.2, 0.8, 1, 0.05,
-1, -3.75, -2.69553, 0.6745098, 0.2, 0.7490196, 1, 0.05,
-1, -3.5, -1.912302, 0.4784314, 0.2, 0.7019608, 1, 0.05,
-1, -3.25, -1.023586, 0.254902, 0.2, 0.6509804, 1, 0.05,
-1, -3, -0.08273412, 0.01960784, 0.2, 0.6, 1, 0.05,
-1, -2.75, 0.8550219, 0.2156863, 0.2, 0.5490196, 1, 0.05,
-1, -2.5, 1.736296, 0.4352941, 0.2, 0.5019608, 1, 0.05,
-1, -2.25, 2.513238, 0.627451, 0.2, 0.4509804, 1, 0.05,
-1, -2, 3.146996, 0.7882353, 0.2, 0.4, 1, 0.05,
-1, -1.75, 3.610842, 0.9019608, 0.2, 0.3490196, 1, 0.05,
-1, -1.5, 3.892853, 0.972549, 0.2, 0.3019608, 1, 0.05,
-1, -1.25, 3.998202, 1, 0.2, 0.2509804, 1, 0.05,
-1, -1, 3.951064, 0.9882353, 0.2, 0.2, 1, 0.05,
-1, -0.75, 3.795938, 0.9490196, 0.2, 0.1490196, 1, 0.05,
-1, -0.5, 3.596969, 0.8980392, 0.2, 0.1019608, 1, 0.05,
-1, -0.25, 3.430794, 0.8588235, 0.2, 0.05098039, 1, 0.05,
-1, 0, 3.365884, 0.8431373, 0.2, 0, 1, 0.05,
-1, 0.25, 3.430794, 0.8588235, 0.2, 0.05098039, 1, 0.05,
-1, 0.5, 3.596969, 0.8980392, 0.2, 0.1019608, 1, 0.05,
-1, 0.75, 3.795938, 0.9490196, 0.2, 0.1490196, 1, 0.05,
-1, 1, 3.951064, 0.9882353, 0.2, 0.2, 1, 0.05,
-1, 1.25, 3.998202, 1, 0.2, 0.2509804, 1, 0.05,
-1, 1.5, 3.892853, 0.972549, 0.2, 0.3019608, 1, 0.05,
-1, 1.75, 3.610842, 0.9019608, 0.2, 0.3490196, 1, 0.05,
-1, 2, 3.146996, 0.7882353, 0.2, 0.4, 1, 0.05,
-1, 2.25, 2.513238, 0.627451, 0.2, 0.4509804, 1, 0.05,
-1, 2.5, 1.736296, 0.4352941, 0.2, 0.5019608, 1, 0.05,
-1, 2.75, 0.8550219, 0.2156863, 0.2, 0.5490196, 1, 0.05,
-1, 3, -0.08273412, 0.01960784, 0.2, 0.6, 1, 0.05,
-1, 3.25, -1.023586, 0.254902, 0.2, 0.6509804, 1, 0.05,
-1, 3.5, -1.912302, 0.4784314, 0.2, 0.7019608, 1, 0.05,
-1, 3.75, -2.69553, 0.6745098, 0.2, 0.7490196, 1, 0.05,
-1, 4, -3.325357, 0.8313726, 0.2, 0.8, 1, 0.05,
-1, 4.25, -3.762504, 0.9411765, 0.2, 0.8509804, 1, 0.05,
-1, 4.5, -3.978958, 0.9960784, 0.2, 0.9019608, 1, 0.05,
-1, 4.75, -3.959891, 0.9882353, 0.2, 0.9490196, 1, 0.05,
-1, 5, -3.704739, 0.9254902, 0.2, 1, 1, 0.05,
-0.75, -5, -3.766262, 0.9411765, 0.1490196, 1, 1, 0.05,
-0.75, -4.75, -3.981406, 0.9960784, 0.1490196, 0.9490196, 1, 0.05,
-0.75, -4.5, -3.954895, 0.9882353, 0.1490196, 0.9019608, 1, 0.05,
-0.75, -4.25, -3.689333, 0.9215686, 0.1490196, 0.8509804, 1, 0.05,
-0.75, -4, -3.20196, 0.8, 0.1490196, 0.8, 1, 0.05,
-0.75, -3.75, -2.523474, 0.6313726, 0.1490196, 0.7490196, 1, 0.05,
-0.75, -3.5, -1.696019, 0.4235294, 0.1490196, 0.7019608, 1, 0.05,
-0.75, -3.25, -0.7704483, 0.1921569, 0.1490196, 0.6509804, 1, 0.05,
-0.75, -3, 0.196974, 0.05098039, 0.1490196, 0.6, 1, 0.05,
-0.75, -2.75, 1.148232, 0.2862745, 0.1490196, 0.5490196, 1, 0.05,
-0.75, -2.5, 2.027363, 0.5058824, 0.1490196, 0.5019608, 1, 0.05,
-0.75, -2.25, 2.784209, 0.6941177, 0.1490196, 0.4509804, 1, 0.05,
-0.75, -2, 3.377916, 0.8431373, 0.1490196, 0.4, 1, 0.05,
-0.75, -1.75, 3.780072, 0.945098, 0.1490196, 0.3490196, 1, 0.05,
-0.75, -1.5, 3.977441, 0.9960784, 0.1490196, 0.3019608, 1, 0.05,
-0.75, -1.25, 3.974463, 0.9921569, 0.1490196, 0.2509804, 1, 0.05,
-0.75, -1, 3.795938, 0.9490196, 0.1490196, 0.2, 1, 0.05,
-0.75, -0.75, 3.490712, 0.8745098, 0.1490196, 0.1490196, 1, 0.05,
-0.75, -0.5, 3.136755, 0.7843137, 0.1490196, 0.1019608, 1, 0.05,
-0.75, -0.25, 2.843016, 0.7098039, 0.1490196, 0.05098039, 1, 0.05,
-0.75, 0, 2.726555, 0.682353, 0.1490196, 0, 1, 0.05,
-0.75, 0.25, 2.843016, 0.7098039, 0.1490196, 0.05098039, 1, 0.05,
-0.75, 0.5, 3.136755, 0.7843137, 0.1490196, 0.1019608, 1, 0.05,
-0.75, 0.75, 3.490712, 0.8745098, 0.1490196, 0.1490196, 1, 0.05,
-0.75, 1, 3.795938, 0.9490196, 0.1490196, 0.2, 1, 0.05,
-0.75, 1.25, 3.974463, 0.9921569, 0.1490196, 0.2509804, 1, 0.05,
-0.75, 1.5, 3.977441, 0.9960784, 0.1490196, 0.3019608, 1, 0.05,
-0.75, 1.75, 3.780072, 0.945098, 0.1490196, 0.3490196, 1, 0.05,
-0.75, 2, 3.377916, 0.8431373, 0.1490196, 0.4, 1, 0.05,
-0.75, 2.25, 2.784209, 0.6941177, 0.1490196, 0.4509804, 1, 0.05,
-0.75, 2.5, 2.027363, 0.5058824, 0.1490196, 0.5019608, 1, 0.05,
-0.75, 2.75, 1.148232, 0.2862745, 0.1490196, 0.5490196, 1, 0.05,
-0.75, 3, 0.196974, 0.05098039, 0.1490196, 0.6, 1, 0.05,
-0.75, 3.25, -0.7704483, 0.1921569, 0.1490196, 0.6509804, 1, 0.05,
-0.75, 3.5, -1.696019, 0.4235294, 0.1490196, 0.7019608, 1, 0.05,
-0.75, 3.75, -2.523474, 0.6313726, 0.1490196, 0.7490196, 1, 0.05,
-0.75, 4, -3.20196, 0.8, 0.1490196, 0.8, 1, 0.05,
-0.75, 4.25, -3.689333, 0.9215686, 0.1490196, 0.8509804, 1, 0.05,
-0.75, 4.5, -3.954895, 0.9882353, 0.1490196, 0.9019608, 1, 0.05,
-0.75, 4.75, -3.981406, 0.9960784, 0.1490196, 0.9490196, 1, 0.05,
-0.75, 5, -3.766262, 0.9411765, 0.1490196, 1, 1, 0.05,
-0.5, -5, -3.806212, 0.9529412, 0.1019608, 1, 1, 0.05,
-0.5, -4.75, -3.991848, 0.9960784, 0.1019608, 0.9490196, 1, 0.05,
-0.5, -4.5, -3.931968, 0.9843137, 0.1019608, 0.9019608, 1, 0.05,
-0.5, -4.25, -3.630713, 0.9058824, 0.1019608, 0.8509804, 1, 0.05,
-0.5, -4, -3.107119, 0.7764706, 0.1019608, 0.8, 1, 0.05,
-0.5, -3.75, -2.393892, 0.6, 0.1019608, 0.7490196, 1, 0.05,
-0.5, -3.5, -1.535323, 0.3843137, 0.1019608, 0.7019608, 1, 0.05,
-0.5, -3.25, -0.5844758, 0.145098, 0.1019608, 0.6509804, 1, 0.05,
-0.5, -3, 0.400175, 0.1019608, 0.1019608, 0.6, 1, 0.05,
-0.5, -2.75, 1.358461, 0.3411765, 0.1019608, 0.5490196, 1, 0.05,
-0.5, -2.5, 2.232362, 0.5568628, 0.1019608, 0.5019608, 1, 0.05,
-0.5, -2.25, 2.969763, 0.7411765, 0.1019608, 0.4509804, 1, 0.05,
-0.5, -2, 3.527906, 0.8823529, 0.1019608, 0.4, 1, 0.05,
-0.5, -1.75, 3.87641, 0.9686275, 0.1019608, 0.3490196, 1, 0.05,
-0.5, -1.5, 3.999786, 1, 0.1019608, 0.3019608, 1, 0.05,
-0.5, -1.25, 3.899618, 0.9764706, 0.1019608, 0.2509804, 1, 0.05,
-0.5, -1, 3.596969, 0.8980392, 0.1019608, 0.2, 1, 0.05,
-0.5, -0.75, 3.136755, 0.7843137, 0.1019608, 0.1490196, 1, 0.05,
-0.5, -0.5, 2.598548, 0.6509804, 0.1019608, 0.1019608, 1, 0.05,
-0.5, -0.25, 2.121412, 0.5294118, 0.1019608, 0.05098039, 1, 0.05,
-0.5, 0, 1.917702, 0.4784314, 0.1019608, 0, 1, 0.05,
-0.5, 0.25, 2.121412, 0.5294118, 0.1019608, 0.05098039, 1, 0.05,
-0.5, 0.5, 2.598548, 0.6509804, 0.1019608, 0.1019608, 1, 0.05,
-0.5, 0.75, 3.136755, 0.7843137, 0.1019608, 0.1490196, 1, 0.05,
-0.5, 1, 3.596969, 0.8980392, 0.1019608, 0.2, 1, 0.05,
-0.5, 1.25, 3.899618, 0.9764706, 0.1019608, 0.2509804, 1, 0.05,
-0.5, 1.5, 3.999786, 1, 0.1019608, 0.3019608, 1, 0.05,
-0.5, 1.75, 3.87641, 0.9686275, 0.1019608, 0.3490196, 1, 0.05,
-0.5, 2, 3.527906, 0.8823529, 0.1019608, 0.4, 1, 0.05,
-0.5, 2.25, 2.969763, 0.7411765, 0.1019608, 0.4509804, 1, 0.05,
-0.5, 2.5, 2.232362, 0.5568628, 0.1019608, 0.5019608, 1, 0.05,
-0.5, 2.75, 1.358461, 0.3411765, 0.1019608, 0.5490196, 1, 0.05,
-0.5, 3, 0.400175, 0.1019608, 0.1019608, 0.6, 1, 0.05,
-0.5, 3.25, -0.5844758, 0.145098, 0.1019608, 0.6509804, 1, 0.05,
-0.5, 3.5, -1.535323, 0.3843137, 0.1019608, 0.7019608, 1, 0.05,
-0.5, 3.75, -2.393892, 0.6, 0.1019608, 0.7490196, 1, 0.05,
-0.5, 4, -3.107119, 0.7764706, 0.1019608, 0.8, 1, 0.05,
-0.5, 4.25, -3.630713, 0.9058824, 0.1019608, 0.8509804, 1, 0.05,
-0.5, 4.5, -3.931968, 0.9843137, 0.1019608, 0.9019608, 1, 0.05,
-0.5, 4.75, -3.991848, 0.9960784, 0.1019608, 0.9490196, 1, 0.05,
-0.5, 5, -3.806212, 0.9529412, 0.1019608, 1, 1, 0.05,
-0.25, -5, -3.828535, 0.9568627, 0.05098039, 1, 1, 0.05,
-0.25, -4.75, -3.996096, 1, 0.05098039, 0.9490196, 1, 0.05,
-0.25, -4.5, -3.915877, 0.9803922, 0.05098039, 0.9019608, 1, 0.05,
-0.25, -4.25, -3.59297, 0.8980392, 0.05098039, 0.8509804, 1, 0.05,
-0.25, -4, -3.047524, 0.7607843, 0.05098039, 0.8, 1, 0.05,
-0.25, -3.75, -2.313487, 0.5764706, 0.05098039, 0.7490196, 1, 0.05,
-0.25, -3.5, -1.436479, 0.3607843, 0.05098039, 0.7019608, 1, 0.05,
-0.25, -3.25, -0.4709394, 0.1176471, 0.05098039, 0.6509804, 1, 0.05,
-0.25, -3, 0.5232719, 0.1294118, 0.05098039, 0.6, 1, 0.05,
-0.25, -2.75, 1.484619, 0.372549, 0.05098039, 0.5490196, 1, 0.05,
-0.25, -2.5, 2.353746, 0.5882353, 0.05098039, 0.5019608, 1, 0.05,
-0.25, -2.25, 3.077204, 0.7686275, 0.05098039, 0.4509804, 1, 0.05,
-0.25, -2, 3.610842, 0.9019608, 0.05098039, 0.4, 1, 0.05,
-0.25, -1.75, 3.922656, 0.9803922, 0.05098039, 0.3490196, 1, 0.05,
-0.25, -1.5, 3.99498, 1, 0.05098039, 0.3019608, 1, 0.05,
-0.25, -1.25, 3.825995, 0.9568627, 0.05098039, 0.2509804, 1, 0.05,
-0.25, -1, 3.430794, 0.8588235, 0.05098039, 0.2, 1, 0.05,
-0.25, -0.75, 2.843016, 0.7098039, 0.05098039, 0.1490196, 1, 0.05,
-0.25, -0.5, 2.121412, 0.5294118, 0.05098039, 0.1019608, 1, 0.05,
-0.25, -0.25, 1.384934, 0.345098, 0.05098039, 0.05098039, 1, 0.05,
-0.25, 0, 0.9896159, 0.2470588, 0.05098039, 0, 1, 0.05,
-0.25, 0.25, 1.384934, 0.345098, 0.05098039, 0.05098039, 1, 0.05,
-0.25, 0.5, 2.121412, 0.5294118, 0.05098039, 0.1019608, 1, 0.05,
-0.25, 0.75, 2.843016, 0.7098039, 0.05098039, 0.1490196, 1, 0.05,
-0.25, 1, 3.430794, 0.8588235, 0.05098039, 0.2, 1, 0.05,
-0.25, 1.25, 3.825995, 0.9568627, 0.05098039, 0.2509804, 1, 0.05,
-0.25, 1.5, 3.99498, 1, 0.05098039, 0.3019608, 1, 0.05,
-0.25, 1.75, 3.922656, 0.9803922, 0.05098039, 0.3490196, 1, 0.05,
-0.25, 2, 3.610842, 0.9019608, 0.05098039, 0.4, 1, 0.05,
-0.25, 2.25, 3.077204, 0.7686275, 0.05098039, 0.4509804, 1, 0.05,
-0.25, 2.5, 2.353746, 0.5882353, 0.05098039, 0.5019608, 1, 0.05,
-0.25, 2.75, 1.484619, 0.372549, 0.05098039, 0.5490196, 1, 0.05,
-0.25, 3, 0.5232719, 0.1294118, 0.05098039, 0.6, 1, 0.05,
-0.25, 3.25, -0.4709394, 0.1176471, 0.05098039, 0.6509804, 1, 0.05,
-0.25, 3.5, -1.436479, 0.3607843, 0.05098039, 0.7019608, 1, 0.05,
-0.25, 3.75, -2.313487, 0.5764706, 0.05098039, 0.7490196, 1, 0.05,
-0.25, 4, -3.047524, 0.7607843, 0.05098039, 0.8, 1, 0.05,
-0.25, 4.25, -3.59297, 0.8980392, 0.05098039, 0.8509804, 1, 0.05,
-0.25, 4.5, -3.915877, 0.9803922, 0.05098039, 0.9019608, 1, 0.05,
-0.25, 4.75, -3.996096, 1, 0.05098039, 0.9490196, 1, 0.05,
-0.25, 5, -3.828535, 0.9568627, 0.05098039, 1, 1, 0.05,
0, -5, -3.835697, 0.9607843, 0, 1, 1, 0.05,
0, -4.75, -3.997171, 1, 0, 0.9490196, 1, 0.05,
0, -4.5, -3.91012, 0.9764706, 0, 0.9019608, 1, 0.05,
0, -4.25, -3.579957, 0.8941177, 0, 0.8509804, 1, 0.05,
0, -4, -3.02721, 0.7568628, 0, 0.8, 1, 0.05,
0, -3.75, -2.286245, 0.572549, 0, 0.7490196, 1, 0.05,
0, -3.5, -1.403133, 0.3490196, 0, 0.7019608, 1, 0.05,
0, -3.25, -0.4327805, 0.1098039, 0, 0.6509804, 1, 0.05,
0, -3, 0.56448, 0.1411765, 0, 0.6, 1, 0.05,
0, -2.75, 1.526644, 0.3803922, 0, 0.5490196, 1, 0.05,
0, -2.5, 2.393888, 0.6, 0, 0.5019608, 1, 0.05,
0, -2.25, 3.112293, 0.7764706, 0, 0.4509804, 1, 0.05,
0, -2, 3.63719, 0.9098039, 0, 0.4, 1, 0.05,
0, -1.75, 3.935944, 0.9843137, 0, 0.3490196, 1, 0.05,
0, -1.5, 3.98998, 0.9960784, 0, 0.3019608, 1, 0.05,
0, -1.25, 3.795938, 0.9490196, 0, 0.2509804, 1, 0.05,
0, -1, 3.365884, 0.8431373, 0, 0.2, 1, 0.05,
0, -0.75, 2.726555, 0.682353, 0, 0.1490196, 1, 0.05,
0, -0.5, 1.917702, 0.4784314, 0, 0.1019608, 1, 0.05,
0, -0.25, 0.9896159, 0.2470588, 0, 0.05098039, 1, 0.05,
0, 0, 0, 0, 0, 0, 1, 0.05,
0, 0.25, 0.9896159, 0.2470588, 0, 0.05098039, 1, 0.05,
0, 0.5, 1.917702, 0.4784314, 0, 0.1019608, 1, 0.05,
0, 0.75, 2.726555, 0.682353, 0, 0.1490196, 1, 0.05,
0, 1, 3.365884, 0.8431373, 0, 0.2, 1, 0.05,
0, 1.25, 3.795938, 0.9490196, 0, 0.2509804, 1, 0.05,
0, 1.5, 3.98998, 0.9960784, 0, 0.3019608, 1, 0.05,
0, 1.75, 3.935944, 0.9843137, 0, 0.3490196, 1, 0.05,
0, 2, 3.63719, 0.9098039, 0, 0.4, 1, 0.05,
0, 2.25, 3.112293, 0.7764706, 0, 0.4509804, 1, 0.05,
0, 2.5, 2.393888, 0.6, 0, 0.5019608, 1, 0.05,
0, 2.75, 1.526644, 0.3803922, 0, 0.5490196, 1, 0.05,
0, 3, 0.56448, 0.1411765, 0, 0.6, 1, 0.05,
0, 3.25, -0.4327805, 0.1098039, 0, 0.6509804, 1, 0.05,
0, 3.5, -1.403133, 0.3490196, 0, 0.7019608, 1, 0.05,
0, 3.75, -2.286245, 0.572549, 0, 0.7490196, 1, 0.05,
0, 4, -3.02721, 0.7568628, 0, 0.8, 1, 0.05,
0, 4.25, -3.579957, 0.8941177, 0, 0.8509804, 1, 0.05,
0, 4.5, -3.91012, 0.9764706, 0, 0.9019608, 1, 0.05,
0, 4.75, -3.997171, 1, 0, 0.9490196, 1, 0.05,
0, 5, -3.835697, 0.9607843, 0, 1, 1, 0.05,
0.25, -5, -3.828535, 0.9568627, 0.05098039, 1, 1, 0.05,
0.25, -4.75, -3.996096, 1, 0.05098039, 0.9490196, 1, 0.05,
0.25, -4.5, -3.915877, 0.9803922, 0.05098039, 0.9019608, 1, 0.05,
0.25, -4.25, -3.59297, 0.8980392, 0.05098039, 0.8509804, 1, 0.05,
0.25, -4, -3.047524, 0.7607843, 0.05098039, 0.8, 1, 0.05,
0.25, -3.75, -2.313487, 0.5764706, 0.05098039, 0.7490196, 1, 0.05,
0.25, -3.5, -1.436479, 0.3607843, 0.05098039, 0.7019608, 1, 0.05,
0.25, -3.25, -0.4709394, 0.1176471, 0.05098039, 0.6509804, 1, 0.05,
0.25, -3, 0.5232719, 0.1294118, 0.05098039, 0.6, 1, 0.05,
0.25, -2.75, 1.484619, 0.372549, 0.05098039, 0.5490196, 1, 0.05,
0.25, -2.5, 2.353746, 0.5882353, 0.05098039, 0.5019608, 1, 0.05,
0.25, -2.25, 3.077204, 0.7686275, 0.05098039, 0.4509804, 1, 0.05,
0.25, -2, 3.610842, 0.9019608, 0.05098039, 0.4, 1, 0.05,
0.25, -1.75, 3.922656, 0.9803922, 0.05098039, 0.3490196, 1, 0.05,
0.25, -1.5, 3.99498, 1, 0.05098039, 0.3019608, 1, 0.05,
0.25, -1.25, 3.825995, 0.9568627, 0.05098039, 0.2509804, 1, 0.05,
0.25, -1, 3.430794, 0.8588235, 0.05098039, 0.2, 1, 0.05,
0.25, -0.75, 2.843016, 0.7098039, 0.05098039, 0.1490196, 1, 0.05,
0.25, -0.5, 2.121412, 0.5294118, 0.05098039, 0.1019608, 1, 0.05,
0.25, -0.25, 1.384934, 0.345098, 0.05098039, 0.05098039, 1, 0.05,
0.25, 0, 0.9896159, 0.2470588, 0.05098039, 0, 1, 0.05,
0.25, 0.25, 1.384934, 0.345098, 0.05098039, 0.05098039, 1, 0.05,
0.25, 0.5, 2.121412, 0.5294118, 0.05098039, 0.1019608, 1, 0.05,
0.25, 0.75, 2.843016, 0.7098039, 0.05098039, 0.1490196, 1, 0.05,
0.25, 1, 3.430794, 0.8588235, 0.05098039, 0.2, 1, 0.05,
0.25, 1.25, 3.825995, 0.9568627, 0.05098039, 0.2509804, 1, 0.05,
0.25, 1.5, 3.99498, 1, 0.05098039, 0.3019608, 1, 0.05,
0.25, 1.75, 3.922656, 0.9803922, 0.05098039, 0.3490196, 1, 0.05,
0.25, 2, 3.610842, 0.9019608, 0.05098039, 0.4, 1, 0.05,
0.25, 2.25, 3.077204, 0.7686275, 0.05098039, 0.4509804, 1, 0.05,
0.25, 2.5, 2.353746, 0.5882353, 0.05098039, 0.5019608, 1, 0.05,
0.25, 2.75, 1.484619, 0.372549, 0.05098039, 0.5490196, 1, 0.05,
0.25, 3, 0.5232719, 0.1294118, 0.05098039, 0.6, 1, 0.05,
0.25, 3.25, -0.4709394, 0.1176471, 0.05098039, 0.6509804, 1, 0.05,
0.25, 3.5, -1.436479, 0.3607843, 0.05098039, 0.7019608, 1, 0.05,
0.25, 3.75, -2.313487, 0.5764706, 0.05098039, 0.7490196, 1, 0.05,
0.25, 4, -3.047524, 0.7607843, 0.05098039, 0.8, 1, 0.05,
0.25, 4.25, -3.59297, 0.8980392, 0.05098039, 0.8509804, 1, 0.05,
0.25, 4.5, -3.915877, 0.9803922, 0.05098039, 0.9019608, 1, 0.05,
0.25, 4.75, -3.996096, 1, 0.05098039, 0.9490196, 1, 0.05,
0.25, 5, -3.828535, 0.9568627, 0.05098039, 1, 1, 0.05,
0.5, -5, -3.806212, 0.9529412, 0.1019608, 1, 1, 0.05,
0.5, -4.75, -3.991848, 0.9960784, 0.1019608, 0.9490196, 1, 0.05,
0.5, -4.5, -3.931968, 0.9843137, 0.1019608, 0.9019608, 1, 0.05,
0.5, -4.25, -3.630713, 0.9058824, 0.1019608, 0.8509804, 1, 0.05,
0.5, -4, -3.107119, 0.7764706, 0.1019608, 0.8, 1, 0.05,
0.5, -3.75, -2.393892, 0.6, 0.1019608, 0.7490196, 1, 0.05,
0.5, -3.5, -1.535323, 0.3843137, 0.1019608, 0.7019608, 1, 0.05,
0.5, -3.25, -0.5844758, 0.145098, 0.1019608, 0.6509804, 1, 0.05,
0.5, -3, 0.400175, 0.1019608, 0.1019608, 0.6, 1, 0.05,
0.5, -2.75, 1.358461, 0.3411765, 0.1019608, 0.5490196, 1, 0.05,
0.5, -2.5, 2.232362, 0.5568628, 0.1019608, 0.5019608, 1, 0.05,
0.5, -2.25, 2.969763, 0.7411765, 0.1019608, 0.4509804, 1, 0.05,
0.5, -2, 3.527906, 0.8823529, 0.1019608, 0.4, 1, 0.05,
0.5, -1.75, 3.87641, 0.9686275, 0.1019608, 0.3490196, 1, 0.05,
0.5, -1.5, 3.999786, 1, 0.1019608, 0.3019608, 1, 0.05,
0.5, -1.25, 3.899618, 0.9764706, 0.1019608, 0.2509804, 1, 0.05,
0.5, -1, 3.596969, 0.8980392, 0.1019608, 0.2, 1, 0.05,
0.5, -0.75, 3.136755, 0.7843137, 0.1019608, 0.1490196, 1, 0.05,
0.5, -0.5, 2.598548, 0.6509804, 0.1019608, 0.1019608, 1, 0.05,
0.5, -0.25, 2.121412, 0.5294118, 0.1019608, 0.05098039, 1, 0.05,
0.5, 0, 1.917702, 0.4784314, 0.1019608, 0, 1, 0.05,
0.5, 0.25, 2.121412, 0.5294118, 0.1019608, 0.05098039, 1, 0.05,
0.5, 0.5, 2.598548, 0.6509804, 0.1019608, 0.1019608, 1, 0.05,
0.5, 0.75, 3.136755, 0.7843137, 0.1019608, 0.1490196, 1, 0.05,
0.5, 1, 3.596969, 0.8980392, 0.1019608, 0.2, 1, 0.05,
0.5, 1.25, 3.899618, 0.9764706, 0.1019608, 0.2509804, 1, 0.05,
0.5, 1.5, 3.999786, 1, 0.1019608, 0.3019608, 1, 0.05,
0.5, 1.75, 3.87641, 0.9686275, 0.1019608, 0.3490196, 1, 0.05,
0.5, 2, 3.527906, 0.8823529, 0.1019608, 0.4, 1, 0.05,
0.5, 2.25, 2.969763, 0.7411765, 0.1019608, 0.4509804, 1, 0.05,
0.5, 2.5, 2.232362, 0.5568628, 0.1019608, 0.5019608, 1, 0.05,
0.5, 2.75, 1.358461, 0.3411765, 0.1019608, 0.5490196, 1, 0.05,
0.5, 3, 0.400175, 0.1019608, 0.1019608, 0.6, 1, 0.05,
0.5, 3.25, -0.5844758, 0.145098, 0.1019608, 0.6509804, 1, 0.05,
0.5, 3.5, -1.535323, 0.3843137, 0.1019608, 0.7019608, 1, 0.05,
0.5, 3.75, -2.393892, 0.6, 0.1019608, 0.7490196, 1, 0.05,
0.5, 4, -3.107119, 0.7764706, 0.1019608, 0.8, 1, 0.05,
0.5, 4.25, -3.630713, 0.9058824, 0.1019608, 0.8509804, 1, 0.05,
0.5, 4.5, -3.931968, 0.9843137, 0.1019608, 0.9019608, 1, 0.05,
0.5, 4.75, -3.991848, 0.9960784, 0.1019608, 0.9490196, 1, 0.05,
0.5, 5, -3.806212, 0.9529412, 0.1019608, 1, 1, 0.05,
0.75, -5, -3.766262, 0.9411765, 0.1490196, 1, 1, 0.05,
0.75, -4.75, -3.981406, 0.9960784, 0.1490196, 0.9490196, 1, 0.05,
0.75, -4.5, -3.954895, 0.9882353, 0.1490196, 0.9019608, 1, 0.05,
0.75, -4.25, -3.689333, 0.9215686, 0.1490196, 0.8509804, 1, 0.05,
0.75, -4, -3.20196, 0.8, 0.1490196, 0.8, 1, 0.05,
0.75, -3.75, -2.523474, 0.6313726, 0.1490196, 0.7490196, 1, 0.05,
0.75, -3.5, -1.696019, 0.4235294, 0.1490196, 0.7019608, 1, 0.05,
0.75, -3.25, -0.7704483, 0.1921569, 0.1490196, 0.6509804, 1, 0.05,
0.75, -3, 0.196974, 0.05098039, 0.1490196, 0.6, 1, 0.05,
0.75, -2.75, 1.148232, 0.2862745, 0.1490196, 0.5490196, 1, 0.05,
0.75, -2.5, 2.027363, 0.5058824, 0.1490196, 0.5019608, 1, 0.05,
0.75, -2.25, 2.784209, 0.6941177, 0.1490196, 0.4509804, 1, 0.05,
0.75, -2, 3.377916, 0.8431373, 0.1490196, 0.4, 1, 0.05,
0.75, -1.75, 3.780072, 0.945098, 0.1490196, 0.3490196, 1, 0.05,
0.75, -1.5, 3.977441, 0.9960784, 0.1490196, 0.3019608, 1, 0.05,
0.75, -1.25, 3.974463, 0.9921569, 0.1490196, 0.2509804, 1, 0.05,
0.75, -1, 3.795938, 0.9490196, 0.1490196, 0.2, 1, 0.05,
0.75, -0.75, 3.490712, 0.8745098, 0.1490196, 0.1490196, 1, 0.05,
0.75, -0.5, 3.136755, 0.7843137, 0.1490196, 0.1019608, 1, 0.05,
0.75, -0.25, 2.843016, 0.7098039, 0.1490196, 0.05098039, 1, 0.05,
0.75, 0, 2.726555, 0.682353, 0.1490196, 0, 1, 0.05,
0.75, 0.25, 2.843016, 0.7098039, 0.1490196, 0.05098039, 1, 0.05,
0.75, 0.5, 3.136755, 0.7843137, 0.1490196, 0.1019608, 1, 0.05,
0.75, 0.75, 3.490712, 0.8745098, 0.1490196, 0.1490196, 1, 0.05,
0.75, 1, 3.795938, 0.9490196, 0.1490196, 0.2, 1, 0.05,
0.75, 1.25, 3.974463, 0.9921569, 0.1490196, 0.2509804, 1, 0.05,
0.75, 1.5, 3.977441, 0.9960784, 0.1490196, 0.3019608, 1, 0.05,
0.75, 1.75, 3.780072, 0.945098, 0.1490196, 0.3490196, 1, 0.05,
0.75, 2, 3.377916, 0.8431373, 0.1490196, 0.4, 1, 0.05,
0.75, 2.25, 2.784209, 0.6941177, 0.1490196, 0.4509804, 1, 0.05,
0.75, 2.5, 2.027363, 0.5058824, 0.1490196, 0.5019608, 1, 0.05,
0.75, 2.75, 1.148232, 0.2862745, 0.1490196, 0.5490196, 1, 0.05,
0.75, 3, 0.196974, 0.05098039, 0.1490196, 0.6, 1, 0.05,
0.75, 3.25, -0.7704483, 0.1921569, 0.1490196, 0.6509804, 1, 0.05,
0.75, 3.5, -1.696019, 0.4235294, 0.1490196, 0.7019608, 1, 0.05,
0.75, 3.75, -2.523474, 0.6313726, 0.1490196, 0.7490196, 1, 0.05,
0.75, 4, -3.20196, 0.8, 0.1490196, 0.8, 1, 0.05,
0.75, 4.25, -3.689333, 0.9215686, 0.1490196, 0.8509804, 1, 0.05,
0.75, 4.5, -3.954895, 0.9882353, 0.1490196, 0.9019608, 1, 0.05,
0.75, 4.75, -3.981406, 0.9960784, 0.1490196, 0.9490196, 1, 0.05,
0.75, 5, -3.766262, 0.9411765, 0.1490196, 1, 1, 0.05,
1, -5, -3.704739, 0.9254902, 0.2, 1, 1, 0.05,
1, -4.75, -3.959891, 0.9882353, 0.2, 0.9490196, 1, 0.05,
1, -4.5, -3.978958, 0.9960784, 0.2, 0.9019608, 1, 0.05,
1, -4.25, -3.762504, 0.9411765, 0.2, 0.8509804, 1, 0.05,
1, -4, -3.325357, 0.8313726, 0.2, 0.8, 1, 0.05,
1, -3.75, -2.69553, 0.6745098, 0.2, 0.7490196, 1, 0.05,
1, -3.5, -1.912302, 0.4784314, 0.2, 0.7019608, 1, 0.05,
1, -3.25, -1.023586, 0.254902, 0.2, 0.6509804, 1, 0.05,
1, -3, -0.08273412, 0.01960784, 0.2, 0.6, 1, 0.05,
1, -2.75, 0.8550219, 0.2156863, 0.2, 0.5490196, 1, 0.05,
1, -2.5, 1.736296, 0.4352941, 0.2, 0.5019608, 1, 0.05,
1, -2.25, 2.513238, 0.627451, 0.2, 0.4509804, 1, 0.05,
1, -2, 3.146996, 0.7882353, 0.2, 0.4, 1, 0.05,
1, -1.75, 3.610842, 0.9019608, 0.2, 0.3490196, 1, 0.05,
1, -1.5, 3.892853, 0.972549, 0.2, 0.3019608, 1, 0.05,
1, -1.25, 3.998202, 1, 0.2, 0.2509804, 1, 0.05,
1, -1, 3.951064, 0.9882353, 0.2, 0.2, 1, 0.05,
1, -0.75, 3.795938, 0.9490196, 0.2, 0.1490196, 1, 0.05,
1, -0.5, 3.596969, 0.8980392, 0.2, 0.1019608, 1, 0.05,
1, -0.25, 3.430794, 0.8588235, 0.2, 0.05098039, 1, 0.05,
1, 0, 3.365884, 0.8431373, 0.2, 0, 1, 0.05,
1, 0.25, 3.430794, 0.8588235, 0.2, 0.05098039, 1, 0.05,
1, 0.5, 3.596969, 0.8980392, 0.2, 0.1019608, 1, 0.05,
1, 0.75, 3.795938, 0.9490196, 0.2, 0.1490196, 1, 0.05,
1, 1, 3.951064, 0.9882353, 0.2, 0.2, 1, 0.05,
1, 1.25, 3.998202, 1, 0.2, 0.2509804, 1, 0.05,
1, 1.5, 3.892853, 0.972549, 0.2, 0.3019608, 1, 0.05,
1, 1.75, 3.610842, 0.9019608, 0.2, 0.3490196, 1, 0.05,
1, 2, 3.146996, 0.7882353, 0.2, 0.4, 1, 0.05,
1, 2.25, 2.513238, 0.627451, 0.2, 0.4509804, 1, 0.05,
1, 2.5, 1.736296, 0.4352941, 0.2, 0.5019608, 1, 0.05,
1, 2.75, 0.8550219, 0.2156863, 0.2, 0.5490196, 1, 0.05,
1, 3, -0.08273412, 0.01960784, 0.2, 0.6, 1, 0.05,
1, 3.25, -1.023586, 0.254902, 0.2, 0.6509804, 1, 0.05,
1, 3.5, -1.912302, 0.4784314, 0.2, 0.7019608, 1, 0.05,
1, 3.75, -2.69553, 0.6745098, 0.2, 0.7490196, 1, 0.05,
1, 4, -3.325357, 0.8313726, 0.2, 0.8, 1, 0.05,
1, 4.25, -3.762504, 0.9411765, 0.2, 0.8509804, 1, 0.05,
1, 4.5, -3.978958, 0.9960784, 0.2, 0.9019608, 1, 0.05,
1, 4.75, -3.959891, 0.9882353, 0.2, 0.9490196, 1, 0.05,
1, 5, -3.704739, 0.9254902, 0.2, 1, 1, 0.05,
1.25, -5, -3.616459, 0.9058824, 0.2509804, 1, 1, 0.05,
1.25, -4.75, -3.920797, 0.9803922, 0.2509804, 0.9490196, 1, 0.05,
1.25, -4.5, -3.996472, 1, 0.2509804, 0.9019608, 1, 0.05,
1.25, -4.25, -3.841583, 0.9607843, 0.2509804, 0.8509804, 1, 0.05,
1.25, -4, -3.468042, 0.8666667, 0.2509804, 0.8, 1, 0.05,
1.25, -3.75, -2.900606, 0.7254902, 0.2509804, 0.7490196, 1, 0.05,
1.25, -3.5, -2.175086, 0.5450981, 0.2509804, 0.7019608, 1, 0.05,
1.25, -3.25, -1.33585, 0.3333333, 0.2509804, 0.6509804, 1, 0.05,
1.25, -3, -0.4327805, 0.1098039, 0.2509804, 0.6, 1, 0.05,
1.25, -2.75, 0.4821494, 0.1215686, 0.2509804, 0.5490196, 1, 0.05,
1.25, -2.5, 1.358461, 0.3411765, 0.2509804, 0.5019608, 1, 0.05,
1.25, -2.25, 2.150727, 0.5372549, 0.2509804, 0.4509804, 1, 0.05,
1.25, -2, 2.821912, 0.7058824, 0.2509804, 0.4, 1, 0.05,
1.25, -1.75, 3.346322, 0.8352941, 0.2509804, 0.3490196, 1, 0.05,
1.25, -1.5, 3.712032, 0.9294118, 0.2509804, 0.3019608, 1, 0.05,
1.25, -1.25, 3.922656, 0.9803922, 0.2509804, 0.2509804, 1, 0.05,
1.25, -1, 3.998202, 1, 0.2509804, 0.2, 1, 0.05,
1.25, -0.75, 3.974463, 0.9921569, 0.2509804, 0.1490196, 1, 0.05,
1.25, -0.5, 3.899618, 0.9764706, 0.2509804, 0.1019608, 1, 0.05,
1.25, -0.25, 3.825995, 0.9568627, 0.2509804, 0.05098039, 1, 0.05,
1.25, 0, 3.795938, 0.9490196, 0.2509804, 0, 1, 0.05,
1.25, 0.25, 3.825995, 0.9568627, 0.2509804, 0.05098039, 1, 0.05,
1.25, 0.5, 3.899618, 0.9764706, 0.2509804, 0.1019608, 1, 0.05,
1.25, 0.75, 3.974463, 0.9921569, 0.2509804, 0.1490196, 1, 0.05,
1.25, 1, 3.998202, 1, 0.2509804, 0.2, 1, 0.05,
1.25, 1.25, 3.922656, 0.9803922, 0.2509804, 0.2509804, 1, 0.05,
1.25, 1.5, 3.712032, 0.9294118, 0.2509804, 0.3019608, 1, 0.05,
1.25, 1.75, 3.346322, 0.8352941, 0.2509804, 0.3490196, 1, 0.05,
1.25, 2, 2.821912, 0.7058824, 0.2509804, 0.4, 1, 0.05,
1.25, 2.25, 2.150727, 0.5372549, 0.2509804, 0.4509804, 1, 0.05,
1.25, 2.5, 1.358461, 0.3411765, 0.2509804, 0.5019608, 1, 0.05,
1.25, 2.75, 0.4821494, 0.1215686, 0.2509804, 0.5490196, 1, 0.05,
1.25, 3, -0.4327805, 0.1098039, 0.2509804, 0.6, 1, 0.05,
1.25, 3.25, -1.33585, 0.3333333, 0.2509804, 0.6509804, 1, 0.05,
1.25, 3.5, -2.175086, 0.5450981, 0.2509804, 0.7019608, 1, 0.05,
1.25, 3.75, -2.900606, 0.7254902, 0.2509804, 0.7490196, 1, 0.05,
1.25, 4, -3.468042, 0.8666667, 0.2509804, 0.8, 1, 0.05,
1.25, 4.25, -3.841583, 0.9607843, 0.2509804, 0.8509804, 1, 0.05,
1.25, 4.5, -3.996472, 1, 0.2509804, 0.9019608, 1, 0.05,
1.25, 4.75, -3.920797, 0.9803922, 0.2509804, 0.9490196, 1, 0.05,
1.25, 5, -3.616459, 0.9058824, 0.2509804, 1, 1, 0.05,
1.5, -5, -3.495335, 0.8745098, 0.3019608, 1, 1, 0.05,
1.5, -4.75, -3.856334, 0.9647059, 0.3019608, 0.9490196, 1, 0.05,
1.5, -4.5, -3.998075, 1, 0.3019608, 0.9019608, 1, 0.05,
1.5, -4.25, -3.915877, 0.9803922, 0.3019608, 0.8509804, 1, 0.05,
1.5, -4, -3.618347, 0.9058824, 0.3019608, 0.8, 1, 0.05,
1.5, -3.75, -3.126535, 0.7803922, 0.3019608, 0.7490196, 1, 0.05,
1.5, -3.5, -2.472307, 0.6196079, 0.3019608, 0.7019608, 1, 0.05,
1.5, -3.25, -1.696019, 0.4235294, 0.3019608, 0.6509804, 1, 0.05,
1.5, -3, -0.8436537, 0.2117647, 0.3019608, 0.6, 1, 0.05,
1.5, -2.75, 0.03640603, 0.007843138, 0.3019608, 0.5490196, 1, 0.05,
1.5, -2.5, 0.8967791, 0.2235294, 0.3019608, 0.5019608, 1, 0.05,
1.5, -2.25, 1.694448, 0.4235294, 0.3019608, 0.4509804, 1, 0.05,
1.5, -2, 2.393888, 0.6, 0.3019608, 0.4, 1, 0.05,
1.5, -1.75, 2.969763, 0.7411765, 0.3019608, 0.3490196, 1, 0.05,
1.5, -1.5, 3.409002, 0.8509804, 0.3019608, 0.3019608, 1, 0.05,
1.5, -1.25, 3.712032, 0.9294118, 0.3019608, 0.2509804, 1, 0.05,
1.5, -1, 3.892853, 0.972549, 0.3019608, 0.2, 1, 0.05,
1.5, -0.75, 3.977441, 0.9960784, 0.3019608, 0.1490196, 1, 0.05,
1.5, -0.5, 3.999786, 1, 0.3019608, 0.1019608, 1, 0.05,
1.5, -0.25, 3.99498, 1, 0.3019608, 0.05098039, 1, 0.05,
1.5, 0, 3.98998, 0.9960784, 0.3019608, 0, 1, 0.05,
1.5, 0.25, 3.99498, 1, 0.3019608, 0.05098039, 1, 0.05,
1.5, 0.5, 3.999786, 1, 0.3019608, 0.1019608, 1, 0.05,
1.5, 0.75, 3.977441, 0.9960784, 0.3019608, 0.1490196, 1, 0.05,
1.5, 1, 3.892853, 0.972549, 0.3019608, 0.2, 1, 0.05,
1.5, 1.25, 3.712032, 0.9294118, 0.3019608, 0.2509804, 1, 0.05,
1.5, 1.5, 3.409002, 0.8509804, 0.3019608, 0.3019608, 1, 0.05,
1.5, 1.75, 2.969763, 0.7411765, 0.3019608, 0.3490196, 1, 0.05,
1.5, 2, 2.393888, 0.6, 0.3019608, 0.4, 1, 0.05,
1.5, 2.25, 1.694448, 0.4235294, 0.3019608, 0.4509804, 1, 0.05,
1.5, 2.5, 0.8967791, 0.2235294, 0.3019608, 0.5019608, 1, 0.05,
1.5, 2.75, 0.03640603, 0.007843138, 0.3019608, 0.5490196, 1, 0.05,
1.5, 3, -0.8436537, 0.2117647, 0.3019608, 0.6, 1, 0.05,
1.5, 3.25, -1.696019, 0.4235294, 0.3019608, 0.6509804, 1, 0.05,
1.5, 3.5, -2.472307, 0.6196079, 0.3019608, 0.7019608, 1, 0.05,
1.5, 3.75, -3.126535, 0.7803922, 0.3019608, 0.7490196, 1, 0.05,
1.5, 4, -3.618347, 0.9058824, 0.3019608, 0.8, 1, 0.05,
1.5, 4.25, -3.915877, 0.9803922, 0.3019608, 0.8509804, 1, 0.05,
1.5, 4.5, -3.998075, 1, 0.3019608, 0.9019608, 1, 0.05,
1.5, 4.75, -3.856334, 0.9647059, 0.3019608, 0.9490196, 1, 0.05,
1.5, 5, -3.495335, 0.8745098, 0.3019608, 1, 1, 0.05,
1.75, -5, -3.334813, 0.8352941, 0.3490196, 1, 1, 0.05,
1.75, -4.75, -3.757868, 0.9411765, 0.3490196, 0.9490196, 1, 0.05,
1.75, -4.5, -3.973158, 0.9921569, 0.3490196, 0.9019608, 1, 0.05,
1.75, -4.25, -3.973028, 0.9921569, 0.3490196, 0.8509804, 1, 0.05,
1.75, -4, -3.762504, 0.9411765, 0.3490196, 0.8, 1, 0.05,
1.75, -3.75, -3.358611, 0.8392157, 0.3490196, 0.7490196, 1, 0.05,
1.75, -3.5, -2.788921, 0.6980392, 0.3490196, 0.7019608, 1, 0.05,
1.75, -3.25, -2.089429, 0.5215687, 0.3490196, 0.6509804, 1, 0.05,
1.75, -3, -1.301916, 0.3254902, 0.3490196, 0.6, 1, 0.05,
1.75, -2.75, -0.4709394, 0.1176471, 0.3490196, 0.5490196, 1, 0.05,
1.75, -2.5, 0.3593299, 0.09019608, 0.3490196, 0.5019608, 1, 0.05,
1.75, -2.25, 1.148232, 0.2862745, 0.3490196, 0.4509804, 1, 0.05,
1.75, -2, 1.861493, 0.4666667, 0.3490196, 0.4, 1, 0.05,
1.75, -1.75, 2.473644, 0.6196079, 0.3490196, 0.3490196, 1, 0.05,
1.75, -1.5, 2.969763, 0.7411765, 0.3490196, 0.3019608, 1, 0.05,
1.75, -1.25, 3.346322, 0.8352941, 0.3490196, 0.2509804, 1, 0.05,
1.75, -1, 3.610842, 0.9019608, 0.3490196, 0.2, 1, 0.05,
1.75, -0.75, 3.780072, 0.945098, 0.3490196, 0.1490196, 1, 0.05,
1.75, -0.5, 3.87641, 0.9686275, 0.3490196, 0.1019608, 1, 0.05,
1.75, -0.25, 3.922656, 0.9803922, 0.3490196, 0.05098039, 1, 0.05,
1.75, 0, 3.935944, 0.9843137, 0.3490196, 0, 1, 0.05,
1.75, 0.25, 3.922656, 0.9803922, 0.3490196, 0.05098039, 1, 0.05,
1.75, 0.5, 3.87641, 0.9686275, 0.3490196, 0.1019608, 1, 0.05,
1.75, 0.75, 3.780072, 0.945098, 0.3490196, 0.1490196, 1, 0.05,
1.75, 1, 3.610842, 0.9019608, 0.3490196, 0.2, 1, 0.05,
1.75, 1.25, 3.346322, 0.8352941, 0.3490196, 0.2509804, 1, 0.05,
1.75, 1.5, 2.969763, 0.7411765, 0.3490196, 0.3019608, 1, 0.05,
1.75, 1.75, 2.473644, 0.6196079, 0.3490196, 0.3490196, 1, 0.05,
1.75, 2, 1.861493, 0.4666667, 0.3490196, 0.4, 1, 0.05,
1.75, 2.25, 1.148232, 0.2862745, 0.3490196, 0.4509804, 1, 0.05,
1.75, 2.5, 0.3593299, 0.09019608, 0.3490196, 0.5019608, 1, 0.05,
1.75, 2.75, -0.4709394, 0.1176471, 0.3490196, 0.5490196, 1, 0.05,
1.75, 3, -1.301916, 0.3254902, 0.3490196, 0.6, 1, 0.05,
1.75, 3.25, -2.089429, 0.5215687, 0.3490196, 0.6509804, 1, 0.05,
1.75, 3.5, -2.788921, 0.6980392, 0.3490196, 0.7019608, 1, 0.05,
1.75, 3.75, -3.358611, 0.8392157, 0.3490196, 0.7490196, 1, 0.05,
1.75, 4, -3.762504, 0.9411765, 0.3490196, 0.8, 1, 0.05,
1.75, 4.25, -3.973028, 0.9921569, 0.3490196, 0.8509804, 1, 0.05,
1.75, 4.5, -3.973158, 0.9921569, 0.3490196, 0.9019608, 1, 0.05,
1.75, 4.75, -3.757868, 0.9411765, 0.3490196, 0.9490196, 1, 0.05,
1.75, 5, -3.334813, 0.8352941, 0.3490196, 1, 1, 0.05,
2, -5, -3.12838, 0.7803922, 0.4, 1, 1, 0.05,
2, -4.75, -3.616459, 0.9058824, 0.4, 0.9490196, 1, 0.05,
2, -4.5, -3.910414, 0.9764706, 0.4, 0.9019608, 1, 0.05,
2, -4.25, -3.999531, 1, 0.4, 0.8509804, 1, 0.05,
2, -4, -3.885111, 0.972549, 0.4, 0.8, 1, 0.05,
2, -3.75, -3.579957, 0.8941177, 0.4, 0.7490196, 1, 0.05,
2, -3.5, -3.107119, 0.7764706, 0.4, 0.7019608, 1, 0.05,
2, -3.25, -2.498002, 0.6235294, 0.4, 0.6509804, 1, 0.05,
2, -3, -1.789967, 0.4470588, 0.4, 0.6, 1, 0.05,
2, -2.75, -1.023586, 0.254902, 0.4, 0.5490196, 1, 0.05,
2, -2.5, -0.2397341, 0.05882353, 0.4, 0.5019608, 1, 0.05,
2, -2.25, 0.5232719, 0.1294118, 0.4, 0.4509804, 1, 0.05,
2, -2, 1.232287, 0.3098039, 0.4, 0.4, 1, 0.05,
2, -1.75, 1.861493, 0.4666667, 0.4, 0.3490196, 1, 0.05,
2, -1.5, 2.393888, 0.6, 0.4, 0.3019608, 1, 0.05,
2, -1.25, 2.821912, 0.7058824, 0.4, 0.2509804, 1, 0.05,
2, -1, 3.146996, 0.7882353, 0.4, 0.2, 1, 0.05,
2, -0.75, 3.377916, 0.8431373, 0.4, 0.1490196, 1, 0.05,
2, -0.5, 3.527906, 0.8823529, 0.4, 0.1019608, 1, 0.05,
2, -0.25, 3.610842, 0.9019608, 0.4, 0.05098039, 1, 0.05,
2, 0, 3.63719, 0.9098039, 0.4, 0, 1, 0.05,
2, 0.25, 3.610842, 0.9019608, 0.4, 0.05098039, 1, 0.05,
2, 0.5, 3.527906, 0.8823529, 0.4, 0.1019608, 1, 0.05,
2, 0.75, 3.377916, 0.8431373, 0.4, 0.1490196, 1, 0.05,
2, 1, 3.146996, 0.7882353, 0.4, 0.2, 1, 0.05,
2, 1.25, 2.821912, 0.7058824, 0.4, 0.2509804, 1, 0.05,
2, 1.5, 2.393888, 0.6, 0.4, 0.3019608, 1, 0.05,
2, 1.75, 1.861493, 0.4666667, 0.4, 0.3490196, 1, 0.05,
2, 2, 1.232287, 0.3098039, 0.4, 0.4, 1, 0.05,
2, 2.25, 0.5232719, 0.1294118, 0.4, 0.4509804, 1, 0.05,
2, 2.5, -0.2397341, 0.05882353, 0.4, 0.5019608, 1, 0.05,
2, 2.75, -1.023586, 0.254902, 0.4, 0.5490196, 1, 0.05,
2, 3, -1.789967, 0.4470588, 0.4, 0.6, 1, 0.05,
2, 3.25, -2.498002, 0.6235294, 0.4, 0.6509804, 1, 0.05,
2, 3.5, -3.107119, 0.7764706, 0.4, 0.7019608, 1, 0.05,
2, 3.75, -3.579957, 0.8941177, 0.4, 0.7490196, 1, 0.05,
2, 4, -3.885111, 0.972549, 0.4, 0.8, 1, 0.05,
2, 4.25, -3.999531, 1, 0.4, 0.8509804, 1, 0.05,
2, 4.5, -3.910414, 0.9764706, 0.4, 0.9019608, 1, 0.05,
2, 4.75, -3.616459, 0.9058824, 0.4, 0.9490196, 1, 0.05,
2, 5, -3.12838, 0.7803922, 0.4, 1, 1, 0.05,
2.25, -5, -2.870141, 0.7176471, 0.4509804, 1, 1, 0.05,
2.25, -4.75, -3.423492, 0.854902, 0.4509804, 0.9490196, 1, 0.05,
2.25, -4.5, -3.798494, 0.9490196, 0.4509804, 0.9019608, 1, 0.05,
2.25, -4.25, -3.981406, 0.9960784, 0.4509804, 0.8509804, 1, 0.05,
2.25, -4, -3.969781, 0.9921569, 0.4509804, 0.8, 1, 0.05,
2.25, -3.75, -3.772118, 0.9411765, 0.4509804, 0.7490196, 1, 0.05,
2.25, -3.5, -3.406833, 0.8509804, 0.4509804, 0.7019608, 1, 0.05,
2.25, -3.25, -2.900606, 0.7254902, 0.4509804, 0.6509804, 1, 0.05,
2.25, -3, -2.286245, 0.572549, 0.4509804, 0.6, 1, 0.05,
2.25, -2.75, -1.600213, 0.4, 0.4509804, 0.5490196, 1, 0.05,
2.25, -2.5, -0.8799956, 0.2196078, 0.4509804, 0.5019608, 1, 0.05,
2.25, -2.25, -0.1615075, 0.03921569, 0.4509804, 0.4509804, 1, 0.05,
2.25, -2, 0.5232719, 0.1294118, 0.4509804, 0.4, 1, 0.05,
2.25, -1.75, 1.148232, 0.2862745, 0.4509804, 0.3490196, 1, 0.05,
2.25, -1.5, 1.694448, 0.4235294, 0.4509804, 0.3019608, 1, 0.05,
2.25, -1.25, 2.150727, 0.5372549, 0.4509804, 0.2509804, 1, 0.05,
2.25, -1, 2.513238, 0.627451, 0.4509804, 0.2, 1, 0.05,
2.25, -0.75, 2.784209, 0.6941177, 0.4509804, 0.1490196, 1, 0.05,
2.25, -0.5, 2.969763, 0.7411765, 0.4509804, 0.1019608, 1, 0.05,
2.25, -0.25, 3.077204, 0.7686275, 0.4509804, 0.05098039, 1, 0.05,
2.25, 0, 3.112293, 0.7764706, 0.4509804, 0, 1, 0.05,
2.25, 0.25, 3.077204, 0.7686275, 0.4509804, 0.05098039, 1, 0.05,
2.25, 0.5, 2.969763, 0.7411765, 0.4509804, 0.1019608, 1, 0.05,
2.25, 0.75, 2.784209, 0.6941177, 0.4509804, 0.1490196, 1, 0.05,
2.25, 1, 2.513238, 0.627451, 0.4509804, 0.2, 1, 0.05,
2.25, 1.25, 2.150727, 0.5372549, 0.4509804, 0.2509804, 1, 0.05,
2.25, 1.5, 1.694448, 0.4235294, 0.4509804, 0.3019608, 1, 0.05,
2.25, 1.75, 1.148232, 0.2862745, 0.4509804, 0.3490196, 1, 0.05,
2.25, 2, 0.5232719, 0.1294118, 0.4509804, 0.4, 1, 0.05,
2.25, 2.25, -0.1615075, 0.03921569, 0.4509804, 0.4509804, 1, 0.05,
2.25, 2.5, -0.8799956, 0.2196078, 0.4509804, 0.5019608, 1, 0.05,
2.25, 2.75, -1.600213, 0.4, 0.4509804, 0.5490196, 1, 0.05,
2.25, 3, -2.286245, 0.572549, 0.4509804, 0.6, 1, 0.05,
2.25, 3.25, -2.900606, 0.7254902, 0.4509804, 0.6509804, 1, 0.05,
2.25, 3.5, -3.406833, 0.8509804, 0.4509804, 0.7019608, 1, 0.05,
2.25, 3.75, -3.772118, 0.9411765, 0.4509804, 0.7490196, 1, 0.05,
2.25, 4, -3.969781, 0.9921569, 0.4509804, 0.8, 1, 0.05,
2.25, 4.25, -3.981406, 0.9960784, 0.4509804, 0.8509804, 1, 0.05,
2.25, 4.5, -3.798494, 0.9490196, 0.4509804, 0.9019608, 1, 0.05,
2.25, 4.75, -3.423492, 0.854902, 0.4509804, 0.9490196, 1, 0.05,
2.25, 5, -2.870141, 0.7176471, 0.4509804, 1, 1, 0.05,
2.5, -5, -2.555439, 0.6392157, 0.5019608, 1, 1, 0.05,
2.5, -4.75, -3.171366, 0.7921569, 0.5019608, 0.9490196, 1, 0.05,
2.5, -4.5, -3.626762, 0.9058824, 0.5019608, 0.9019608, 1, 0.05,
2.5, -4.25, -3.904997, 0.9764706, 0.5019608, 0.8509804, 1, 0.05,
2.5, -4, -3.999958, 1, 0.5019608, 0.8, 1, 0.05,
2.5, -3.75, -3.915877, 0.9803922, 0.5019608, 0.7490196, 1, 0.05,
2.5, -3.5, -3.666525, 0.9176471, 0.5019608, 0.7019608, 1, 0.05,
2.5, -3.25, -3.273809, 0.8196079, 0.5019608, 0.6509804, 1, 0.05,
2.5, -3, -2.76591, 0.6901961, 0.5019608, 0.6, 1, 0.05,
2.5, -2.75, -2.175086, 0.5450981, 0.5019608, 0.5490196, 1, 0.05,
2.5, -2.5, -1.535323, 0.3843137, 0.5019608, 0.5019608, 1, 0.05,
2.5, -2.25, -0.8799956, 0.2196078, 0.5019608, 0.4509804, 1, 0.05,
2.5, -2, -0.2397341, 0.05882353, 0.5019608, 0.4, 1, 0.05,
2.5, -1.75, 0.3593299, 0.09019608, 0.5019608, 0.3490196, 1, 0.05,
2.5, -1.5, 0.8967791, 0.2235294, 0.5019608, 0.3019608, 1, 0.05,
2.5, -1.25, 1.358461, 0.3411765, 0.5019608, 0.2509804, 1, 0.05,
2.5, -1, 1.736296, 0.4352941, 0.5019608, 0.2, 1, 0.05,
2.5, -0.75, 2.027363, 0.5058824, 0.5019608, 0.1490196, 1, 0.05,
2.5, -0.5, 2.232362, 0.5568628, 0.5019608, 0.1019608, 1, 0.05,
2.5, -0.25, 2.353746, 0.5882353, 0.5019608, 0.05098039, 1, 0.05,
2.5, 0, 2.393888, 0.6, 0.5019608, 0, 1, 0.05,
2.5, 0.25, 2.353746, 0.5882353, 0.5019608, 0.05098039, 1, 0.05,
2.5, 0.5, 2.232362, 0.5568628, 0.5019608, 0.1019608, 1, 0.05,
2.5, 0.75, 2.027363, 0.5058824, 0.5019608, 0.1490196, 1, 0.05,
2.5, 1, 1.736296, 0.4352941, 0.5019608, 0.2, 1, 0.05,
2.5, 1.25, 1.358461, 0.3411765, 0.5019608, 0.2509804, 1, 0.05,
2.5, 1.5, 0.8967791, 0.2235294, 0.5019608, 0.3019608, 1, 0.05,
2.5, 1.75, 0.3593299, 0.09019608, 0.5019608, 0.3490196, 1, 0.05,
2.5, 2, -0.2397341, 0.05882353, 0.5019608, 0.4, 1, 0.05,
2.5, 2.25, -0.8799956, 0.2196078, 0.5019608, 0.4509804, 1, 0.05,
2.5, 2.5, -1.535323, 0.3843137, 0.5019608, 0.5019608, 1, 0.05,
2.5, 2.75, -2.175086, 0.5450981, 0.5019608, 0.5490196, 1, 0.05,
2.5, 3, -2.76591, 0.6901961, 0.5019608, 0.6, 1, 0.05,
2.5, 3.25, -3.273809, 0.8196079, 0.5019608, 0.6509804, 1, 0.05,
2.5, 3.5, -3.666525, 0.9176471, 0.5019608, 0.7019608, 1, 0.05,
2.5, 3.75, -3.915877, 0.9803922, 0.5019608, 0.7490196, 1, 0.05,
2.5, 4, -3.999958, 1, 0.5019608, 0.8, 1, 0.05,
2.5, 4.25, -3.904997, 0.9764706, 0.5019608, 0.8509804, 1, 0.05,
2.5, 4.5, -3.626762, 0.9058824, 0.5019608, 0.9019608, 1, 0.05,
2.5, 4.75, -3.171366, 0.7921569, 0.5019608, 0.9490196, 1, 0.05,
2.5, 5, -2.555439, 0.6392157, 0.5019608, 1, 1, 0.05,
2.75, -5, -2.181476, 0.5450981, 0.5490196, 1, 1, 0.05,
2.75, -4.75, -2.854224, 0.7137255, 0.5490196, 0.9490196, 1, 0.05,
2.75, -4.5, -3.386113, 0.8470588, 0.5490196, 0.9019608, 1, 0.05,
2.75, -4.25, -3.757868, 0.9411765, 0.5490196, 0.8509804, 1, 0.05,
2.75, -4, -3.959891, 0.9882353, 0.5490196, 0.8, 1, 0.05,
2.75, -3.75, -3.992285, 1, 0.5490196, 0.7490196, 1, 0.05,
2.75, -3.5, -3.864255, 0.9647059, 0.5490196, 0.7019608, 1, 0.05,
2.75, -3.25, -3.59297, 0.8980392, 0.5490196, 0.6509804, 1, 0.05,
2.75, -3, -3.20196, 0.8, 0.5490196, 0.6, 1, 0.05,
2.75, -2.75, -2.719214, 0.6784314, 0.5490196, 0.5490196, 1, 0.05,
2.75, -2.5, -2.175086, 0.5450981, 0.5490196, 0.5019608, 1, 0.05,
2.75, -2.25, -1.600213, 0.4, 0.5490196, 0.4509804, 1, 0.05,
2.75, -2, -1.023586, 0.254902, 0.5490196, 0.4, 1, 0.05,
2.75, -1.75, -0.4709394, 0.1176471, 0.5490196, 0.3490196, 1, 0.05,
2.75, -1.5, 0.03640603, 0.007843138, 0.5490196, 0.3019608, 1, 0.05,
2.75, -1.25, 0.4821494, 0.1215686, 0.5490196, 0.2509804, 1, 0.05,
2.75, -1, 0.8550219, 0.2156863, 0.5490196, 0.2, 1, 0.05,
2.75, -0.75, 1.148232, 0.2862745, 0.5490196, 0.1490196, 1, 0.05,
2.75, -0.5, 1.358461, 0.3411765, 0.5490196, 0.1019608, 1, 0.05,
2.75, -0.25, 1.484619, 0.372549, 0.5490196, 0.05098039, 1, 0.05,
2.75, 0, 1.526644, 0.3803922, 0.5490196, 0, 1, 0.05,
2.75, 0.25, 1.484619, 0.372549, 0.5490196, 0.05098039, 1, 0.05,
2.75, 0.5, 1.358461, 0.3411765, 0.5490196, 0.1019608, 1, 0.05,
2.75, 0.75, 1.148232, 0.2862745, 0.5490196, 0.1490196, 1, 0.05,
2.75, 1, 0.8550219, 0.2156863, 0.5490196, 0.2, 1, 0.05,
2.75, 1.25, 0.4821494, 0.1215686, 0.5490196, 0.2509804, 1, 0.05,
2.75, 1.5, 0.03640603, 0.007843138, 0.5490196, 0.3019608, 1, 0.05,
2.75, 1.75, -0.4709394, 0.1176471, 0.5490196, 0.3490196, 1, 0.05,
2.75, 2, -1.023586, 0.254902, 0.5490196, 0.4, 1, 0.05,
2.75, 2.25, -1.600213, 0.4, 0.5490196, 0.4509804, 1, 0.05,
2.75, 2.5, -2.175086, 0.5450981, 0.5490196, 0.5019608, 1, 0.05,
2.75, 2.75, -2.719214, 0.6784314, 0.5490196, 0.5490196, 1, 0.05,
2.75, 3, -3.20196, 0.8, 0.5490196, 0.6, 1, 0.05,
2.75, 3.25, -3.59297, 0.8980392, 0.5490196, 0.6509804, 1, 0.05,
2.75, 3.5, -3.864255, 0.9647059, 0.5490196, 0.7019608, 1, 0.05,
2.75, 3.75, -3.992285, 1, 0.5490196, 0.7490196, 1, 0.05,
2.75, 4, -3.959891, 0.9882353, 0.5490196, 0.8, 1, 0.05,
2.75, 4.25, -3.757868, 0.9411765, 0.5490196, 0.8509804, 1, 0.05,
2.75, 4.5, -3.386113, 0.8470588, 0.5490196, 0.9019608, 1, 0.05,
2.75, 4.75, -2.854224, 0.7137255, 0.5490196, 0.9490196, 1, 0.05,
2.75, 5, -2.181476, 0.5450981, 0.5490196, 1, 1, 0.05,
3, -5, -1.747902, 0.4352941, 0.6, 1, 1, 0.05,
3, -4.75, -2.468658, 0.6156863, 0.6, 0.9490196, 1, 0.05,
3, -4.5, -3.069811, 0.7686275, 0.6, 0.9019608, 1, 0.05,
3, -4.25, -3.529757, 0.8823529, 0.6, 0.8509804, 1, 0.05,
3, -4, -3.835697, 0.9607843, 0.6, 0.8, 1, 0.05,
3, -3.75, -3.983827, 0.9960784, 0.6, 0.7490196, 1, 0.05,
3, -3.5, -3.978958, 0.9960784, 0.6, 0.7019608, 1, 0.05,
3, -3.25, -3.833618, 0.9568627, 0.6, 0.6509804, 1, 0.05,
3, -3, -3.566729, 0.8901961, 0.6, 0.6, 1, 0.05,
3, -2.75, -3.20196, 0.8, 0.6, 0.5490196, 1, 0.05,
3, -2.5, -2.76591, 0.6901961, 0.6, 0.5019608, 1, 0.05,
3, -2.25, -2.286245, 0.572549, 0.6, 0.4509804, 1, 0.05,
3, -2, -1.789967, 0.4470588, 0.6, 0.4, 1, 0.05,
3, -1.75, -1.301916, 0.3254902, 0.6, 0.3490196, 1, 0.05,
3, -1.5, -0.8436537, 0.2117647, 0.6, 0.3019608, 1, 0.05,
3, -1.25, -0.4327805, 0.1098039, 0.6, 0.2509804, 1, 0.05,
3, -1, -0.08273412, 0.01960784, 0.6, 0.2, 1, 0.05,
3, -0.75, 0.196974, 0.05098039, 0.6, 0.1490196, 1, 0.05,
3, -0.5, 0.400175, 0.1019608, 0.6, 0.1019608, 1, 0.05,
3, -0.25, 0.5232719, 0.1294118, 0.6, 0.05098039, 1, 0.05,
3, 0, 0.56448, 0.1411765, 0.6, 0, 1, 0.05,
3, 0.25, 0.5232719, 0.1294118, 0.6, 0.05098039, 1, 0.05,
3, 0.5, 0.400175, 0.1019608, 0.6, 0.1019608, 1, 0.05,
3, 0.75, 0.196974, 0.05098039, 0.6, 0.1490196, 1, 0.05,
3, 1, -0.08273412, 0.01960784, 0.6, 0.2, 1, 0.05,
3, 1.25, -0.4327805, 0.1098039, 0.6, 0.2509804, 1, 0.05,
3, 1.5, -0.8436537, 0.2117647, 0.6, 0.3019608, 1, 0.05,
3, 1.75, -1.301916, 0.3254902, 0.6, 0.3490196, 1, 0.05,
3, 2, -1.789967, 0.4470588, 0.6, 0.4, 1, 0.05,
3, 2.25, -2.286245, 0.572549, 0.6, 0.4509804, 1, 0.05,
3, 2.5, -2.76591, 0.6901961, 0.6, 0.5019608, 1, 0.05,
3, 2.75, -3.20196, 0.8, 0.6, 0.5490196, 1, 0.05,
3, 3, -3.566729, 0.8901961, 0.6, 0.6, 1, 0.05,
3, 3.25, -3.833618, 0.9568627, 0.6, 0.6509804, 1, 0.05,
3, 3.5, -3.978958, 0.9960784, 0.6, 0.7019608, 1, 0.05,
3, 3.75, -3.983827, 0.9960784, 0.6, 0.7490196, 1, 0.05,
3, 4, -3.835697, 0.9607843, 0.6, 0.8, 1, 0.05,
3, 4.25, -3.529757, 0.8823529, 0.6, 0.8509804, 1, 0.05,
3, 4.5, -3.069811, 0.7686275, 0.6, 0.9019608, 1, 0.05,
3, 4.75, -2.468658, 0.6156863, 0.6, 0.9490196, 1, 0.05,
3, 5, -1.747902, 0.4352941, 0.6, 1, 1, 0.05,
3.25, -5, -1.257336, 0.3137255, 0.6509804, 1, 1, 0.05,
3.25, -4.75, -2.014374, 0.5019608, 0.6509804, 0.9490196, 1, 0.05,
3.25, -4.5, -2.674281, 0.6666667, 0.6509804, 0.9019608, 1, 0.05,
3.25, -4.25, -3.213524, 0.8039216, 0.6509804, 0.8509804, 1, 0.05,
3.25, -4, -3.616459, 0.9058824, 0.6509804, 0.8, 1, 0.05,
3.25, -3.75, -3.87568, 0.9686275, 0.6509804, 0.7490196, 1, 0.05,
3.25, -3.5, -3.991848, 0.9960784, 0.6509804, 0.7019608, 1, 0.05,
3.25, -3.25, -3.973028, 0.9921569, 0.6509804, 0.6509804, 1, 0.05,
3.25, -3, -3.833618, 0.9568627, 0.6509804, 0.6, 1, 0.05,
3.25, -2.75, -3.59297, 0.8980392, 0.6509804, 0.5490196, 1, 0.05,
3.25, -2.5, -3.273809, 0.8196079, 0.6509804, 0.5019608, 1, 0.05,
3.25, -2.25, -2.900606, 0.7254902, 0.6509804, 0.4509804, 1, 0.05,
3.25, -2, -2.498002, 0.6235294, 0.6509804, 0.4, 1, 0.05,
3.25, -1.75, -2.089429, 0.5215687, 0.6509804, 0.3490196, 1, 0.05,
3.25, -1.5, -1.696019, 0.4235294, 0.6509804, 0.3019608, 1, 0.05,
3.25, -1.25, -1.33585, 0.3333333, 0.6509804, 0.2509804, 1, 0.05,
3.25, -1, -1.023586, 0.254902, 0.6509804, 0.2, 1, 0.05,
3.25, -0.75, -0.7704483, 0.1921569, 0.6509804, 0.1490196, 1, 0.05,
3.25, -0.5, -0.5844758, 0.145098, 0.6509804, 0.1019608, 1, 0.05,
3.25, -0.25, -0.4709394, 0.1176471, 0.6509804, 0.05098039, 1, 0.05,
3.25, 0, -0.4327805, 0.1098039, 0.6509804, 0, 1, 0.05,
3.25, 0.25, -0.4709394, 0.1176471, 0.6509804, 0.05098039, 1, 0.05,
3.25, 0.5, -0.5844758, 0.145098, 0.6509804, 0.1019608, 1, 0.05,
3.25, 0.75, -0.7704483, 0.1921569, 0.6509804, 0.1490196, 1, 0.05,
3.25, 1, -1.023586, 0.254902, 0.6509804, 0.2, 1, 0.05,
3.25, 1.25, -1.33585, 0.3333333, 0.6509804, 0.2509804, 1, 0.05,
3.25, 1.5, -1.696019, 0.4235294, 0.6509804, 0.3019608, 1, 0.05,
3.25, 1.75, -2.089429, 0.5215687, 0.6509804, 0.3490196, 1, 0.05,
3.25, 2, -2.498002, 0.6235294, 0.6509804, 0.4, 1, 0.05,
3.25, 2.25, -2.900606, 0.7254902, 0.6509804, 0.4509804, 1, 0.05,
3.25, 2.5, -3.273809, 0.8196079, 0.6509804, 0.5019608, 1, 0.05,
3.25, 2.75, -3.59297, 0.8980392, 0.6509804, 0.5490196, 1, 0.05,
3.25, 3, -3.833618, 0.9568627, 0.6509804, 0.6, 1, 0.05,
3.25, 3.25, -3.973028, 0.9921569, 0.6509804, 0.6509804, 1, 0.05,
3.25, 3.5, -3.991848, 0.9960784, 0.6509804, 0.7019608, 1, 0.05,
3.25, 3.75, -3.87568, 0.9686275, 0.6509804, 0.7490196, 1, 0.05,
3.25, 4, -3.616459, 0.9058824, 0.6509804, 0.8, 1, 0.05,
3.25, 4.25, -3.213524, 0.8039216, 0.6509804, 0.8509804, 1, 0.05,
3.25, 4.5, -2.674281, 0.6666667, 0.6509804, 0.9019608, 1, 0.05,
3.25, 4.75, -2.014374, 0.5019608, 0.6509804, 0.9490196, 1, 0.05,
3.25, 5, -1.257336, 0.3137255, 0.6509804, 1, 1, 0.05,
3.5, -5, -0.7157543, 0.1803922, 0.7019608, 1, 1, 0.05,
3.5, -4.75, -1.494721, 0.372549, 0.7019608, 0.9490196, 1, 0.05,
3.5, -4.5, -2.199813, 0.5490196, 0.7019608, 0.9019608, 1, 0.05,
3.5, -4.25, -2.806018, 0.7019608, 0.7019608, 0.8509804, 1, 0.05,
3.5, -4, -3.295269, 0.8235294, 0.7019608, 0.8, 1, 0.05,
3.5, -3.75, -3.656937, 0.9137255, 0.7019608, 0.7490196, 1, 0.05,
3.5, -3.5, -3.88785, 0.972549, 0.7019608, 0.7019608, 1, 0.05,
3.5, -3.25, -3.991848, 0.9960784, 0.7019608, 0.6509804, 1, 0.05,
3.5, -3, -3.978958, 0.9960784, 0.7019608, 0.6, 1, 0.05,
3.5, -2.75, -3.864255, 0.9647059, 0.7019608, 0.5490196, 1, 0.05,
3.5, -2.5, -3.666525, 0.9176471, 0.7019608, 0.5019608, 1, 0.05,
3.5, -2.25, -3.406833, 0.8509804, 0.7019608, 0.4509804, 1, 0.05,
3.5, -2, -3.107119, 0.7764706, 0.7019608, 0.4, 1, 0.05,
3.5, -1.75, -2.788921, 0.6980392, 0.7019608, 0.3490196, 1, 0.05,
3.5, -1.5, -2.472307, 0.6196079, 0.7019608, 0.3019608, 1, 0.05,
3.5, -1.25, -2.175086, 0.5450981, 0.7019608, 0.2509804, 1, 0.05,
3.5, -1, -1.912302, 0.4784314, 0.7019608, 0.2, 1, 0.05,
3.5, -0.75, -1.696019, 0.4235294, 0.7019608, 0.1490196, 1, 0.05,
3.5, -0.5, -1.535323, 0.3843137, 0.7019608, 0.1019608, 1, 0.05,
3.5, -0.25, -1.436479, 0.3607843, 0.7019608, 0.05098039, 1, 0.05,
3.5, 0, -1.403133, 0.3490196, 0.7019608, 0, 1, 0.05,
3.5, 0.25, -1.436479, 0.3607843, 0.7019608, 0.05098039, 1, 0.05,
3.5, 0.5, -1.535323, 0.3843137, 0.7019608, 0.1019608, 1, 0.05,
3.5, 0.75, -1.696019, 0.4235294, 0.7019608, 0.1490196, 1, 0.05,
3.5, 1, -1.912302, 0.4784314, 0.7019608, 0.2, 1, 0.05,
3.5, 1.25, -2.175086, 0.5450981, 0.7019608, 0.2509804, 1, 0.05,
3.5, 1.5, -2.472307, 0.6196079, 0.7019608, 0.3019608, 1, 0.05,
3.5, 1.75, -2.788921, 0.6980392, 0.7019608, 0.3490196, 1, 0.05,
3.5, 2, -3.107119, 0.7764706, 0.7019608, 0.4, 1, 0.05,
3.5, 2.25, -3.406833, 0.8509804, 0.7019608, 0.4509804, 1, 0.05,
3.5, 2.5, -3.666525, 0.9176471, 0.7019608, 0.5019608, 1, 0.05,
3.5, 2.75, -3.864255, 0.9647059, 0.7019608, 0.5490196, 1, 0.05,
3.5, 3, -3.978958, 0.9960784, 0.7019608, 0.6, 1, 0.05,
3.5, 3.25, -3.991848, 0.9960784, 0.7019608, 0.6509804, 1, 0.05,
3.5, 3.5, -3.88785, 0.972549, 0.7019608, 0.7019608, 1, 0.05,
3.5, 3.75, -3.656937, 0.9137255, 0.7019608, 0.7490196, 1, 0.05,
3.5, 4, -3.295269, 0.8235294, 0.7019608, 0.8, 1, 0.05,
3.5, 4.25, -2.806018, 0.7019608, 0.7019608, 0.8509804, 1, 0.05,
3.5, 4.5, -2.199813, 0.5490196, 0.7019608, 0.9019608, 1, 0.05,
3.5, 4.75, -1.494721, 0.372549, 0.7019608, 0.9490196, 1, 0.05,
3.5, 5, -0.7157543, 0.1803922, 0.7019608, 1, 1, 0.05,
3.75, -5, -0.1327169, 0.03137255, 0.7490196, 1, 1, 0.05,
3.75, -4.75, -0.917074, 0.227451, 0.7490196, 0.9490196, 1, 0.05,
3.75, -4.5, -1.651098, 0.4117647, 0.7490196, 0.9019608, 1, 0.05,
3.75, -4.25, -2.308792, 0.5764706, 0.7490196, 0.8509804, 1, 0.05,
3.75, -4, -2.870141, 0.7176471, 0.7490196, 0.8, 1, 0.05,
3.75, -3.75, -3.321732, 0.8313726, 0.7490196, 0.7490196, 1, 0.05,
3.75, -3.5, -3.656937, 0.9137255, 0.7490196, 0.7019608, 1, 0.05,
3.75, -3.25, -3.87568, 0.9686275, 0.7490196, 0.6509804, 1, 0.05,
3.75, -3, -3.983827, 0.9960784, 0.7490196, 0.6, 1, 0.05,
3.75, -2.75, -3.992285, 1, 0.7490196, 0.5490196, 1, 0.05,
3.75, -2.5, -3.915877, 0.9803922, 0.7490196, 0.5019608, 1, 0.05,
3.75, -2.25, -3.772118, 0.9411765, 0.7490196, 0.4509804, 1, 0.05,
3.75, -2, -3.579957, 0.8941177, 0.7490196, 0.4, 1, 0.05,
3.75, -1.75, -3.358611, 0.8392157, 0.7490196, 0.3490196, 1, 0.05,
3.75, -1.5, -3.126535, 0.7803922, 0.7490196, 0.3019608, 1, 0.05,
3.75, -1.25, -2.900606, 0.7254902, 0.7490196, 0.2509804, 1, 0.05,
3.75, -1, -2.69553, 0.6745098, 0.7490196, 0.2, 1, 0.05,
3.75, -0.75, -2.523474, 0.6313726, 0.7490196, 0.1490196, 1, 0.05,
3.75, -0.5, -2.393892, 0.6, 0.7490196, 0.1019608, 1, 0.05,
3.75, -0.25, -2.313487, 0.5764706, 0.7490196, 0.05098039, 1, 0.05,
3.75, 0, -2.286245, 0.572549, 0.7490196, 0, 1, 0.05,
3.75, 0.25, -2.313487, 0.5764706, 0.7490196, 0.05098039, 1, 0.05,
3.75, 0.5, -2.393892, 0.6, 0.7490196, 0.1019608, 1, 0.05,
3.75, 0.75, -2.523474, 0.6313726, 0.7490196, 0.1490196, 1, 0.05,
3.75, 1, -2.69553, 0.6745098, 0.7490196, 0.2, 1, 0.05,
3.75, 1.25, -2.900606, 0.7254902, 0.7490196, 0.2509804, 1, 0.05,
3.75, 1.5, -3.126535, 0.7803922, 0.7490196, 0.3019608, 1, 0.05,
3.75, 1.75, -3.358611, 0.8392157, 0.7490196, 0.3490196, 1, 0.05,
3.75, 2, -3.579957, 0.8941177, 0.7490196, 0.4, 1, 0.05,
3.75, 2.25, -3.772118, 0.9411765, 0.7490196, 0.4509804, 1, 0.05,
3.75, 2.5, -3.915877, 0.9803922, 0.7490196, 0.5019608, 1, 0.05,
3.75, 2.75, -3.992285, 1, 0.7490196, 0.5490196, 1, 0.05,
3.75, 3, -3.983827, 0.9960784, 0.7490196, 0.6, 1, 0.05,
3.75, 3.25, -3.87568, 0.9686275, 0.7490196, 0.6509804, 1, 0.05,
3.75, 3.5, -3.656937, 0.9137255, 0.7490196, 0.7019608, 1, 0.05,
3.75, 3.75, -3.321732, 0.8313726, 0.7490196, 0.7490196, 1, 0.05,
3.75, 4, -2.870141, 0.7176471, 0.7490196, 0.8, 1, 0.05,
3.75, 4.25, -2.308792, 0.5764706, 0.7490196, 0.8509804, 1, 0.05,
3.75, 4.5, -1.651098, 0.4117647, 0.7490196, 0.9019608, 1, 0.05,
3.75, 4.75, -0.917074, 0.227451, 0.7490196, 0.9490196, 1, 0.05,
3.75, 5, -0.1327169, 0.03137255, 0.7490196, 1, 1, 0.05,
4, -5, 0.4786063, 0.1215686, 0.8, 1, 1, 0.05,
4, -4.75, -0.2929939, 0.07450981, 0.8, 0.9490196, 1, 0.05,
4, -4.5, -1.03755, 0.2588235, 0.8, 0.9019608, 1, 0.05,
4, -4.25, -1.728604, 0.4313726, 0.8, 0.8509804, 1, 0.05,
4, -4, -2.344705, 0.5843138, 0.8, 0.8, 1, 0.05,
4, -3.75, -2.870141, 0.7176471, 0.8, 0.7490196, 1, 0.05,
4, -3.5, -3.295269, 0.8235294, 0.8, 0.7019608, 1, 0.05,
4, -3.25, -3.616459, 0.9058824, 0.8, 0.6509804, 1, 0.05,
4, -3, -3.835697, 0.9607843, 0.8, 0.6, 1, 0.05,
4, -2.75, -3.959891, 0.9882353, 0.8, 0.5490196, 1, 0.05,
4, -2.5, -3.999958, 1, 0.8, 0.5019608, 1, 0.05,
4, -2.25, -3.969781, 0.9921569, 0.8, 0.4509804, 1, 0.05,
4, -2, -3.885111, 0.972549, 0.8, 0.4, 1, 0.05,
4, -1.75, -3.762504, 0.9411765, 0.8, 0.3490196, 1, 0.05,
4, -1.5, -3.618347, 0.9058824, 0.8, 0.3019608, 1, 0.05,
4, -1.25, -3.468042, 0.8666667, 0.8, 0.2509804, 1, 0.05,
4, -1, -3.325357, 0.8313726, 0.8, 0.2, 1, 0.05,
4, -0.75, -3.20196, 0.8, 0.8, 0.1490196, 1, 0.05,
4, -0.5, -3.107119, 0.7764706, 0.8, 0.1019608, 1, 0.05,
4, -0.25, -3.047524, 0.7607843, 0.8, 0.05098039, 1, 0.05,
4, 0, -3.02721, 0.7568628, 0.8, 0, 1, 0.05,
4, 0.25, -3.047524, 0.7607843, 0.8, 0.05098039, 1, 0.05,
4, 0.5, -3.107119, 0.7764706, 0.8, 0.1019608, 1, 0.05,
4, 0.75, -3.20196, 0.8, 0.8, 0.1490196, 1, 0.05,
4, 1, -3.325357, 0.8313726, 0.8, 0.2, 1, 0.05,
4, 1.25, -3.468042, 0.8666667, 0.8, 0.2509804, 1, 0.05,
4, 1.5, -3.618347, 0.9058824, 0.8, 0.3019608, 1, 0.05,
4, 1.75, -3.762504, 0.9411765, 0.8, 0.3490196, 1, 0.05,
4, 2, -3.885111, 0.972549, 0.8, 0.4, 1, 0.05,
4, 2.25, -3.969781, 0.9921569, 0.8, 0.4509804, 1, 0.05,
4, 2.5, -3.999958, 1, 0.8, 0.5019608, 1, 0.05,
4, 2.75, -3.959891, 0.9882353, 0.8, 0.5490196, 1, 0.05,
4, 3, -3.835697, 0.9607843, 0.8, 0.6, 1, 0.05,
4, 3.25, -3.616459, 0.9058824, 0.8, 0.6509804, 1, 0.05,
4, 3.5, -3.295269, 0.8235294, 0.8, 0.7019608, 1, 0.05,
4, 3.75, -2.870141, 0.7176471, 0.8, 0.7490196, 1, 0.05,
4, 4, -2.344705, 0.5843138, 0.8, 0.8, 1, 0.05,
4, 4.25, -1.728604, 0.4313726, 0.8, 0.8509804, 1, 0.05,
4, 4.5, -1.03755, 0.2588235, 0.8, 0.9019608, 1, 0.05,
4, 4.75, -0.2929939, 0.07450981, 0.8, 0.9490196, 1, 0.05,
4, 5, 0.4786063, 0.1215686, 0.8, 1, 1, 0.05,
4.25, -5, 1.101643, 0.2745098, 0.8509804, 1, 1, 0.05,
4.25, -4.75, 0.3618609, 0.09019608, 0.8509804, 0.9490196, 1, 0.05,
4.25, -4.5, -0.3733602, 0.09411765, 0.8509804, 0.9019608, 1, 0.05,
4.25, -4.25, -1.07763, 0.2705882, 0.8509804, 0.8509804, 1, 0.05,
4.25, -4, -1.728604, 0.4313726, 0.8509804, 0.8, 1, 0.05,
4.25, -3.75, -2.308792, 0.5764706, 0.8509804, 0.7490196, 1, 0.05,
4.25, -3.5, -2.806018, 0.7019608, 0.8509804, 0.7019608, 1, 0.05,
4.25, -3.25, -3.213524, 0.8039216, 0.8509804, 0.6509804, 1, 0.05,
4.25, -3, -3.529757, 0.8823529, 0.8509804, 0.6, 1, 0.05,
4.25, -2.75, -3.757868, 0.9411765, 0.8509804, 0.5490196, 1, 0.05,
4.25, -2.5, -3.904997, 0.9764706, 0.8509804, 0.5019608, 1, 0.05,
4.25, -2.25, -3.981406, 0.9960784, 0.8509804, 0.4509804, 1, 0.05,
4.25, -2, -3.999531, 1, 0.8509804, 0.4, 1, 0.05,
4.25, -1.75, -3.973028, 0.9921569, 0.8509804, 0.3490196, 1, 0.05,
4.25, -1.5, -3.915877, 0.9803922, 0.8509804, 0.3019608, 1, 0.05,
4.25, -1.25, -3.841583, 0.9607843, 0.8509804, 0.2509804, 1, 0.05,
4.25, -1, -3.762504, 0.9411765, 0.8509804, 0.2, 1, 0.05,
4.25, -0.75, -3.689333, 0.9215686, 0.8509804, 0.1490196, 1, 0.05,
4.25, -0.5, -3.630713, 0.9058824, 0.8509804, 0.1019608, 1, 0.05,
4.25, -0.25, -3.59297, 0.8980392, 0.8509804, 0.05098039, 1, 0.05,
4.25, 0, -3.579957, 0.8941177, 0.8509804, 0, 1, 0.05,
4.25, 0.25, -3.59297, 0.8980392, 0.8509804, 0.05098039, 1, 0.05,
4.25, 0.5, -3.630713, 0.9058824, 0.8509804, 0.1019608, 1, 0.05,
4.25, 0.75, -3.689333, 0.9215686, 0.8509804, 0.1490196, 1, 0.05,
4.25, 1, -3.762504, 0.9411765, 0.8509804, 0.2, 1, 0.05,
4.25, 1.25, -3.841583, 0.9607843, 0.8509804, 0.2509804, 1, 0.05,
4.25, 1.5, -3.915877, 0.9803922, 0.8509804, 0.3019608, 1, 0.05,
4.25, 1.75, -3.973028, 0.9921569, 0.8509804, 0.3490196, 1, 0.05,
4.25, 2, -3.999531, 1, 0.8509804, 0.4, 1, 0.05,
4.25, 2.25, -3.981406, 0.9960784, 0.8509804, 0.4509804, 1, 0.05,
4.25, 2.5, -3.904997, 0.9764706, 0.8509804, 0.5019608, 1, 0.05,
4.25, 2.75, -3.757868, 0.9411765, 0.8509804, 0.5490196, 1, 0.05,
4.25, 3, -3.529757, 0.8823529, 0.8509804, 0.6, 1, 0.05,
4.25, 3.25, -3.213524, 0.8039216, 0.8509804, 0.6509804, 1, 0.05,
4.25, 3.5, -2.806018, 0.7019608, 0.8509804, 0.7019608, 1, 0.05,
4.25, 3.75, -2.308792, 0.5764706, 0.8509804, 0.7490196, 1, 0.05,
4.25, 4, -1.728604, 0.4313726, 0.8509804, 0.8, 1, 0.05,
4.25, 4.25, -1.07763, 0.2705882, 0.8509804, 0.8509804, 1, 0.05,
4.25, 4.5, -0.3733602, 0.09411765, 0.8509804, 0.9019608, 1, 0.05,
4.25, 4.75, 0.3618609, 0.09019608, 0.8509804, 0.9490196, 1, 0.05,
4.25, 5, 1.101643, 0.2745098, 0.8509804, 1, 1, 0.05,
4.5, -5, 1.716872, 0.427451, 0.9019608, 1, 1, 0.05,
4.5, -4.75, 1.028094, 0.2588235, 0.9019608, 0.9490196, 1, 0.05,
4.5, -4.5, 0.3227516, 0.08235294, 0.9019608, 0.9019608, 1, 0.05,
4.5, -4.25, -0.3733602, 0.09411765, 0.9019608, 0.8509804, 1, 0.05,
4.5, -4, -1.03755, 0.2588235, 0.9019608, 0.8, 1, 0.05,
4.5, -3.75, -1.651098, 0.4117647, 0.9019608, 0.7490196, 1, 0.05,
4.5, -3.5, -2.199813, 0.5490196, 0.9019608, 0.7019608, 1, 0.05,
4.5, -3.25, -2.674281, 0.6666667, 0.9019608, 0.6509804, 1, 0.05,
4.5, -3, -3.069811, 0.7686275, 0.9019608, 0.6, 1, 0.05,
4.5, -2.75, -3.386113, 0.8470588, 0.9019608, 0.5490196, 1, 0.05,
4.5, -2.5, -3.626762, 0.9058824, 0.9019608, 0.5019608, 1, 0.05,
4.5, -2.25, -3.798494, 0.9490196, 0.9019608, 0.4509804, 1, 0.05,
4.5, -2, -3.910414, 0.9764706, 0.9019608, 0.4, 1, 0.05,
4.5, -1.75, -3.973158, 0.9921569, 0.9019608, 0.3490196, 1, 0.05,
4.5, -1.5, -3.998075, 1, 0.9019608, 0.3019608, 1, 0.05,
4.5, -1.25, -3.996472, 1, 0.9019608, 0.2509804, 1, 0.05,
4.5, -1, -3.978958, 0.9960784, 0.9019608, 0.2, 1, 0.05,
4.5, -0.75, -3.954895, 0.9882353, 0.9019608, 0.1490196, 1, 0.05,
4.5, -0.5, -3.931968, 0.9843137, 0.9019608, 0.1019608, 1, 0.05,
4.5, -0.25, -3.915877, 0.9803922, 0.9019608, 0.05098039, 1, 0.05,
4.5, 0, -3.91012, 0.9764706, 0.9019608, 0, 1, 0.05,
4.5, 0.25, -3.915877, 0.9803922, 0.9019608, 0.05098039, 1, 0.05,
4.5, 0.5, -3.931968, 0.9843137, 0.9019608, 0.1019608, 1, 0.05,
4.5, 0.75, -3.954895, 0.9882353, 0.9019608, 0.1490196, 1, 0.05,
4.5, 1, -3.978958, 0.9960784, 0.9019608, 0.2, 1, 0.05,
4.5, 1.25, -3.996472, 1, 0.9019608, 0.2509804, 1, 0.05,
4.5, 1.5, -3.998075, 1, 0.9019608, 0.3019608, 1, 0.05,
4.5, 1.75, -3.973158, 0.9921569, 0.9019608, 0.3490196, 1, 0.05,
4.5, 2, -3.910414, 0.9764706, 0.9019608, 0.4, 1, 0.05,
4.5, 2.25, -3.798494, 0.9490196, 0.9019608, 0.4509804, 1, 0.05,
4.5, 2.5, -3.626762, 0.9058824, 0.9019608, 0.5019608, 1, 0.05,
4.5, 2.75, -3.386113, 0.8470588, 0.9019608, 0.5490196, 1, 0.05,
4.5, 3, -3.069811, 0.7686275, 0.9019608, 0.6, 1, 0.05,
4.5, 3.25, -2.674281, 0.6666667, 0.9019608, 0.6509804, 1, 0.05,
4.5, 3.5, -2.199813, 0.5490196, 0.9019608, 0.7019608, 1, 0.05,
4.5, 3.75, -1.651098, 0.4117647, 0.9019608, 0.7490196, 1, 0.05,
4.5, 4, -1.03755, 0.2588235, 0.9019608, 0.8, 1, 0.05,
4.5, 4.25, -0.3733602, 0.09411765, 0.9019608, 0.8509804, 1, 0.05,
4.5, 4.5, 0.3227516, 0.08235294, 0.9019608, 0.9019608, 1, 0.05,
4.5, 4.75, 1.028094, 0.2588235, 0.9019608, 0.9490196, 1, 0.05,
4.5, 5, 1.716872, 0.427451, 0.9019608, 1, 1, 0.05,
4.75, -5, 2.302511, 0.5764706, 0.9490196, 1, 1, 0.05,
4.75, -4.75, 1.683208, 0.4196078, 0.9490196, 0.9490196, 1, 0.05,
4.75, -4.5, 1.028094, 0.2588235, 0.9490196, 0.9019608, 1, 0.05,
4.75, -4.25, 0.3618609, 0.09019608, 0.9490196, 0.8509804, 1, 0.05,
4.75, -4, -0.2929939, 0.07450981, 0.9490196, 0.8, 1, 0.05,
4.75, -3.75, -0.917074, 0.227451, 0.9490196, 0.7490196, 1, 0.05,
4.75, -3.5, -1.494721, 0.372549, 0.9490196, 0.7019608, 1, 0.05,
4.75, -3.25, -2.014374, 0.5019608, 0.9490196, 0.6509804, 1, 0.05,
4.75, -3, -2.468658, 0.6156863, 0.9490196, 0.6, 1, 0.05,
4.75, -2.75, -2.854224, 0.7137255, 0.9490196, 0.5490196, 1, 0.05,
4.75, -2.5, -3.171366, 0.7921569, 0.9490196, 0.5019608, 1, 0.05,
4.75, -2.25, -3.423492, 0.854902, 0.9490196, 0.4509804, 1, 0.05,
4.75, -2, -3.616459, 0.9058824, 0.9490196, 0.4, 1, 0.05,
4.75, -1.75, -3.757868, 0.9411765, 0.9490196, 0.3490196, 1, 0.05,
4.75, -1.5, -3.856334, 0.9647059, 0.9490196, 0.3019608, 1, 0.05,
4.75, -1.25, -3.920797, 0.9803922, 0.9490196, 0.2509804, 1, 0.05,
4.75, -1, -3.959891, 0.9882353, 0.9490196, 0.2, 1, 0.05,
4.75, -0.75, -3.981406, 0.9960784, 0.9490196, 0.1490196, 1, 0.05,
4.75, -0.5, -3.991848, 0.9960784, 0.9490196, 0.1019608, 1, 0.05,
4.75, -0.25, -3.996096, 1, 0.9490196, 0.05098039, 1, 0.05,
4.75, 0, -3.997171, 1, 0.9490196, 0, 1, 0.05,
4.75, 0.25, -3.996096, 1, 0.9490196, 0.05098039, 1, 0.05,
4.75, 0.5, -3.991848, 0.9960784, 0.9490196, 0.1019608, 1, 0.05,
4.75, 0.75, -3.981406, 0.9960784, 0.9490196, 0.1490196, 1, 0.05,
4.75, 1, -3.959891, 0.9882353, 0.9490196, 0.2, 1, 0.05,
4.75, 1.25, -3.920797, 0.9803922, 0.9490196, 0.2509804, 1, 0.05,
4.75, 1.5, -3.856334, 0.9647059, 0.9490196, 0.3019608, 1, 0.05,
4.75, 1.75, -3.757868, 0.9411765, 0.9490196, 0.3490196, 1, 0.05,
4.75, 2, -3.616459, 0.9058824, 0.9490196, 0.4, 1, 0.05,
4.75, 2.25, -3.423492, 0.854902, 0.9490196, 0.4509804, 1, 0.05,
4.75, 2.5, -3.171366, 0.7921569, 0.9490196, 0.5019608, 1, 0.05,
4.75, 2.75, -2.854224, 0.7137255, 0.9490196, 0.5490196, 1, 0.05,
4.75, 3, -2.468658, 0.6156863, 0.9490196, 0.6, 1, 0.05,
4.75, 3.25, -2.014374, 0.5019608, 0.9490196, 0.6509804, 1, 0.05,
4.75, 3.5, -1.494721, 0.372549, 0.9490196, 0.7019608, 1, 0.05,
4.75, 3.75, -0.917074, 0.227451, 0.9490196, 0.7490196, 1, 0.05,
4.75, 4, -0.2929939, 0.07450981, 0.9490196, 0.8, 1, 0.05,
4.75, 4.25, 0.3618609, 0.09019608, 0.9490196, 0.8509804, 1, 0.05,
4.75, 4.5, 1.028094, 0.2588235, 0.9490196, 0.9019608, 1, 0.05,
4.75, 4.75, 1.683208, 0.4196078, 0.9490196, 0.9490196, 1, 0.05,
4.75, 5, 2.302511, 0.5764706, 0.9490196, 1, 1, 0.05,
5, -5, 2.835445, 0.7098039, 1, 1, 1, 0.05,
5, -4.75, 2.302511, 0.5764706, 1, 0.9490196, 1, 0.05,
5, -4.5, 1.716872, 0.427451, 1, 0.9019608, 1, 0.05,
5, -4.25, 1.101643, 0.2745098, 1, 0.8509804, 1, 0.05,
5, -4, 0.4786063, 0.1215686, 1, 0.8, 1, 0.05,
5, -3.75, -0.1327169, 0.03137255, 1, 0.7490196, 1, 0.05,
5, -3.5, -0.7157543, 0.1803922, 1, 0.7019608, 1, 0.05,
5, -3.25, -1.257336, 0.3137255, 1, 0.6509804, 1, 0.05,
5, -3, -1.747902, 0.4352941, 1, 0.6, 1, 0.05,
5, -2.75, -2.181476, 0.5450981, 1, 0.5490196, 1, 0.05,
5, -2.5, -2.555439, 0.6392157, 1, 0.5019608, 1, 0.05,
5, -2.25, -2.870141, 0.7176471, 1, 0.4509804, 1, 0.05,
5, -2, -3.12838, 0.7803922, 1, 0.4, 1, 0.05,
5, -1.75, -3.334813, 0.8352941, 1, 0.3490196, 1, 0.05,
5, -1.5, -3.495335, 0.8745098, 1, 0.3019608, 1, 0.05,
5, -1.25, -3.616459, 0.9058824, 1, 0.2509804, 1, 0.05,
5, -1, -3.704739, 0.9254902, 1, 0.2, 1, 0.05,
5, -0.75, -3.766262, 0.9411765, 1, 0.1490196, 1, 0.05,
5, -0.5, -3.806212, 0.9529412, 1, 0.1019608, 1, 0.05,
5, -0.25, -3.828535, 0.9568627, 1, 0.05098039, 1, 0.05,
5, 0, -3.835697, 0.9607843, 1, 0, 1, 0.05,
5, 0.25, -3.828535, 0.9568627, 1, 0.05098039, 1, 0.05,
5, 0.5, -3.806212, 0.9529412, 1, 0.1019608, 1, 0.05,
5, 0.75, -3.766262, 0.9411765, 1, 0.1490196, 1, 0.05,
5, 1, -3.704739, 0.9254902, 1, 0.2, 1, 0.05,
5, 1.25, -3.616459, 0.9058824, 1, 0.2509804, 1, 0.05,
5, 1.5, -3.495335, 0.8745098, 1, 0.3019608, 1, 0.05,
5, 1.75, -3.334813, 0.8352941, 1, 0.3490196, 1, 0.05,
5, 2, -3.12838, 0.7803922, 1, 0.4, 1, 0.05,
5, 2.25, -2.870141, 0.7176471, 1, 0.4509804, 1, 0.05,
5, 2.5, -2.555439, 0.6392157, 1, 0.5019608, 1, 0.05,
5, 2.75, -2.181476, 0.5450981, 1, 0.5490196, 1, 0.05,
5, 3, -1.747902, 0.4352941, 1, 0.6, 1, 0.05,
5, 3.25, -1.257336, 0.3137255, 1, 0.6509804, 1, 0.05,
5, 3.5, -0.7157543, 0.1803922, 1, 0.7019608, 1, 0.05,
5, 3.75, -0.1327169, 0.03137255, 1, 0.7490196, 1, 0.05,
5, 4, 0.4786063, 0.1215686, 1, 0.8, 1, 0.05,
5, 4.25, 1.101643, 0.2745098, 1, 0.8509804, 1, 0.05,
5, 4.5, 1.716872, 0.427451, 1, 0.9019608, 1, 0.05,
5, 4.75, 2.302511, 0.5764706, 1, 0.9490196, 1, 0.05,
5, 5, 2.835445, 0.7098039, 1, 1, 1, 0.05
]);
var values7 = v;
var normLoc7 = gl.getAttribLocation(prog7, "aNorm");
var mvMatLoc7 = gl.getUniformLocation(prog7,"mvMatrix");
var prMatLoc7 = gl.getUniformLocation(prog7,"prMatrix");
var normMatLoc7 = gl.getUniformLocation(prog7,"normMatrix");
gl.enable(gl.DEPTH_TEST);
gl.depthFunc(gl.LEQUAL);
gl.clearDepth(1.0);
gl.clearColor(1,1,1,1);
var xOffs = yOffs = 0,  drag  = 0;
function multMV(M, v) {
return [M.m11*v[0] + M.m12*v[1] + M.m13*v[2] + M.m14*v[3],
M.m21*v[0] + M.m22*v[1] + M.m23*v[2] + M.m24*v[3],
M.m31*v[0] + M.m32*v[1] + M.m33*v[2] + M.m34*v[3],
M.m41*v[0] + M.m42*v[1] + M.m43*v[2] + M.m44*v[3]];
}
drawScene();
function drawScene(){
gl.depthMask(true);
gl.disable(gl.BLEND);
gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
// ***** subscene 1 ****
gl.viewport(0, 0, 504, 504);
gl.scissor(0, 0, 504, 504);
gl.clearColor(1, 1, 1, 1);
gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
var radius = 9.031159;
var distance = 31.72156;
var t = tan(fov[1]*PI/360);
var near = distance - radius;
var far = distance + radius;
var hlen = t*near;
var aspect = 1;
prMatrix.makeIdentity();
if (aspect > 1)
prMatrix.frustum(-hlen*aspect*zoom[1], hlen*aspect*zoom[1], 
-hlen*zoom[1], hlen*zoom[1], near, far);
else  
prMatrix.frustum(-hlen*zoom[1], hlen*zoom[1], 
-hlen*zoom[1]/aspect, hlen*zoom[1]/aspect, 
near, far);
mvMatrix.makeIdentity();
mvMatrix.translate( -0, -0, 8.583069e-05 );
mvMatrix.scale( 1, 1, 1 );   
mvMatrix.multRight( userMatrix[1] );
mvMatrix.translate(-0, -0, -31.72156);
normMatrix.makeIdentity();
normMatrix.scale( 1, 1, 1 );   
normMatrix.multRight( userMatrix[1] );
// ****** spheres object 7 *******
gl.useProgram(prog7);
gl.bindBuffer(gl.ARRAY_BUFFER, sphereBuf);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, sphereIbuf);
gl.uniformMatrix4fv( prMatLoc7, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc7, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniformMatrix4fv( normMatLoc7, false, new Float32Array(normMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.enableVertexAttribArray(normLoc7 );
gl.vertexAttribPointer(normLoc7,  3, gl.FLOAT, false, 12,  0);
gl.disableVertexAttribArray( colLoc );
var sphereNorm = new CanvasMatrix4();
sphereNorm.scale(1, 1, 1);
sphereNorm.multRight(normMatrix);
gl.uniformMatrix4fv( normMatLoc7, false, new Float32Array(sphereNorm.getAsArray()) );
for (var i = 0; i < 1681; i++) {
var sphereMV = new CanvasMatrix4();
var baseofs = i*8
var ofs = baseofs + 7;	       
var scale = values7[ofs];
sphereMV.scale(1*scale, 1*scale, 1*scale);
sphereMV.translate(values7[baseofs], 
values7[baseofs+1], 
values7[baseofs+2]);
sphereMV.multRight(mvMatrix);
gl.uniformMatrix4fv( mvMatLoc7, false, new Float32Array(sphereMV.getAsArray()) );
ofs = baseofs + 3;       
gl.vertexAttrib4f( colLoc, values7[ofs], 
values7[ofs+1], 
values7[ofs+2],
values7[ofs+3] );
gl.drawElements(gl.TRIANGLES, 384, gl.UNSIGNED_SHORT, 0);
}
gl.flush ();
}
var vpx0 = {
1: 0
};
var vpy0 = {
1: 0
};
var vpWidths = {
1: 504
};
var vpHeights = {
1: 504
};
var activeModel = {
1: 1
};
var activeProjection = {
1: 1
};
var whichSubscene = function(coords){
if (0 <= coords.x && coords.x <= 504 && 0 <= coords.y && coords.y <= 504) return(1);
return(1);
}
var translateCoords = function(subsceneid, coords){
return {x:coords.x - vpx0[subsceneid], y:coords.y - vpy0[subsceneid]};
}
var vlen = function(v) {
return sqrt(v[0]*v[0] + v[1]*v[1] + v[2]*v[2])
}
var xprod = function(a, b) {
return [a[1]*b[2] - a[2]*b[1],
a[2]*b[0] - a[0]*b[2],
a[0]*b[1] - a[1]*b[0]];
}
var screenToVector = function(x, y) {
var width = vpWidths[activeSubscene];
var height = vpHeights[activeSubscene];
var radius = max(width, height)/2.0;
var cx = width/2.0;
var cy = height/2.0;
var px = (x-cx)/radius;
var py = (y-cy)/radius;
var plen = sqrt(px*px+py*py);
if (plen > 1.e-6) { 
px = px/plen;
py = py/plen;
}
var angle = (SQRT2 - plen)/SQRT2*PI/2;
var z = sin(angle);
var zlen = sqrt(1.0 - z*z);
px = px * zlen;
py = py * zlen;
return [px, py, z];
}
var rotBase;
var trackballdown = function(x,y) {
rotBase = screenToVector(x, y);
saveMat.load(userMatrix[activeModel[activeSubscene]]);
}
var trackballmove = function(x,y) {
var rotCurrent = screenToVector(x,y);
var dot = rotBase[0]*rotCurrent[0] + 
rotBase[1]*rotCurrent[1] + 
rotBase[2]*rotCurrent[2];
var angle = acos( dot/vlen(rotBase)/vlen(rotCurrent) )*180./PI;
var axis = xprod(rotBase, rotCurrent);
userMatrix[activeModel[activeSubscene]].load(saveMat);
userMatrix[activeModel[activeSubscene]].rotate(angle, axis[0], axis[1], axis[2]);
drawScene();
}
var y0zoom = 0;
var zoom0 = 1;
var zoomdown = function(x, y) {
y0zoom = y;
zoom0 = log(zoom[activeProjection[activeSubscene]]);
}
var zoommove = function(x, y) {
zoom[activeProjection[activeSubscene]] = exp(zoom0 + (y-y0zoom)/height);
drawScene();
}
var y0fov = 0;
var fov0 = 1;
var fovdown = function(x, y) {
y0fov = y;
fov0 = fov[activeProjection[activeSubscene]];
}
var fovmove = function(x, y) {
fov[activeProjection[activeSubscene]] = max(1, min(179, fov0 + 180*(y-y0fov)/height));
drawScene();
}
var mousedown = [trackballdown, zoomdown, fovdown];
var mousemove = [trackballmove, zoommove, fovmove];
function relMouseCoords(event){
var totalOffsetX = 0;
var totalOffsetY = 0;
var currentElement = canvas;
do{
totalOffsetX += currentElement.offsetLeft;
totalOffsetY += currentElement.offsetTop;
}
while(currentElement = currentElement.offsetParent)
var canvasX = event.pageX - totalOffsetX;
var canvasY = event.pageY - totalOffsetY;
return {x:canvasX, y:canvasY}
}
canvas.onmousedown = function ( ev ){
if (!ev.which) // Use w3c defns in preference to MS
switch (ev.button) {
case 0: ev.which = 1; break;
case 1: 
case 4: ev.which = 2; break;
case 2: ev.which = 3;
}
drag = ev.which;
var f = mousedown[drag-1];
if (f) {
var coords = relMouseCoords(ev);
coords.y = height-coords.y;
activeSubscene = whichSubscene(coords);
coords = translateCoords(activeSubscene, coords);
f(coords.x, coords.y); 
ev.preventDefault();
}
}    
canvas.onmouseup = function ( ev ){	
drag = 0;
}
canvas.onmouseout = canvas.onmouseup;
canvas.onmousemove = function ( ev ){
if ( drag == 0 ) return;
var f = mousemove[drag-1];
if (f) {
var coords = relMouseCoords(ev);
coords.y = height - coords.y;
coords = translateCoords(activeSubscene, coords);
f(coords.x, coords.y);
}
}
var wheelHandler = function(ev) {
var del = 1.1;
if (ev.shiftKey) del = 1.01;
var ds = ((ev.detail || ev.wheelDelta) > 0) ? del : (1 / del);
zoom[activeProjection[activeSubscene]] *= ds;
drawScene();
ev.preventDefault();
};
canvas.addEventListener("DOMMouseScroll", wheelHandler, false);
canvas.addEventListener("mousewheel", wheelHandler, false);
}
</script>
<canvas id="testglcanvas" width="1" height="1"></canvas> 
<p id="testgldebug">
You must enable Javascript to view this page properly.</p>
<script>testglwebGLStart();</script>




## Some other possibilites

I also like using the tanh() function to replace the sin() function. When my wife was teaching and it was "Just say no to drugs" week at school I printed this one up and used the title "Beware the Black Hole of Drugs."

Try playing  around with some other trig functions and see what pops up!


