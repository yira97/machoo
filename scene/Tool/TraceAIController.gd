extends "res://scene/Tool/AIController.gd"

var puppet = null
var target = null
var move_direcstion:Vector2 = Vector2(0,0)
var last_move_direction:Vector2 = Vector2(0,0);

export (bool) var random_walk = false
export (Array,NodePath) var target_nodes = null

func _enter_tree():
	puppet = get_parent()
	
	
func _physics_process(delta):
	move_direcstion = Vector2(0,0)
	if puppet != null:
		if target != null:
			move_direcstion = (target.get_global_position() - puppet.get_global_position())
			puppet.move_to(move_direcstion)
		else:
			if random_walk && randi()%15 < 1: # not change direction frecrently
				# new direction will some of base on last direction 
				last_move_direction = ( 0.3 * last_move_direction +  Vector2(randf()*2-1,randf()*2-1))
			puppet.move_to(last_move_direction)


func _on_Area2D_body_entered(body):
	if target == null:
		if target_nodes != null:
			for n in target_nodes:
				if get_node(n).is_a_parent_of(body) || get_node(n) == body:
					print("catch you")
					target = body


func _on_Area2D_body_exited(body):
	if target == body:
		print("lost you")
		target = null;
