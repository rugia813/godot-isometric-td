extends CharacterBody2D

class_name Enemy

@export var target : Marker2D
@export var hp := 10

@onready var navAgent := $NavigationAgent2D as NavigationAgent2D
@onready var hud := $UI/EntityHUD as EntityHud

const SPEED = 100.0


func _ready() -> void:
	hud.healthbar.max_value = hp
	create_path()

func _physics_process(delta: float) -> void:
	if hp > 0:
		var direction = to_local(navAgent.get_next_path_position()).normalized()
		velocity = direction * SPEED
		move_and_slide()

func create_path():
	navAgent.target_position = target.global_position


func take_dmg(amt):
	hp -= amt
	hud.healthbar.value = hp
	if hp <= 0:
		die()

	
func die():
	hp = 0
	remove_from_group("enemy")
	$CollisionShape2D.set_deferred("disabled", true)
	
	$AnimationPlayer.play("death")
	await $AnimationPlayer.animation_finished
	
	$CorpseTimer.start()
	await $CorpseTimer.timeout
	
	var tween := get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.25)
	await tween.finished
	
	call_deferred("queue_free")

func _on_timer_timeout() -> void:
	create_path()
