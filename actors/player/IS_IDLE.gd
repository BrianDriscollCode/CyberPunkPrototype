extends Node

onready var sprite = get_node("../../AnimatedSprite");
onready var playerState = get_parent();
onready var player = get_parent().get_parent();
onready var AttackState = get_node("../../AttackState");

const SPEED = 70
const UP = Vector2(0, -1)
const JUMP_SPEED = 250
var character_motion = Vector2(0,0)
var jump_gravity_increment = 10

var apply_gravity = true;
var is_current_state = false;
var is_attacking = false;

func _physics_process(delta):
	check_if_state();
	is_attacking = AttackState.get_attack_state();
		
	if is_current_state:
		
		if Input.is_action_pressed("ui_down"):
			sprite.play("crouch")
		else:
			if !is_attacking:
				sprite.play("idle");
		apply_gravity();
		
		if !player.is_on_floor():
			character_motion.y += (jump_gravity_increment * 2) + jump_gravity_increment * delta
			if jump_gravity_increment > 1:
				jump_gravity_increment -= .15
		else:
			character_motion.y = 0;
			
		player.move_and_slide(character_motion, UP)
	

func check_if_state():
	if playerState.get_state() == self:
		is_current_state = true;
	else:
		is_current_state = false;

func apply_gravity():
	if apply_gravity == true:		
		character_motion.y += 4 + jump_gravity_increment 
		if jump_gravity_increment > 1:
			jump_gravity_increment -= .15
		else: 
			character_motion.y = 0;


#func _on_AnimatedSprite_animation_finished():
#	if sprite.get_animation() == "punch":
#		is_punching = false;
