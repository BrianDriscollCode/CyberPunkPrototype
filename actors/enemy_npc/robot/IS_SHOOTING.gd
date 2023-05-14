extends Node
#
#onready var enemy = get_parent();
#onready var sprite = get_node("../../AnimatedSprite");
#var is_current_state = false;
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#func _physics_process(delta):
#	check_if_state();
#
#	if is_current_state:
#		sprite.play("shoot")
#
#func check_if_state():
#	if enemy.get_state() == self:
#		is_current_state = true;
#	else: 
#		is_current_state = false;
#
