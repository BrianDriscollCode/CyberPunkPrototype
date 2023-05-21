extends Node2D

var current_frame;
onready var animated_sprite = $AnimatedSprite;
var collider_chooser;

#resources
onready var laser = $LaserRayCast;
onready var attack_timer = $Attack_Timer;
onready var laser_timer = $Laser_Timer;

#player
onready var player = get_tree().get_root().get_node("./Level/Player")

#particles
onready var start_laser_particles = $StartLaserParticles;

#colliders
#Left
onready var left_collider = $Left/CollisionShape2D;
onready var mid_left_collider = $MidLeftCollider/CollisionShape2D;
onready var bottom_left_collider = $BottomLeftCollider/CollisionShape2D;

#Mid
onready var bottom_collider = $BottomCollider/CollisionShape2D;

#Right
onready var right_collider = $Right/CollisionShape2D;
onready var mid_right_collider = $MidRightCollider/CollisionShape2D;
onready var bottom_right_collider = $BottomRightCollider/CollisionShape2D;


enum states {
	PATROL,
	ATTACKING,
	FINDING,
}

var current_state;
var is_emitting = false;
var is_colliders_enabled = false;
var animation_paused = false;
var laser_shot = false;
var timer_started = false;
 


func _ready():
	current_frame = animated_sprite.get_frame();
	current_state = states.PATROL;


func _physics_process(delta):
	if current_state == states.PATROL:
		is_emitting = false;
		is_colliders_enabled = false;
		check_animation();
		align_colliders();
		enable_colliders();
		if animation_paused:
			animated_sprite.play();
			animation_paused = false;
			is_colliders_enabled = false;
			laser_shot = false;
			is_emitting = false;
	elif current_state == states.ATTACKING:
		if !is_colliders_enabled:
			enable_all_colliders();
			is_colliders_enabled = true;
		if !is_emitting:
			start_emitters();
			is_emitting = true;	
		if !animation_paused:
			animated_sprite.stop()
			animation_paused = true;
		if !laser_shot:
			shoot();
			laser_shot = true;
	else:
		pass;

func return_to_patrol():
	current_state = states.PATROL;
	laser.disappear();
	
	
func start_attack_timer():
	attack_timer.start();
	
func stop_timer():
	attack_timer.stop();
	timer_started = false;
		
func shoot():
	yield(get_tree().create_timer(1.5), "timeout")
	update_player_position();
	yield(get_tree().create_timer(0.3), "timeout")
	laser.shoot();				
	start_attack_timer();
	
func start_emitters():
	start_laser_particles.set_emitting(true)

func enable_all_colliders():
	left_collider.set_disabled(false);
	mid_left_collider.set_disabled(false);
	bottom_left_collider.set_disabled(false);
	bottom_collider.set_disabled(false);
	bottom_right_collider.set_disabled(false);
	mid_right_collider.set_disabled(false);
	right_collider.set_disabled(false);
			
func check_animation():
	current_frame = animated_sprite.get_frame();

func align_colliders():
	if current_frame == 0:
		collider_chooser = "left";
		start_laser_particles.position = Vector2(-6, 8);
		laser.set_start_point(current_frame);
	elif current_frame == 1 || current_frame == 11:
		collider_chooser = "mid_left";
		start_laser_particles.position = Vector2(-5, 11);
		laser.set_start_point(current_frame);
	elif current_frame == 2 || current_frame == 10:
		collider_chooser = "bottom_left";
		start_laser_particles.position = Vector2(-2, 13);
		laser.set_start_point(current_frame);
	elif current_frame == 3 || current_frame == 9:
		collider_chooser = "bottom";
		start_laser_particles.position = Vector2(1, 14);
		laser.set_start_point(current_frame);
	elif current_frame == 4 || current_frame == 8:
		collider_chooser = "bottom_right";
		start_laser_particles.position = Vector2(4, 13);
		laser.set_start_point(current_frame);
	elif current_frame == 5 || current_frame == 7:
		collider_chooser = "mid_right";
		start_laser_particles.position = Vector2(6, 11);
		laser.set_start_point(current_frame);
	elif current_frame == 6:
		collider_chooser = "right";
		start_laser_particles.position = Vector2(7, 8);
		laser.set_start_point(current_frame);

func enable_colliders():
	left_collider.set_disabled(true);
	mid_left_collider.set_disabled(true);
	bottom_left_collider.set_disabled(true);
	bottom_collider.set_disabled(true);
	bottom_right_collider.set_disabled(true);
	mid_right_collider.set_disabled(true);
	right_collider.set_disabled(true);
	
	match collider_chooser:
		"left":
			left_collider.set_disabled(false);
		"mid_left":
			mid_left_collider.set_disabled(false);
		"bottom_left":
			bottom_left_collider.set_disabled(false);
		"bottom":
			bottom_collider.set_disabled(false);
		"bottom_right":
			bottom_right_collider.set_disabled(false);
		"mid_right":
			mid_right_collider.set_disabled(false);
		"right":
			right_collider.set_disabled(false);
		
func get_player_position():
	return player.get_global_position();

func get_turret_state():
	return current_state;

func update_player_position():
	laser.update_player_position()
	
func _on_BottomCollider_area_entered(area):
	if current_state == states.PATROL:
		current_state = states.ATTACKING;
	animated_sprite.set_frame(3)
	start_laser_particles.position = Vector2(1, 14);
	stop_timer();
	if laser_timer.is_stopped():
		laser_timer.start();

func _on_Left_area_entered(area):
	if current_state == states.PATROL:
		current_state = states.ATTACKING;
	animated_sprite.set_frame(0)
	start_laser_particles.position = Vector2(-6, 8);
	stop_timer();
	if laser_timer.is_stopped():
		laser_timer.start();

func _on_MidLeftCollider_area_entered(area):
	if current_state == states.PATROL:
		current_state = states.ATTACKING;
	animated_sprite.set_frame(1)
	start_laser_particles.position = Vector2(-5, 11);
	stop_timer();
	if laser_timer.is_stopped():
		laser_timer.start();
	
func _on_BottomLeftCollider_area_entered(area):
	if current_state == states.PATROL:
		current_state = states.ATTACKING;
	animated_sprite.set_frame(2)
	start_laser_particles.position = Vector2(-2, 13);
	stop_timer();
	if laser_timer.is_stopped():
		laser_timer.start();

func _on_BottomRightCollider_area_entered(area):
	if current_state == states.PATROL:
		current_state = states.ATTACKING;
	animated_sprite.set_frame(4)
	start_laser_particles.position = Vector2(4, 13);
	stop_timer();
	if laser_timer.is_stopped():
		laser_timer.start();

func _on_MidRightCollider_area_entered(area):
	if current_state == states.PATROL:
		current_state = states.ATTACKING;
	animated_sprite.set_frame(5)
	start_laser_particles.position = Vector2(6, 11);
	stop_timer();
	if laser_timer.is_stopped():
		laser_timer.start();

func _on_Right_area_entered(area):
	if current_state == states.PATROL:
		current_state = states.ATTACKING;
	animated_sprite.set_frame(6)
	start_laser_particles.position = Vector2(7, 8);
	stop_timer();
	if laser_timer.is_stopped():
		laser_timer.start();
		

func _on_Attack_Timer_timeout():
	laser_timer.stop();
	return_to_patrol();

func _on_Laser_Timer_timeout():
	laser_shot = false;
