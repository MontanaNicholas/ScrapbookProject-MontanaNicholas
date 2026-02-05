extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")


func _on_help_pressed() -> void:
	get_tree().change_scene_to_file("res://help_menu.tscn")
