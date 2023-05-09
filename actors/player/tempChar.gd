extends KinematicBody2D


var character_health = 3;


func _on_Area2D_area_entered(area):
	character_health -= 1;
