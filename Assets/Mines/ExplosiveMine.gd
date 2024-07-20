extends BasicMine

@export var ExplosionAnim : AnimationPlayer
@export var ExplosionSprite : Sprite2D
@export var ExplosionRadius : Area2D

@export var dmg : float = 50


func _ready():
	ExplosionSprite.visible = false
	ExplosionRadius.monitoring = false
	

func explosion_start():
	ExplosionAnim.play("Explosion")
	ExplosionRadius.monitoring = true


func _on_explosion_radius_area_entered(area):
	if area is HurtBox:
		area.take_damage(dmg, Source)
