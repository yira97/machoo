extends "res://scene/Character/Character.gd"

var coin

func _enter_tree():
	coin = preload("res://scene/CollectableItem/Coin.tscn").instance()

func take_damage_extend():
	.take_damage_extend()
	

func dead_extend():
	.dead_extend()
	coin.position = self.position
	get_parent().add_child(coin)
	