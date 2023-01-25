shader_type canvas_item;

void fragment() {
	float diff_y = 0.075 * sin((5.0 * UV.x) + (TIME * 1.0));
	COLOR = texture(TEXTURE, vec2(UV.x, UV.y + diff_y));
}