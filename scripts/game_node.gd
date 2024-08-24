extends Node2D

var player_object = preload("res://scenes/player.tscn")

func _ready() -> void:
	if not multiplayer.has_multiplayer_peer():
		var p = player_object.instantiate()
		add_child(p)
	else:
		Multiplayer.player_joined.connect(player_joined)
		Multiplayer.player_quit.connect(player_quit)
		#Multiplayer.update_players.connect(update_players)

#func update_players(players) -> void:
	#if not multiplayer.is_server():
		#return
	#for children in get_children():
		#for player in players:
			#if str(player["id"]) == children.name:
				#children.username = player["username"]

func player_joined(id) -> void:
	if not multiplayer.is_server():
		return
	var player = player_object.instantiate()
	player.name = str(id)
	call_deferred("add_child", player, true)
	pass

func player_quit(id) -> void:
	if not multiplayer.is_server():
		return
	print("[" + str(multiplayer.multiplayer_peer.get_unique_id()) + "] removing " + str(id) + " from the game")
	for children in get_children():
		if children.name == str(id):
			children.call_deferred("queue_free")
