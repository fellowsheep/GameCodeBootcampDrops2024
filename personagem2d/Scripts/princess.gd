extends CharacterBody2D


const SPEED = 300.0
const STAIRS_SPEED = 50.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite = $AnimatedSprite2D

var onStair
var onTopStair

func _ready() -> void:
	onStair = false
	onTopStair = false

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor() and not onStair:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or onTopStair) :
		velocity.y = JUMP_VELOCITY
		onTopStair = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	# Get the input direction -1, 0, 1
	var directionX := Input.get_axis("moveLeft", "moveRight")
	var directionY := Input.get_axis("moveUp", "moveDown")
	
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if onStair:
		if directionY:
			velocity.y = directionY * STAIRS_SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, STAIRS_SPEED)

	# Switch the animations
	if not onStair or onTopStair:
		if is_on_floor():
			if directionX == 0:
				animated_sprite.play("idle")
			if directionX == -1:
				animated_sprite.play("walkLeft")
			if directionX == 1:
				animated_sprite.play("walkRight")
		else:
			if directionX == -1:
				animated_sprite.play("jumpLeft")
			elif directionX == 1:
				animated_sprite.play("jumpRight")
			else:
				animated_sprite.play("jumpFront")
			
	if onStair && not onTopStair:
		animated_sprite.play("onStairs")
			
	move_and_slide()
