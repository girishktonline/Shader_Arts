void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    uv = uv * 2.0 - 1.0;
    uv.x *= iResolution.x / iResolution.y;

    float time = iTime;

    //Create layered sine waves
    float wave1 = sin(uv.x * 10.0 + time * 1.5) * 0.05;
    float wave2 = sin((uv.x + uv.y) * 8.0 - time * 1.2) * 0.03;
    float wave3 = sin(uv.y * 12.0 + time * 0.8) * 0.02;

    float waves = wave1 + wave2 + wave3;

    //Color based on wave height
    vec3 baseColor = vec3(0.0, 0.4, 0.7);
    vec3 light = vec3(0.2, 0.6, 0.9);

    float shade = smoothstep(0.0, 0.05, waves);
    vec3 color = mix(baseColor, light, shade);

    fragColor = vec4(color, 1.0);
}
