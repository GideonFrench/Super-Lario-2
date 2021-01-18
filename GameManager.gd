extends Node

var Player
var coinUI
var heartUI
var health
var Rewind
var EndScreen
var end = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if end == true:
		EndScreen.GameEnd()
	if health < 1:
		Rewind.GameOver()
		
func restart():
	get_tree().reload_current_scene()

