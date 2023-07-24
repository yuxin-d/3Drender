varying vec4 V_Normal_VCS;
varying vec4 V_ViewPosition;
uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightPosition;
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;
varying vec3 viewVector;
varying vec3 normalVector;

void main() {

    // ADJUST THESE VARIABLES TO PASS PROPER DATA TO THE FRAGMENTS

    V_ViewPosition =vec4(position,1.0);  // change it to 4x4 matrix
    V_Normal_VCS = vec4(normal, 1.0); // change VCS

    // viewVector and normalVector
    viewVector =  -normalize(vec3(modelViewMatrix * vec4(position,1.0)));
    normalVector = normalize(normalMatrix * vec3(V_Normal_VCS));


    gl_Position = projectionMatrix *  modelViewMatrix * vec4(position, 1.0);
}