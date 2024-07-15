extends CharacterBody2D


func _physics_process(delta):
	if !is_multiplayer_authority():
		return
	
	velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down")*400
	move_and_slide()
