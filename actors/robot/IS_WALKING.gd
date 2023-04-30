extends Node
#
#onready var enemy = get_parent().get_parent();
#onready var state = get_parent();
#onready var sprite = get_node("../../AnimatedSprite");
#var is_current_state = false;
#var move_left = true;
#var move_right = false;
#var loop_started = false;
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#func _physics_process(delta):
#	check_if_state();
#
#	if is_current_state:
#		sprite.play("run")
#		if move_left && !loop_started:
#			sprite.set_flip_h(false);
#			print("run_left")
#			loop_started = true;
#			var tween = create_tween();
#			tween.tween_property(enemy, "global_position", enemy.global_position + Vector2(-5, 0), 2);
#			yield(tween, "finished");
#			loop_started = false;
#			move_left = false;
#			move_right = true;
#		if move_right && !loop_started:
#			sprite.set_flip_h(true);
#			print("run_right")
#			loop_started = true;
#			var tween2 = create_tween();
#			tween2.tween_property(enemy, "global_position", enemy.global_position + Vector2(5, 0), 2);
#			yield(tween2, "finished");
#			loop_started = false;
#			move_left = true;
#			move_right = false;
#
#
#func check_if_state():
#	if state.get_state() == self:
#		is_current_state = true;
#	else: 
#		is_current_state = false;

