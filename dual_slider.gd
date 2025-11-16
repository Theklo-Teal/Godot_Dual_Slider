@tool
@abstract
extends Control
class_name DualSlider

signal value_changing(start:float, stop:float) ## Emits signal has the user drags the handles.
signal value_changed(start:float, stop:float) ## Emits signal when the user stops dragging the handles.

#TODO make this inherit or mimic the Range class
#TODO a "set_value_no_signal" function
#TODO allow to reverse the positive direction of the range, right-to-left, bottom-to-top

@export var minim : float = 0 : 
	set(value):
		queue_redraw()
		minim = min(value, maxim)

@export var maxim : float = 100 : 
	set(value):
		queue_redraw()
		maxim = max(value, minim)

@export var lower : float = 25 :
	set(value):
		if value >= minim:
			queue_redraw()
			lower = min(value, upper - min_span)

@export var upper : float = 75 :
	set(value):
		if value <= maxim:
			queue_redraw()
			upper = max(value, lower + min_span)

@export var min_span : float = 1 :
	set(value):
		min_span = max(abs(value), 1) 

@export_group("Options")

@export var editable : bool = true ## If `true`, the slider can be interacted with, otherwise, only in code.
#@export var scrollable : bool = true ## If `true`, the value can be changed with the mouse wheel.

@export var tick_count : int = 0 :
	set(val):
		tick_count = abs(val)
		queue_redraw()

@export var ticks_on_borders : bool = false : ## If `true`, the ticks at the extremes are displayed.
	set(val):
		ticks_on_borders = val
		queue_redraw()

@export var thickness : float = 15 : 
	set(thick):
		thickness = abs(thick)
		custom_minimum_size = Vector2.ONE * thickness
		queue_redraw()

@export var handle_size : float = 8 : 
	set(handle):
		handle_size = abs(handle)
		queue_redraw()
		
@export_group("Colors", "color_")
@export var color_back := Color("#696969") :
	set(color):
		queue_redraw()
		color_back = color
@export var color_front := Color("#a9a9a9") : 
	set(color):
		queue_redraw()
		color_front = color
@export var color_handle := Color("#a9a9a9") :
	set(color):
		queue_redraw()
		color_handle = color
@export var color_active := Color("#d3d3d3") : 
	set(color):
		queue_redraw()
		color_active = color

func _is_vertical() -> bool:
	return false

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP


var range_start : float
var range_stop : float
func _draw():
	range_start = remap(lower, minim, maxim, 0, max(size.x, size.y))
	range_stop = remap(upper, minim, maxim, 0, max(size.x, size.y))


var hover_start : bool
var hover_stop : bool
var hover_range : bool
var drag_start : bool
var drag_stop : bool
var orig_start : float
var orig_stop : float
var drag_origin : float
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var pos = [event.position.x, event.position.y][int(_is_vertical())]
		
		if not (drag_start or drag_stop):
			hover_start = abs(pos - range_start) < handle_size
			hover_stop = abs(pos - range_stop) < handle_size
			hover_range = pos > range_start + handle_size and pos < range_stop - handle_size
		
		if drag_start:
			var delta = orig_start + (pos - drag_origin)
			lower = remap(delta, 0, max(size.x, size.y), minim, maxim)
		if drag_stop and upper < maxim:
			var delta = orig_stop + (pos - drag_origin)
			upper = remap(delta, 0, max(size.x, size.y), minim, maxim)
			
		if drag_start or drag_stop:
			value_changing.emit(lower, upper)
		
		queue_redraw()
	
	if editable and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			drag_origin = [event.position.x, event.position.y][int(_is_vertical())]
			orig_start = range_start
			orig_stop = range_stop
			drag_start = hover_start or hover_range
			drag_stop = hover_stop or hover_range
		else:
			drag_start = false
			drag_stop = false
			var changed_lower = not is_equal_approx(orig_start, range_start)
			var changed_upper = not is_equal_approx(orig_stop, range_stop)
			if changed_lower or changed_upper:
				value_changed.emit(lower, upper)
