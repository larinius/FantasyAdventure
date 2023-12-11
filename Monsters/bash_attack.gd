extends MonsterAbility
class_name BashAttack

func _ready():
	pass

func _init():
	title = "BashAttack"
	damage = 10
	required_mp = 0
	required_ap = 3
	cooldown = 10

func perform(owner : Object, target : Object) -> void:
	if is_usable(owner):
		super.perform(owner, target)
		var anim = owner.get_node("AnimationPlayer")
		anim.play("Attack")


