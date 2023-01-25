shader_type canvas_item;

uniform float screen_height = 270.0;

void fragment() {
	float diff_x = -0.075 * sin((100.0 * UV.y) + (1.0 * TIME));
	COLOR = texture(TEXTURE, vec2(UV.x + diff_x, UV.y));
	COLOR = mix(vec4(0.0), COLOR, float(int(UV.y * screen_height) % 2));
}