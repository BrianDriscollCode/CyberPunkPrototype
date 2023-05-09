extends Camera2D


onready var player = get_node("../Player");
onready var player_state_node = get_node("../Player/playerState");
var y_offset = -40;
var x_offset = 0;
var player_direction;

var diff;

func _physics_process(delta):
	player_direction = receive_player_direction();
	if player_direction == "right":
		x_offset = 1;
	elif player_direction == "left":
		x_offset = -1;
	else:
		pass;
		
	diff = self.global_position - (player.global_position + Vector2(x_offset, y_offset));
	
	if player_direction == "right" && abs(diff.x) < 0.3:
		self.global_position = player.global_position + Vector2(x_offset, y_offset);
	else:
		self.global_position = self.global_position.linear_interpolate((player.global_position + Vector2(x_offset, y_offset)), delta * 4.0)
	
	print(self.global_position - (player.global_position + Vector2(x_offset, y_offset)));
	
func receive_player_direction():
	return player_state_node.get_direction();
