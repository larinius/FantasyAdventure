class_name MonsterAbility extends Node

var title : StringName = "Base ability"
var damage : int = 0
var required_mp : int = 0
var required_ap : int = 0
var cooldown : float = 0
var last_used_time : float = 0

func _ready():
	pass

func _process(_delta):
	pass

func is_usable(owner : Node) -> bool:
	var anim = owner.get_node("AnimationPlayer")
	return (Time.get_unix_time_from_system() - last_used_time) >= cooldown and anim.get_current_animation() == "Idle"

func perform(owner : Object, target : Object) -> void:
	if is_usable(owner):
		owner.current_ability = self
		owner.current_target = target
		last_used_time = Time.get_unix_time_from_system()
		GameController.on_monster_ability(owner, self, target)

	else:
		print("Ability on cooldown")


