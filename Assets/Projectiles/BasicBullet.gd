extends CharacterBody2D

@export_group("Properties")
@export var speed : int = 400
@export var dmg : int = 5

var direction : float
var spawnPos : Vector2
var spawnRot : float
var zdex : int

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot
	direction = spawnRot
	z_index = zdex


func _physics_process(_delta):
	velocity = Vector2(speed, 0).rotated(direction)
	move_and_slide()


func _on_life_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	queue_free()
