extends KinematicBody2D

var character_health = 3;
var can_take_damage = true;
onready var health_bar = get_node("../Camera2D/HealthBar");
onready var damage_timer = $DamageTimer;

func _on_Area2D_area_entered(area):
	if can_take_damage:
		character_health -= 1;
		health_bar.set_ui_character_health(character_health);
		can_take_damage = false;
		damage_timer.start();


func _on_DamageTimer_timeout():
	can_take_damage = true;
