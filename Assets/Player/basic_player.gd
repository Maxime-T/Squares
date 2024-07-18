extends CharacterBody2D
class_name Player

@export_group("Movement")
@export_range(0,1000,0.5) var MAX_SPEED : float = 400
@export_range(0,2,0.01) var TIME_TO_MAX_SPEED : float = 0.25
@export_range(0,360*2,0.1,"degrees") var TURN_SPEED : float = 360
@export_range(0,2,0.01) var TIME_TO_MAX_ANGULAR_SPEED : float = 0.5

@export_group("Nodes")
@export var BodyNode : Node2D
@export var TurretNode : Node2D
@export var EndOfCannon : Marker2D
@export var BulletScene : PackedScene
@export var spawner : MultiplayerSpawner

@onready var ACCELERATION = MAX_SPEED/TIME_TO_MAX_SPEED
@onready var TURN_ACCELERATION = TURN_SPEED/TIME_TO_MAX_SPEED

@onready var MainLevel = $".." #C'est clairement pas ouf de faire comme ca, faudra changer

var turretTrueRotation : float = 0

var direction : Vector2 = Vector2(0,-1):
	set(value):
		direction = value.normalized()
		rotation = direction.angle()

var speed : float = 0:
	set(value):
		speed = clamp(value, -MAX_SPEED, MAX_SPEED)

var angularSpeed : float = 0:
	set(value):
		angularSpeed = clamp(value, -TURN_SPEED, TURN_SPEED)

#.######################################################################
#.                             RUNTIME                                 #                                                     #
#.######################################################################

func _ready():
	spawner.spawn_function = spawnBullet
	dead.connect(killed)

func _input(event):
	if !is_multiplayer_authority():
		return
	
	shoot_if_click(event)

func _physics_process(delta):
	if !is_multiplayer_authority():
		return
	
	movement(delta)

#mouvement ##########################################################
func movement(delta) -> void:
	#Forward movement
	var forwardAxis = Input.get_axis("Down","Up")
	if forwardAxis:
		speed = acceleration_function(speed, forwardAxis, delta) * MAX_SPEED
	else:
		speed = deceleration_function(speed, forwardAxis, delta) * MAX_SPEED
	
	#Turn movement
	var turnAxis = Input.get_axis("Left","Right")
	angularSpeed = move_toward(angularSpeed, TURN_SPEED*turnAxis, TURN_ACCELERATION*delta)
	direction = direction.rotated(deg_to_rad(angularSpeed)*delta)
	
	#Turret mouvement
	TurretNode.look_at(get_global_mouse_position())
	turretTrueRotation = TurretNode.rotation + rotation
	
	velocity = direction * speed
	move_and_slide()

func acceleration_function(v, forwardAxis, delta) -> float:
	var x : float = v/MAX_SPEED
	x += delta*forwardAxis/TIME_TO_MAX_SPEED
	x = clamp(x,-1,1)
	return x

func deceleration_function(v, _forwardAxis, delta) -> float:
	var x : float = acos(abs(v)/MAX_SPEED)*2/PI
	x += delta/TIME_TO_MAX_SPEED
	x = clamp(x,-1,1)
	return cos(x*PI/2) * sign(v)

#shoot ##############################################################
func spawnBullet(_data):
	var b : Node2D = BulletScene.instantiate()
	b.spawnRot = turretTrueRotation
	b.spawnPos = EndOfCannon.global_position
	b.zdex = z_index - 1
	#b.global_transform = TurretNode.global_transform
	b.shooter = self
	var auth = get_multiplayer_authority()
	b.set_multiplayer_authority(auth)
	return b

func shoot_if_click(event) -> void:
	if event.is_action_pressed("LeftClic"):
		spawner.spawn(BulletScene)

#life ###############################################################
@export_group("Life")
@export var MAX_HP : float = 100

signal dead
@onready var hp = MAX_HP :
	set(value):
		hp = clamp(value, 0, MAX_HP)

##make the player take damage,
##dead signal is emited if hp fall at 0, put dealer = null if no dealer is known
func take_damage(damage : float, dealer : Player) -> void:
	hp -= damage
	if_killed_emit(dealer)

func set_hp(_hp):
	hp = _hp
	if_killed_emit(null)

func if_killed_emit(dealer : Player) -> void:
	if hp <= 0:
		dead.emit(dealer)

func killed(_dealer):
	queue_free()
