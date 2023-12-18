class_name Fireball
extends BaseAbility

func _ready():
	title = "Fireball"
	level = 1
	required_ap = 5
	required_mp = 5
	cooldown = 5

	effect_scene = preload("res://Abilities/Fireball/FireballEffect.tscn")


func use(position):
	super.use(position)
