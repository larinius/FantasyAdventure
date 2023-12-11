class_name MonsterFSM extends Node

var abilities : Array[MonsterAbility] = []
var action_points = 0

enum MonsterState {
	IDLE,
	AGGRESSIVE,
	DAMAGE,
	RETREAT,
	DEAD
}

var current_state : MonsterState = MonsterState.IDLE
var timer : Timer
var stats : MonsterStats

# Called when the node enters the scene tree for the first time.
func _ready():
	var bash = BashAttack.new()
	var acid = AcidSpitAttack.new()

	abilities.append(bash)
	abilities.append(acid)


	timer = Timer.new()
	timer.wait_time = 0.5
	timer.connect("timeout", update_ai)
	add_child(timer)
	timer.start()

	GameController.connect("take_damage", take_damage)
	stats = $Stats


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func transition_to_state(new_state : MonsterState) -> void:
	current_state = new_state
	on_state_enter(current_state)

func on_state_enter(state : MonsterState) -> void:
	match state:
		MonsterState.IDLE:
			#print(current_state)
			pass
		MonsterState.DAMAGE:
			pass
			# Logic for entering IDLE state
		MonsterState.AGGRESSIVE:
			#print(current_state)
			pass
			# Logic for entering AGGRESSIVE state
		MonsterState.RETREAT:
			#print(current_state)
			pass
			# Logic for entering RETREAT state
		MonsterState.DEAD:
			on_die()
			pass
			# Logic for entering DEAD state


func update_ai() -> void:
	#print("Updating AI ", action_points, " ap")
	action_points += 1

	match current_state:
		MonsterState.IDLE:
			idle_logic()
			pass
			# Logic for IDLE state
		MonsterState.AGGRESSIVE:
			# Logic for AGGRESSIVE state
			perform_attack()
		MonsterState.RETREAT:
			pass
			# Logic for RETREAT state
		MonsterState.DEAD:

			pass
			# Logic for DEAD state

func perform_attack() -> void:
	#print("Attack")
	for ability in abilities:
		if ability.required_ap <= action_points:
			use_ability(ability)
	transition_to_state(MonsterState.IDLE)

func idle_logic():
	#print("Idle logic, ", current_state)
	var anim = get_parent().get_node("AnimationPlayer")
	if not anim.is_playing():
		anim.play("Idle")

	for ability in abilities:
		if ability.required_ap <= action_points and ability.is_usable(get_parent()):
			transition_to_state(MonsterState.AGGRESSIVE)

func use_ability(ability : MonsterAbility):
	action_points -= ability.required_ap
	var target = get_tree().get_nodes_in_group("Player")[0]
	ability.perform(get_parent(), target)

func take_damage(amount : float):
	transition_to_state(MonsterState.DAMAGE)
	on_damage(amount)

func on_damage(amount : float):
	print("Got damage ", amount)
	var anim = get_parent().get_node("AnimationPlayer")
	if not anim.is_playing():
		anim.play("Damage")
	else:
		anim.stop()
		anim.play("Damage")
	stats.hp -= amount
	if stats.hp <= 0:
		transition_to_state(MonsterState.DEAD)
	else:
		transition_to_state(MonsterState.IDLE)


func on_die():
	var anim = get_parent().get_node("AnimationPlayer")
	if not anim.is_playing():
		anim.play("Die")
	else:
		anim.stop()
		anim.play("Die")
