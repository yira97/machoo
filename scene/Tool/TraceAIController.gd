extends "res://scene/Tool/AIController.gd"

var puppet = null
var target = null
var move_direcstion:Vector2 = Vector2(0,0)

export (bool) var random_walk = false
export (Array,NodePath) var target_nodes = null

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
	if target == null:
		if target_nodes != null:
			for n in target_nodes:
				if get_node(n).is_a_parent_of(area):
					target = area


func _on_Area2D_area_exited(area):
	if target == area:
		target = null;
