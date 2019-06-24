extends Node2D

export (int) var health = 100
export (int) var magic = 0
export (int) var strength = 10
export (int) var constitution = 10
export (int) var dexterity = 10
export (int) var intelligence = 10
export (int) var mens = 10
export (int) var luck = 100

var move_step:Vector2 = Vector2(0,0);

func _enter_tree():
	$Area2D/AnimatedSprite.play()

func get_speed():
	return dexterity * 10

func move(delta):
	var move:Vector2 = move_step * get_speed() * delta
	if move.length() == 0:
		$Area2D/AnimatedSprite.animation = "idle"
	else:
		if move.x > 0:
			$Area2D/AnimatedSprite.flip_h = false
		else:
			$Area2D/AnimatedSprite.flip_h = true
		$Area2D/AnimatedSprite.animation = "run"
	position += move
	
func clear_status():
	move_step = Vector2(0,0)
	
func move_to(direction:Vector2):
	move_step = direction
	
	
func _physics_process(delta):
	move(delta)
	clear_status()