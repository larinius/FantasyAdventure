extends Node

var circle : Sprite2D
var slash : Node2D
var explosion : Node2D
var is_ui := false

signal rebuild_scene()
signal active_skill(skill_name : StringName)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and GameState.active_skill == "Search":
		if not is_ui:
			search_effect(event)
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and GameState.active_skill == "SwordSlash":
		if not is_ui:
			slash_effect(event)
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and GameState.active_skill == "Fireball":
		if not is_ui:
			explosion_effect(event)


# Signal handler for animation_finished
func _on_animation_finished(anim_name: String):

	if anim_name == "Expand":
		circle.queue_free()
		emit_signal("rebuild_scene")

	if anim_name == "Slash":
		slash.queue_free()
	
	if anim_name == "Explosion":
		explosion.queue_free()


func search_effect(event : InputEvent):
	var search_button = get_tree().get_root().get_node("Forest/CanvasLayer/SearchButton")
			
	
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


func slash_effect(event : InputEvent):
	
	if not slash or not slash.find_child("AnimationPlayer").is_playing():

		slash = preload("res://Skills/Sword/Slash.tscn").instantiate()
		slash.visible = false
		var animation : AnimationPlayer = slash.find_child("AnimationPlayer")
	
		slash.position = event.position
		slash.visible = true
		
		animation.connect("animation_finished", _on_animation_finished)

		animation.play("Slash")
		
		get_tree().get_root().add_child(slash)
		

func explosion_effect(event : InputEvent):
	
	if not explosion or not explosion.find_child("AnimationPlayer").is_playing():

		explosion = preload("res://Skills/Fireball/FireballEffect.tscn").instantiate()
		explosion.visible = false
		var animation : AnimationPlayer = explosion.find_child("AnimationPlayer")
	
		explosion.position = event.position
		explosion.visible = true
		
		animation.connect("animation_finished", _on_animation_finished)

		animation.play("Explosion")
		
		get_tree().get_root().add_child(explosion)



func on_use_skill(skill_name : String):
	GameState.active_skill = skill_name
	emit_signal("active_skill", skill_name)
	print("Using: ", GameState.active_skill)

func is_ui_zone(zone : bool):
	is_ui = zone

func on_hit(monster : Node2D, skill : StringName):
	print("Hit: ", monster.name, skill)
