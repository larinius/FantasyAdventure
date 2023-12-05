extends Area2D


func _ready():
	visible = false
	set_random_position()

func set_random_position():
	var screen_size = get_viewport_rect().size
	var lower_half_height = screen_size.y / 2
	var random_position = Vector2(randf_range(0, screen_size.x), randf_range(lower_half_height, screen_size.y))
	
	position = random_position

