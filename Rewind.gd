extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rewind_on = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.Rewind = self
	$RewindSprite.visible = false

func GameOver():
	if rewind_on == 0:
		rewind_on = 1
		$RewindTimer.start()
		$RewindSprite.visible = true
		$RewindAnim.play("gameover")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_RewindTimer_timeout():
	GameManager.restart()
