extends Node2D


func _process(delta: float) -> void:
	global_position = get_global_mouse_position()

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.is_pressed():
			#print("Mouse Button Pressed at: ", event.position)
		#elif event.is_released():
			#print("Mouse Button Released at: ", event.position)
