varying vec4 V_Normal_VCS;
varying vec4 V_ViewPosition;

varying vec3 viewVector;
varying vec3 normalVector;

uniform int rcState;

void main() {

    // ADJUST THESE VARIABLES TO PASS PROPER DATA TO THE FRAGMENTS

    V_ViewPosition =vec4(position,1.0);  // change to a 4x4 matrix
    V_Normal_VCS = vec4(normal, 1.0); // change the VCS

    //viewVector and normalVector
    vec4 temp = vec4(position, 1.0) * modelViewMatrix;
    vec3 viewVector = vec3(temp);
    viewVector = -normalize(viewVector);
    normalVector = normalize(normalMatrix * vec3(V_Normal_VCS));


    gl_Position = projectionMatrix *  modelViewMatrix * vec4(position, 1.0);
}