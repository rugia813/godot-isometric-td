extends CharacterBody2D


@export var target : Marker2D

const SPEED = 100.0
@onready var navAgent := $NavigationAgent2D

func _ready() -> void:
	create_path()

func _physics_process(delta: float) -> void:
	var direction = to_local(navAgent.get_next_path_position()).normalized()
	velocity = direction * SPEED
	move_and_slide()

func create_path():
	navAgent.target_position = target.global_position

func _on_timer_timeout() -> void:
	create_path()
