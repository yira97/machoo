extends "res://scene/Character/Character.gd"

var coin

func _enter_tree():
	coin = preload("res://scene/CollectableItem/Coin.tscn")

func take_damage_extend():
	.take_damage_extend()
	

func dead():
	.dead()
	var i_coin = coin.instance()
	i_coin.position = self.position
	get_parent().add_child(i_coin)
	