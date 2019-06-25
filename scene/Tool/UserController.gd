extends Node2D

var puppet = null
var move_direction:Vector2 = Vector2(0,0)

func _enter_tree():
	puppet = get_parent()

func execute_move_and_clear():
	puppet.move_to(move_direction)
	move_direction = Vector2(0,0)

func _physics_process(delta):
	if puppet != null:
		if Input.is_action_pressed("ctl_hit_1"):
			puppet.hit()
		else: # hit action will stop character move
			if Input.is_action_pressed("ctl_up"):
				move_direction.y -= 1
			elif Input.is_action_pressed("ctl_down"):
				move_direction.y += 1
			if Input.is_action_pressed("ctl_left"):
				move_direction.x -= 1
			elif Input.is_action_pressed("ctl_right"):
				move_direction.x += 1
		execute_move_and_clear()
		
		