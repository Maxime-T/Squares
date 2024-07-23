extends Node

class Shake:
	var direction : Vector2:
		set(d):
			direction = d.normalized()
	
	var amount : float
	var goTime : float
	
	var time : float = 0
	
	func _init(direction : Vector2, amount : float, goTime : float):
		self.direction = direction
		self.amount = amount
		self.goTime = goTime

var shakes : Array[Shake]

func shake(direction : Vector2, amount : float, goTime : float):
	shakes.append(Shake.new(direction, amount, goTime))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var offset = Vector2(0,0)
	var camera : Camera2D = get_viewport().get_camera_2d()
	for s in shakes:
		if s.time < s.goTime:
			offset += s.direction * lerpf(s.amount, 0, s.time/s.goTime) * delta
		
		s.time += delta
		
	if camera != null:
		camera.offset = offset
		print(camera.offset)















