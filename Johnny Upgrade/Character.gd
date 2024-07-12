extends CharacterBody2D
class_name Character

var health = 0
var max_health = 100
var is_alive = true

var _damage = 1

func _ready():
	initialize_health()

func initialize_health():
	health = max_health

func damage(damage : float, origin : Character):
	health -= damage
	if health <= 0:
		health = 0
		die()
		on_death(origin)

func on_death(origin : Character):
	pass

func get_damage():
	return _damage

func die():
	if not is_alive:
		return
	is_alive = false

func revive():
	initialize_health()
	is_alive = true
