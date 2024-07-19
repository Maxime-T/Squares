extends Area2D
class_name HurtBox

@export var health_component : Health

func take_damage(dmg, dealer):
	health_component.take_damage(dmg, dealer)
