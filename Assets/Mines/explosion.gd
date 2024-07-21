extends Area2D

##PARAMETRE A DONNER
var dmg : float = 50
var size : float = 5.5
var Source : Player

func _ready():
	scale = Vector2(size, size)

func _on_area_entered(area):
	if area is HurtBox:
		area.take_damage(dmg, Source)
