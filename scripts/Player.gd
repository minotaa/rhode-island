extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta):

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	var dir
	if velocity.x > 0:
		$Body.play("char1_walk_right")
	elif velocity.x < 0:
		$Body.play("char1_walk_left")
	if velocity.y > 0:
		$Body.play("char1_walk_down")
	elif velocity.y < 0:
		$Body.play("char1_walk_up")
	if velocity.length() == 0:
		$Body.play("char1_idle")
	

	move_and_slide()
