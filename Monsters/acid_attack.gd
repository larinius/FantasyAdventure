extends MonsterAbility
class_name AcidSpitAttack

func _ready():
	pass

func _init():
	title = "AcidSpit"
	damage = 3
	required_mp = 5
	required_ap = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func perform(owner : Object, target : Object) -> void:
	super.perform(owner, target)

