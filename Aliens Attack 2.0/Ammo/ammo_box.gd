extends RigidBody2D

@onready var level = $"../.."

func _on_body_entered(body):
	if body.name == "player":
		level.ammo += (randi() % 5) + 5
		queue_free()
