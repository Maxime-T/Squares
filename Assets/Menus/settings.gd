extends Control

@export var VolumeSlider : HSlider

@onready var input_button_scene = preload("res://Assets/Menus/input_button.tscn")
@export var action_list : VBoxContainer 
var input_actions = {
	"Left": "Turn left",
	"Right": "Turn right",
	"Up": "Move up",
	"Down": "Move down"
}

var isRemapping = false
var actionToRemap = null
var remappingButton = null

var Resolutions = [Vector2(960,540), Vector2(1920,1080), Vector2(2560,1080)]


func _input(event):
	if !is_multiplayer_authority():
		return
	if event.is_action_pressed("Esc"):
		visible = !visible

func _ready():
	visible = false
	AudioServer.set_bus_volume_db(0, VolumeSlider.value)
	
	#Window mode (par def)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	
	#Input settings
	create_action_list()
	

func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)


func _on_exit_pressed():
	visible = false


func _on_check_mute_toggled(toggled_on):
	if toggled_on:
		AudioServer.set_bus_volume_db(0, -200) ### On va dire que c'est ok
	else:
		AudioServer.set_bus_volume_db(0, VolumeSlider.value)


func _on_check_full_s_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)


func _on_resolutions_item_selected(index):
	DisplayServer.window_set_size(Resolutions[index])

func create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var ActionLabel = button.find_child("LabelAction")
		var InputLabel = button.find_child("LabelInput")
		
		ActionLabel.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			InputLabel.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			InputLabel.text = ""
		
		action_list.add_child(button)
