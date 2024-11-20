extends Node2D

@export var soul_shard_value : int = 1



func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	var player : Player = body
	player.pick_up_soul_shard(soul_shard_value)
	queue_free()
