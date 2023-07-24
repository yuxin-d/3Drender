varying vec4 V_ViewPosition;
varying vec4 V_Normal_VCS;

uniform vec3 lightColor;
uniform vec3 lightPosition;
uniform vec3 ambientColor;
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

varying vec3 viewVector;
varying vec3 normalVector;

// for creative
uniform int rcState;
uniform float timePassed;

uniform vec3 lightColor1;
uniform float shininess1;
uniform vec3 lightColor2;
uniform float shininess2;
uniform vec3 lightColor3;
uniform float shininess3;

void main() {

    // light and half vectors
    vec3 lightVector = normalize(vec3(viewMatrix * vec4(lightPosition,0.0)));
    vec3 halfVector = normalize( (lightVector + viewVector) / 2.0);

    // iffuse and specular
    float tempmax = max(0.0,dot(halfVector, normalVector));
    float specAmount = pow(tempmax,shininess);
    vec3 specular = specAmount * lightColor;
    float NLAngle = max (0.0, dot(normalVector, lightVector));
    vec3 diffuse =  NLAngle * lightColor;

    //fragment color
    vec3 finalColor = (kAmbient * ambientColor + kDiffuse * diffuse + kSpecular * specular);
    gl_FragColor = vec4(finalColor, 1.0);

    if (rcState == 1){
        // first layer for making a creative texture
        vec3 lightVector1 = normalize(vec3(-fract(timePassed),-fract(timePassed),1.2));
        vec3 reflectionVector1 = normalize( 2.0 * dot(lightVector1,normalVector) * normalVector - lightVector1);
        // calculate the diffuse and specular
        vec3 specular1 = float(pow(max(0.0, dot(reflectionVector1,viewVector)),shininess1)) * lightColor1;
        vec3 diffuse1 =  float(max (0.0, dot(normalVector, lightVector1))) * lightColor1;

        // second layer for making a creative texture
        vec3 lightVector2 = normalize(vec3(0.3,-fract(timePassed),-fract(timePassed)));
        vec3 reflectionVector2 = normalize( 2.0 * dot(lightVector2,normalVector) * normalVector - lightVector2);
        // calculate the diffuse and specular
        vec3 specular2 = float(pow(max(0.0, dot(reflectionVector2,viewVector)),shininess2)) * lightColor2;
        vec3 diffuse2 =  float(max (0.0, dot(normalVector, lightVector2))) * lightColor2;

        // third layer for making a creative texture
        vec3 lightVector3 = normalize(vec3(-fract(timePassed),0.5,-fract(timePassed)));
        vec3 reflectionVector3 = normalize( 2.0 * dot(lightVector3,normalVector) * normalVector - lightVector3);
        // calculate the diffuse and specular
        vec3 specular3 = float(pow(max(0.0, dot(reflectionVector3,viewVector)),shininess3)) * lightColor3;
        vec3 diffuse3 =  float(max (0.0, dot(normalVector, lightVector3))) * lightColor3;


        //compute  the fragment color, we plus the three layers together
        gl_FragColor = vec4((1.0 *kAmbient * ambientColor + (diffuse1+diffuse2+diffuse3+diffuse) * kDiffuse  + (specular1+specular2+specular3+specular) * kSpecular), 1.0);

    }

}
