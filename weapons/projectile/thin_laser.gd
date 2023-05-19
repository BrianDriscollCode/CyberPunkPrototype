extends Node2D

onready var player = get_tree().get_root().get_node("Level").get_node("Player");
onready var sprite = get_node("AnimatedSprite");
var current_frame;

onready var area1_collision = get_node("area1/CollisionShape2D");
onready var area2_collision = get_node("area2/CollisionShape2D");
onready var area3_collision = get_node("area3/CollisionShape2D");
onready var area4_collision = get_node("area4/CollisionShape2D");

var velocity;

func _ready():
	if player.get_global_position() < self.global_position:
		velocity = 4;
	else:
		velocity = -4;

func _physics_process(delta):
	current_frame = sprite.get_frame();
	
	self.global_position = self.global_position + Vector2(velocity,0);
	
	if current_frame == 0:
		area1_collision.set_disabled(false);
		area2_collision.set_disabled(true);
		area3_collision.set_disabled(true);
		area4_collision.set_disabled(true);
	elif current_frame == 1:
		area1_collision.set_disabled(true);
		area2_collision.set_disabled(false);
		area3_collision.set_disabled(true);
		area4_collision.set_disabled(true);
	elif current_frame == 2:
		area1_collision.set_disabled(true);
		area2_collision.set_disabled(true);
		area3_collision.set_disabled(false);
		area4_collision.set_disabled(true);
	else:
		area1_collision.set_disabled(true);
		area2_collision.set_disabled(true);
		area3_collision.set_disabled(true);
		area4_collision.set_disabled(false);
		
		
	
