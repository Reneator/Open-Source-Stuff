extends Character
class_name Monster

func _on_area_2d_body_entered(body):
	if not body is Player:
		return
	var t_damage = get_damage()
	body.damage(t_damage, self)

func on_death(origin : Character):
	reward(origin)

func reward(origin : Character):
	if not origin is Player:
		return
	origin.soul_shards_pending += 1
