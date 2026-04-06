extends Area2D

var correct_items = ["camera", "Passport", "Toothbrush"]

func _on_area_entered(area: Area2D) -> void:

	if area.name in correct_items:
		print("Correct item packed!")
	else:
		print("Wrong item!")
