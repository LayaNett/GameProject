extends Control
func _on_play_again_button_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
