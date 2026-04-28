extends Node2D
func _on_button_pressed() -> void:
	Sound.play_worm()
	get_tree().change_scene_to_file("res://game.tscn")
