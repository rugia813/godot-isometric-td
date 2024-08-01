extends Node2D


@export var projectile_type : PackedScene
@export var attack_cd_s := 1
@export var attack_range := 300
@export var attack_dmg := 1


@onready var attack_range_area : Area2D = $AttackRange
@onready var attack_cd_timer : Timer = $AttackCDTimer
@onready var attack_point : Marker2D = $AttackPoint

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if attack_cd_timer.is_stopped():
		attack()


# Function to find an entity in group "0" that is inside this Area2D
func find_entity_in_area():
	var entities_in_area = attack_range_area.get_overlapping_bodies()

	# Iterate through the overlapping bodies
	for entity in entities_in_area:
		# Check if the entity is in group "0"
		if entity.is_in_group("enemy"):
			return entity
			
	return null

func attack():
	var enemy_in_range = find_entity_in_area()
	if enemy_in_range:
		var projectile = projectile_type.instantiate()
		projectile.target = enemy_in_range
		projectile.position = attack_point.global_position
		get_tree().root.add_child(projectile)
		
		attack_cd_timer.start()
	
		


func _on_attack_cd_timer_timeout() -> void:
	attack()
