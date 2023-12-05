extends Node

const BASE_COIN_VALUE = 1.38 	# Copper coin value ~1.38
const SILVER2COPPER = 60		# Silver coin value ~83
const GOLD2COPPER = 24 * 60 	# Gold coin value ~2000

class Item:
	var id : int
	var name : String
	var price : float
	var weight : float
		
	func _init():
		id = Utils.unique_item_id()
		price = 0.0
		weight = 0.0
		name = ""
		GameState.world_items.append(self)
	
class Weapon extends Item:
	func _init():
		super._init()
		price = 100
		weight = 1.0

class Money extends Item:
	func _init():
		super._init()

class GoldCoin extends Money:
	func _init():
			super._init()
			price = BASE_COIN_VALUE * GOLD2COPPER

class SilverCoin extends Money:
	func _init():
		super._init()
		price = BASE_COIN_VALUE * SILVER2COPPER

class CopperCoin extends Money:
	func _init():
		super._init()
		price = BASE_COIN_VALUE

class Sword extends Weapon:
	func _init():
		super._init()
		weight = 1.5
		price = 83.3
	
class Bow extends Weapon:
	func _init():
		super._init()
		weight = 2.0
		price = 40.0

class Knife extends Weapon:
	func _init():
		super._init()
		weight = 0.5
		price = 30.0

class Club extends Weapon:
	func _init():
		super._init()
		weight = 3.0
		price = 10.0

class Herb extends Item:
	func _init():
		super._init()
		
class Drop extends Item:
	func _init():
		super._init()
		

class CraftMaterial extends Item:
	func _init():
		super._init()

class Ore extends CraftMaterial:
	func _init():
		super._init()

class Wood extends CraftMaterial:
	func _init():
		super._init()

class MonsterPart extends CraftMaterial:
	func _init():
		super._init()

class Potion extends Item:
	func _init():
		super._init()
		price = 60
		weight = 0.1
