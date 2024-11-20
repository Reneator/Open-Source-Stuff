extends PanelContainer

var player : Player

@onready var alive_label := $VBoxContainer/Player_Is_Alive/Alive_Label
@onready var soul_shard_count_label := $"VBoxContainer/Soul Shard Count/Soul Shard Count Label"
@onready var soul_shards_pending_label := $"VBoxContainer/Soul Shard Pending/Soul_Shards_Pending_Label"


func _ready():
	Events.player_initialized.connect(on_player_initialized)

func on_player_initialized(_player):
	player = _player

func _process(delta):
	player = Global.player
	if not player:
		return
	
	alive_label.text = str(player.is_alive)
	soul_shard_count_label.text = "%d" % player.soul_shard_count
	soul_shards_pending_label.text = "%d" % player.soul_shards_pending
