extends Node2D


onready var sprite = get_node("AnimatedSprite");
onready var player = get_tree().get_root().get_node("./Level/Player")
onready var damage_collider = get_node("damageCollider");
onready var color_timer = get_node("color_timer");

var health = 2;
	
func _on_damageCollider_area_entered(area):
	health -= 1;
	self.set_modulate(Color(80, 80, 80, 1));
	color_timer.start();
	print("damage taken")
	
func _on_color_timer_timeout():
	self.set_modulate(Color(1,1,1,1));
	if health == 0:
		queue_free();
