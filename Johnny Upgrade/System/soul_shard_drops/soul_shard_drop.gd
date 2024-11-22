extends Node2D


@onready var animated_sprite = $AnimatedSprite2D
@onready var sprite = $SoulShardBig

@export var soul_shard_value : int = 1

var is_picked_up = false
var last_played_anim

func _ready():
	animated_sprite.animation_finished.connect(on_animation_finished)



func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_picked_up:
		return
	if not body is Player:
		return
	var player : Player = body
	player.pick_up_soul_shard(soul_shard_value)
	is_picked_up = true
	sprite.hide()
	last_played_anim = "perish"
	animated_sprite.play(last_played_anim)

func on_animation_finished():
	if last_played_anim == "perish":
		queue_free()
	last_played_anim = null
