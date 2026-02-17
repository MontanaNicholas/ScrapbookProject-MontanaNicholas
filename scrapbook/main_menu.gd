extends Control

@onready var sfx_ui: AudioStreamPlayer = $SFX_UI
@onready var sfx_worm: AudioStreamPlayer = $SFX_WORM
@onready var worm = $BookCover/worm

func _ready() -> void:
	_start_worm_wiggle()

func _start_worm_wiggle() -> void:
	if worm == null:
		return

	var base_y: float = worm.position.y

	var tween := create_tween()
	tween.set_loops()

	tween.tween_property(worm, "rotation_degrees", 6.0, 1.2)
	tween.tween_property(worm, "position:y", base_y - 2.0, 0.6)

	tween.tween_property(worm, "rotation_degrees", -6.0, 1.2)
	tween.tween_property(worm, "position:y", base_y, 0.6)

func _on_play_pressed() -> void:
	sfx_ui.play()
	get_tree().change_scene_to_file("res://game.tscn")

func _on_help_pressed() -> void:
	Sound.play_ui()
	get_tree().change_scene_to_file("res://help_menu.tscn")

func _on_worm_pressed() -> void:
	Sound.play_worm()
	get_tree().change_scene_to_file("res://main_menu_worm.tscn")
