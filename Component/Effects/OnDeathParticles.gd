extends Node
class_name OnDeathParticles

@export var particlesScene : PackedScene
@export var keepParentRotation : bool = false


var particle : GPUParticles2D
var parent : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	parent.connect("tree_exited",play)

func play():
	particle = particlesScene.instantiate()
	particle.global_position = parent.global_position
	
	if keepParentRotation:
		particle.rotation = parent.global_rotation
	
	print(particle)
	ParticleManager.create(particle)
