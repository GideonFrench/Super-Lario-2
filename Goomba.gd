extends KinematicBody2D

var speed : int = -200
var gravity : int = 1000
# 1 is left, 0 is right
var direction : int = 11

onready var msprite : Sprite = get_node("SpriteMove")
onready var dsprite : Sprite = get_node("SpriteDie")

var vel : Vector2 = Vector2()

func _ready():
	dsprite.visible = false
	msprite.visible = true
	
func _on_KillArea_body_entered(body):
	if body.name == "Player":
		speed = 0
		vel.x = 0

func _physics_process(delta):
	get_node("AnimationPlayer").play("Walk")
	get_node("AnimationPlayer").advance(0)

	if is_on_wall():
		speed = speed * -1
		direction = direction * -1
		msprite.flip_h = not msprite.flip_h
		
	vel.x = speed
	vel = move_and_slide(vel, Vector2.UP)
	
	vel.y += gravity * delta
