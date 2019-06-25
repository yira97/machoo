extends Area2D

export (int) var item_ID = 0

var collectable:bool = false

func _enter_tree():
	$ItemSprite.play("idle")

func _on_CollectableItem_body_entered(body):
	if collectable == true:
		body.on_collect_item(item_ID)
		queue_free()

func _on_WaitTimer_timeout():
	collectable = true
