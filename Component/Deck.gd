extends Node
class_name Deck

@export var weapons : Array[WeaponScene]

var currentIndex : int = 0:
	set(value):
		currentIndex = value % weapons.size()

func add_weapon(w : WeaponScene):
	weapons.append(w)

func next_weapon() -> WeaponScene:
	var current = weapons[currentIndex]
	currentIndex += 1
	return current
