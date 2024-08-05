extends Area2D
class_name Attack_Area

var processed_targets = []

signal enemy_hit(enemy)

func _ready():
	visibility_changed.connect(on_visibility_changed)

func on_visibility_changed():
	if not visible:
		clear_targets()

func clear_targets():
	processed_targets = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_visible_in_tree():
		return
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if not body is Enemy:
			continue
		process_target(body)

func process_target(enemy : Enemy):
	if enemy in processed_targets:
		return
	processed_targets.append(enemy)
	enemy_hit.emit(enemy)
	
