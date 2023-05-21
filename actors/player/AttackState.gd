extends Node


var IS_ATTACKING = false;
onready var sprite = get_node("../AnimatedSprite");
onready var attack_collider1 = get_node("../attack_collider/CollisionPolygon2D");
onready var attack_collider2 = get_node("../attack_collider/CollisionPolygon2D2");

var player_direction = "right";

func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		IS_ATTACKING = true;
	if IS_ATTACKING:
		sprite.play("punch");
		if player_direction == "right":
			print("right")
			attack_collider1.set_disabled(false);
			attack_collider2.set_disabled(true);
		elif player_direction == "left":
			print("left")
			attack_collider1.set_disabled(true);
			attack_collider2.set_disabled(false);
		else:
			attack_collider1.set_disabled(false);
			attack_collider2.set_disabled(false);
	if Input.is_action_just_pressed("ui_right"):
		player_direction = "right";
	elif Input.is_action_just_pressed("ui_left"):
		player_direction = "left";
	else:
		pass;

func get_attack_state():
	return IS_ATTACKING;

func _on_AnimatedSprite_animation_finished():
	IS_ATTACKING = false;
	if sprite.get_animation() == "punch":
		attack_collider1.set_disabled(true);
		attack_collider2.set_disabled(true);
