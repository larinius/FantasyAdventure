extends Node2D

var explosion : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_area_entered(area):
	var monster = area.get_parent()
	GameController.on_hit(monster, "Fireball")

func ability_effect(click_position):

	if not explosion or not explosion.find_child("AnimationPlayer").is_playing():

		explosion = preload("res://Abilities/Fireball/FireballEffect.tscn").instantiate()
		explosion.visible = false
		var animation : AnimationPlayer = explosion.find_child("AnimationPlayer")

		explosion.position = click_position
		explosion.visible = true

		animation.connect("animation_finished", _on_animation_finished)

		animation.play("Explosion")

		get_tree().get_root().add_child(explosion)


func _on_animation_finished(anim_name: String):
	if anim_name == "Explosion":
		explosion.queue_free()
