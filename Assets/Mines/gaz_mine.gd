extends BasicMine

@onready var GazScene : PackedScene = preload("res://Assets/Mines/poison_cloud.tscn")

@export var dmgPerTick : float = 5
@export var cloudDuration : float = 7
@export var cloudSize : float = 6.5

func explosion_start():
	var instance = GazScene.instantiate()
	instance.Source = Source
	instance.dmgPerTick = dmgPerTick
	instance.duration = cloudDuration
	instance.size = cloudSize
	add_child(instance)
	queue_free()
	

