extends CharacterBody2D

@onready var parent = $'..'
@onready var sprite = $sprite
@onready var player = $"../../player"
@onready var alien = $"."
@onready var level = $'../..'

var direction = 1
var shooting = false
var reload = 0

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var move_time = 0

func shoot(enemy):
	if reload <= 0:
		reload = 1
		direction = 0
		velocity.x = 0
		if enemy.transform.origin.x > transform.origin.x:
			sprite.flip_h = false
		elif enemy.transform.origin.x < transform.origin.x:
			sprite.flip_h = true
		sprite.play("shoot")
		shooting = true
		var bullet = load("res://bullet/bullet.tscn").instantiate()
		if sprite.flip_h:
			bullet.direction = -1
		else:
			bullet.direction = 1
		bullet.shot_by = alien
		bullet.transform.origin = transform.origin
		level.add_child(bullet)

func on_hit(_i):
	queue_free()

func _physics_process(delta):
	if reload > 0:
		reload -= delta
	
	if move_time > 0:
		move_time -= delta
	
	if velocity.x > 0:
		sprite.flip_h = false
	if velocity.x < 0:
		sprite.flip_h = true
	
	if is_on_wall() and not shooting:
		direction *= -1
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if (move_time <= 0 or direction == 0) and not shooting:
		direction = (randi() % 3) - 1
		move_time = (randi() % 2) + 3
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_range_entered(body):
	if body.name == "player":
		shoot(body)


func _on_sprite_animation_finished():
	sprite.play("walk")
	shooting = false


func _on_left_foot_body_exited(body):
	direction *= -1


func _on_right_foot_body_exited(body):
	direction *= -1
