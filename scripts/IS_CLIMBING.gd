extends Node

onready var sprite = get_node("../../AnimatedSprite");
onready var playerState = get_parent();
onready var player = get_parent().get_parent();

onready var climbCollision = get_node("../../climb/CollisionShape2D")

var SPEED = 70
const UP = Vector2(0, -1)
const JUMP_SPEED = 250
var character_motion = Vector2(0,0)
var jump_gravity_increment = 10
var apply_gravity = true;
var player_hanging = false;

var is_current_state = false;
var toggleStart = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	check_if_state();
	
	
	if is_current_state:
#		climbCollision.set_disabled(true);
		sprite.play("ledgeClimb")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func check_if_state():
	if playerState.get_state() == self:
		is_current_state = true;
	else:
		is_current_state = false;
