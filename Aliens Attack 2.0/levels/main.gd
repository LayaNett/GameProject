extends Node

@onready var health = 3
@onready var rescued = 0
@onready var ammo = 10
@onready var player = $player
@onready var main = $"."
@onready var healthbar = $player/Camera2D/Panel/healthbar
@onready var ammo_count = $player/Camera2D/Panel/ammo
@onready var rescue_count = $player/Camera2D/Panel/rescues

func _process(_delta):
	
	if health > 2:
		health = 3
		healthbar.texture = load("res://UI/full_health.png")
	elif health == 2:
		healthbar.texture = load("res://UI/two_health.png")
	elif health == 1:
		healthbar.texture = load("res://UI/one_health.png")
	elif health <= 0:
		main.get_tree().change_scene_to_file("res://Finish/defeat_screen.tscn")
	
	rescue_count.set_text("X " + str(rescued))
	
	ammo_count.set_text("X " + str(ammo))
