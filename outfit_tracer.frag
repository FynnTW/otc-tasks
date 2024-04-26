uniform sampler2D u_Tex0;
uniform float u_Time;
varying vec2 v_TexCoord;

void main() {
    vec4 texColor = texture2D(u_Tex0, v_TexCoord);
	
	//Tried to get a smooth fade effect
    float fadeFactor = (sin(u_Time * 1.0) + 1.0) * 0.5;

    // Clamp because it looks bette
    float minAlpha = 0.2;
    float maxAlpha = 0.6;
    fadeFactor = minAlpha + (maxAlpha - minAlpha) * fadeFactor;

	//change the alpha
    texColor.a *= fadeFactor;
    gl_FragColor = texColor;
}