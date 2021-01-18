tool extends Area2D

func _on_PonyArea_body_entered(body):
	if body.name == "Player":
		GameManager.end = true
		$PonyMusic.play()
