extends Control


var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.player_initialized.connect(on_player_initialized)

func on_player_initialized(_player):
	player = _player
	$Player_Info_Panel.player = player

func _on_kill_player_button_pressed():
	player.die()

func _on_revive_player_button_pressed():
	player.revive()

func _on_gain_soul_shard_button_pressed():
	player.soul_shards_pending += 1

func _on_spawn_enemy_button_pressed() -> void:
	Events.spawn_enemy.emit()


func _on_open_upgrade_ui_button_pressed() -> void:
	$Upgrade_UI.show()
	pass # Replace with function body.


func _on_respawn_soul_shard_pressed() -> void:
	Events.respawn_soul_shard.emit()
