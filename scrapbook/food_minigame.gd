extends Node2D


func _on_pause_pressed() -> void:
	get_tree().change_scene_to_file("res://help_menu.tscn")
