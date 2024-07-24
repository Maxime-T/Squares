shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 size = vec2(1./TEXTURE_PIXEL_SIZE.x, 1./TEXTURE_PIXEL_SIZE.y);
	vec2 newSize = vec2(size.x/1., size.y/1.);
	vec2 uv = vec2(floor(UV.x * newSize.x)/newSize.x, floor(UV.y * newSize.y)/newSize.y);
	COLOR = texture(TEXTURE, uv);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
