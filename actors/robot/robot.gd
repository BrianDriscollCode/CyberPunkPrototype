extends Node2D

enum {
	IS_PATROLLING,
	IS_ATTACKING
}

onready var scene = get_tree().get_current_scene();
onready var player = get_tree().get_current_scene().get_node("Player");
onready var spawnBulletRightPosition = get_node("SpawnBulletRight").get_global_position();
onready var spawnBulletLeftPosition = get_node("SpawnBulletLeft").get_global_position();

onready var bullet = preload("res://weapons/projectile/red_bullet.tscn").instance();

onready var raycast1 = get_node("RayCast1");
onready var raycast2 = get_node("RayCast2");

onready var display_text = get_node("text");

var loop_started = false;
var loop_finished = false;
var current_state = IS_PATROLLING;
var prev_state = null;
onready var sprite = get_node("AnimatedSprite");

onready var animationPlayer = get_node("AnimationPlayer");
var first_play = false;
var paused = false;
var changing_state = false;

var has_entered = false;
var has_left = true;
	

func _ready():
	animationPlayer.play("run_left");
	print(player)
	raycast1.set_global_rotation_degrees(-180)
	raycast2.set_global_rotation_degrees(-180)

func _physics_process(delta):
	
	if raycast1.is_colliding() || raycast2.is_colliding():
		if !has_entered:
			set_state(IS_ATTACKING, current_state)
			has_entered = true;
			has_left = false;
	if !raycast1.is_colliding() && !raycast2.is_colliding():
		if !has_left:
			set_state(IS_PATROLLING, current_state)
			has_entered = false;
			has_left = true;
		
#	print(animationPlayer.get_queue().size())
		
	if current_state == IS_ATTACKING && first_play == true:
		print("run is attacking")
		sprite.set_modulate(Color(100,1,1,1))
		attacking();
		first_play = false;

	if current_state == IS_PATROLLING && first_play == true:
		print("run is patrolling")
		resume_animation();
		first_play = false
##
	display_text.clear();
	display_text.add_text(str(current_state))
	
func resume_animation():
	print("resuming animation")
	print(animationPlayer.get_queue());
	animationPlayer.play();
#
func end_current_animation():
	print(animationPlayer.get_queue())
	animationPlayer.stop(false);
	print(animationPlayer.get_queue())
#
func attacking():
	end_current_animation();
	shoot();
#
func shoot():
	sprite.play("shoot");
	if player.get_global_position().x < self.get_global_position().x:
		var bullet = scene.add_child(bullet);
		bullet.global_position = spawnBulletLeftPosition;
	
	
func face_player():
	if player.get_global_position().x > self.get_global_position():
		sprite.flip_h(true);
		

func set_state(new_state, prev_state):
	print("changing state to: ", new_state);
	current_state = new_state;
	prev_state = prev_state;
	first_play = true;

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "run_left":
		animationPlayer.play("idle");
	elif anim_name == "idle":
		animationPlayer.play("run_right");
		yield(get_tree().create_timer(0.03), "timeout")
		raycast1.set_global_rotation_degrees(0)
		raycast2.set_global_rotation_degrees(0)
	elif anim_name == "run_right":
		animationPlayer.play("idle2");
	elif anim_name == "idle2":
		animationPlayer.play("run_left");
		yield(get_tree().create_timer(0.03), "timeout")
		raycast1.set_global_rotation_degrees(-180)
		raycast2.set_global_rotation_degrees(-180)
