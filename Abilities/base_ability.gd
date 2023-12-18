class_name BaseAbility extends Node

@export var icon : CompressedTexture2D = preload("res://Abilities/default.png")
@export var title : StringName = "Base Ability"
@export var level : int = 0
@export var required_mp : int = 0
@export var required_ap : int = 0
@export var cooldown : float = 0
@export_multiline var description : String = ""

var damages : Array[DamageType] = []
var last_used_time : float = 0
var is_active : bool = false

var effect : Node2D
var effect_scene : PackedScene

signal ability_used()

func _ready():
	pass # Replace with function body.

func _init():
	add_to_group("Abilities")

func is_usable() -> bool:
	var cooldown_ready = Time.get_unix_time_from_system() - last_used_time >= cooldown
	var usable = cooldown_ready and is_active
	return usable

func use(point):
	last_used_time = Time.get_unix_time_from_system()
	print("Ability, using ", title)

	if effect_scene != null:
		var effect = effect_scene.instantiate()
		effect.visible = false
		if effect != null:
			get_tree().get_root().add_child(effect)
			effect.ability_effect(point)
			emit_signal("ability_used", title)
		else:
			print("Error: Unable to instantiate Effect")
	else:
		print("Error: Unable to preload Effect scene")

