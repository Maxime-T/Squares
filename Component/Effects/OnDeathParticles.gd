extends Node
class_name OnDeathParticles

@export var particlesScene : PackedScene
var particle : GPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect("tree_exited",play)
	particle = particlesScene.instantiate()
	get_parent().add_sibling(particle)

func play():
	particle.global_position = get_parent().global_position
	particle.emitting = true
	particle.connect("finished", delete)

func delete():
	print("ui")
	particle.queue_free()
