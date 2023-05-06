extends Node

# State
onready var IS_PATROLLING = $IS_PATROLLING;
onready var IS_SHOOTING = $IS_SHOOTING;
var current_state;
var prev_state;
var state_text;

#pauses
onready var out_of_action_timer = get_node("../OutOfActionTimer");
var in_action = false;
var timer_started = false;

#detect
onready var leftRayCast = get_node("../Path2D/PathFollow2D/RayCastLeft");
onready var leftRayCast2 = get_node("../Path2D/PathFollow2D/RayCastLeft2");
onready var leftRayCast3 = get_node("../Path2D/PathFollow2D/RayCastLeft3");

onready var rightRayCast = get_node("../Path2D/PathFollow2D/RayCastRight");
onready var rightRayCast2 = get_node("../Path2D/PathFollow2D/RayCastRight2");
onready var rightRayCast3 = get_node("../Path2D/PathFollow2D/RayCastRight3");

# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = IS_PATROLLING;
	
func _physics_process(delta):
	if leftRayCast.is_colliding() || leftRayCast2.is_colliding() || leftRayCast3.is_colliding():
		set_state(IS_SHOOTING, current_state, "IS_SHOOTING")
		in_action = true;
	elif rightRayCast.is_colliding() || rightRayCast2.is_colliding() || rightRayCast3.is_colliding():
		set_state(IS_SHOOTING, current_state, "IS_SHOOTING")
		in_action = true;
	elif in_action == false: 
		set_state(IS_PATROLLING, current_state, "IS_PATROLLING")
	elif timer_started == false:
		timer_started = true;
		out_of_action_timer.start();
	else:
		pass
		
	
func set_state(new_state, prev_state, text):
	if new_state == prev_state:
		pass;
	
	current_state = new_state;
	prev_state = prev_state;
	state_text = text;

func get_state():
	return current_state;

func get_state_text():
	return state_text;

func _on_OutOfActionTimer_timeout():
	in_action = false;
	timer_started = false;
