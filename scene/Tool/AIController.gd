extends Node2D

var puppet = null
var move_direction:Vector2 = Vector2(0,0)

func _enter_tree():
	puppet = get_parent()
	
func execute_move_and_clear():
	puppet.move_to(move_direction)
	move_direction = Vector2(0,0)

func make_move_direction(delta):
	pass
	
func _physics_process(delta):
	if puppet != null:
		make_move_direction(delta)
		execute_move_and_clear()