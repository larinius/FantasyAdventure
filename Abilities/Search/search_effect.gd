extends Sprite2D

signal item_found()


func _on_area_2d_body_entered(body):
	emit_signal("item_found", body)


func _on_area_2d_area_entered(area):
	area.visible = true


func ability_effect(point):

	if not find_child("AnimationPlayer").is_playing():

		visible = false
		var animation : AnimationPlayer = find_child("AnimationPlayer")

		position = point

		animation.connect("animation_finished", _on_animation_finished)
		animation.play("Expand")
		visible = true


func _on_animation_finished(anim_name: String):
	if anim_name == "Search":
		self.queue_free()
