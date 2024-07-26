@tool
extends Resource
class_name WeaponScene

@export var scene : PackedScene:
	set(value):
		if value != null:
			var root = value.instantiate()
			var hasWeapon : bool = false
			
			for child in root.get_children():
				if child is Weapon:
					hasWeapon = true
			
			assert(hasWeapon, "scene has no weapon type children")
		
		scene = value

func instantiate():
	var node = scene.instantiate()
	return node
