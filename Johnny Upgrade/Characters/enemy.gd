extends Character
class_name Enemy

@onready var animated_sprite = $AnimatedSprite2D

var is_dying = false

func _ready():
	animated_sprite.animation_finished.connect(on_animation_finished)
	animated_sprite.play("move")

func on_animation_finished():
	if animated_sprite.animation == "death":
		queue_free()

func _on_area_2d_body_entered(body):
	if not body is Player:
		return
	var t_damage = get_damage()
	body.damage(t_damage, self)

func on_death(origin : Character):
	if is_dying:
		return
	print("%s is dying!" % name)
	is_dying = true
	animated_sprite.play("death")
	reward(origin)

func reward(origin : Character):
	if not origin is Player:
		return
	origin.soul_shards_pending += 1
