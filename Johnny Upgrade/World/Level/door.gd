extends Area2D
class_name Door

@export_enum("South", "West", "North", "East") var door_orientation : String = "South"
@export var leads_to_room : String

signal entered()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		entered.emit()
