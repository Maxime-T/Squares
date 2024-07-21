extends BasicMine

@export var dmgPerTick : float = 5
@export var cloudDuration : float = 7
@export var cloudSize : float = 6.5

func mine_constructor():
	var inst = ExplosionScene.instantiate()
	inst.dmgPerTick = dmgPerTick
	inst.duration = cloudDuration
	inst.size = cloudSize
	return inst
	

