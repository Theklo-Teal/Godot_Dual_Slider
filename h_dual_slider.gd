@tool
@icon("./IconH.svg")
extends DualSlider
class_name HDualSlider

func _is_vertical() -> bool:
	return false

func _ready() -> void:
	super()
	size_flags_vertical = Control.SIZE_FILL
	size_flags_horizontal = Control.SIZE_EXPAND_FILL

func _draw():
	super()
	draw_line(Vector2(handle_size, size.y * 0.5), Vector2(size.x - handle_size, size.y * 0.5), color_back, thickness * 0.5)
	draw_line(Vector2(range_start, size.y * 0.5), Vector2(range_stop, size.y * 0.5), [color_front, color_active][int(hover_range)], thickness * 0.5)
	
	for n in range(tick_count):
		if not ticks_on_borders and n in [0, tick_count - 1]:
			continue
		var dist = remap(n, 0, tick_count - 1, handle_size, size.x - handle_size)
		draw_line(Vector2(dist, 0), Vector2(dist, size.y), color_active, 3)
	
	draw_circle(Vector2(range_start, size.y * 0.5), handle_size, [color_handle, color_active][int(hover_start)])
	draw_circle(Vector2(range_stop, size.y * 0.5), handle_size, [color_handle, color_active][int(hover_stop)])
