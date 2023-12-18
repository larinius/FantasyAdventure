class_name PlayerCharacter
extends Node

@export var health_points : int = 100
@export var mana_points : int = 100
var current_health_points : int
var current_mana_points : int

var abilities = []

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health_points = health_points
	current_mana_points = mana_points

	var sword_slash = preload("res://Abilities/Sword/SwordSlash.tscn").instantiate()
	var fireball = preload("res://Abilities/Fireball/FirebalAbility.tscn").instantiate()
	var ice_needle = preload("res://Abilities/Icicle/IceNeedle.tscn").instantiate()
	var search = preload("res://Abilities/Search/SearchAbility.tscn").instantiate()

	add_child(sword_slash)
	add_child(fireball)
	add_child(ice_needle)
	add_child(search)

	abilities = get_tree().get_nodes_in_group("Abilities")

	connect_signals()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_click(event):
	use_current_ability(event.position)

func use_current_ability(position):
	for ability in abilities:
		if ability.is_usable():
			ability.use(position)

func activate_ability(ability_name: StringName):
	for ability in abilities:
		ability.is_active = (ability.title == ability_name)

	print("ability activated: ", ability_name)

func connect_signals():
	var ability_buttons = get_tree().get_nodes_in_group("Buttons")
	for button in ability_buttons:
			button.connect("activate_ability", activate_ability)

	GameController.connect("on_click", on_click)
