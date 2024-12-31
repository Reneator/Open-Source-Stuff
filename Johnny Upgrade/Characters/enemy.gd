extends Character
class_name Enemy

@onready var animated_sprite = $AnimatedSprite2D

var is_dying = false
var speed = 30
var player_in_area = false
var player = null

func _ready():
	animated_sprite.animation_finished.connect(on_animation_finished)
	animated_sprite.play("default")

func _physics_process(delta):
	if is_dying or not player_in_area or not player:
		return

	move_towards_player(delta)

func move_towards_player(delta):
	if player:
		var move_vector = player.global_position - global_position
		if move_vector.length() > 5:  # Threshold to avoid jittering when close
			global_position += move_vector.normalized() * speed * delta

func _on_player_search_area_body_entered(body: Node2D):
	if body is Player:
		player_in_area = true
		player = body
		animated_sprite.play("move")
		print("Enemy detected the player!")

func _on_player_search_area_body_exited(body: Node2D):
	if body is Player:
		player_in_area = false
		player = null
		animated_sprite.play("default")
		print("Enemy lost sight of the player!")

func on_animation_finished():
	if animated_sprite.animation == "death":
		queue_free()
		
func on_death(origin: Character):
	if is_dying:
		return
	print("%s is dying!" % name)
	is_dying = true
	animated_sprite.play("death")
