extends CharacterBody2D

@export_group("Movement")
@export_range(0,1000,0.5) var MAX_SPEED : float = 400
@export_range(0,1000,0.01) var TIME_TO_MAX_SPEED : float = 0.25
@export_range(0,360*2,0.1,"degrees") var TURN_SPEED : float = 2.5

var ACCELERATION = MAX_SPEED * (1/TIME_TO_MAX_SPEED)

var direction : Vector2 = Vector2(0,-1):
	set(value):
		direction = value.normalized()
		rotation = direction.angle() + PI/2

var speed : float = 0:
	set(value):
		speed = clamp(value, -MAX_SPEED, MAX_SPEED)

func _physics_process(delta):
	if !is_multiplayer_authority():
		return
	
	var forwardAxis = Input.get_axis("Down","Up")
	var turnAxis = Input.get_axis("Left","Right")
	
	speed = move_toward(speed,MAX_SPEED*forwardAxis,ACCELERATION*delta)
	direction = direction.rotated(turnAxis*TURN_SPEED*delta)
	
	velocity = direction * speed
	move_and_slide()
