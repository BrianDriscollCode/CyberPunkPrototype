extends Node

onready var IS_JUMPING = get_node("IS_JUMPING");
onready var IS_WALKING = get_node("IS_WALKING");
onready var IS_IDLE = get_node("IS_IDLE");
onready var IS_HANGING = get_node("IS_HANGING");
onready var IS_SPRINTING = get_node("IS_SPRINTING");
onready var IS_CLIMBING = get_node("IS_CLIMBING");

var direction;
var current_state;
var prev_state;
var state_text;
onready var player = get_parent();

onready var display_text = get_node("../RichTextLabel");
var ledgeNodes;
		
func _ready():
	current_state = IS_IDLE;
	prev_state = IS_WALKING;
	state_text = "IS_IDLE"
	
#	Get all the ledge nodes in level
	if get_node("../../LeftLedgeNodes"):
		for node in get_node("../../LeftLedgeNodes").get_children():
			node.connect("area_entered", self, "_left_ledge_connected", [node])
	if get_node("../../RightLedgeNodes"):
		for node in get_node("../../RightLedgeNodes").get_children():
			node.connect("area_entered", self, "_right_ledge_connected", [node])
	
func _physics_process(delta):
	
	accept_input();
			
	display_text.clear()
	display_text.add_text(state_text)
	display_text.add_text(str(player.is_on_floor()))
	
func accept_input():
	
	#	when pressing jump on floor or while hanging
	if Input.is_action_just_pressed("jump") && player.is_on_floor() || Input.is_action_just_pressed("jump") && current_state == IS_HANGING:
		set_state(IS_JUMPING, current_state, "IS_JUMPING")
	#	set walking state with conditions for sprinting "right"
	elif Input.is_action_pressed("ui_right") && player.is_on_floor() && current_state != IS_HANGING:
		direction = "right";
		if Input.is_action_pressed("shift"):
			set_state(IS_SPRINTING, current_state, "IS_SPRINTING")
		else:
			set_state(IS_WALKING, current_state, "IS_WALKING")
	#	set walking state with conditions for sprinting "left"
	elif Input.is_action_pressed("ui_left") && player.is_on_floor() && current_state != IS_HANGING:
		direction = "left";
		if Input.is_action_pressed("shift"):
			set_state(IS_SPRINTING, current_state, "IS_SPRINTING")
		else:
			set_state(IS_WALKING, current_state, "IS_WALKING")
	else:
		if player.is_on_floor(): 
			set_state(IS_IDLE, current_state, "IS_IDLE")
	

func set_state(new_state, prev_state, text):
	# Cannot switch to walking while in the air
	if new_state == IS_WALKING && prev_state == IS_JUMPING && !player.is_on_floor():
		return;
	# When using jumpkey while hanging, switch to climbing instead
	if new_state == IS_JUMPING && prev_state == IS_HANGING:
		current_state = IS_CLIMBING;
		prev_state = prev_state;
		state_text = "IS_CLIMBING"
		return;
	current_state = new_state;
	prev_state = prev_state;
	state_text = text

func get_state():
	return current_state;

func get_state_text():
	return state_text;
	
func get_direction():
	return direction;

func set_idle():
	set_state(IS_IDLE, current_state, "IS_IDLE");

func _left_ledge_connected(body, node):
	current_state = IS_HANGING;
	player.global_position = node.global_position - Vector2(3, -4);
	state_text = "IS_HANGING"
	
func _right_ledge_connected(body, node):
	current_state = IS_HANGING;
	player.global_position = node.global_position - Vector2(-3, -4);
	state_text = "IS_HANGING"
