extends CharacterBody2D

@onready var hitbox = $hitbox
@onready var sprite = $AnimatedSprite2D
@onready var main = $"../.."

var timer = 3
var free = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if free == true:
		if timer > 0:
			timer -= 1 * delta
		else:
			queue_free()
	
	move_and_slide()

#Makes human disappear when collected
func _on_hitbox_body_entered(body):
	if (body.name == "player"):
		hitbox.queue_free()
		sprite.transform.origin += Vector2(0, -10)
		sprite.play("celebrate")
		main.rescued += 1
		free = true
		print("Human collected")
