@tool

extends Control

@export var skill_texture : CompressedTexture2D
@export var skill_name : String = "Default"

var cooldown : float = 0
var current_cooldown: float = 0
var cooldown_timer: Timer
var is_active : bool = false
var is_cooldown : bool = false

@onready var progress_bar : TextureProgressBar

var player_ability : BaseAbility

signal activate_ability()

func _ready():
	$IconButton.texture_normal = skill_texture
	$IconButton/Border.visible = false
	$IconButton/ProgressCircle.visible = false
	GameController.connect("active_skill", on_active_skill)
	GameController.connect("skill_used", on_skill_used)
	progress_bar = $IconButton/ProgressCircle

	cooldown_timer = Timer.new()
	add_child(cooldown_timer)
	cooldown_timer.connect("timeout", _on_cooldown_timeout)
	cooldown_timer.wait_time = 0.1
	cooldown_timer.start()

	connect_signals()

func _on_icon_button_pressed():
	is_active = true
	emit_signal("activate_ability", skill_name)
	#GameController.on_use_skill(skill_name)
	$AnimationPlayer.play("Active")

func _on_ability_select(ability_name : StringName):
	if ability_name != skill_name:
		is_active = false
		$AnimationPlayer.play("Idle")

	var player = get_tree().get_nodes_in_group("Player")[0]

	for ability in player.abilities:
		if ability.title == skill_name:
			ability.connect("ability_used", on_ability_used)
			player_ability = ability

func on_active_skill(new_skill_name : StringName, skill_cooldown : float):
	if new_skill_name == skill_name:
		is_active = true
		cooldown = skill_cooldown
		current_cooldown = skill_cooldown
		print("Using skill: ", skill_name, ", cooldown ", cooldown)
	else:
		is_active = false
		$AnimationPlayer.stop()
		$AnimationPlayer.play("Idle")


func on_skill_used(new_skill_name : StringName):
	current_cooldown = cooldown

func _on_icon_button_button_down():
	pass
	#GameController.on_use_skill(skill_name)
	#emit_signal("activate_ability", skill_name)


func _on_icon_button_mouse_entered():
	GameController.is_ui_zone(true)


func _on_icon_button_mouse_exited():
	GameController.is_ui_zone(false)

func _on_cooldown_timeout():

	$IconButton/ProgressCircle.visible = is_cooldown
	var is_gray = true if is_cooldown else false
	$IconButton.material.set_shader_parameter("grayscale", is_gray)


	if not is_cooldown:
		return

	current_cooldown -= cooldown_timer.wait_time

	if current_cooldown <= 0.0:
		is_cooldown = false
	else:
		update_progress_bar()


func update_progress_bar():
	var progress_value: float = 1.0 - current_cooldown / cooldown
	progress_bar.value = progress_value * 100


func connect_signals():
	var ability_buttons = get_tree().get_nodes_in_group("Buttons")
	for button in ability_buttons:
			button.connect("activate_ability", _on_ability_select)

func on_ability_used(ability_name : StringName):
	if ability_name == skill_name:
		is_cooldown =  true
		cooldown = player_ability.cooldown
		current_cooldown = player_ability.cooldown
