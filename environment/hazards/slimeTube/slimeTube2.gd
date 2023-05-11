extends Node2D

onready var slime_animation = $SlimeAnimation;

onready var timer = $Timer;
var randomGenerator = RandomNumberGenerator.new();
var randomNumber;
var drop_slime = true;

onready var slimeCollisionArea = $slimeCollisionArea;

func _ready():
	slimeCollisionArea.position = Vector2(1.5, -257);


func _physics_process(delta):
	if drop_slime == true:
		slime_animation.play("default");
		drop_slime = false;
		
	if slime_animation.get_frame() == 1:
		slimeCollisionArea.position = Vector2(1.5, -257);
	elif slime_animation.get_frame() == 2:
		slimeCollisionArea.position = Vector2(1.5, -213);
	elif slime_animation.get_frame() == 3:
		slimeCollisionArea.position = Vector2(1.5, -188);
	elif slime_animation.get_frame() == 4:
		slimeCollisionArea.position = Vector2(1.5, -138);
	elif slime_animation.get_frame() == 4:
		slimeCollisionArea.position = Vector2(1.5, -114);
	elif slime_animation.get_frame() == 5:
		slimeCollisionArea.position = Vector2(1.5, -90);
	elif slime_animation.get_frame() == 6:
		slimeCollisionArea.position = Vector2(1.5, -88);
	elif slime_animation.get_frame() == 7:
		slimeCollisionArea.position = Vector2(1.5, -52);
	elif slime_animation.get_frame() == 8:
		slimeCollisionArea.position = Vector2(1.5, -23);
	elif slime_animation.get_frame() == 9:
		slimeCollisionArea.position = Vector2(1.5, 23);
	elif slime_animation.get_frame() == 11:
		slimeCollisionArea.position = Vector2(1.5, 49);
	elif slime_animation.get_frame() == 11:
		slimeCollisionArea.position = Vector2(1.5, 73);
	elif slime_animation.get_frame() == 12:
		slimeCollisionArea.position = Vector2(1.5, 92);
	elif slime_animation.get_frame() == 14:
		randomGenerator.randomize();
		randomNumber = randomGenerator.randf_range(3.0, 5.0)
		print(randomNumber)
		print(15)
		timer.set_wait_time(randomNumber) 
		timer.start();
	else:
		pass;
		

func _on_Timer_timeout():
#	print("drop slime")
	print(randomNumber)
	slime_animation.set_frame(0) 
	drop_slime = true;

