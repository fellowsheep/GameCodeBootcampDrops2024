extends Area2D

@onready var topo = $"../StaticBody2D/CollisionShape2D2" 

var onTopStair = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if onTopStair and Input.get_axis("moveUp", "moveDown") == 1:
		topo.disabled = true
	else:
		topo.disabled = false
	


func _on_body_entered(body: Node2D) -> void:
	body.onTopStair = true 
	onTopStair = true
	print("Entrou S2!")
	
	


func _on_body_exited(body: Node2D) -> void:
	body.onTopStair = false
	print("Saiu! S2")
