extends Node
class_name Function

var function : Callable
var precision : int
var map : Dictionary = {}
var d : float

func _init(function : Callable, precision : int = 100):
	self.function = function
	self.precision = precision
	d = 1/(precision)

func _ready():
	for i in range(precision+1):
		var x = i/(precision)
		map[x] = function.callv([x])

func of(x) -> float:
	return function.callv(x)

func inverse_of(y) -> float:
	var values : Array = map.values()
	
	var index = values.bsearch(y, true)
	assert(index>0 && index<=precision)
	var yResult = Vector2(values[index], values[index+1])
	var slope = yResult.y-yResult.x
	var ratio = abs(y-yResult.x)/abs(yResult.x-yResult.y)
	
	var xResult = Vector2(map.find_key(yResult.x), map.find_key(yResult.y))
	var result = lerp(xResult.x,yResult.y,ratio)
	
	return result










