extends AnimatedSprite2D

var shader_material : ShaderMaterial

func _ready():
	shader_material = ShaderMaterial.new()
	shader_material.shader = preload("res://Abilities/Fireball/FireballEffect.gdshader")
	material = shader_material

func _process(_delta):
	# Update the "noise_tex" uniform in the shader with the current frame texture

	var txr = get_sprite_frames().get_frame_texture(get_animation(), get_frame())

	material.set_shader_parameter("gradient_tex", txr)
	material.set_shader_parameter("noise_tex", txr)

	pass
