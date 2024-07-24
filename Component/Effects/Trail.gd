extends Node
class_name Trail

@export var follows : Node2D
@export var bufferSize : int = 10
@export var width : float = 20
@export var width_curve : Curve
@export var color : Color = Color(1,1,1,1)
@export var colorGradient : Gradient
@export_range(0,10) var hdr : float
var buffer : PackedVector2Array
var line : FollowLine

func _ready():
	follows.connect("ready", _start)

func _start():
	line = FollowLine.new(follows, bufferSize)
	line.width = width
	line.width_curve = width_curve
	line.z_index = follows.z_index - 1
	line.default_color = color
	line.gradient = colorGradient
	line.end_cap_mode = Line2D.LINE_CAP_ROUND
	line.modulate = Color(hdr, hdr, hdr)
	
	follows.connect("tree_exited", _follows_destroyed)
	follows.add_sibling(line)
	line.following = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	buffer.append(follows.position)
		
	if buffer.size() > bufferSize:
		buffer.remove_at(0)
		
	line.points = buffer

func _follows_destroyed():
	line.following = false
