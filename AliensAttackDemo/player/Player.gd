extends CharacterBody2D

@onready var sprite = $sprite
@onready var level = $".."
@onready var player = $"."

const SPEED = 400.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hit_timer = 0
var reload = 0

func shoot():
	if level.ammo > 0 and reload <= 0:
		reload = .5
		level.ammo -= 1
		var bullet = load("res://bullet/bullet.tscn").instantiate()
		if sprite.flip_h:
			bullet.direction = -1
		else:
			bullet.direction = 1
		bullet.shot_by = player
		bullet.transform.origin = player.transform.origin
		level .add_child(bullet)

func on_hit(_i):
	if hit_timer <= 0:
		level.health -= 1
		hit_timer = 1

func _physics_process(delta):
	if reload > 0:
		reload -= delta
	if hit_timer > 0:
		hit_timer -= delta
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x > 0:
		sprite.flip_h = false
	if velocity.x < 0:
		sprite.flip_h = true

	if Input.is_action_just_pressed("shoot"):
		shoot()

	move_and_slide()
