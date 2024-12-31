extends Character
class_name Bushenemy

@onready var animated_sprite = $AnimatedSprite2D

var is_dying = false
var is_burrowed = false
var is_on_cooldown = false
var player_position = null
var player_in_area = false
var speed = 100
var burrowed_position = null
var player = null

enum State { SEARCH, BURROWED }
var state = State.SEARCH

func _ready():
	animated_sprite.animation_finished.connect(on_animation_finished)
	animated_sprite.play("default")

func _physics_process(delta):
	if is_dying or not is_alive:
		return

	match state:
		State.SEARCH:
			if player_in_area and player and not is_on_cooldown:
				start_tracking()
		State.BURROWED:
			if is_burrowed:
				move_to_position(delta)

func start_tracking():
	if is_dying or is_on_cooldown:
		return
	player_position = player.global_position
	await get_tree().create_timer(1.0).timeout
	burrowed_position = player_position
	enter_burrowed_state()

func enter_burrowed_state():
	if is_burrowed or state != State.SEARCH: # Prevent re-triggering
		return
	is_burrowed = true
	state = State.BURROWED
	animated_sprite.play("burrowed")
	print("Bushenemy is burrowed!")

func move_to_position(delta):
	if is_dying or not burrowed_position or is_on_cooldown:
		return
	var move_vector = burrowed_position - global_position
	if move_vector.length() <= 5: # Threshold to stop moving
		global_position = burrowed_position
		exit_burrowed_state()
	else:
		global_position += move_vector.normalized() * speed * delta

func exit_burrowed_state():
	is_burrowed = false
	burrowed_position = null
	state = State.SEARCH
	animated_sprite.play("default")
	start_cooldown()
	print("Bushenemy exited burrowed state.")

func start_cooldown():
	is_on_cooldown = true
	print("Cooldown started.")
	await get_tree().create_timer(5.0).timeout
	is_on_cooldown = false
	print("Cooldown finished. Bushenemy can burrow again.")

func _on_player_search_area_body_entered(body: Node2D):
	if body is Player:
		player_in_area = true
		player = body

func _on_player_search_area_body_exited(body: Node2D):
	if body is Player:
		player_in_area = false
		player = null

func on_animation_finished():
	if animated_sprite.animation == "death":
		queue_free()

func on_death(origin: Character):
	if is_dying:
		return
	is_dying = true
	animated_sprite.play("death")
