extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _on_DestructArea_body_entered(body):
	if body.name == "Player":
		# Sets coin to disappear
		$BlockSprite.visible = false
		# Plays noise and removes from scene
		$AnimationPlayer.play("Destroy")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
