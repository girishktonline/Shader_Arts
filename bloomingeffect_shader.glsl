void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 center = vec2(0.5, 0.5);
    vec3 baseColor = vec3(1.0, 1.0, 0.3); // Yellow glow

    float time = iTime;

    // Make radius pulse over time
    float pulse = 0.03 * sin(time * 2.0);
    float radius = 0.2 + pulse;

    // Main core glow
    float d = distance(uv, center);
    float intensity = smoothstep(radius, radius - 0.01, d);

    // Animated bloom layers
    float bloom = 0.0;
    bloom += smoothstep(radius + 0.05, radius + 0.02, d) * 0.2;
    bloom += smoothstep(radius + 0.10, radius + 0.07, d) * 0.15;
    bloom += smoothstep(radius + 0.15, radius + 0.12, d) * 0.1;
    bloom += smoothstep(radius + 0.20, radius + 0.17, d) * 0.07;
    bloom += smoothstep(radius + 0.25, radius + 0.22, d) * 0.05;

    // Combine base + bloom
    vec3 color = baseColor * (intensity + bloom);

    // Simple tone mapping
    color = 1.0 - exp(-color);

    fragColor = vec4(color, 1.0);
}
