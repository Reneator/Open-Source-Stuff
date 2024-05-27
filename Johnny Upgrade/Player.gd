extends Character
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var attack_area = $Attack_Area2D

var soul_shard_count := 0 #the spendable sould shards the player can spend on upgrades after death
var soul_shards_pending := 0 #player collects these by completing tasks and defeating monsters
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	var move_horizontal = Input.get_axis("move_left", "move_right")
	var move_vertical = Input.get_axis("move_up", "move_down")
	var move_vector = Vector2(move_horizontal, move_vertical).normalized()
	#print("Move_vector: %s" % move_vector)
	rotate_player_towards_movement_direction(move_vector)

	velocity = Vector2.ZERO
	velocity += SPEED * move_vector

	move_and_slide()

func rotate_player_towards_movement_direction(move_vector : Vector2):
	if move_vector.length() <= 0:
		return
	var vector_angle_rad = move_vector.angle()
	rotation = vector_angle_rad

func _input(event):
	if event.is_action_pressed("attack"):
		start_attack()
	

func start_attack():
	attack_area.show()
	
	#check for bodys in damage area
	#damage enemies

func _on_attack_area_2d_body_entered(body):
	if not body is Monster:
		return
	attack(body)

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
