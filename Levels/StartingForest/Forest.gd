extends Node2D

var searching := false

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func on_search_toggle():
	if searching:
		searching = false
	else:
		searching = true

	print("Search: ", searching)
