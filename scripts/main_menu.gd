extends Node2D

func _ready() -> void:
	$CanvasLayer/Main/Title/Version.text = "2024 (c) " + "v" + str(ProjectSettings.get_setting("application/config/version"))



func _on_play_pressed() -> void:
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
