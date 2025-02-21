extends Area2D

func _on_body_entered(body: Node2D):
	if body is Player:
		body.set_position($Marker2D.global_position)
		
