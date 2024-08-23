extends Node

var PORT: int = 1213
const DEFAULT_SERVER_IP: String = "127.0.0.1"
var players = []
var main: PackedScene = preload("res://scenes/game.tscn")
var player_name: String

signal player_joined(peer_id)
signal update_players(players)
signal player_quit(peer_id)

func _ready():
	var arguments = OS.get_cmdline_args()
	for arg in arguments:
		if arg.split("=")[0] == "--port":
			PORT = arg.split("=")[1].to_int()
	if DisplayServer.get_name() == "headless":
		print("Detected client is using a headless version of the game, loading the game...")
		get_tree().change_scene_to_packed(main)
		print("Starting a server...")
		var peer = ENetMultiplayerPeer.new()
		var error = peer.create_server(PORT)
		if error == OK:
			print("Created server with IP " + DEFAULT_SERVER_IP + " with port " + str(PORT))
		else:
			print(error)
			return
		multiplayer.multiplayer_peer = peer
		multiplayer.peer_connected.connect(_player_joined)
		multiplayer.peer_disconnected.connect(_player_quit)

# Server only	
func _player_joined(id) -> void:
	print("[server] player joined with the id " + str(id))
	print("[server] sending to players")
	server_player_joined.rpc(id)
	pass

func _player_quit(id) -> void:
	print("[server] player quit with the id " + str(id))
	print("[server] sending to players")
	server_player_quit.rpc(id)
	pass

@rpc("any_peer", "call_local", "reliable")
func send_info(id: int, username: String) -> void:
	if multiplayer.is_server():
		players.append({
			"id": id,
			"username": username
		})
		update_players.emit(players)

# Client only

@rpc("authority", "call_local", "reliable")
func server_player_joined(id) -> void:
	print("[" + str(multiplayer.multiplayer_peer.get_unique_id()) + "] [client] player joined with the id " + str(id))
	player_joined.emit(id)
	pass

@rpc("authority", "call_local", "reliable")
func server_player_quit(id) -> void:
	print("[" + str(multiplayer.multiplayer_peer.get_unique_id()) + "] [client] player quit with the id " + str(id))
	player_quit.emit(id)
	pass

func server_disconnected() -> void:
	print("server disconnected")
	multiplayer.server_disconnected.disconnect(server_disconnected)
	multiplayer.connection_failed.disconnect(connection_failed)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	multiplayer.multiplayer_peer = null

func connection_failed() -> void:
	print("connection failed")
	multiplayer.server_disconnected.disconnect(server_disconnected)
	multiplayer.connection_failed.disconnect(connection_failed)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	multiplayer.multiplayer_peer = null
	
	
func join_server(address: String, username: String = "Player") -> bool:
	if not username.is_valid_identifier():
		username = "Player"
	player_name = username
	if address == "localhost":
		address = "127.0.0.1"
	if not address.is_valid_ip_address():
		print("Invalid IP Address")
		return false
	var split_address = address.split(":")
	var valid_address: String
	var port: int
	if split_address.size() == 1:
		valid_address = split_address[0]
		port = PORT
	elif split_address.size() > 2:
		print("Too big arguments or something...")
		return false
	else:
		valid_address = split_address[0]
		port = split_address[1]
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(valid_address, port)
	if error:
		print(error)
		print("Error occurred while connecting")
		return false
	multiplayer.multiplayer_peer = peer
	multiplayer.server_disconnected.connect(server_disconnected)
	multiplayer.connection_failed.connect(connection_failed)
	print("[" + str(multiplayer.multiplayer_peer.get_unique_id()) + "] Connected to the server")
	return true
