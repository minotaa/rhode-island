shader_type canvas_item;

uniform float txr_width;
uniform float txr_height;
uniform float tile_width;
uniform float tile_height;
uniform float tile_count;

void fragment() {
	vec2 txr_size = vec2(txr_width, txr_height);
	COLOR = texture(TEXTURE,
		(mod(UV * txr_size, 1) * tile_width // offset
		+ vec2(floor(texture(TEXTURE, UV).r * tile_count) * tile_width., txr_height - tile_height) // map
		/ txr_size // normalize
	);
}