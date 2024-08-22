extends Node2D

func _ready() -> void:
	$CanvasLayer/Main/Title/Version.text = "2024 (c) " + "v" + str(ProjectSettings.get_setting("application/config/version"))



func _on_play_pressed() -> void:
	multiplayer.multiplayer_peer = null
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_how_to_play_pressed() -> void:
	$CanvasLayer/Main/Buttons.visible = false
	$CanvasLayer/Main/Title.visible = false
	$CanvasLayer/Main/Tutorial.visible = true

func _on_settings_pressed() -> void:
	pass

func _on_button_pressed() -> void:
	$CanvasLayer/Main/Buttons.visible = true
	$CanvasLayer/Main/Title.visible = true
	$CanvasLayer/Main/Tutorial.visible = false
	$CanvasLayer/Main/Multiplayer.visible = false

func _on_connect_to_multiplayer_pressed() -> void:
	$CanvasLayer/Main/Buttons.visible = false
	$CanvasLayer/Main/Title.visible = false
	$CanvasLayer/Main/Multiplayer.visible = true

func _on_join_server_pressed() -> void:
	$"CanvasLayer/Main/Multiplayer/Panel/Go Back".visible = false
	$"CanvasLayer/Main/Multiplayer/Panel/IP Address".visible = false
	$"CanvasLayer/Main/Multiplayer/Panel/Join Server".visible = false
	$"CanvasLayer/Main/Multiplayer/Panel/Username".visible = false
	$CanvasLayer/Main/Multiplayer/Panel/Status.text = "Connecting to server..."
	$CanvasLayer/Main/Multiplayer/Panel/Status.visible = true
	var result = Multiplayer.join_server($"CanvasLayer/Main/Multiplayer/Panel/IP Address".text, $"CanvasLayer/Main/Multiplayer/Panel/Username".text)
	if result == false:
		$CanvasLayer/Main/Multiplayer/Panel/Status.text = "Couldn't connect to the server."
		await get_tree().create_timer(3.0).timeout
		$CanvasLayer/Main/Multiplayer/Panel/Status.visible = false
		$"CanvasLayer/Main/Multiplayer/Panel/Go Back".visible = true
		$"CanvasLayer/Main/Multiplayer/Panel/IP Address".visible = true
		$"CanvasLayer/Main/Multiplayer/Panel/Username".visible = true
		$"CanvasLayer/Main/Multiplayer/Panel/Join Server".visible = true
	elif result == true:
		$CanvasLayer/Main/Multiplayer/Panel/Status.text = "Successfully connected to the server,\nloading game..."
		get_tree().change_scene_to_file("res://scenes/game.tscn")
