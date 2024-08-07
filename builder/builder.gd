extends Node2D

@export var terrain_tilemap : TileMapLayer
@export var tower_tilemap : TileMapLayer
@export var tower_type : PackedScene

var tower : Tower


signal place_start
signal place_end


#func _ready() -> void:
	#tower.changed.connect(get_tower)
	#get_tower()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_tile = get_global_mouse_position()
	var map_pos = tower_tilemap.local_to_map(mouse_tile)
	var co = tower_tilemap.map_to_local(map_pos)
	
	if tower:
		tower.global_position = to_global(co)


func _unhandled_input(event: InputEvent) -> void:
	# esc
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		clear_tower()
	# mouse
	elif event is InputEventMouseButton and event.is_pressed():
		# left
		if event.button_index == MOUSE_BUTTON_LEFT:
			if tower_type and tower:
				# check tile availability
				var clicked_cell = terrain_tilemap.local_to_map(terrain_tilemap.get_local_mouse_position())
				var atlas_coords = terrain_tilemap.get_cell_atlas_coords(clicked_cell)
				if (atlas_coords.x != 1 or atlas_coords.y != 0):
					return
				
				# build tower
				var mouse_tile = get_global_mouse_position()
				var map_pos = tower_tilemap.local_to_map(mouse_tile)
				var co = tower_tilemap.map_to_local(map_pos)
				
				# check if tile has tower
				var towers = get_tree().get_nodes_in_group("tower")
				for t in towers:
					if t.position == co:
						return
				
				tower.global_position = co
				tower.is_built = true
				tower.state_machine.transition_to("Idle")
				tower.add_to_group("tower")
				clear_tower()
		# right
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			clear_tower()
	
	
func get_tower():
	tower = tower_type.instantiate()
	tower.is_built = false
	get_tree().root.get_node("Dev/TileMapLayer2").add_child(tower)
	place_start.emit()

func clear_tower():
	if tower and not tower.is_built:
		tower.queue_free()
	tower = null
	place_end.emit()


func _on_main_ui_tower_selected(_tower) -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	tower_type = _tower
	get_tower()
