extends TextureButton

func _ready():
	connect("pressed", _on_press)


func _on_press():
	GameState.on_search()

	if GameState.is_searching:
		$CircleArrows.visible = true
		$AnimationPlayer.play("Rotate")
	else:
		$AnimationPlayer.stop()
		$CircleArrows.visible = false
