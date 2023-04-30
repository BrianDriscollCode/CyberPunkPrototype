extends KinematicBody2D


#const SPEED = 70
#const UP = Vector2(0, -1)
#const JUMP_SPEED = 250
#var character_motion = Vector2(0,0)
#var jump_gravity_increment = 10
#
#var is_jumping = false;
#
#var alive = true
#var current_ressurect_location
#onready var revive_timer = $revive_timer
#
#var apply_gravity = true
#
#var character_direction = "right"
#onready var sprite = $AnimatedSprite
#
#var ledgeNodes = [];

#func _ready():
#	for node in get_node("../ledgeNodes").get_children():
#		node.connect("body_entered", self, "_ledge_connected", [node])
#		ledgeNodes.append(node)
#	print(ledgeNodes)
#
#func _physics_process(_delta):
#	if is_on_floor():
#		is_jumping = false;
#
#
#	#jump	
#	if Input.is_action_just_pressed("jump") and is_on_floor():
#		character_motion.y = -JUMP_SPEED
#		jump_gravity_increment = 10
#		apply_gravity = true
#	elif is_on_floor():
#		jump_gravity_increment = 10
#	else: 
#			#falling code
#			if apply_gravity == true:		
#				character_motion.y += 4 + jump_gravity_increment 
#
#				if jump_gravity_increment > 1:
#					jump_gravity_increment -= .15
#			else: 
#				character_motion.y = 0;
#
#func set_character_direction(setting):
#	character_direction = setting
#
#
#func _on_AnimatedSprite_animation_finished():
#	print(Input)
#	var current_animation = sprite.get_animation();
##	if is_jumping:
##		sprite.play("falling")
##	else:
##		sprite.play("idle")
#
#func hang_on_ledge(position):
#	var current_position = position;
#	current_position.x += 5
#	current_position.y += 4;
#	self.global_position = current_position;
#
#func _ledge_connected(body, node):
##	sprite.play("hanging");
#	hang_on_ledge(node.global_position);
#	apply_gravity = false;
#

