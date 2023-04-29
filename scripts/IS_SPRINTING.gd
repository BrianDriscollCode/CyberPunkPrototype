extends Node

onready var sprite = get_node("../../AnimatedSprite");
onready var playerState = get_parent();
onready var player = get_parent().get_parent();

const SPEED = 140
const UP = Vector2(0, -1)
const JUMP_SPEED = 250
var character_motion = Vector2(0,0)
var jump_gravity_increment = 10

var gravity = 10;

var apply_gravity = true;

var is_current_state = false;

func _physics_process(delta):
	check_if_state();
		
	if is_current_state:
		character_motion.y = gravity;
		sprite.play("run");
		basic_movement();
		player.move_and_slide(character_motion, UP)

func check_if_state():
	if playerState.get_state() == self:
		is_current_state = true;
	else:
		is_current_state = false;
		
func basic_movement():
		if Input.is_action_pressed("ui_right"):
			character_motion.x = SPEED 
			sprite.set_flip_h(false);
#			if is_on_floor():
#				sprite.play("walk");
		elif Input.is_action_pressed("ui_left"):
			character_motion.x = -SPEED 
			sprite.set_flip_h(true);
#			if is_on_floor():
#				sprite.play("walk")
		else: 
#			sprite.play("default");
			character_motion.x = 0
