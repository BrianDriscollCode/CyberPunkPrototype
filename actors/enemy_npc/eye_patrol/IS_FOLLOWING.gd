extends Node

onready var player = get_tree().get_root().get_node("./Level/Player")

onready var container = get_parent().get_parent();
onready var parent = get_parent();
onready var sprite = get_node("../../AnimatedSprite");
var current_state;

var follow_animation_on = false;

func _physics_process(delta):
	current_state = parent.get_current_state();
	
	if current_state == self:
		if !follow_animation_on:
			sprite.play("attack");
			follow_animation_on = true;
		follow_player();
			
func follow_player():
	var player_position = player.get_global_position();
	var self_position = container.get_global_position();
		
	if abs(player_position.x - self_position.x) < 1:
		print(abs(player_position.x - self_position.x))	
		pass;
	elif player_position.x < self_position.x:
		self_position.x -= 0.5;
		container.set_global_position(self_position)
	elif player_position.x > self_position.x:
		self_position.x += 0.5;
		container.set_global_position(self_position)
	else:
		pass
	
	if abs(player_position.y - self_position.y) < 1:
		print(abs(player_position.y - self_position.y))	
		pass;
	elif player_position.y < self_position.y && abs(player_position.x - self_position.x) < 50:
		self_position.y -= 0.5;
		container.set_global_position(self_position)
	elif player_position.y > self_position.y && abs(player_position.x - self_position.x) < 50:
		self_position.y += 0.5;
		container.set_global_position(self_position)
	else:
		pass
	
	if abs(player_position.y - self_position.y) < 1 && abs(player_position.x - self_position.x) < 1:
		parent.set_attack_state(self);
