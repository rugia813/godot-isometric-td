extends State

@onready var parent : Tower = owner

func enter(_msg: Dictionary = {}) -> void:
	parent.modulate = Color(1,1,1,0.5)
	

func exit():
	parent.modulate = Color(1,1,1,1)
