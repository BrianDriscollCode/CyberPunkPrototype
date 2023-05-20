extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_tree().get_current_scene().get_node("Player");
onready var on_screen_notifier = get_node("VisibilityNotifier2D");
const SPEED = 4;
var move_left = false;
var move_right = false;
var direction_chosen = false;
var can_queue_free = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	if on_screen_notifier.is_on_screen():
		can_queue_free = true;
	
	if !on_screen_notifier.is_on_screen() && can_queue_free:
		self.queue_free();
	
	print(player.get_global_position(), self.get_global_position());
	
	if player.get_global_position().x < self.get_global_position().x && !direction_chosen:
		move_left = true;
		
	elif player.get_global_position().x > self.get_global_position().x && !direction_chosen:
		move_right = true;

	
	if move_left:
		self.global_position.x -= SPEED;
	elif move_right: 
		self.global_position.x += SPEED;

