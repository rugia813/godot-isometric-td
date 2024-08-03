#extends Node
#class_name StateMachine
## Generic State Machine. Initializes states and delegates engine callbacks
## (_physics_process, _unhandled_input) to the active state.
#
#@onready var state_label = $"../StateLabel"
#
#
#@export var initial_state := NodePath()
#
#@onready var state: State = get_node(initial_state) :
	#set (val):
		#state = val
	#get:
		#return state
#@onready var _state_name := state.name
#
#
#func _init() -> void:
	#add_to_group("state_machine")
#
#
#func _ready() -> void:
	#await owner.ready
	#state.enter("")
#
#
#func _input(event: InputEvent) -> void:
	#state.input(event)
#
#
#func _process(delta: float) -> void:
	#state.process(delta)
#
#
#func _unhandled_input(event: InputEvent) -> void:
	#state.unhandled_input(event)
#
#
#func _physics_process(delta: float) -> void:
	#state.physics_process(delta)
#
#
#func transition_to(target_state_path: String, msg: Dictionary = {}) -> void:
	#print(target_state_path)
	#var prev_state_name = self.state.name
	#var target_state := get_node(target_state_path)
#
	#if not target_state:
		#return
#
	#state.exit()
	#self.state = target_state
	#state.enter(prev_state_name, msg)
#
	#if state_label:
		#state_label.text = target_state.name
