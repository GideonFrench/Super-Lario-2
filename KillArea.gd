extends Area2D

var djumpForce : int = 700
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_KillArea_body_entered(body):
	if body.name == "Player":
		body.vel.y = -1*djumpForce
		# Plays noise and removes from scene
		$KillAnimation.play("Death")
