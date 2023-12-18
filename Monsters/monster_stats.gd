class_name MonsterStats extends Node

@export var title : String = "Slime"
@export var hp : int = 10
@export var mp : int = 0
var current_hp : int = 10
var current_mp : int = 0
@export var level : int = 1
@export var str : int = 5
@export var evasion : int = 10
@export var pdef : int = 0

@export var fire_resist : int = 20
@export var water_resist : int = 10
@export var air_resist : int = 5
@export var electro_resist : int = 0
@export var ice_resist : int = 0
@export var earth_resist : int = 0

@onready var hp_bar = find_child("HealthBar")
@onready var title_info = find_child("Title")
@onready var level_info = find_child("Level")
@onready var info = find_child("Info")

func _ready():
	hp_bar.max_value = hp
	title_info.text = str(title)
	level_info.text = "%d Lvl" % level

	current_hp = hp
	current_mp = mp

func update_info():
	hp_bar.value = current_hp
	if current_hp <= 0:
		info.visible = false
