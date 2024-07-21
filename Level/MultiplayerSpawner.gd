extends MultiplayerSpawner

@export var playerScene : PackedScene
@export var SpawnPos1 : Marker2D
@export var SpawnPos2 : Marker2D

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_function = spawnPlayer
	if is_multiplayer_authority():
		spawn(1)
		multiplayer.peer_connected.connect(spawn)
		multiplayer.peer_disconnected.connect(removePlayer)

var players = {}

func spawnPlayer(data):
	var p : Node2D = playerScene.instantiate()
	
	if players.size() == 0:
		p.position = SpawnPos1.global_position
	if players.size() == 1:
		p.position = SpawnPos2.global_position
	
	p.set_multiplayer_authority(data)
	players[data] = p
	return p

func removePlayer(data):
	players[data].queuddde_free()
	players.erase(data)
