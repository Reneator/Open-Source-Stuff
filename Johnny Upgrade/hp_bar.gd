extends TextureProgressBar


var player : Player

func _process(delta: float) -> void:
	if not player:
		player = Global.player
	if not player:
		return
	
	value = player.health
	max_value = player.max_health
