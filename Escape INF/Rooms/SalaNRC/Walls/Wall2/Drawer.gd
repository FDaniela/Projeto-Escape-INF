extends Area2D

export(bool) var locked := false

onready var sprite = $Sprite

var _hovering = false
		
func _on_Drawer_mouse_entered():
	_hovering = true
	Input.set_default_cursor_shape(2)

func _on_Drawer_mouse_exited():
	_hovering = false
	Input.set_default_cursor_shape(0)
	
func _input(event):
	if _hovering:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
			interact()
			get_tree().set_input_as_handled()
		
func interact():
	if  not ProgressManager.check_progress("unlocked_items", "res://Rooms/SalaNRC/Walls/SalaNRC.tscn", "SalaNRC_Wall3", "Fios"):
		sprite.frame=1
	else:
		TextBox.show_texts(["Estava gaveta está travada"])