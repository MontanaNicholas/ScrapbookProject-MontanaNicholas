extends Node2D

@onready var layers_container: Node2D = $GlassArea/LayersContainer
@onready var result_label: Label = $UI/ResultLabel
@onready var title_label: Label = $UI/Recipecard/TitleLabel
@onready var step1_label: Label = $UI/Recipecard/Step1Label
@onready var step2_label: Label = $UI/Recipecard/Step2Label
@onready var step3_label: Label = $UI/Recipecard/Step3Label
@onready var step4_label: Label = $UI/Recipecard/Step4Label
var current_layers: Array[String] = []

var target_recipe: Array[String] = ["ice", "strawberry_syrup", "oat_milk", "matcha"]

var recipe_display_steps: Array[String] = [
	"1. Ice",
	"2. Strawberry Syrup",
	"3. Oat Milk",
	"4. Matcha"
]
var recipe_name := "Iced Strawberry Oat Matcha"
var game_locked := false

func _ready() -> void:
	reset_drink()
	_update_recipe_card()

func add_layer(name: String) -> void:
	if game_locked:
		return

	current_layers.append(name)
	print("Added:", name, "=>", current_layers)
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

func _update_recipe_card() -> void:
	title_label.text = recipe_name

	if recipe_display_steps.size() >= 4:
		step1_label.text = recipe_display_steps[0]
		step2_label.text = recipe_display_steps[1]
		step3_label.text = recipe_display_steps[2]
		step4_label.text = recipe_display_steps[3]
		
		
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


func _on_mix_button_pressed() -> void:
	if game_locked:
		return

	#only allow mixing once you’ve added at least 1 thing
	if current_layers.is_empty():
		result_label.text = "Add ingredients first!"
		return

	check_recipe()
