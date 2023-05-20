extends Node2D

onready var sprite = get_node("AnimatedSprite");
onready var player = get_tree().get_root().get_node("./Level/Player")

func _physics_process(delta):
	pass
#	if abs(player_position.x - self_position.x) < 1:
#		pass;
#	elif player_position.x < self_position.x:
#		self_position.x -= 0.5;
#		container.set_global_position(self_position)
#	elif player_position.x > self_position.x:
#		self_position.x += 0.5;
#		container.set_global_position(self_position)
#	else:
#		pass
##
#func _on_Area2D_area_entered(area):
#	sprite.play("transition_to_attack");
#
#func _on_AnimatedSprite_animation_finished():
#	if sprite.get_animation() == "transition_to_attack":
#		sprite.play("attack");
