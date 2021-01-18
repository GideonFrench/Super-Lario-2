extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$EndSprite.visible = false
	GameManager.EndScreen = self


func GameEnd():
	$EndSprite.visible = true
	#$EndMusic.play()
