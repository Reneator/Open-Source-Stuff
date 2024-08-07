extends Character
class_name Player

@export var texture_hero_right : Texture2D
@export var texture_hero_down : Texture2D
@export var texture_hero_up : Texture2D
@export var texture_hero_left : Texture2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var attack_area = $Attack_Area2D
@onready var animation_player = $AnimationPlayer
@onready var icon = $Icon


var soul_shard_count := 0 #the spendable sould shards the player can spend on upgrades after death
var soul_shards_pending := 0 #player collects these by completing tasks and defeating monsters
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	for child in get_children():
		if not child is Attack_Area:
			continue
		child.enemy_hit.connect(on_enemy_hit_by_attack)
	initialize_hp()
	Global.player = self

func initialize_hp():
	health = max_health

func on_enemy_hit_by_attack(enemy : Enemy):
	attack(enemy)

var last_direction 

func _physics_process(delta):
	
	var move_horizontal = Input.get_axis("move_left", "move_right")
	var move_vertical = Input.get_axis("move_up", "move_down")
	var move_vector = Vector2(move_horizontal, move_vertical).normalized()
	
	velocity = Vector2.ZERO
	velocity += SPEED * move_vector
	if not move_vector.length() == 0:
		set_texture_for_velocity()
		last_direction = get_view_direction()

	move_and_slide()

var last_degrees

func set_texture_for_velocity():
	var player_texture = get_texture_for_direction()
	var direction = get_view_direction()

	icon.texture = player_texture

enum DIRECTION{LEFT, RIGHT, DOWN, UP}

func get_texture_for_direction():
	var direction = get_view_direction()
	match direction:
		DIRECTION.UP:
			return texture_hero_up
		DIRECTION.DOWN:
			return texture_hero_down
		DIRECTION.RIGHT:
			return texture_hero_right
		DIRECTION.LEFT:
			return texture_hero_left

func get_view_direction():
	var direction = velocity.normalized()
	var degrees = rad_to_deg(direction.angle())
	if degrees >= -135 and degrees < -46: #up
		return DIRECTION.UP
	if degrees >= -46 and degrees < 46: #right
		return DIRECTION.RIGHT
	if degrees >= 46 and degrees < 135: #down
		return DIRECTION.DOWN
	if degrees >= 135 or degrees < -135: #left
		return DIRECTION.LEFT

func _input(event):
	if event.is_action_pressed("attack"):
		start_attack()

var is_attacking = false
var current_attack

func start_attack():
	if is_attacking:
		return
	is_attacking = true
	get_tree().create_timer(0.5).timeout.connect(stop_attack)
	
	current_attack = get_attack_area()
	current_attack.show()

func get_attack_area():
	var direction = get_view_direction()
	if velocity.length()<= 0:
		direction = last_direction
	match direction:
		DIRECTION.UP:
			return $Attack_Top
		DIRECTION.DOWN:
			return $Attack_Bottom
		DIRECTION.RIGHT:
			return $Attack_Right
		DIRECTION.LEFT:
			return $Attack_Left
	

func stop_attack():
	if current_attack:
		current_attack.hide()
	current_attack = null
	is_attacking = false
	

func on_death(origin : Character):
	print("Player was killed by %s" % origin)
	soul_shard_count += soul_shards_pending
	soul_shards_pending = 0

func attack(character : Character):
	var t_damage = get_damage()
	character.damage(t_damage, self)
	print("Player dealt %s damage to %s" % [t_damage, character])

func get_damage():
	return 1
