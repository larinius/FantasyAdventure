extends Sprite2D

signal item_found()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	print(body.name)
	emit_signal("item_found", body)
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	print(area.name)
	area.visible = true
	pass # Replace with function body.
