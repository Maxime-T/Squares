extends Node2D

var peer = SteamMultiplayerPeer.new()
var lobby_id = 0
@onready var ms = $MultiplayerSpawner

@export var player_scene : PackedScene

func _ready():
	ms.spawn_function = spawn_level
	peer.lobby_created.connect(_on_lobby_created)
	Steam.lobby_match_list.connect(_on_lobby_match_list)
	open_lobby_list()

func spawn_level(data):
	var a = (load(data) as PackedScene).instantiate()
	return a

func _on_host_pressed():
	peer.create_lobby(SteamMultiplayerPeer.LOBBY_TYPE_PUBLIC)
	multiplayer.multiplayer_peer = peer
	ms.spawn("res://Level/Level.tscn")
	$Host.hide()
	$LobbyContainer.hide()
	$Refresh.hide()

func join_lobby(id):
	peer.connect_lobby(id)
	multiplayer.multiplayer_peer = peer
	lobby_id = id
	$Host.hide()
	$LobbyContainer.hide()
	$Refresh.hide()

func _on_lobby_created(connect, id):
	lobby_id = id
	Steam.setLobbyData(lobby_id,"name",str(Steam.getPersonaName()+ "'s Lobby"))
	Steam.setLobbyData(lobby_id, "game", "squares")
	Steam.setLobbyJoinable(lobby_id, true)

func open_lobby_list():
	Steam.addRequestLobbyListDistanceFilter(Steam.LOBBY_DISTANCE_FILTER_WORLDWIDE)
	Steam.addRequestLobbyListStringFilter("game","squares",Steam.LOBBY_COMPARISON_EQUAL)
	Steam.requestLobbyList()

func _on_lobby_match_list(lobbies):
	for lobby in lobbies:
		var lobby_name = Steam.getLobbyData(lobby, "name")
		var game_lobby = Steam.getLobbyData(lobby, "game")
		var mem_count = Steam.getNumLobbyMembers(lobby)
		
		var but = Button.new()
		but.text = str(lobby_name, " | Players: ", mem_count)
		but.set_size(Vector2(150,5))
		but.connect("pressed", Callable(self, "join_lobby").bind(lobby))
		$LobbyContainer/Lobbies.add_child(but)

func _on_refresh_pressed():
	if $LobbyContainer/Lobbies.get_child_count() > 0:
		for n in $LobbyContainer/Lobbies.get_children():
			n.queue_free()
	open_lobby_list()
