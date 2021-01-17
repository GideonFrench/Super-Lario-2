extends KinematicBody2D

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

func _physics_process(delta):
	# Only show the idle sprite at first
	isprite.visible = true
	msprite.visible = false
	
	# If no key is being pressed and the player is on the floor, play the idle animation
	if Input.is_action_pressed("move_left") == false and Input.is_action_pressed("move_right") == false and is_on_floor() == true:
		get_node("AnimationPlayer").play("Idle")
		get_node("AnimationPlayer").advance(0)
	
	# If the left key is pressed
	if Input.is_action_pressed("move_left"):
		# Show only the movement sprite
		isprite.visible = false
		msprite.visible = true
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
	
	if Input.is_action_pressed("move_right"):
		# Show only the movement sprite
		isprite.visible = false
		msprite.visible = true
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
	if Input.is_action_just_pressed("jump") and is_on_floor():
		vel.y -= jumpForce
		doublejump = 1
		$JumpSound.play()
	
	# Double jump, only once per jump
	if Input.is_action_just_pressed("jump") and doublejump == 1 and is_on_floor() == false:
		delta = 0
		vel.y = -1*djumpForce
		doublejump = 0
		$JumpSound.play()
