extends Camera2D

var playerTarget = null

func _process(delta):
	playerTarget = get_parent().get_node("Player")
	if (playerTarget.position.x - 450 > 0):
		offset.x = playerTarget.position.x - 450
	else:
		offset.x = 0

