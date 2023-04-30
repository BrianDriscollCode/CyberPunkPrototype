extends Node

onready var sprite = get_node("../../AnimatedSprite");
onready var playerState = get_parent();
onready var player = get_parent().get_parent();

const SPEED = 60
const UP = Vector2(0, -1)
const JUMP_SPEED = 250
var character_motion = Vector2(0,0)
var jump_gravity_increment = 5

var gravity = 200;

var apply_gravity = true;

var is_current_state = false;

func _physics_process(delta):
	check_if_state();
		
	if is_current_state:
#		character_motion.y = gravity;
		sprite.play("walk");
		applyGravity(delta);
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

func applyGravity(delta):
	if apply_gravity == true:		
		character_motion.y += 4 + jump_gravity_increment 
	if !player.is_on_floor():
		character_motion.y += (jump_gravity_increment * 2) + jump_gravity_increment * delta
		if jump_gravity_increment > 1:
			jump_gravity_increment -= .15
	else:
			character_motion.y = 0;
#		else: 
#			character_motion.y = 0;
