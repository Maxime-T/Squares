extends Node
class_name Weapon

@export var image : Texture2D
@export var cooldown : float = 1.0

var t : Timer
signal when_ready

var shooter : Player
var spawnRot : float
var spawnPos : Vector2
var zdex : int


func _ready():
	t = Timer.new()
	t.wait_time = cooldown
	t.timeout.connect(cooldown_end)

func start_cooldown(time : float = cooldown):
	t.start(time)

func is_ready():
	return t.time_left <= 0

func set_cooldown(_cooldown):
	cooldown = _cooldown

func cooldown_end():
	when_ready.emit()
