extends Node
class_name Player

var is_alive := true

var soul_shard_count := 0 #the spendable sould shards the player can spend on upgrades after death
var soul_shards_pending := 0 #player collects these by completing tasks and defeating monsters

func die():
	if not is_alive:
		return
	
	soul_shard_count += soul_shards_pending
	soul_shards_pending = 0
	
	is_alive = false
	
func revive():
	is_alive = true
