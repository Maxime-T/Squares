extends CharacterBody2D
class_name Projectile

enum projectileType {
	LINE,
}

@export_group("Projectile Properties")
@export var dmg : float = 25
@export var speed : float = 1000
@export var type : projectileType

@export_group("Setup")
@export var weapon : Weapon
@export var collision : Area2D

@export_group("Particles")
@export var explosionParticles : PackedScene
@export var nozzleFlash : PackedScene
@export var recoil : float

var body : CharacterBody2D

var direction : float


func _ready():
	play_flash()
	CameraShake.shake(Vector2.from_angle(weapon.spawnRot + PI), 300, 0.1)
	
	collision.body_entered.connect(_on_collision_with_body)
	collision.area_entered.connect(_on_collision_with_area)
	
	if !is_multiplayer_authority():
		return
	
	direction = weapon.spawnRot
	global_position = weapon.spawnPos
	global_rotation = weapon.spawnRot
	z_index = weapon.zdex


func play_flash():
	if nozzleFlash != null:
		var flash = nozzleFlash.instantiate()
		flash.global_position = global_position
		flash.global_rotation = weapon.spawnRot
		flash.scale = Vector2(0.3,0.3)
		ParticleManager.create(flash)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match type:
		projectileType.LINE:
			line_path(delta)


func line_path(_delta):
	velocity = Vector2(speed, 0).rotated(direction)
	move_and_slide()
	

func _on_collision_with_body(_body):
	destroy()


func _on_collision_with_area(area):
	if area is HurtBox:
		area.take_damage(dmg, weapon.shooter)
	
	destroy()


func destroy():
	var part = explosionParticles.instantiate()
	part.global_rotation = Vector2(1,0).angle_to(get_wall_normal()) + velocity.rotated(PI).angle_to(get_wall_normal())

	part.global_position = global_position
	ParticleManager.create(part)
	queue_free()








