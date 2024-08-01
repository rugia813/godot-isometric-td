extends Node2D

@export var enemy_type : PackedScene
@export var target : Marker2D

var enemy_group : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_group = get_tree().root.get_node("Dev/TileMapLayer2/Enemies")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var enemy = enemy_type.instantiate()
	enemy.global_position = global_position
	enemy.target = target
	enemy.add_to_group("enemy")
	enemy_group.add_child(enemy)
