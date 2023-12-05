extends Node

var circle : Sprite2D

signal rebuild_scene()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and GameState.is_searching:
		var search_button = get_tree().get_root().get_node("Forest/CanvasLayer/SearchButton")
				
		var search_button_rect = Rect2(search_button.global_position.x, search_button.global_position.y, search_button.size.x, search_button.size.y)
		
		if search_button_rect.has_point(event.global_position):
			return 
		
		if not circle or not circle.find_child("AnimationPlayer").is_playing():

			circle = preload("res://UI/Search/circle_effect.tscn").instantiate()
			circle.visible = false
			var animation : AnimationPlayer = circle.find_child("AnimationPlayer")
			var click_radius = 32
			
			circle.position = event.position
			circle.visible = true
			
			# Connect to the animation_finished signal
			animation.connect("animation_finished", _on_animation_finished)

			animation.play("Expand")
			
			get_tree().get_root().add_child(circle)


# Signal handler for animation_finished
func _on_animation_finished(anim_name: String):
	if anim_name == "Expand":
		circle.queue_free()
	emit_signal("rebuild_scene")
