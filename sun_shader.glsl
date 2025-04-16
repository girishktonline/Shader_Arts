float noise(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float fbm(vec2 p) {
    float value = 0.0;
    float amplitude = 0.5;
    for (int i = 0; i < 5; i++) {
        value += noise(p) * amplitude;
        p *= 2.0;
        amplitude *= 0.5;
    }
    return value;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;
    uv = uv * 2.0 - 1.0;
    uv.x *= iResolution.x / iResolution.y;

    float t = iTime * 0.7;
    float r = length(uv);
    float sphere = smoothstep(0.4, 0.39, r);

    vec2 fireUV = uv * 2.0;
    fireUV.y += t * 0.5;

    float f = fbm(fireUV * 3.0);
    float heat = smoothstep(0.0, 1.0, f + 0.3 - r * 1.5);

    float beat = texture(iChannel0, vec2(0.1, 0.25)).x;
    heat *= 1.0 + beat * 1.2;

    vec3 sunColor = mix(vec3(1.0, 0.5, 0.0), vec3(1.0, 1.0, 0.5), heat);
    vec3 glow = vec3(1.0) * (1.0 - sphere);

    vec3 finalColor = mix(glow, sunColor, sphere);

    fragColor = vec4(finalColor, 1.0);
}
