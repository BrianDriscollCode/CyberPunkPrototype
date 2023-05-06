extends Node


onready var sprite = get_node("../../Path2D/PathFollow2D/AnimatedSprite");
var CURRENT_ENEMY_STATE;
onready var scene = get_tree().get_current_scene();
onready var spawnBullet = get_node("../../Path2D/PathFollow2D/SpawnBullet/");

#detect
onready var leftRayCast = get_node("../../Path2D/PathFollow2D/RayCastLeft");
onready var leftRayCast2 = get_node("../../Path2D/PathFollow2D/RayCastLeft2");
onready var leftRayCast3 = get_node("../../Path2D/PathFollow2D/RayCastLeft3");

onready var rightRayCast = get_node("../../Path2D/PathFollow2D/RayCastRight");
onready var rightRayCast2 = get_node("../../Path2D/PathFollow2D/RayCastRight2");
onready var rightRayCast3 = get_node("../../Path2D/PathFollow2D/RayCastRight3");

#statuses
var gun_out = false;
var first_play = true;
onready var first_play_timer = get_node("../../FirstPlayTimer")

#resources
onready var bullet = preload("res://weapons/projectile/red_bullet.tscn");


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	CURRENT_ENEMY_STATE = get_parent().get_state();
	if CURRENT_ENEMY_STATE == self:
		if gun_out == false:
			sprite.play("pullGun")
			first_play_timer.start();
		face_player();
		if gun_out == true && first_play == false:
			print("bullet")
			first_play = true;
			yield(get_tree().create_timer(1), "timeout");
			print("bullet")
			if CURRENT_ENEMY_STATE == self:
				var newBullet = bullet.instance();
				scene.add_child(newBullet);
				newBullet.global_position = spawnBullet.get_global_position();
				first_play_timer.start();
	else:
		gun_out = false;
		
func face_player():
	if leftRayCast.is_colliding() || leftRayCast2.is_colliding() || leftRayCast3.is_colliding():
		sprite.set_flip_h(false);
	elif rightRayCast.is_colliding() || rightRayCast2.is_colliding() || rightRayCast3.is_colliding():
		sprite.set_flip_h(true);


func _on_AnimatedSprite_animation_finished():
	print(sprite.get_animation())
	if sprite.get_animation() == "pullGun":
		gun_out = true;


func _on_FirstPlayTimer_timeout():
	first_play = false;
