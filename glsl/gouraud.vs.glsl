varying vec4 V_Color;
uniform vec3 lightColor;
uniform vec3 lightPosition;
uniform vec3 ambientColor;
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

void main() {
    // Ambient Component
    vec3 lightVector = normalize(vec3(viewMatrix * vec4(lightPosition,0.0)));
    vec4 temp = modelViewMatrix * vec4(position, 1.0);
    vec3 viewVector = -normalize(vec3(temp));

    //normal vector and reflection vector
    vec3 normalVector = normalize(normalMatrix * normal);
    vec3 reflectionVector = normalize( 2.0 * dot(lightVector,normalVector) * normalVector - lightVector);

    // Specular Component
    float tempmax = max(0.0,dot(reflectionVector, viewVector));
    float specAmount = pow(tempmax,shininess);
    vec3 specular = specAmount * lightColor;
    float NLAngle = max (0.0, dot(normalVector, lightVector));
    vec3 diffuse =  NLAngle * lightColor;

    //fragment color
    vec3 finalColor = (kAmbient * ambientColor + kDiffuse * diffuse + kSpecular * specular);
    V_Color = vec4(finalColor, 1.0);

    // Position
    gl_Position = projectionMatrix *  modelViewMatrix * vec4(position, 1.0);
}