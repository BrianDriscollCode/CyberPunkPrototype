extends Node

onready var IS_IDLE = get_node("IS_IDLE");
onready var IS_ATTACKING = get_node("IS_ATTACKING");
onready var IS_FOLLOWING = get_node("IS_FOLLOWING");


onready var sprite = get_node("../AnimatedSprite");
var current_state;
var prev_state;
onready var text_label = get_node("../RichTextLabel");

func _ready():
	current_state = IS_IDLE;
	
func get_current_state():
	return current_state;
	
func set_state(new_state, prev_state, text):
	if prev_state == IS_ATTACKING && new_state != IS_FOLLOWING:
		return
	current_state = new_state;
	prev_state = prev_state;
	text_label.set_text(text);
	
func _on_AnimatedSprite_animation_finished():
	if sprite.get_animation() == "transition_to_attack":
		set_state(IS_FOLLOWING, IS_IDLE, "is_following");
		
func set_attack_state(prev_state):
	set_state(IS_ATTACKING, prev_state, "is_attacking")
	IS_ATTACKING.reset();

func _on_attacking_area_area_exited(area):
	set_state(IS_FOLLOWING, current_state, "is_following");
