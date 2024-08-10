extends Node2D

class_name Tower

@export var projectile_type : PackedScene
@export var attack_cd_s := 1
@export var attack_range := 300
@export var attack_dmg := 6

@export var is_built := true

@onready var state_machine: StateMachine = $StateMachine


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_built:
		state_machine.transition_to("Idle")
		add_to_group("tower")
	else:
		state_machine.transition_to("Virtual")
		
