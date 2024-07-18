extends Node2D

var peer = ENetMultiplayerPeer.new()
@onready var ms = $MultiplayerSpawner
@export var level_scene : PackedScene

func _ready():
	ms.spawn_function = spawn_level

func _on_host_pressed():
	peer.create_server(2048)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(spawn_level)
	ms.spawn(level_scene)
	hideMenu()

func _on_join_pressed():
	peer.create_client("localhost", 2048)
	multiplayer.multiplayer_peer = peer
	hideMenu()

func spawn_level(_data):
	var a = level_scene.instantiate()
	return a

func hideMenu():
	$Host.hide()
	$Join.hide()
