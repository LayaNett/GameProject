extends Node

@onready var health = 3
@onready var rescued = 0
@onready var ammo = 10
@onready var player = $player
@onready var main = $"."
@onready var label = $player/Camera2D/Label

func _process(_delta):
	
	label.set_text("Hitpoints: " + str(health) 
	+ "\nPeople Rescued: " + str(rescued)
	+ "\nAmmo: " + str(ammo))
	
	if health <= 0:
		main.get_tree().change_scene_to_file("res://Finish/defeat_screen.tscn")
