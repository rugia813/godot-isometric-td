extends Camera2D

@export var zoom_speed: float = 0.1	# Speed of zooming
@export var min_zoom: Vector2 = Vector2(0.5, 0.5)	# Minimum zoom level
@export var max_zoom: Vector2 = Vector2(1, 1)	# Maximum zoom level

func _input(event: InputEvent) -> void:
	# Check if the event is a mouse wheel event
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			# Zoom in
			zoom = zoom - Vector2(zoom_speed, zoom_speed)
			zoom = zoom.clamp(min_zoom, max_zoom) # Clamp zoom to limits

		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			# Zoom out
			zoom = zoom + Vector2(zoom_speed, zoom_speed)
			zoom = zoom.clamp(min_zoom, max_zoom) # Clamp zoom to limits
