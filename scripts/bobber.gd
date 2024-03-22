extends RigidBody2D

func set_point(pos: Vector2):
	$Line2D.set_point_position(1, to_local(pos))
