extends Line2D
class_name FollowLine

var follows : Node2D
var buffer : PackedVector2Array
var bufferSize : int
var following : bool = true

func _init(follows : Node2D, bufferSize : int):
	self.follows = follows
	self.bufferSize = bufferSize

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if following:
		buffer.append(follows.position)
			
		if buffer.size() > bufferSize:
			buffer.remove_at(0)
			
	else: if !buffer.is_empty():
		buffer.remove_at(0)
	else:
		queue_free()
	
	points = buffer
