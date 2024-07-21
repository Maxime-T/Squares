extends BasicMine

@export var dmg : float = 50
@export var explosionSize : float = 5.5
@export var weapon : Weapon

func mine_constructor():
	var inst = ExplosionScene.instantiate()
	inst.dmg = dmg
	inst.size = explosionSize
	return inst
