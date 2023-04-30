extends Node

onready var sprite = get_node("../../AnimatedSprite");
onready var playerState = get_parent();
onready var player = get_parent().get_parent();
onready var camera = get_node("../../mainCamera");

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
var tweens_completed = false;
var tween_1_completed = false;
var tween_2_completed = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	check_if_state();
	set_animation();
		

func set_animation():
	if is_current_state && tweens_completed == false:
#		climbCollision.set_disabled(true);
		tweens_completed = true;
		sprite.play("ledgeClimb");
		camera._set_current(false);
		var tween = create_tween();
		tween.tween_property(player, "global_position", player.global_position + Vector2(3, -3), 0.05)
		yield(tween, "finished");
		var tween2 = create_tween();
		tween2.tween_property(player, "global_position", player.global_position + Vector2(0, 0), 0.2)
		yield(tween2, "finished");
		var tween3 = create_tween();
		tween3.tween_property(player, "global_position", player.global_position + Vector2(0, -14), 0.05)
		yield(tween3, "finished");
		var tween4 = create_tween();
		tween4.tween_property(player, "global_position", player.global_position + Vector2(0, 0), 0.2)
		yield(tween4, "finished");
		camera.set_follow_smoothing(3)
		camera._set_current(true);
		var tween5 = create_tween();
		tween5.tween_property(player, "global_position", player.global_position + Vector2(13, -6), 0.01)
		yield(tween5, "finished");
		yield(get_tree().create_timer(0.4), "timeout")
		get_parent().set_idle();
		yield(get_tree().create_timer(0.1), "timeout")
		yield(get_tree().create_timer(2), "timeout")
		camera.set_follow_smoothing(5);
		tweens_completed = false;
			
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func check_if_state():
	if playerState.get_state() == self:
		is_current_state = true;
	else:
		is_current_state = false;
