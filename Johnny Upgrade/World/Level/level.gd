extends Node2D

@export var room_1_scene : PackedScene
@export var room_2_scene : PackedScene
@export var player_scene : PackedScene

var current_room : Room

func _ready():
	start_level()

func start_level():
	start_room(room_1_scene.instantiate())

func start_room(room : Room):
	clear()
	room.entered_door.connect(on_room_entered_door.bind(room))
	current_room = room
	add_child(room)

func on_room_entered_door(door : Door, origin_room : Room):
	var target_room_id = door.leads_to_room
	var target_room = Rooms.get_by_id(target_room_id)
	if not target_room:
		assert(false)
	start_room(target_room)

func clear():
	if current_room:
		current_room.queue_free()
	current_room = null
