@tool

extends Control

@export var skill_texture : CompressedTexture2D
@export var skill_name : String = "Default"

# Called when the node enters the scene tree for the first time.
func _ready():
	$IconButton.texture_normal = skill_texture
	GameController.connect("active_skill", on_skill)
	pass # Replace with function body.



func _on_icon_button_pressed():
	GameController.on_use_skill(skill_name)
	$AnimationPlayer.play("Active")
	pass # Replace with function body.

func on_skill(new_skill_name : StringName):
	if new_skill_name != skill_name:
		$AnimationPlayer.stop()
	print("Using skill: ", skill_name)
