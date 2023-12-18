extends Node2D


var slash : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_area_entered(area):
	var monster = area.get_parent()
	GameController.on_hit(monster, "SwordSlash")


func ability_effect(click_position):

	if not slash or not slash.find_child("AnimationPlayer").is_playing():

		slash = preload("res://Abilities/Sword/SlashEffect.tscn").instantiate()
		slash.visible = false
		var animation : AnimationPlayer = slash.find_child("AnimationPlayer")

		slash.position = click_position
		slash.visible = true

		animation.connect("animation_finished", _on_animation_finished)

		animation.play("Slash")

		get_tree().get_root().add_child(slash)


func _on_animation_finished(anim_name: String):
	if anim_name == "Slash":
		slash.queue_free()
