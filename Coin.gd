tool extends Area2D

func _on_CoinArea_body_entered(body):
	# Increase the score
	GameManager.Player.increaseScore()
	# Sets coin to disappear
	$Coin.visible = false
	# Plays noise and removes from scene
	$AnimationPlayer.play("Pickup")
