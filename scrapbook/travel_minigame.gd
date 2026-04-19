extends Node2D

@onready var pause_menu: Control = $UILayer/UI/PauseMenu
@onready var resume_button: Button = $UILayer/UI/PauseMenu/ResumeButton
@onready var quit_button: Button = $UILayer/UI/PauseMenu/QuitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the Sprevious frame.
func _process(delta: float) -> void:
	pass


func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	pause_menu.visible = true


func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	pause_menu.visible = false


func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://travel_main.tscn")


func _on_quit_2_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://travel_main.tscn")


func _on_replay_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
