extends Node


@export var enemy_scene : PackedScene

var current_enemy : Character

func _ready():
	current_enemy = $Enemy
	Events.spawn_enemy.connect(on_spawn_enemy)

func on_spawn_enemy():
	if current_enemy != null:
		clear()
	current_enemy = enemy_scene.instantiate()
	current_enemy.tree_exiting.connect(on_enemy_exiting_tree)
	add_child(current_enemy)

func clear():
	current_enemy.queue_free()
	current_enemy = null

func on_enemy_exiting_tree():
	current_enemy = null
