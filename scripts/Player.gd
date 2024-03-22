extends CharacterBody2D

const SPEED = 300.0

func fish():
	fishing = false
	$Body.play("char1_fish_" + last_direction)
	
func use():
	print("Hmm...")	

var bobber_object = preload("res://scenes/bobber.tscn")
var bobber: RigidBody2D
var fishing = false
func _on_body_animation_finished():
	if $Body.animation.ends_with("fish_right") or $Body.animation.ends_with("fish_up") or $Body.animation.ends_with("fish_left") or $Body.animation.ends_with("fish_down"):
		fishing = true
		if bobber != null:
			bobber.queue_free()
		bobber = bobber_object.instantiate()
		bobber.position = Vector2(position.x, position.y)
		get_parent().add_child(bobber)
		bobber.apply_impulse(directions[last_direction] * 500)
		await get_tree().create_timer(0.85).timeout
		if bobber == null:
			return
		if bobber != null:
			bobber.apply_impulse(-directions[last_direction] * 250)
		await get_tree().create_timer(0.25).timeout
		if bobber == null:
			return
		if bobber != null:
			bobber.sleeping = true

var directions = {
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}
var last_direction = "down"

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	#var direction = Input.get_vector("left", "ui_right", "ui_up", "ui_down")
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")  
	velocity.normalized()
	if !fishing and bobber != null:
		bobber.queue_free()
		bobber = null
	if bobber != null:
		var line_point: Vector2 
		if last_direction == "left":
			line_point = Vector2(global_position.x - 52, global_position.y + 38)
		elif last_direction == "right":
			line_point = Vector2(global_position.x + 52, global_position.y + 38)
		elif last_direction == "up":
			line_point = Vector2(global_position.x, global_position.y - 35.5)
		elif last_direction == "down":
			line_point = Vector2(global_position.x, global_position.y + 67)
		bobber.set_point(line_point)
		$Camera2D.global_position = (bobber.global_position + global_position) / 2
		var z1 = abs(bobber.global_position.x - global_position.x) / (1280-25)
		var z2 = abs(bobber.global_position.y - global_position.y) / (720-25)
		var zoom_factor = max(max(z1, z2), 0.95)
		$Camera2D.zoom = Vector2(zoom_factor, zoom_factor) 
	else:
		$Camera2D.global_position = lerp($Camera2D.global_position, global_position, 0.05)
		$Camera2D.zoom = lerp($Camera2D.zoom, Vector2(1.2, 1.2), 0.05)

	if round(velocity.x) == -1:
		$Body.play("char1_walk_left")
		last_direction = "left"
		fishing = false
	if round(velocity.x) == 1:
		$Body.play("char1_walk_right")
		last_direction = "right"
		fishing = false
	if round(velocity.y) == -1:
		$Body.play("char1_walk_up")
		last_direction = "up"
		fishing = false
	if round(velocity.y) == 1:
		$Body.play("char1_walk_down")
		last_direction = "down"
		fishing = false
	if round(velocity.x) == 1 and round(velocity.y) == 1:
		$Body.play("char1_walk_right")
		last_direction = "right"
		fishing = false
	if round(velocity.x) == 1 and round(velocity.y) == -1:
		$Body.play("char1_walk_right")
		last_direction = "right"
		fishing = false
	if round(velocity.x) == -1 and round(velocity.y) == -1:
		$Body.play("char1_walk_left")
		last_direction = "left"
		fishing = false
	if round(velocity.x) == -1 and round(velocity.y) == 1:
		$Body.play("char1_walk_left")
		last_direction = "left"	
		fishing = false

	velocity *= SPEED
	if velocity.x == 0 and velocity.y == 0:
		if $Body.animation == "char1_walk_left" or $Body.animation == "char1_walk_up" or $Body.animation == "char1_walk_down" or $Body.animation == "char1_walk_right":
			$Body.play("char1_idle_" + last_direction)	
	
	move_and_slide()
