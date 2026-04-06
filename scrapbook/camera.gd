extends Area2D

var dragging = false


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		dragging = true


func _input(event):
	if event is InputEventMouseButton and not event.pressed:
		dragging = false


func _process(delta):
	if dragging:
		global_position = get_global_mouse_position()
