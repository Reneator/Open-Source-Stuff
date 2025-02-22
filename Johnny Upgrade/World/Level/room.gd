extends Node2D
class_name Room


signal entered_door(door : Door)

func _ready():
	initialize_doors()

func initialize_doors():
	var doors = get_all_doors()
	for door : Door in doors:
		door.entered.connect(on_door_entered.bind(door))

func on_door_entered(door : Door):
	entered_door.emit(door)

func get_all_doors():
	var doors = []
	for child in $Doors.get_children():
		if child is Door:
			doors.append(child)
	return doors


#func start_room(player):
	#spawn_player(player)

#func enter_room(from_room, player):
	#spawn_player_at_door(player)
#
#func spawn_player(player):
	#var spawn_position = get_spawn_position()
#
#func get_spawn_position():
	#
	#pass	
