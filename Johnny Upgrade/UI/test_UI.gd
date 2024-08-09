extends Control


@onready var player := Player.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player_Info_Panel.player = player

func _on_kill_player_button_pressed():
	player.die()

func _on_revive_player_button_pressed():
	player.revive()

func _on_gain_soul_shard_button_pressed():
	player.soul_shards_pending += 1

func _on_spawn_enemy_button_pressed() -> void:
	Events.spawn_enemy.emit()
