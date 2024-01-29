@tool

extends Control

@export var skill_texture : CompressedTexture2D
@export var skill_name : String = "Default"

var cooldown : float = 0
var current_cooldown: float = 0
var cooldown_timer: Timer
var is_active : bool = false
var is_cooldown : bool = false

@onready var progress_bar : TextureProgressBar = $IconButton/ProgressCircle

var player_ability : BaseAbility

signal activate_ability()
const COOLDOWN_UPDATE_INTERVAL: float = 0.1

func _ready():
	$IconButton.texture_normal = skill_texture
	$IconButton/Border.visible = false
	$IconButton/ProgressCircle.visible = false
	connect_signals()
	start_timer()

#region UI signals handlers
func _on_icon_button_pressed():

	is_active = true
	emit_signal("activate_ability", skill_name)
	$AnimationPlayer.play("Active")


func _on_icon_button_button_down():
	pass


func _on_icon_button_mouse_entered():
	GameController.is_ui_zone(true)


func _on_icon_button_mouse_exited():
	GameController.is_ui_zone(false)

#endregion


#region Ability handlers

func on_ability_used(ability_name : StringName):
	if ability_name == skill_name:
		is_cooldown =  true
		cooldown = player_ability.cooldown
		current_cooldown = player_ability.cooldown


func on_ability_selected(ability_name : StringName):
	print("on_ability_selected")
	if ability_name != skill_name:
		is_active = false
		$AnimationPlayer.play("Idle")

	var player = get_tree().get_nodes_in_group("Player")[0]

	for ability in player.abilities:
		if ability.title == skill_name:
			player_ability = ability

#endregion


#region Helpers
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
			button.connect("activate_ability", on_ability_selected)

	var player = get_tree().get_nodes_in_group("Player")[0]
	for ability in player.abilities:
		if ability.title == skill_name:
			ability.connect("ability_used", on_ability_used)


func start_timer():
	cooldown_timer = Timer.new()
	add_child(cooldown_timer)
	cooldown_timer.connect("timeout", _on_cooldown_timeout)
	cooldown_timer.wait_time = COOLDOWN_UPDATE_INTERVAL
	cooldown_timer.start()

#endregion
