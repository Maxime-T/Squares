extends MultiplayerSpawner

@export var playerScene : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_function = spawnPlayer
	if is_multiplayer_authority():
		spawn(1)
		multiplayer.peer_connected.connect(spawn)
		multiplayer.peer_disconnected.connect(removePlayer)

var players = {}

func spawnPlayer(data):
	print(data)
	var p : Node2D = playerScene.instantiate()
	p.position = Vector2(randi_range(1, 700),randi_range(1, 700))
	p.set_multiplayer_authority(data)
	players[data] = p
	return p

func removePlayer(data):
	players[data].queue_free()
	players.erase(data)
