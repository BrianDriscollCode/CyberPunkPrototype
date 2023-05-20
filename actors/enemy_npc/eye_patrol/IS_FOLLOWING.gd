extends Node

onready var player = get_tree().get_root().get_node("./Level/Player")
var player_direction;

onready var container = get_parent().get_parent();
onready var parent = get_parent();
onready var sprite = get_node("../../AnimatedSprite");
onready var shoot_anim = get_node("../../shoot_anim");
var current_state;

onready var left_point = get_node("../../LeftPoint");
onready var right_point = get_node("../../RightPoint");
var follow_node;

onready var raycast_top_left = get_node("../../RayCastTopLeft");
onready var raycast_top_right = get_node("../../RayCastTopRight");
onready var raycast_bottom_left = get_node("../../RayCastBottomLeft");
onready var raycast_bottom_right = get_node("../../RayCastBottomRight");


var follow_animation_on = false;

func _ready():
	follow_node = left_point.get_global_position();

func _physics_process(delta):
	current_state = parent.get_current_state();
		
	
	if current_state == self:
		shoot_anim.set_visible(false)
		start_attacking();
		if !follow_animation_on:
			sprite.play("attack");
			follow_animation_on = true;
		follow_player();

func start_attacking():
	if raycast_top_left.is_colliding() && raycast_bottom_left.is_colliding():
		parent.set_attack_state(self);
	elif raycast_top_right.is_colliding() && raycast_bottom_right.is_colliding():
		parent.set_attack_state(self);
	else:
		pass;
			
func follow_player():
	var player_position = player.get_global_position();
	var self_position = container.get_global_position();
	var left_point_position = left_point.get_global_position();
	var right_point_position = right_point.get_global_position();
		
#	if abs(player_position.x - self_position.x) < 1:
#		pass;
#	elif player_position.x < self_position.x:
#		self_position.x -= 0.5;
#		container.set_global_position(self_position)
#		sprite.set_flip_h(false);
#		player_direction = "left";
#	elif player_position.x > self_position.x:
#		self_position.x += 0.5;
#		container.set_global_position(self_position)
#		sprite.set_flip_h(true);
#		player_direction = "right";
#	else:
#		pass

	if abs(player_position.x - self_position.x) < 1:
		print(abs(player_position.x - self_position.x))	
		pass;
	elif player_position.x < self_position.x:
#		self_position.x -= 0.5;
#		container.set_global_position(self_position)
		sprite.set_flip_h(false);
		player_direction = "left";
	elif player_position.x > self_position.x:
#		self_position.x += 0.5;
		container.set_global_position(self_position)
		sprite.set_flip_h(true);
		player_direction = "right";
	else:
		pass
	
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
	
	
	if abs(player_position.y - self_position.y) < 1:
		pass;
	elif player_position.y < self_position.y && abs(player_position.x - self_position.x) < 350:
		self_position.y -= 0.5;
		container.set_global_position(self_position)
	elif player_position.y > self_position.y && abs(player_position.x - self_position.x) < 350:
		self_position.y += 0.5;
		container.set_global_position(self_position)
	else:
		pass
	
#	if abs(player_position.y - self_position.y) < 1 && abs(player_position.x - self_position.x) < 1:
#		parent.set_attack_state(self);
