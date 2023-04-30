extends Node
#
#var loop_active = false;
#
#var current_state;
#var prev_state;
#var state_text;
#
#onready var display_text = get_node("../text");
#
#onready var IS_IDLE = get_node("IS_IDLE");
#onready var IS_SHOOTING = get_node("IS_SHOOTING");
#onready var IS_WALKING = get_node("IS_WALKING");
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	current_state = IS_IDLE;
#	prev_state = IS_WALKING;
#	state_text = "IS_IDLE";
#
#func _physics_process(delta):
#	if !loop_active:
#		loop_active = true;
#		set_state(IS_WALKING, current_state, "IS_WALKING")
#		yield(get_tree().create_timer(2), "timeout")
#		set_state(IS_IDLE, current_state, "IS_IDLE")
#		yield(get_tree().create_timer(1), "timeout")
#		loop_active = false;
#
#	display_text.clear()
#	display_text.add_text(state_text)
#
#
#
#
#
#func set_state(new_state, prev_state, text):
#	current_state = new_state;
#	prev_state = prev_state;
#	state_text = text;
#
#func get_state():
#	return current_state;
