extends Control

@onready var sfx_ui: AudioStreamPlayer = $SFX_UI

func _on_play_pressed() -> void:
	sfx_ui.play()
	get_tree().change_scene_to_file("res://game.tscn")


func _on_help_pressed() -> void:
	sfx_ui.play()
	get_tree().change_scene_to_file("res://help_menu.tscn")
