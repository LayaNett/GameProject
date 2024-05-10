extends Control

@onready var play = $VBoxContainer/Play
@onready var settings = $VBoxContainer/Settings
@onready var quit = $VBoxContainer/Quit
@onready var main = $"."

func _on_play_pressed(): #Loads into the actual game
	main.get_tree().change_scene_to_file("res://levels/level1.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_settings_pressed(): #takes toa diff node that changes the game's settings
	get_tree().change_scene_to_file("res://settings.tscn")
