extends Line2D
class_name FollowLine

var follows : Node2D
var buffer : PackedVector2Array
var bufferSize : int
var following : bool = true

func _init(_follows : Node2D, _bufferSize : int):
	self.follows = _follows
	self.bufferSize = _bufferSize

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if following:
		buffer.append(follows.position)
			
		if buffer.size() > bufferSize:
			buffer.remove_at(0)
			
	else: if !buffer.is_empty():
		buffer.remove_at(0)
	else:
		queue_free()
	
	points = buffer
