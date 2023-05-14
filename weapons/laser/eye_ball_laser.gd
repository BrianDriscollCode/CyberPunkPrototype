extends RayCast2D

var is_casting := false setget set_is_casting;
var cast_point := cast_to;

var player = get_parent();

func _ready() -> void:
	set_physics_process(false);
	$Line2D.points[1] = Vector2.ZERO;

func _unhandled_input(event: InputEvent) -> void:
	print("LASER")
	if event is InputEventMouseButton:
		self.is_casting = event.pressed;

func _physics_process(delta):
	var cast_point := global_position.direction_to(Vector2(-14,410));
	force_raycast_update();
	
	if is_colliding():
		cast_point = to_local(get_collision_point());

	
	$Line2D.points[1] = cast_point;
	
func set_is_casting(cast: bool) -> void:
	is_casting = cast;
	
	if is_casting:
		appear();
	else:
		disappear();
	set_physics_process(is_casting);
	
func appear() -> void:
	$Tween.stop_all();
	$Tween.interpolate_property($Line2d, "width", 0, 10.0, 0.2);
	$Tween.start();
	
func disappear() -> void:
	$Tween.stop_all();
	$Tween.interpolate_property($Line2d, "width", 0, 10.0, 0.1);
	$Tween.start();
	
