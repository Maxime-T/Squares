extends Area2D

##PARAMETRE A DONNER
var dmgPerTick : float 	= 6
var duration : float 	= 6
var size : float 		= 6
var Source : Player

@export var LifeTimer : Timer


func _ready():
	LifeTimer.wait_time = duration
	LifeTimer.start()
	scale = Vector2(size, size)


func _on_tick_rate_timeout():
	for i in get_overlapping_areas():
		if i as HurtBox:
			i.take_damage(dmgPerTick, Source)


func _on_life_timer_timeout():
	queue_free()
