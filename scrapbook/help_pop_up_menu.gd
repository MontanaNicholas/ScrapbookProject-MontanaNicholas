extends Control

@onready var sfx_ui: AudioStreamPlayer = $SFX_UI


func _on_button_pressed() -> void:
	Sound.play_ui()
	get_tree().change_scene_to_file("res://main_menu.tscn")
