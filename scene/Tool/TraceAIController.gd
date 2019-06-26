extends "res://scene/Tool/AIController.gd"

var target = null
export (bool) var random_walk = false
export (Array,NodePath) var target_nodes = null

func trace():
	move_direction = (target.get_global_position() - puppet.get_global_position())

func after_trace():
	pass

func make_move_direction(delta):
	if target != null:
		trace()
		after_trace()
	else:
		if random_walk && randi()%15 < 1: # not change direction frecrently
			# new direction will some of base on last direction 
			move_direction = ( 0.3 * move_direction +  Vector2(randf()*2-1,randf()*2-1))


func _on_Area2D_body_entered(body):
	if target == null:
		if target_nodes != null:
			for n in target_nodes:
				var i_n = get_node(n)
				if i_n:
					if i_n.is_a_parent_of(body) || i_n == body:
						#print("catch you")
						target = body


func _on_Area2D_body_exited(body):
	if target == body:
		#print("lost you")
		target = null;
