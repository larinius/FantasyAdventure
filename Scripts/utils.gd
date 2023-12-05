extends Node


var uuid_counter := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


func convertToCoins(amount_in_dollars: float) -> String:
	var gold_value: float = 2000.0
	var silver_value: float = gold_value / 24
	var copper_value: float = silver_value / 60
	var penny_value: float = copper_value / 12
	
	var gold_count: int = int(amount_in_dollars / gold_value)
	var remaining_amount: float = fmod(amount_in_dollars, gold_value)
	
	var silver_count: int = int(remaining_amount / silver_value)
	remaining_amount = fmod(remaining_amount, silver_value)
	
	var copper_count: int = int(remaining_amount / copper_value)
	remaining_amount = fmod(remaining_amount, copper_value)
	
	var penny_count: int = int(remaining_amount / penny_value + 0.5) # Round up
	
	var result: String = ""
	
	if gold_count > 0:
		result += str(gold_count) + "G"
	
	if silver_count > 0:
		if result != "":
			result += ", "
		result += str(silver_count) + "S"
	
	if copper_count > 0:
		if result != "":
			result += ", "
		result += str(copper_count) + "C"
	
	if penny_count > 0:
		if result != "":
			result += ", "
		result += str(penny_count) + "P"
	
	return result


func unique_item_id() -> int:
	var timestamp := int(Time.get_unix_time_from_system())
	var rand_part := randi()

	# Combine timestamp and random part to create a unique ID
	var uuid = (timestamp << 32) | rand_part

	# Increment a counter to ensure uniqueness in case of rapid calls
	uuid_counter += 1

	# Combine the counter with the previous UUID
	uuid = (uuid << 32) | uuid_counter

	return uuid
