extends Node2D

var rng = RandomNumberGenerator.new()

var speed = 0.05
var gravity = Vector2(0.0,9.8)
var velocity = Vector2(0.0,0.0)
var collected = false
var initial_position = Vector2(0.0,0.0)
var first = true

@onready var sprite = $AnimatedSprite2D
@onready var gameManager = %GameManager

func respawn() -> void:
	collected = false
	var posi = Vector2(0.0,0.0)
	posi.x = rng.randf_range(initial_position.x - 100.0,initial_position.x + 100.0)
	if first:
		posi.y = rng.randf_range(-500.0, -50.0)
		first = false
	else:	
		posi.y = rng.randf_range(-1000.0, -50.0)
		speed = rng.randf_range(0.01,0.07)
	position = posi
	velocity = Vector2(0.0,0.0)
	var animation_names = sprite.sprite_frames.get_animation_names()
	var spr_name = animation_names[rng.randi() % animation_names.size()]
	sprite.play(spr_name)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial_position.x = position.x
	initial_position.y = position.y
	respawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if collected:
		respawn()
	else:
		if position.y <= 625.0:
			velocity += gravity * speed * delta
			position += velocity 
		else:
			respawn()		
	
		
	
func _on_killzone_body_entered(_body: Node2D) -> void:
	if _body is CharacterBody2D:
		gameManager.add_point()
		collected = true
