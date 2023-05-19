extends Node

onready var scene = get_tree().get_current_scene();

onready var player = get_tree().get_root().get_node("./Level/Player")

onready var container = get_parent().get_parent();
onready var parent = get_parent();
onready var sprite = get_node("../../AnimatedSprite");
onready var shoot_anim = get_node("../../shoot_anim");
onready var bullet_spawn = get_node("../../bullet_spawn");

onready var attacking_area = get_node("../../attacking_area");

var laser;

var current_state;

var attack_animation_on = false;
var can_shoot = true;
onready var shoot_timer = get_node("../../shoot_timer");

func _ready():
	laser = load("res://weapons/laser/thin_laser.tscn")

func _physics_process(delta):
	current_state = parent.get_current_state();
	
	if parent.get_current_state() == self:
		if !attack_animation_on:
			print("PLAY ATTACK")
			shoot_anim.set_visible(true);
			shoot_anim.play("default");
			attack_animation_on = true;
		if attack_animation_on:
			if shoot_anim.get_frame() == 5 && can_shoot:
				shoot_anim.set_visible(false);
				shoot();
				
func shoot():
	var laser_instance = laser.instance();
	scene.add_child(laser_instance);
	laser_instance.global_position = bullet_spawn.get_global_position();
	can_shoot = false;
	shoot_timer.start()
	

func _on_shoot_timer_timeout():
	print("timer done")
	can_shoot = true;
	attack_animation_on = false
	shoot_anim.set_frame(0);
	shoot_anim.stop();
	
func reset():
	can_shoot = true;
	attack_animation_on = false
	shoot_anim.set_frame(0);
	shoot_anim.stop();
	
