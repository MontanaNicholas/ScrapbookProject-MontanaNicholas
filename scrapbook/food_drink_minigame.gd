extends Node2D

@onready var end_screen: Control = $UI/EndScreenLayer/EndScreen
@onready var end_label: Label = $UI/EndScreenLayer/EndScreen/VBoxContainer/EndLabel
@onready var restart_button: Button = $UI/EndScreenLayer/EndScreen/VBoxContainer/RestartButton
@onready var exit_button: Button = $UI/EndScreenLayer/EndScreen/VBoxContainer/ExitButton
@onready var bg_music: AudioStreamPlayer = $BGMusic
@onready var correct_sound: AudioStreamPlayer = $CorrectSound
@onready var wrong_sound: AudioStreamPlayer = $WrongSound
@onready var layers_container: Node2D = $GlassArea/LayersContainer
@onready var result_label: Label = $UI/ResultLabel
@onready var title_label: Label = $UI/Recipecard/TitleLabel
@onready var step1_label: Label =  $UI/Recipecard/TitleLabel/VBoxContainer/Step1Label
@onready var step2_label: Label = $UI/Recipecard/TitleLabel/VBoxContainer/Step2Label
@onready var step3_label: Label = $UI/Recipecard/TitleLabel/VBoxContainer/Step3Label
@onready var step4_label: Label = $UI/Recipecard/TitleLabel/VBoxContainer/Step4Label
@onready var step5_label: Label = $UI/Recipecard/TitleLabel/VBoxContainer/Step5Label
@onready var finished_strawberry_matcha: Sprite2D = $GlassArea/FinishedStrawberryMatcha
@onready var finished_mango_matcha: Sprite2D = $GlassArea/FinishedMangoMatcha
@export var strawberry_matcha_texture: Texture2D
@export var mango_matcha_texture: Texture2D

@onready var progress_labels := [
	$UI/progress/slotLabel1,
	$UI/progress/slotLabel2,
	$UI/progress/slotLabel3
]
var current_layers: Array[String] = []
var recipe_index := 0
var drinks_completed := 0

var wrong_drinks := 0

var recipes := [
	{
		"name": "Iced Strawberry Oat Matcha",
		"layers": ["ice", "strawberry_syrup", "oat_milk", "matcha"]
	},
	{
		"name": "Iced Mango Coconut Matcha",
		"layers": ["ice", "mango_syrup", "coconut_milk", "matcha"]
	},
	{
		"name": "Classic Milk Tea",
		"layers": ["ice", "boba", "sugar_syrup", "tea", "milk"]
	}
]

var target_recipe: Array[String] = []
var recipe_name := ""
var game_locked := false

func _ready() -> void:
	randomize()
	_select_next_recipe()
	reset_drink()
	bg_music.play()
	
func _select_next_recipe() -> void:
	if recipe_index >= recipes.size():
		_show_end_screen()
		return

	var recipe = recipes[recipe_index]

	recipe_name = recipe["name"]

	target_recipe.clear()
	for layer in recipe["layers"]:
		target_recipe.append(layer)

	_update_recipe_card()

	recipe_index += 1
	
func add_layer(name: String, texture: Texture2D) -> void:
	if game_locked:
		return

	current_layers.append(name)
	
	var layer_sprite := Sprite2D.new()
	layer_sprite.texture = texture
	layer_sprite.centered = true

	layers_container.add_child(layer_sprite)

	var drop_point := $GlassArea/DropZone/DropPoint
	var base_pos := layers_container.to_local(drop_point.global_position)

	var y_offset: float = 0.0

	for child in layers_container.get_children():
		if child == layer_sprite:
			continue

		if child is Sprite2D:
			var s := child as Sprite2D
			if s.texture:
				var h: float = s.texture.get_size().y * s.scale.y
				y_offset += h

	layer_sprite.position = base_pos + Vector2(0, -y_offset)

	layer_sprite.z_as_relative = false
	layer_sprite.z_index = 500 + layers_container.get_child_count()
	
func _show_end_screen() -> void:
	game_locked = true
	
	$UI/EndScreenLayer.visible = true
	$GlassArea.visible = false

	if wrong_drinks == 0:
		end_label.text = "Congratulations! Perfect drinks!"
	else:
		end_label.text = "Oh no! Some drinks were wrong!"

func _on_restart_button_pressed() -> void:
	$UI/EndScreenLayer.visible = false
	$GlassArea.visible = true

	recipe_index = 0
	drinks_completed = 0
	wrong_drinks = 0
	current_layers.clear()

	for label in progress_labels:
		if label != null:
			label.text = ""

	_clear_layers_visual()

	game_locked = false

	_select_next_recipe()
	reset_drink()

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://food_drink_main.tscn")
	
func check_recipe() -> void:
	game_locked = true

	if current_layers == target_recipe:
		print("Correct:", recipe_name)
		result_label.text = "Perfect!"
		correct_sound.play()
		_mark_drink_complete(true)

		_show_final_drink()

	else:
		print("Wrong order:", current_layers)
		result_label.text = "Oops… muddy drink!"
		wrong_sound.play()
		_mark_drink_complete(false)
		_make_muddy_placeholder()
		wrong_drinks += 1

	await get_tree().create_timer(2.0).timeout

	_select_next_recipe()
	reset_drink()
	
func _show_final_drink() -> void:
	_clear_layers_visual()

	$GlassArea/GlassSprite.visible = false   # hide the empty glass

	finished_strawberry_matcha.visible = false
	finished_mango_matcha.visible = false

	if recipe_name == "Iced Strawberry Oat Matcha":
		finished_strawberry_matcha.visible = true
		finished_strawberry_matcha.scale = Vector2(0.2,0.2)

		var tween = create_tween()
		tween.tween_property(finished_strawberry_matcha,"scale",Vector2(1,1),0.25)

	elif recipe_name == "Iced Mango Coconut Matcha":
		finished_mango_matcha.visible = true
		finished_mango_matcha.scale = Vector2(0.2,0.2)

		var tween = create_tween()
		tween.tween_property(finished_mango_matcha,"scale",Vector2(1,1),0.25)
	
func _update_recipe_card() -> void:
	title_label.text = recipe_name
	
	var step_labels = [
		step1_label,
		step2_label,
		step3_label,
		step4_label,
		step5_label
	]
	
	for i in range(step_labels.size()):
		if step_labels[i] == null:
			continue

		if i < target_recipe.size():
			var nice_name := target_recipe[i].replace("_", " ").capitalize()
			step_labels[i].text = str(i + 1) + ". " + nice_name
		else:
			step_labels[i].text = ""
		
func reset_drink() -> void:
	game_locked = false
	current_layers.clear()
	_clear_layers_visual()

	$GlassArea/GlassSprite.visible = true   # show the empty glass again

	finished_strawberry_matcha.visible = false
	finished_mango_matcha.visible = false
	
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


func _mark_drink_complete(correct: bool) -> void:
	if drinks_completed >= progress_labels.size():
		return

	var label: Label = progress_labels[drinks_completed]

	if correct:
		label.text = "✔"
		label.modulate = Color(0.2, 0.8, 0.2)
	else:
		label.text = "✖"
		label.modulate = Color(0.9, 0.2, 0.2)

	drinks_completed += 1
	
func _on_mix_button_pressed() -> void:
	if game_locked:
		return

	#only allow mixing once you’ve added at least 1 thing
	if current_layers.is_empty():
		result_label.text = "Add ingredients first!"
		return

	check_recipe()
