extends Node

onready var IS_IDLE = get_node("IS_IDLE");
onready var IS_ATTACKING = get_node("IS_ATTACKING");
onready var IS_FOLLOWING = get_node("IS_FOLLOWING");


onready var sprite = get_node("../AnimatedSprite");
var current_state;
var prev_state;

func _ready():
	current_state = IS_IDLE;
	
func get_current_state():
	return current_state;
	
func set_state(new_state, prev_state):
	current_state = new_state;
	prev_state = prev_state;
	
func _on_AnimatedSprite_animation_finished():
	if sprite.get_animation() == "transition_to_attack":
		set_state(IS_FOLLOWING, IS_IDLE);
		
func set_attack_state(prev_state):
	set_state(IS_ATTACKING, prev_state)
