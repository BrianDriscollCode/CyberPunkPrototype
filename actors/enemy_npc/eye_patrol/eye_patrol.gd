extends Node2D

onready var sprite = get_node("AnimatedSprite");

func _ready():
	pass # Replace with function body.
#
#func _on_Area2D_area_entered(area):
#	sprite.play("transition_to_attack");
#
#func _on_AnimatedSprite_animation_finished():
#	if sprite.get_animation() == "transition_to_attack":
#		sprite.play("attack");
