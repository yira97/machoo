extends Node2D

export (int) var health = 100
export (int) var magic = 0
export (int) var strength = 10
export (int) var constitution = 10
export (int) var dexterity = 10
export (int) var intelligence = 10
export (int) var mens = 10
export (int) var luck = 100
export (PackedScene) var main_hand_equip = null

var move_step:Vector2 = Vector2(0,0)
var in_range_targets:Array = []

func _enter_tree():
	$AnimatedSprite.play()
	$AnimationPlayer.play("idle")

func get_speed():
	return dexterity * 10
	
func take_damage(damge_number:int):
	health -= damge_number
	if health < 0:
		health = 0

func move(delta):
	var move:Vector2 = move_step * get_speed() * delta
	# choose [hit/idle] or [run] by move.length()
	if move.length() == 0: # the priority of hit is high than idle
		if $AnimationPlayer.get_current_animation() != "hit":
			$AnimationPlayer.play("idle")
	else:
		if move.x > 0:
			$AnimatedSprite.set_flip_h(false)
			$MainHandPosition/EquipSprite.set_flip_h(false)
			$MainHandPosition.position.x = abs($MainHandPosition.position.x)
			
		else:
			$AnimatedSprite.set_flip_h(true)
			$MainHandPosition/EquipSprite.set_flip_h(true)
			$MainHandPosition.position.x = -abs($MainHandPosition.position.x)
		$AnimationPlayer.play("run")
	$".".move_and_collide(move)
	
func clear_status():
	move_step = Vector2(0,0)


func hit():
	$AnimationPlayer.play("hit")
	hit_extend()

func hit_extend():
	pass
	
func move_to(direction:Vector2):
	move_step = direction.normalized()
	
func _physics_process(delta):
	move(delta)
	clear_status()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hit":
		$AnimationPlayer.play("idle")


func _on_EquipArea_body_exited(body):
	var existence = false
	for t in in_range_targets:
		if t == body:
			existence = true
	if existence == false:
		in_range_targets.push_back(body)
	else:
		pass

func _on_EquipArea_body_entered(body):
	in_range_targets.erase(body)