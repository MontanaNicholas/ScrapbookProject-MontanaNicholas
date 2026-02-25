extends Node2D

@onready var layers_container: Node2D = $GlassArea/LayersContainer
@onready var result_label: Label = $UI/ResultLabel
var current_layers: Array[String] = []

var target_recipe: Array[String] = ["ice", "strawberry_syrup", "oat_milk", "matcha"]
var recipe_name := "Iced Strawberry Oat Matcha"

var game_locked := false

func _ready() -> void:
	reset_drink()

func add_layer(name: String) -> void:
	if game_locked:
		return

	current_layers.append(name)
	print("Added:", name, "=>", current_layers)

	
	if current_layers.size() == target_recipe.size():
		check_recipe()

func check_recipe() -> void:
	game_locked = true

	var correct := (current_layers == target_recipe)

	if correct:
		print("Correct:", recipe_name)
		if is_instance_valid(result_label):
			result_label.text = "Perfect!"
	else:
		print(" Wrong order:", current_layers)
		if is_instance_valid(result_label):
			result_label.text = "Oops… muddy drink! "

		_make_muddy_placeholder() # temporary visual feedback

func reset_drink() -> void:
	game_locked = false
	current_layers.clear()
	_clear_layers_visual()

	if is_instance_valid(result_label):
		result_label.text = "Make: " + recipe_name

func _clear_layers_visual() -> void:
	for c in layers_container.get_children():
		c.queue_free()

func _make_muddy_placeholder() -> void:
	# temporary: colour all placed layers darker to simulate “muddy”
	for c in layers_container.get_children():
		if c is Sprite2D:
			c.modulate = Color(0.45, 0.35, 0.30, 1.0)
