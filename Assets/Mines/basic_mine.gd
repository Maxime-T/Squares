extends Area2D
class_name  BasicMine

@export var Audio : AudioStreamPlayer2D
@export var Sprite : AnimatedSprite2D

var Source : Player = null
var ignited = false

func _on_body_entered(body):
	if not ignited:
		Audio.play()
		Sprite.speed_scale = 3
		ignited = true

func _on_audio_stream_player_2d_finished():
	explosion_start()

func explosion_start():
	queue_free()
