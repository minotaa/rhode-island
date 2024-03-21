extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")  
	velocity.normalized()
	
	if round(velocity.x) == -1:
		$Body.play("char1_walk_left")
	if round(velocity.x) == 1:
		$Body.play("char1_walk_right")
	if round(velocity.y) == -1:
		$Body.play("char1_walk_up")
	if round(velocity.y) == 1:
		$Body.play("char1_walk_down")
	if round(velocity.x) == 1 and round(velocity.y) == 1:
		$Body.play("char1_walk_right")
	if round(velocity.x) == 1 and round(velocity.y) == -1:
		$Body.play("char1_walk_right")
	if round(velocity.x) == -1 and round(velocity.y) == -1:
		$Body.play("char1_walk_left")
	if round(velocity.x) == -1 and round(velocity.y) == 1:
		$Body.play("char1_walk_left")	

	velocity *= SPEED
	if velocity.x == 0 and velocity.y == 0:
		$Body.play("char1_idle")	
	
	move_and_slide()
