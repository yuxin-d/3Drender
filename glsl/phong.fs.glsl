varying vec4 V_ViewPosition;
varying vec4 V_Normal_VCS;

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
    vec3 lightVector = normalize(vec3(viewMatrix * vec4(lightPosition,0.0)));
    vec3 reflectionVector = normalize( 2.0 * dot(lightVector,normalVector) * normalVector - lightVector);

    // diffuse and specular
    float specAmount = pow(max(0.0, dot(reflectionVector,viewVector)),shininess);
    vec3 specular = specAmount * lightColor;
    float NLAngle = max (0.0, dot(normalVector, lightVector));
    vec3 diffuse =  NLAngle * lightColor;

    //fragment color
    gl_FragColor = vec4((kAmbient * ambientColor + diffuse * kDiffuse  + specular * kSpecular), 1.0);
}