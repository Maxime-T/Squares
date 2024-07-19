extends Node
class_name Health

signal died 

@export var MAX_HP : float = 100
@onready var hp = MAX_HP :
	set(value):
		hp = clamp(value, 0, MAX_HP)

##make the player take damage,
##died signal is emited if hp fall at 0, put dealer = null if no dealer is known
func take_damage(damage : float, dealer : Player) -> void:
	hp -= damage
	if_killed_emit(dealer)

func set_hp(_hp) -> void:
	hp = _hp
	if_killed_emit(null)

func get_hp() -> float:
	return hp

func if_killed_emit(dealer : Player) -> void:
	if hp <= 0:
		died.emit(dealer)
