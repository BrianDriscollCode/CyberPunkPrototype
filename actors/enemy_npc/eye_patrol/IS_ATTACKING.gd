extends Node

onready var scene = get_tree().get_current_scene();

var self_position;
onready var left_point = get_node("../../LeftPoint");
onready var right_point = get_node("../../RightPoint");
var follow_node;

onready var player = get_tree().get_root().get_node("./Level/Player")
var player_position;
var player_direction;


onready var container = get_parent().get_parent();
onready var parent = get_parent();
onready var sprite = get_node("../../AnimatedSprite");
onready var shoot_anim = get_node("../../shoot_anim");
onready var bullet_spawn = get_node("../../bullet_spawn");
onready var attacking_area = get_node("../../attacking_area");

onready var raycast_top_left = get_node("../../RayCastTopLeft");
onready var raycast_top_right = get_node("../../RayCastTopRight");
onready var raycast_bottom_left = get_node("../../RayCastBottomLeft");
onready var raycast_bottom_right = get_node("../../RayCastBottomRight");

var laser;

var current_state;

var attack_animation_on = false;
var can_shoot = true;
onready var shoot_timer = get_node("../../shoot_timer");

func _ready():
	laser = load("res://weapons/laser/thin_laser.tscn")
	follow_node = left_point.get_global_position();

func _physics_process(delta):
	current_state = parent.get_current_state();
	player_position = player.get_global_position();
	self_position = container.get_global_position();
	set_player_direction();
	
	
	if parent.get_current_state() == self:
		if !attack_animation_on:
			shoot_anim.set_visible(true);
			shoot_anim.play("default");
			attack_animation_on = true;
		if attack_animation_on:
			if shoot_anim.get_frame() == 5 && can_shoot:
				shoot_anim.set_visible(false);
				shoot();
		if !raycast_top_left.is_colliding() && !raycast_bottom_left.is_colliding() && player_direction == "left":
			move_y();
			move_x();
		elif !raycast_top_right.is_colliding() && !raycast_bottom_right.is_colliding() && player_direction == "right":
			move_y();
			move_x();
		else:
			pass;
			
func shoot():
	var laser_instance = laser.instance();
	scene.add_child(laser_instance);
	laser_instance.global_position = bullet_spawn.get_global_position();
	can_shoot = false;
	shoot_timer.start()

func set_player_direction():
	if abs(player_position.x - self_position.x) < 1:
		pass;
	elif player_position.x < self_position.x:
#		self_position.x -= 0.5;
#		container.set_global_position(self_position)
		sprite.set_flip_h(false);
		player_direction = "left";
		shoot_anim.set_flip_h(false);
		bullet_spawn.position = Vector2(-5, -1);
	elif player_position.x > self_position.x:
#		self_position.x += 0.5;
		container.set_global_position(self_position)
		sprite.set_flip_h(true);
		player_direction = "right";
		shoot_anim.set_flip_h(true);
		bullet_spawn.position = Vector2(5, -1)
	else:
		pass	

func move_x():
	
	if player_direction == "left":
		follow_node = left_point.get_global_position();
	elif player_direction == "right":
		follow_node = right_point.get_global_position();
	else:
		pass;
		
	if follow_node.x < self_position.x:
		self_position.x -= 0.5;
		container.set_global_position(self_position);
	elif follow_node.x > self_position.x:
		self_position.x += 0.5;
		container.set_global_position(self_position);
	else:
		pass;

func move_y():
	if abs(player_position.y - self_position.y) < 1:
		pass;
	elif player_position.y < self_position.y && abs(player_position.x - self_position.x) < 250:
		self_position.y -= 0.5;
		container.set_global_position(self_position)
	elif player_position.y > self_position.y && abs(player_position.x - self_position.x) < 250:
		self_position.y += 0.5;
		container.set_global_position(self_position)
	else:
		pass

func _on_shoot_timer_timeout():
	can_shoot = true;
	attack_animation_on = false
	shoot_anim.set_frame(0);
	shoot_anim.stop();
	
func reset():
	can_shoot = true;
	attack_animation_on = false
	shoot_anim.set_frame(0);
	shoot_anim.stop();
	
