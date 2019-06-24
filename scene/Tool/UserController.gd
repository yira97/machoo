extends Node2D

var puppet = null
var move_direction:Vector2 = Vector2(0,0)
func _enter_tree():
	puppet = get_parent()

func _physics_process(delta):
	if puppet != null:
		move_direction = Vector2(0,0)
		if Input.is_action_pressed("ctl_up"):
			move_direction.y -= 1
		elif Input.is_action_pressed("ctl_down"):
			move_direction.y += 1
	 	
		if Input.is_action_pressed("ctl_left"):
			move_direction.x -= 1
		elif Input.is_action_pressed("ctl_right"):
			move_direction.x += 1
		
		var opt_move_direction:Vector2 = move_direction.normalized()
		puppet.move_to(opt_move_direction)