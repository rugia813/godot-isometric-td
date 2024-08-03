extends Control

signal tower_selected

@onready var tower_container = $Panel/VFlowContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var towers = Game.available_towers
	for tower in towers:
		var path = tower.get_path()
		var text = path.right(-path.rfind("/") - 1).left(-5)
		
		var button = Button.new()
		button.text = text
		button.pressed.connect(_on_button_pressed.bind(tower))
		tower_container.add_child(button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed(tower) -> void:
	tower_selected.emit(tower)
