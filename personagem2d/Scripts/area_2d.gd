extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		


func _on_body_entered(body: CharacterBody2D) -> void:
	body.onStair = true
	print("Entrou S1!")


func _on_body_exited(body: CharacterBody2D) -> void:
		body.onStair = false
		body.velocity.y -= 100.0 
		print("Saiu! S1")
