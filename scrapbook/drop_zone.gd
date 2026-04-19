extends Area2D

@onready var win_label = $"../../UILayer/UI/WinLabel"

var correct_items = ["camera", "Passport", "Toothbrush"]

var packed_items = 0
var total_items = 3


func _on_area_entered(area: Area2D) -> void:

	if area.name in correct_items:
		print("Correct item packed!")
		area.queue_free()

		packed_items += 1

		if packed_items == total_items:
			print("Suitcase Packed!")
			get_tree().paused = true
			get_node("../../UILayer/UI/WinScreen").visible = true
			get_tree().paused = true

	else:
		print("Wrong item!")
