extends Node

func _ready() -> void:
	# Set your game's Steam app ID here
	OS.set_environment("SteamAppId", str(583950))
	OS.set_environment("SteamGameId", str(583950))
	initialize_steam()

func initialize_steam() -> void:
	var initialize_response: Dictionary = Steam.steamInitEx()
	print("Did Steam initialize?: %s" % initialize_response)
		
	if initialize_response['status'] > 0:
		print("Failed to initialize Steam, shutting down: %s" % initialize_response)
		#get_tree().quit()


func _process(_delta: float) -> void:
	Steam.run_callbacks()
