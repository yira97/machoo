extends Node2D

var ork = preload("res://scene/Character/Masked_Ork.tscn")
var mAI =  preload("res://scene/Tool/MaliciousAIController.tscn")
var i_knight

func gen_mAI():
	var i_ork = ork.instance()
	var i_mAI = mAI.instance()
	i_mAI.target_nodes= ["../../Knight"]
	i_ork.add_child(i_mAI)
	return i_ork


func _enter_tree():
	i_knight = get_node("Knight")
	
	
func _on_Timer_timeout():
	self.add_child(gen_mAI())
