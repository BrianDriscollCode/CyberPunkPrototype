extends Node2D

onready var filler1 = $filler1;
onready var filler2 = $filler2;
onready var filler3 = $filler3;


var character_health = 3; 

func _physics_process(delta):
	if character_health == 3:
		filler1.set_visible(true);
		filler2.set_visible(true);
		filler3.set_visible(true);
	elif character_health == 2:
		filler1.set_visible(true);
		filler2.set_visible(true);
		filler3.set_visible(false);
	elif character_health == 1: 
		filler1.set_visible(true);
		filler2.set_visible(false);
		filler3.set_visible(false);
	else:
		filler1.set_visible(false);
		filler2.set_visible(false);
		filler3.set_visible(false);
	
func set_ui_character_health(health):
	character_health = health;
		
