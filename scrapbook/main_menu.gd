extends Control

@onready var sfx_ui: AudioStreamPlayer = $SFX_UI
@onready var sfx_worm: AudioStreamPlayer = $SFX_WORM

func _on_play_pressed() -> void:
	sfx_ui.play()
	get_tree().change_scene_to_file("res://game.tscn")


func _on_help_pressed() -> void:
	Sound.play_ui()
	get_tree().change_scene_to_file("res://help_menu.tscn")


func _on_worm_pressed() -> void:
	Sound.play_worm()
	get_tree().change_scene_to_file("res://main_menu_worm.tscn")
