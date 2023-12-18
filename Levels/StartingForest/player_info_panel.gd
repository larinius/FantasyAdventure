extends HBoxContainer


@onready var player
@onready var hp_bar = find_child("HealthBar")
@onready var mp_bar = find_child("ManaBar")

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	hp_bar.max_value = player.health_points
	mp_bar.max_value = player.mana_points
	hp_bar.value = hp_bar.max_value
	mp_bar.value = mp_bar.max_value

	GameController.connect("update_player_panel", update)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update():
	hp_bar.value = player.health_points
	mp_bar.value = player.mana_points
