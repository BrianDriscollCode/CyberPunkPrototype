extends Node

var CURRENT_ENEMY_STATE;

# Pathing
onready var path = get_node("../../Path2D/PathFollow2D");
onready var current_offset = path.get_unit_offset();

onready var sprite = get_node("../../Path2D/PathFollow2D/AnimatedSprite");
onready var timer = get_node("../../PatrolTimer");

#detect
onready var leftRayCast = get_node("../../Path2D/PathFollow2D/RayCastLeft");
onready var leftRayCast2 = get_node("../../Path2D/PathFollow2D/RayCastLeft2");
onready var leftRayCast3 = get_node("../../Path2D/PathFollow2D/RayCastLeft3");

onready var rightRayCast = get_node("../../Path2D/PathFollow2D/RayCastRight");
onready var rightRayCast2 = get_node("../../Path2D/PathFollow2D/RayCastRight2");
onready var rightRayCast3 = get_node("../../Path2D/PathFollow2D/RayCastRight3");

var animation_steps = ["move_right", "idle", "move_left", "idle"]
var step = 0;
var timer_started = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	CURRENT_ENEMY_STATE = get_parent().get_state();
	if CURRENT_ENEMY_STATE == self:
		get_current_offset();
		run_animations(delta);

func run_animations(delta):
	# Change step in animation steps based on the offset of "path" and the "step" number
	if current_offset == 1 && step == 0:
		step = 1;
	if current_offset == 0 && step == 2:
		step = 3;

	if step == 0:
		move_right(delta)
		leftRayCast.set_enabled(true);
		leftRayCast2.set_enabled(true);
		leftRayCast3.set_enabled(true);
		rightRayCast.set_enabled(false);
		rightRayCast2.set_enabled(false);
		rightRayCast3.set_enabled(false);
	elif step == 1:
		sprite.play("idle")
		# start idle timer to increase step to "2"
		if !timer_started:
			timer.start();
			timer_started = true;
	elif step == 2:
		move_left(delta);
		leftRayCast.set_enabled(false);
		leftRayCast2.set_enabled(false);
		leftRayCast3.set_enabled(false);
		rightRayCast.set_enabled(true);
		rightRayCast2.set_enabled(true);
		rightRayCast3.set_enabled(true);
	elif step == 3:
		sprite.play("idle")
		# start idle timer to increase step to "2"
		if !timer_started:
			timer.start();
			timer_started = true;
	else:
		pass;

func move_right(delta):
	sprite.play("run");
	path.set_offset(path.get_offset() + 55 * delta);
	sprite.set_flip_h(false);
	
func move_left(delta):
	sprite.play("run");
	path.set_offset(path.get_offset() - 55 * delta);
	sprite.set_flip_h(true);
	
	
func get_current_offset():
	current_offset = path.get_unit_offset();

func _on_Timer_timeout():
	if step < 3:
		step += 1;
	else: 
		step = 0;
	timer_started = false;
