tool extends Area2D

func _on_DestructArea_body_entered(body):
	if body.name == "Player":
		# Sets coin to disappear
		$BlockSprite.visible = false
		# Plays noise and removes from scene
		$AnimationPlayer.play("Destroy")
