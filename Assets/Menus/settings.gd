extends Control

@export var VolumeSlider : HSlider

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
