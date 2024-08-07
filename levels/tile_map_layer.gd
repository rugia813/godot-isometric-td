extends TileMapLayer


var is_highlighted = false


func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	var atlas_coords = get_cell_atlas_coords(coords)
	return true # atlas_coords.x == 1 and atlas_coords.y == 0 #modulated_cells.has(coords)


func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	if is_highlighted == false:
		tile_data.modulate = Color.WHITE
	else:
		var atlas_coords = get_cell_atlas_coords(coords)
		if atlas_coords.x == 1 and atlas_coords.y == 0:
			tile_data.modulate = Color(.7,1.3,.7,1)
		else:
			tile_data.modulate = Color(1,.5,.5,.9)


func toggle_highlight(on: bool) -> void:
	is_highlighted = on
	notify_runtime_tile_data_update()


func _on_builder_place_start() -> void:
	toggle_highlight(true)


func _on_builder_place_end() -> void:
	toggle_highlight(false)
