extends "res://scene/Tool/TraceAIController.gd"

var battle_status:bool = false

func trace():
	move_direction = target.get_global_position() - puppet.get_global_position()
	if abs(target.get_global_position().x - puppet.get_global_position().x) < 25: # if the distance is close enough, hold the x-axis, just move the y-axis.-
		move_direction.x = 0
		if abs(target.get_global_position().y - puppet.get_global_position().y) < 5:
			move_direction.y = 0
			
func after_trace():
	if battle_status == true:
		puppet.hit()

func _on_AttackArea_body_entered(body):
	if body == target:
		print("start battle")
		battle_status = true


func _on_AttackArea_body_exited(body):
	if body == target:
		print("stop battle")
		battle_status = false
