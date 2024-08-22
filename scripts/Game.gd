extends Node2D

@export var player_scene: PackedScene

func _ready() -> void:
	if not multiplayer.has_multiplayer_peer():
		var p = load("res://scenes/player.tscn").instantiate()
		add_child(p)
	else:
		Multiplayer.player_joined.connect(player_joined)
		Multiplayer.player_quit.connect(player_quit)

func player_joined(id) -> void:
	if not multiplayer.is_server():
		return
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child", player, true)
	player.stop_fucking_up.rpc()
	pass
	
func player_quit(id) -> void:
	pass
