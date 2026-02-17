extends Node

@onready var ui_player := AudioStreamPlayer.new()
@onready var worm_player := AudioStreamPlayer.new()

func _ready():
	add_child(ui_player)
	add_child(worm_player)

	ui_player.stream = preload("res://audio/ui_click.mp3")
	worm_player.stream = preload("res://audio/bookworm.mp3")


func play_ui():
	ui_player.play()


func play_worm():
	worm_player.play()
