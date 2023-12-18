class_name SwordSlash
extends BaseAbility



# Called when the node enters the scene tree for the first time.
func _ready():

	title = "SwordSlash"
	level = 1
	required_ap = 5
	required_mp = 0
	cooldown = 3

	effect_scene = preload("res://Abilities/Sword/SlashEffect.tscn")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
