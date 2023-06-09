extends Node

onready var sprite = get_node("../../AnimatedSprite");
onready var playerState = get_parent();
onready var player = get_parent().get_parent();
onready var AttackState = get_node("../../AttackState");

onready var climbCollision = get_node("../../climb/CollisionShape2D")

var SPEED = 60
const UP = Vector2(0, -1)
const JUMP_SPEED = 270
var character_motion = Vector2(0,0)
var jump_gravity_increment = 10
var apply_gravity = true;
var player_hanging = false;

var is_current_state = false;
var is_in_town = false;
var is_attacking = false;

func _ready():
	set_is_in_town();

func _physics_process(delta):
	check_if_state();
	
	is_attacking = AttackState.get_attack_state();
		
	if is_current_state:
		climbCollision.set_disabled(false);
		if !is_attacking:
			sprite.play("jump");
		basic_movement();
		player.move_and_slide(character_motion, UP)
	else: 
		climbCollision.set_disabled(true);

func check_if_state():
	if playerState.get_state() == self:
		is_current_state = true;
	else:
		is_current_state = false;

func basic_movement():
	if Input.is_action_pressed("ui_right"):
		sprite.set_flip_h(false);
		character_motion.x = SPEED 
	elif Input.is_action_pressed("ui_left"):
		sprite.set_flip_h(true);
		character_motion.x = -SPEED 
	else: 			
		character_motion.x = 0

	var is_hanging = check_hanging()
	if Input.is_action_just_pressed("jump") && player.is_on_floor() || Input.is_action_just_pressed("jump") && is_hanging:
		character_motion.y = -JUMP_SPEED
		jump_gravity_increment = 10
		apply_gravity = true
	elif player.is_on_floor():
		jump_gravity_increment = 10
	else: 
			applyGravity();
			
	if is_in_town == false && !Input.is_action_pressed("shift"):
		SPEED = 140; #sprint speed
	else: 
		SPEED = 70; #walk speed
				
func applyGravity():
	if apply_gravity == true:		
		character_motion.y += 4 + jump_gravity_increment 
		if jump_gravity_increment > 1:
			jump_gravity_increment -= .15
#		else: 
#			character_motion.y = 0;
	
func set_is_in_town():
	is_in_town = playerState.get_is_in_town();

func check_hanging():
	player_hanging = get_node("../IS_HANGING").return_hanging();
	return player_hanging;


#func _on_AnimatedSprite_animation_finished():
#	if sprite.get_animation() == "punch":
#		is_punching = false;
