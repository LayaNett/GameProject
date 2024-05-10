extends CharacterBody2D

@onready var parent = $'..'
@onready var sprite = $sprite
@onready var player = $"../../player"
@onready var alien = $"."

@onready var direction = 1
@onready var hitting = false

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var move_time = 0

func smack(enemy):
	velocity.x = 0
	if enemy.transform.origin.x > transform.origin.x:
		sprite.flip_h = true
		sprite.transform.origin.x = 34
	elif enemy.transform.origin.x < transform.origin.x:
		sprite.flip_h = false
		sprite.transform.origin.x = -34
	sprite.play("smack")
	hitting = true
	direction = 0
	enemy.on_hit(alien)

func on_hit(i):
	if i.direction == direction:
		queue_free()

func _physics_process(delta):
	if move_time > 0:
		move_time -= delta
	
	if velocity.x > 0:
		sprite.flip_h = true
		sprite.transform.origin = Vector2(34, -17)
	if velocity.x < 0:
		sprite.flip_h = false
		sprite.transform.origin = Vector2(-34,-17)
	
	if is_on_wall() and not hitting:
		direction *= -1
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if (move_time <= 0 or direction == 0) and not hitting:
		direction = (randi() % 3) - 1
		move_time = (randi() % 2) + 3
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_range_entered(body):
	if body.name == "player":
		smack(body)


func _on_sprite_animation_finished():
	sprite.play("walk")
	hitting = false


func _on_left_foot_body_exited(body):
	direction *= -1


func _on_right_foot_body_exited(body):
	direction *= -1
