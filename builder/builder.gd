extends Node2D

@export var tilemap : TileMapLayer
@export var tower_type : PackedScene

var tower : Tower

#func _ready() -> void:
	#tower.changed.connect(get_tower)
	#get_tower()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_tile = get_global_mouse_position()
	var map_pos = tilemap.local_to_map(mouse_tile)
	var co = tilemap.map_to_local(map_pos)
	
	if tower:
		tower.global_position = to_global(co)


func _input(event: InputEvent) -> void:		
	# esc
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		clear_tower()
	# mouse
	elif event is InputEventMouseButton and event.is_pressed():
		# left
		if event.button_index == MOUSE_BUTTON_LEFT:
			if tower_type and tower:
				var mouse_tile = get_global_mouse_position()
				var map_pos = tilemap.local_to_map(mouse_tile)
				var co = tilemap.map_to_local(map_pos)
				
				#var id = tilemap.get_cell_source_id(map_pos)
				#print(map_pos, id)
				#tilemap.set_cell(map_pos, 0)
				
				tower.global_position = co
				tower.is_built = true
				tower.state_machine.transition_to("Idle")
				clear_tower()
		# right
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			clear_tower()
	
	
func get_tower():
	tower = tower_type.instantiate()
	get_tree().root.add_child(tower)

func clear_tower():
	if not tower.is_built:
		tower.queue_free()
	tower = null


func _on_main_ui_tower_selected(_tower) -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	tower_type = _tower
	get_tower()
