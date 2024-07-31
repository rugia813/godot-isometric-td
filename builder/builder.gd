extends Node2D

@export var tilemap : TileMapLayer
@export var tower : PackedScene

@onready var sprite = $Sprite2D


func _ready() -> void:
	tower.changed.connect(get_sprite)
	get_sprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_tile = get_global_mouse_position()
	var map_pos = tilemap.local_to_map(mouse_tile)
	var co = tilemap.map_to_local(map_pos)
	
	sprite.position = to_global(co)
	
	
func get_sprite():
	var t = tower.instantiate()
	sprite.texture = t.get_child(0).texture
