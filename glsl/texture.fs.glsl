// Create shared variable. The value is given as the interpolation between normals computed in the vertex shader
varying vec2 textureCoodinate;
uniform sampler2D rocksTexture;
void main() {

    // LOOK UP THE COLOR IN THE TEXTURE
    vec4 texColor = texture2D(rocksTexture, textureCoodinate);

    // Set final rendered color according to the surface normal
    gl_FragColor = texColor;
}

