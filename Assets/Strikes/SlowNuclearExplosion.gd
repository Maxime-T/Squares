extends Area2D

@export var ExploSprite : Sprite2D
@export var DeflaSprite : Sprite2D

##PARAMETRE A DONNER
var dmg : float = 9999
var deflaSpeed : float = 0.8
var deflaAcc : float = 0.5
var size : float = 1
var Source : Player

var deflaStarted = false

func _ready():
	scale = Vector2(size, size)
	DeflaSprite.visible = false
	rotation = randi_range(1, 360)


func _on_area_entered(area):
	if area is HurtBox:
		area.take_damage(dmg, Source)

func start_deflagration():
	ExploSprite.visible = false
	deflaStarted = true


func _process(delta):
	if deflaStarted and scale.x < 20:
		scale += scale*delta*deflaAcc + Vector2(delta*deflaSpeed, delta*deflaSpeed)
