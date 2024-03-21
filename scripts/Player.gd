extends CharacterBody2D

const SPEED = 300.0

func fish():
	$Body.play("char1_fish_" + last_direction)
	
func _on_body_animation_finished():
	print("balls")
	pass # Replace with function body.

var last_direction = "down"

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")  
	velocity.normalized()
	
	
	if round(velocity.x) == -1:
		$Body.play("char1_walk_left")
		last_direction = "left"
	if round(velocity.x) == 1:
		$Body.play("char1_walk_right")
		last_direction = "right"
	if round(velocity.y) == -1:
		$Body.play("char1_walk_up")
		last_direction = "up"
	if round(velocity.y) == 1:
		$Body.play("char1_walk_down")
		last_direction = "down"
	if round(velocity.x) == 1 and round(velocity.y) == 1:
		$Body.play("char1_walk_right")
		last_direction = "right"
	if round(velocity.x) == 1 and round(velocity.y) == -1:
		$Body.play("char1_walk_right")
		last_direction = "right"
	if round(velocity.x) == -1 and round(velocity.y) == -1:
		$Body.play("char1_walk_left")
		last_direction = "left"
	if round(velocity.x) == -1 and round(velocity.y) == 1:
		$Body.play("char1_walk_left")
		last_direction = "left"	

	velocity *= SPEED
	if velocity.x == 0 and velocity.y == 0:
		if $Body.animation == "char1_walk_left" or $Body.animation == "char1_walk_up" or $Body.animation == "char1_walk_down" or $Body.animation == "char1_walk_right":
			$Body.play("char1_idle_" + last_direction)	
	
	move_and_slide()
