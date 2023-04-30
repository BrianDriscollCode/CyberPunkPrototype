extends Node2D

enum {
	IS_PATROLLING,
	IS_ATTACKING
}

onready var raycast1 = get_node("RayCast1");
onready var raycast2 = get_node("RayCast2");
onready var raycast3 = get_node("RayCast3");
onready var raycast4 = get_node("RayCast4");

onready var display_text = get_node("text");

var loop_started = false;
var current_state = IS_PATROLLING;
onready var sprite = get_node("AnimatedSprite");

onready var animationPlayer = get_node("AnimationPlayer");
var first_play = true;
var paused = false;
	

func _ready():
	patrol();

func _physics_process(delta):
	
	if raycast1.is_colliding() || raycast2.is_colliding() || raycast3.is_colliding() || raycast4.is_colliding():
		set_attacking_state();
	if !raycast1.is_colliding() && !raycast2.is_colliding() && !raycast3.is_colliding() && !raycast4.is_colliding():
		set_patrolling_state();
		
	
		
	if current_state == IS_ATTACKING:
		sprite.set_modulate(Color(100,1,1,1))
		attacking();
		
	if current_state == IS_PATROLLING && first_play == false && paused == true:
		animationPlayer.play();
		paused = false;
		
	display_text.clear();
	display_text.add_text(str(current_state))
	
func patrol():
	first_play = false;
	animationPlayer.play("run_left");
	animationPlayer.queue("idle");
	animationPlayer.queue("run_right");
	animationPlayer.queue("idle");
	
func resume_animation():
	animationPlayer.play();
	
func end_current_animation():
	animationPlayer.stop(false);
	
func attacking():
	end_current_animation();
	shoot();
	paused = true;
	
func shoot():
	sprite.play("shoot");
#func play_patrol_loop():
#	if current_state == IS_ATTACKING:
#		return;
#
#	if !loop_started && current_state == IS_PATROLLING:
#		sprite.set_modulate(Color(1,1,1,1))
#		loop_started = true;
##		idle
#		sprite.play("idle");
#		yield(get_tree().create_timer(2), "timeout")
#
##		run left
#		sprite.play("run");
#		sprite.set_flip_h(false);
#		var tween = create_tween();
#		tween.tween_property(self, "global_position", self.global_position + Vector2(-83, 0), 2);
#		yield(tween, "finished")
#
##		idle
#		sprite.play("idle");
#		yield(get_tree().create_timer(2), "timeout")
#
##		run right
#		sprite.play("run");
#		sprite.set_flip_h(true);
#		var tween2 = create_tween();
#		tween2.tween_property(self, "global_position", self.global_position + Vector2(83, 0), 2);
#		yield(tween2, "finished")
#
##		idle
#		sprite.play("idle");
#		yield(get_tree().create_timer(2), "timeout")
#
#		loop_started = false;
		
func set_attacking_state():
	current_state = IS_ATTACKING;
	
func set_patrolling_state():
	current_state = IS_PATROLLING;

func _on_AnimationPlayer_animation_finished(anim_name):
	patrol();
