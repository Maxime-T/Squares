extends Node

func create(particles : GPUParticles2D):
	particles.connect("finished", destroy.bind(particles))
	add_child(particles)
	particles.emitting = true

func destroy(particles : GPUParticles2D):
	particles.queue_free()
