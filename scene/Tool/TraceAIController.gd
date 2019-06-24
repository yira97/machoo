extends "res://scene/Tool/AIController.gd"

var puppet = null
var target = null
var move_direcstion:Vector2 = Vector2(0,0)

export (Array,String) var target_class = null
export (bool) var random_walk = false

func _enter_tree():
	puppet = get_parent()
	
	
func _physics_process(delta):
	move_direcstion = Vector2(0,0)
	if puppet != null:
		if target != null:
			move_direcstion = (target.get_global_position() - puppet.get_global_position()).normalized()
			puppet.move_to(move_direcstion)
		else:
			pass


func _on_Area2D_area_entered(area):
	var body = area.get_parent()
	if target == null:
		for name in target_class:
			if name == body.get_name():
				target = body


func _on_Area2D_area_exited(area):
	var body = area.get_parent()
	if target == body:
		target = null;
