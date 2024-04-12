extends Node2D

var movement_speed = 4
var movement_time = 1

var min_distance = 100
var max_distance = 200

var min_position = 140
var max_position = -140

func _ready():
	plan_move()
	
func plan_move():
	var target = randf_range(min_position, max_position)
	while (abs(self.position.y - target) < min_distance or abs(self.position.y - target) > max_distance):
		target = randf_range(min_position, max_position)
		
	move(Vector2(self.position.x, target))

	
func move(target):
	var tween = create_tween()
	
	#tween.interpolate_value(self, "position", position, target, Tween.TRANS_QUINT, Tween.EASE_OUT)
	tween.tween_property(self, "position", target, movement_speed).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	
	$MoveTimer.set_wait_time(movement_time)
	$MoveTimer.start()

func destroy():
	get_parent().remove_child(self)
	queue_free()
func timeout():
	plan_move()
