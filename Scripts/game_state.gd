extends Node

const Item = preload("res://Scripts/game_item.gd")

var world_items : Array = []

var is_searching := false

func _ready():
	test_game_items()

func test_game_items():
	var iron_sword : Item.Sword = Item.Sword.new()
	#world_items.append(iron_sword)
	
	if iron_sword is Item.Sword:
		print("Do something for swords") # It works
	
	if iron_sword is Item.Weapon:
		print("Do something for weapons") # Not fired
	
	if iron_sword is Item.Item:
		print("Do something for all items") # Not fired
	
	print (world_items)


func on_search():
	is_searching = !is_searching

	print("Searching: ", is_searching)
