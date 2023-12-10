@tool

extends Control

@export var skill_texture : CompressedTexture2D
@export var skill_name : String = "Default"

func _ready():
	$IconButton.texture_normal = skill_texture
	GameController.connect("active_skill", on_skill)

func _on_icon_button_pressed():
	GameController.on_use_skill(skill_name)
	$AnimationPlayer.play("Active")

func on_skill(new_skill_name : StringName):
	if new_skill_name != skill_name:
		$AnimationPlayer.stop()
	print("Using skill: ", skill_name)

func _on_icon_button_button_down():
	GameController.on_use_skill(skill_name)


func _on_icon_button_mouse_entered():
	GameController.is_ui_zone(true)


func _on_icon_button_mouse_exited():
	GameController.is_ui_zone(false)

