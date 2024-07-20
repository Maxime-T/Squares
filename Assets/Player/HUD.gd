extends Control

@export var health_component : Health
@export var life_bar : ProgressBar
@export var name_label : Label

var MAX_HP : float

func _ready():
	name_label.text = Steam.getPersonaName()
	life_bar.max_value
	MAX_HP = health_component.MAX_HP
	life_bar.value = MAX_HP
	

func _on_health_healt_changed(hp):
	rpc("update_hp", hp)


@rpc("call_local", "any_peer", "reliable")
func update_hp(hp):
	life_bar.value = hp
