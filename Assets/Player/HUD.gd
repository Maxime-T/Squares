extends Control

@export var health_component : Health
@export var hp_bar : ProgressBar
@export var dmg_bar : ProgressBar
@export var name_label : Label
@export var dmgTimer : Timer

@export var barSize : int = 100
@export var barHeight : int = -90

var MAX_HP : float

func _ready():
	if is_multiplayer_authority():
		name_label.text = Steam.getPersonaName()
	
	MAX_HP = health_component.MAX_HP
	hp_bar.max_value = MAX_HP
	dmg_bar.max_value = MAX_HP
	dmg_bar.value = MAX_HP
	hp_bar.value = MAX_HP
	
	custom_minimum_size.x = barSize
	position.y = barHeight

##Attention: il faut connect Health_changed du HealthComponent
func _on_health_healt_changed(hp):
	dmgTimer.start()
	rpc("update_hp", hp)

func adjust_dmg_bar():
	var trueHP = hp_bar.value
	while(dmg_bar.value != trueHP):
		await get_tree().create_timer(0.05).timeout #D'après la doc, 0.05 c'est le min pour un timer
		if (dmg_bar.value - trueHP >= MAX_HP/50):
			dmg_bar.value -= MAX_HP/50 # =2 pour les players, c'est juste si un truc a genre 10000hp
		else:
			dmg_bar.value = trueHP

@rpc("call_local", "any_peer", "reliable")
func update_hp(hp):
	hp_bar.value = hp

func _on_dmg_update_cd_timeout():
	adjust_dmg_bar()
