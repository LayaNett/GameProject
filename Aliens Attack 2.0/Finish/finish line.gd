extends Area2D

@onready var finish_line = $"."
@onready var player = $"../player"
@onready var node = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for i in finish_line.get_overlapping_bodies():
		if i == player:
			node.get_tree().change_scene_to_file("res://Finish/victory.tscn")
