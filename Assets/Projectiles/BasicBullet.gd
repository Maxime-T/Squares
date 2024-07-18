extends CharacterBody2D

@export_group("Properties")
@export var speed : int = 1000
@export var dmg : int = 25

@export var direction : float
var spawnPos : Vector2
var spawnRot : float
var zdex : int
var shooter : Player

func _ready():
	if !is_multiplayer_authority():
		return
	direction = spawnRot
	global_position = spawnPos
	global_rotation = spawnRot
	z_index = zdex


func _physics_process(_delta):
	velocity = Vector2(speed, 0).rotated(direction)
	move_and_slide()


func _on_life_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	if (body.has_method("take_damage")):
		body.take_damage(dmg,shooter)
	queue_free()
