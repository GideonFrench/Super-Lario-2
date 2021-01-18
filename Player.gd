extends KinematicBody2D

# The score of how many coins picked up
var score : int  = 0
# How much health the player has, starts at 3
var health : int = 3
# Whether the player is invincible or not
var invincible : bool = false
# Whether the player can double jump or not, 1 if a jump is available
var doublejump :int = 1
# Acceleration to the right
var accel_r : int = 0
# Acceleation to the left
var accel_l : int = 0
# The base speed before acceleration
var base_speed : int = 100
# The force of a jump
var jumpForce : int = 1000
# The force of a double jump
var djumpForce : int = 700
# The force of gravity pulling down
var gravity : int = 2000
# The max speed of the character
var max_speed : int = 400
# How much to multiply the acceleration by
var accel_mult : float = 1.3

# The velocity vector
var vel : Vector2 = Vector2()

# The idle sprite
onready var isprite : Sprite = get_node("SpriteIdle")
# The movement sprite
onready var msprite : Sprite = get_node("SpriteMove")
# The hurt sprite
onready var hsprite : Sprite = get_node("SpriteHit")

func _ready():
	GameManager.Player = self
	isprite.visible = true
	msprite.visible = false
	hsprite.visible = false
	
func increaseScore():
	score += 1
	GameManager.coinUI.set_text(String(score))

func hurt():
	if invincible == false and health > 0:
		isprite.visible = false
		msprite.visible = false
		hsprite.visible = true
		invincible = true
		$HurtTimer.start()
		$HurtTimer2.start()
		$HurtSound.play()
		GameManager.health -= 1
		health -= 1
	elif health == 0:
		pass
	
func _on_HurtTimer_timeout():
	invincible = false
	
func _on_HurtTimer2_timeout():
	isprite.visible = true
	msprite.visible = false
	hsprite.visible = false

func _physics_process(delta):
	GameManager.health = health
	
	# If no key is being pressed and the player is on the floor, play the idle animation
	if Input.is_action_pressed("move_left") == false and Input.is_action_pressed("move_right") == false and is_on_floor() == true and invincible == false:
		isprite.visible = true
		msprite.visible = false
		hsprite.visible = false
		get_node("AnimationPlayer").play("Idle")
		get_node("AnimationPlayer").advance(0)
	
	# If the left key is pressed
	if Input.is_action_pressed("move_left") and GameManager.end == false:
		# Show only the movement sprite
		if invincible == false:
			isprite.visible = false
			msprite.visible = true
			hsprite.visible = false
		# If the acceleration is low, set it to the base speed
		if accel_l > -30:
			accel_l = -1 * base_speed
		# If the acceleration is less than the max speed, multiply it
		if accel_l > -1 * max_speed:
			accel_l *= accel_mult
		# Flip the sprites to face the right way
		isprite.flip_h = true
		msprite.flip_h = true
		# If moving and on the floor, play the movement animation
		if is_on_floor():
			get_node("AnimationPlayer").play("Movement")
			get_node("AnimationPlayer").advance(0)
	elif Input.is_action_pressed("move_right") and GameManager.end == false:
		# Show only the movement sprite
		if invincible == false:
			isprite.visible = false
			msprite.visible = true
			hsprite.visible = false
		# If the acceleration is low, set it to the base speed
		if accel_r < 30:
			accel_r = base_speed	
		# If the acceleration is less than the max speed, multiply it
		if accel_r < max_speed:
			accel_r *= accel_mult
		# Flip the sprites to face the right way
		isprite.flip_h = false
		msprite.flip_h = false
		# If moving and on the floor, play the movement animation
		if is_on_floor():
			get_node("AnimationPlayer").play("Movement")
			get_node("AnimationPlayer").advance(0)
	
	# Constant decelleration
	if accel_r > 30:
		accel_r -= 20
	if accel_l < -30:
		accel_l += 20
	
	# Velocity is the sum of the left and right accelerations
	vel.x = accel_l + accel_r
	
	# Stops the character from sliding
	if vel.x < 30 and vel.x > -30:
		vel.x = 0;
	
	vel = move_and_slide(vel, Vector2.UP)
	
	# Gravity pulling the character down
	vel.y += gravity * delta
	
	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor()and GameManager.end == false:
		if invincible == false:
			isprite.visible = false
			msprite.visible = true
			hsprite.visible = false
		vel.y -= jumpForce
		doublejump = 1
		$JumpSound.play()
	# Double jump, only once per jump
	if Input.is_action_just_pressed("jump") and doublejump == 1 and is_on_floor() == false and GameManager.end == false:
		if invincible == false:
			isprite.visible = false
			msprite.visible = true
			hsprite.visible = false
		delta = 0
		vel.y = -1*djumpForce
		doublejump = 0
		$JumpSound.play()
