extends CharacterBody2D

@onready var bullet = $'.'
@onready var sprite = $sprite
@onready var hitbox = $hitbox
@onready var direction  ## should be initialized as the direction of the shooter 
@onready var shot_by ## should be initialized as the node path of the shooter

const SPEED = 600.0

var lifespan = 3

func _physics_process(delta):
	if lifespan > 0:
		lifespan -= delta
	else:
		queue_free()
	if is_on_wall():
		pass #queue_free()
	
	if velocity.x > 0:
		sprite.flip_h = false
	if velocity.x < 0:
		sprite.flip_h = true
	
	# Get the direction and handle the movement/deceleration.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var objects = hitbox.get_overlapping_bodies()
	for i in objects:
		if ( ( i.name == "player" or ( "parent" in i and i.parent.name == "Aliens" ) ) and i != shot_by ):
			i.on_hit(bullet)
			queue_free()
		elif i.name == "TileMap":
			queue_free()
	
	move_and_slide()
