extends Node

onready var player = get_tree().get_root().get_node("./Level/Player")

onready var container = get_parent().get_parent();
onready var parent = get_parent();
onready var sprite = get_node("../../AnimatedSprite");
onready var shoot_anim = get_node("../../shoot_anim");

var current_state;

var attack_animation_on = false;

func _physics_process(delta):
	current_state = parent.get_current_state();
	
	if parent.get_current_state() == self:
		if !attack_animation_on:
			print("PLAY ATTACK")
			shoot_anim.set_visible(true);
			shoot_anim.play("default");
			attack_animation_on = true;
		if attack_animation_on:
			if shoot_anim.get_frame() == 5:
				shoot_anim.set_visible(false);
				
	
		
