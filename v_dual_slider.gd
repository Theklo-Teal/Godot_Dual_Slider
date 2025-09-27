@tool
@icon("res://modules/Dual_Slider/IconV.svg")
extends DualSlider
class_name VDualSlider

func _is_vertical() -> bool:
	return true

func _ready() -> void:
	super()
	size_flags_vertical = Control.SIZE_EXPAND_FILL
	size_flags_horizontal = Control.SIZE_FILL

func _draw():
	super()
	draw_line(Vector2(size.x * 0.5, handle_size), Vector2(size.x * 0.5, size.y - handle_size), color_back, thickness * 0.5)
	draw_line(Vector2(size.x * 0.5, range_start), Vector2(size.x * 0.5, range_stop), [color_front, color_active][int(hover_range)], thickness * 0.5)
	
	for n in range(tick_count):
		if not ticks_on_borders and n in [0, tick_count - 1]:
			continue
		var dist = remap(n, 0, tick_count - 1, handle_size, size.y - handle_size)
		draw_line(Vector2(0, dist), Vector2(size.x, dist), color_active, 3)
	
	draw_circle(Vector2(size.x * 0.5, range_start), handle_size, [color_handle, color_active][int(hover_start)])
	draw_circle(Vector2(size.x * 0.5, range_stop), handle_size, [color_handle, color_active][int(hover_stop)])
