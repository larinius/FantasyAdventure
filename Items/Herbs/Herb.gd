extends Area2D

func _ready():
	visible = false
	GameController.connect("rebuild_scene", on_rebuild_scene)
	set_random_position()


func set_random_position():
	if visible:
		return
	var screen_size = get_viewport_rect().size
	var lower_half_height = screen_size.y / 2
	var random_position = Vector2(randf_range(0, screen_size.x), randf_range(lower_half_height, screen_size.y))

	position = random_position

func on_rebuild_scene():
	print ("Refreshing items")
	set_random_position()


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# This block will be executed when the left mouse button is clicked
		handle_mouse_click(event.position)
	pass

func handle_mouse_click(position):
	print("Mouse clicked at: ", position, name)
	GameController.pick_up(self)

func pick_up():
	print("Item picked up ", name)

func destroy():
	print("Item destroyed ", name)
	queue_free()
