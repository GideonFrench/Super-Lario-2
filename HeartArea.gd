tool extends Area2D

func _on_HeartArea_body_entered(body):
	if body.name == "Player":
		if GameManager.Player.health < 3:
			GameManager.Player.health += 1
			# Sets health to disappear
			$Heart.visible = false
			# Plays noise and removes from scene
			$AnimationPlayer.play("HeartPickup")
