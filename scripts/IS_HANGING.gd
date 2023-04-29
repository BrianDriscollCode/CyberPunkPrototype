extends Node

onready var sprite = get_node("../../AnimatedSprite");
onready var playerState = get_parent();
onready var player = get_parent().get_parent();

onready var climbCollision = get_node("../../climb/CollisionShape2D")

const SPEED = 70
const UP = Vector2(0, -1)
const JUMP_SPEED = 250
var character_motion = Vector2(0,0)
var jump_gravity_increment = 10
var apply_gravity = false;

var is_current_state = false;

func _physics_process(delta):
	check_if_state();
		
	if is_current_state:
		climbCollision.set_disabled(true);
		sprite.play("hanging");
	
#	#jump	
#	if Input.is_action_just_pressed("jump") && is_current_state:
#		character_motion.y = -JUMP_SPEED
#		jump_gravity_increment = 10
#		apply_gravity = true

func check_if_state():
	if playerState.get_state() == self:
		is_current_state = true;
	else:
		is_current_state = false;

func return_hanging():
	return is_current_state;
