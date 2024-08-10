extends Area2D


@export var speed := 500
@export var dmg := 2

var target : CharacterBody2D
var target_last_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var to = target.position if is_instance_valid(target) else target_last_pos
	
	if position.distance_to(target_last_pos) < 20:
		call_deferred("queue_free")
		return
	
	position = position.move_toward(to, delta * speed)
	target_last_pos = to
	look_at(to)


func _on_body_entered(body: Node2D) -> void:
	if body == target:
		body.take_dmg(dmg)
		call_deferred("queue_free")
