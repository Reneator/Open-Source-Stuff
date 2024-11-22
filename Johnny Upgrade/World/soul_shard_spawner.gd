extends Marker2D

@export var soul_shard_scene : PackedScene

var current_soul_shard

func _ready() -> void:
	Events.respawn_soul_shard.connect(on_respawn_soul_shard)
	spawn_soul_shard()

func on_respawn_soul_shard():
	respawn_soul_shard()

func respawn_soul_shard():
	clear()
	spawn_soul_shard()

func spawn_soul_shard():
	current_soul_shard = soul_shard_scene.instantiate()
	current_soul_shard.tree_exited.connect(on_soul_shard_freed.bind(current_soul_shard))
	add_child(current_soul_shard)

func on_soul_shard_freed(soul_shard_freed):
	if not current_soul_shard == soul_shard_freed:
		return
	current_soul_shard = null

func clear():
	if current_soul_shard:
		current_soul_shard.queue_free()
		current_soul_shard = null
