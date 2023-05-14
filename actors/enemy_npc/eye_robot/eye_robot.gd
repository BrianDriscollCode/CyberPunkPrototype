extends Node2D

var current_frame;
onready var animated_sprite = $AnimatedSprite;
var collider_chooser;

#resources
onready var laser = $Laser;

#player
onready var player = "%Player";

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
	elif current_state == states.ATTACKING:
		if !is_colliders_enabled:
			enable_all_colliders();
		if !is_emitting:
			start_emitters();
		if !animation_paused:
			animated_sprite.stop()
			animation_paused = true;
	else:
		pass;
		
func start_emitters():
	start_laser_particles.set_emitting(true)
	is_emitting = true;	
	print("START EMITTER")
	print("START EMITTER")
	print("START EMITTER")
	print("START EMITTER")
	print("START EMITTER")
		
func enable_all_colliders():
	left_collider.set_disabled(false);
	mid_left_collider.set_disabled(false);
	bottom_left_collider.set_disabled(false);
	bottom_collider.set_disabled(false);
	bottom_right_collider.set_disabled(false);
	mid_right_collider.set_disabled(false);
	right_collider.set_disabled(false);
	is_colliders_enabled = true;
			
func check_animation():
	current_frame = animated_sprite.get_frame();

func align_colliders():
	if current_frame == 0:
		collider_chooser = "left";
		start_laser_particles.position = Vector2(-6, 8);
	elif current_frame == 1 || current_frame == 11:
		collider_chooser = "mid_left";
		start_laser_particles.position = Vector2(-5, 11);
	elif current_frame == 2 || current_frame == 10:
		collider_chooser = "bottom_left";
		start_laser_particles.position = Vector2(-2, 13);
	elif current_frame == 3 || current_frame == 9:
		collider_chooser = "bottom";
		start_laser_particles.position = Vector2(1, 14);
	elif current_frame == 4 || current_frame == 8:
		collider_chooser = "bottom_right";
		start_laser_particles.position = Vector2(4, 13);
	elif current_frame == 5 || current_frame == 7:
		collider_chooser = "mid_right";
		start_laser_particles.position = Vector2(6, 11);
	elif current_frame == 6:
		collider_chooser = "right";
		start_laser_particles.position = Vector2(7, 8);

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

func _on_BottomCollider_area_entered(area):
	if current_state == states.PATROL:
		current_state = states.ATTACKING;
	animated_sprite.set_frame(3)
	start_laser_particles.position = Vector2(1, 14);
	
	print("bottom")

func _on_Left_area_entered(area):
	if current_state == states.PATROL:
		current_state = states.ATTACKING;
	animated_sprite.set_frame(0)
	start_laser_particles.position = Vector2(-6, 8);
	print("left")

func _on_MidLeftCollider_area_entered(area):
	if current_state == states.PATROL:
		current_state = states.ATTACKING;
	animated_sprite.set_frame(1)
	start_laser_particles.position = Vector2(-5, 11);
	print("midleft")
	
func _on_BottomLeftCollider_area_entered(area):
	if current_state == states.PATROL:
		current_state = states.ATTACKING;
	animated_sprite.set_frame(2)
	start_laser_particles.position = Vector2(-2, 13);
	print("bottomleft")

func _on_BottomRightCollider_area_entered(area):
	if current_state == states.PATROL:
		current_state = states.ATTACKING;
	animated_sprite.set_frame(4)
	start_laser_particles.position = Vector2(4, 13);
	print("bottomright")

func _on_MidRightCollider_area_entered(area):
	if current_state == states.PATROL:
		current_state = states.ATTACKING;
	animated_sprite.set_frame(5)
	start_laser_particles.position = Vector2(6, 11);
	print("midRight")

func _on_Right_area_entered(area):
	if current_state == states.PATROL:
		current_state = states.ATTACKING;
	animated_sprite.set_frame(6)
	start_laser_particles.position = Vector2(7, 8);
	print("right")
