extends RayCast2D


onready var line2D = $Line2D;
onready var tween = $Tween;
onready var parent = get_parent();
var is_casting := false setget set_is_casting;

#Positions 
var player_global_position;
var player_local_position;
var turret_local_position;
var direction_to_player;
#
#func _unhandled_input(event: InputEvent) -> void:
#	if event is InputEventMouseButton:
#		self.is_casting = event.pressed;

func _physics_process(delta):
	set_is_casting(true);
		

func set_is_casting(cast: bool) -> void:
	is_casting = cast;

	if is_casting:
		appear();
	else:
		disappear();
#	set_physics_process(is_casting);

func shoot():
	if is_casting and parent.get_turret_state() == 1:
		line2D.points[1] = (player_local_position - turret_local_position) * Vector2(20, 20)
		self.cast_to = direction_to_player * 400

func appear() -> void:
	$Tween.stop_all();
	$Tween.interpolate_property($Line2d, "width", 0, 10.0, 0.2);
	$Tween.start();

func disappear() -> void:
	$Tween.stop_all();
	$Tween.interpolate_property($Line2d, "width", 0, 10.0, 0.1);
	$Tween.start();

func update_player_position():
	player_global_position = parent.get_player_position()
	player_local_position = parent.to_local(player_global_position)
	turret_local_position = parent.to_local(parent.get_global_position())
	direction_to_player = global_position.direction_to(player_global_position);

#V2
#
#onready var line2D = $Line2D
#onready var tween = $Tween
#onready var parent = get_parent()
#var is_casting: bool = false setget set_is_casting
#
##func _unhandled_input(event: InputEvent) -> void:
##	print("LASER")
##	if event is InputEventMouseButton:
##		self.is_casting = event.pressed;
#
#func _physics_process(delta: float) -> void:
#	if Input.is_action_pressed("testKey"):
#		is_casting = true;
#
#	if is_casting:
#		var collision = get_collider()
#
##		var collision_point = get_collision_point()
#		line2D.visible = true
#		line2D.points[0] = Vector2.ZERO
##		line2D.points[1] = line2D.to_local(collision_point)
#		var player_global_position = parent.get_player_position()
#		var player_local_position = parent.to_local(player_global_position)
#		var turret_local_position = parent.to_local(parent.get_global_position())
#		yield(get_tree().create_timer(0.4), "timeout")
#		line2D.points[1] = (player_local_position - turret_local_position) * Vector2(20, 20)
#		var collision_point = get_collision_point()
#		line2D.points[1] = line2D.to_local(collision_point)
#	else:
#		line2D.visible = false
#
#func set_is_casting(cast: bool) -> void:
#	is_casting = cast
#	if is_casting:
#		appear()
#	else:
#		disappear()
#	set_physics_process(is_casting)
#
#func appear() -> void:
#	$Tween.stop_all()
#	$Tween.interpolate_property(line2D, "width", 0, 10.0, 0.2)
#	$Tween.start()
#
#func disappear() -> void:
#	$Tween.stop_all()
#	$Tween.interpolate_property(line2D, "width", 0, 10.0, 0.1)
#	$Tween.start()
