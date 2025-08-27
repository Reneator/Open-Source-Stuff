extends Node
var spawnpoint = ""

@export var room_1_scene : PackedScene
@export var room_2_scene : PackedScene
@export var room_3_scene : PackedScene

func get_by_id(id):
	match id:
		"room_1": return room_1_scene.instantiate()
		"room_2": return room_2_scene.instantiate()
		"room_3": return room_3_scene.instantiate()
