extends Node2D

@export var ExplosionScene : PackedScene
@export var WeaponNode : Weapon

func _on_animation_player_animation_finished(anim_name):
	
	var instance = ExplosionScene.instantiate()
	instance.Source = WeaponNode.shooter
	instance.position = global_position
	$"..".add_child(instance) #################### C'est pas ouf ouf
	queue_free()
