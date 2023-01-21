extends Area2D

export(bool) var locked := false

export(Resource) var item_needed

var _hovering = false

func _ready():
	var room_file = get_tree().current_scene.filename
	var wall_name = get_parent().name

	if ProgressManager.unlocked_items.has(room_file):
		if ProgressManager.unlocked_items[room_file].has(wall_name):
			locked = false

func _on_Door_mouse_entered():
	_hovering = true

func _on_Door_mouse_exited():
	_hovering = false
	
func _input(event):
	if _hovering:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
			interact()
			get_tree().set_input_as_handled()
		
func interact():
	
	var room_file = get_tree().current_scene.filename
	var wall_name = get_parent().name
	var wall_index = get_parent().get_parent().current_wall_index
	
	if locked:
		if Inventory.items[Inventory.selected_item_index] == item_needed:
			TextBox.show_texts(["Você usou " + item_needed.name + " . Parabens!"])
			locked = false
			ProgressManager.add_unlocked_item(room_file, wall_name)
			# Usar a chave do inventario
			Inventory.remove_item(item_needed)
			ProgressManager.anxiety -= 10
		else:
			TextBox.show_texts(["Precisa " + item_needed.name + " para usar!"])
	else:
		ProgressManager.previous_room = room_file
		ProgressManager.previous_wall_name = wall_name
		ProgressManager.previous_wall_index = wall_index