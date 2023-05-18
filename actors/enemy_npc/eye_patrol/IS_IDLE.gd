extends Node

onready var parent = get_parent();
onready var sprite = get_node("../../AnimatedSprite");
var current_state;

func _physics_process(delta):
	current_state = parent.get_current_state();
	
	if current_state == self:
		pass


func _on_Area2D_area_entered(area):
	if current_state == self:
		sprite.play("transition_to_attack");
