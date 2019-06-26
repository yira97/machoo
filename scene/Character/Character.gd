extends Node2D

export (int) var health = 100
export (int) var magic = 0
export (int) var strength = 10
export (int) var constitution = 10
export (int) var dexterity = 10
export (int) var intelligence = 10
export (int) var mens = 10
export (int) var luck = 100
export (bool) var alive_status = true

var move_step:Vector2 = Vector2(0,0)
var in_range_targets:Array = []
var cool_down_status:bool = true
var last_face:int = 1 # 1==right, -1==left

func _enter_tree():
	$AnimatedSprite.play()
	$AnimationPlayer.play("idle")

func get_speed():
	return dexterity * 10
	
func dead():
	$AnimationPlayer.play("die")
	dead_extend()

func dead_extend():
	pass
	
func take_damage(damge_number:int):
	health -= damge_number
	take_damage_extend()
	if health <= 0:
		health = 0
		dead()
	

func take_damage_extend():
	pass

func move(delta):
	var move:Vector2 = move_step * get_speed() * delta
	# choose [hit/idle] or [run] by move.length()
	if $AnimationPlayer.get_current_animation() != "die":
		if move.length() == 0: # the priority of hit is high than idle
			if $AnimationPlayer.get_current_animation() != "hit":
				$AnimationPlayer.play("idle")
		else:
			# every time you flip the scale value, 
			# the new scale value of Node will be reset with (1,1)
			# so it is need to add variable (last_face) to sovle the memoryless problem of Node'scale
			if sign(move.x) * last_face < 0: 
				scale.x = -1
				last_face *= -1
			$AnimationPlayer.play("run")
	$".".move_and_collide(move)
	
func clear_status():
	move_step = Vector2(0,0)
	if health <= 0:
		pass

func hit():
	if cool_down_status == true:
		cool_down_status = false
		print("hit...")
		$AnimationPlayer.play("hit")
		for t in in_range_targets:
			t.take_damage(strength)
		hit_extend()

func hit_extend():
	pass
	
func move_to(direction:Vector2):
	move_step = direction.normalized()
	

func _physics_process(delta):
	move(delta)
	clear_status() # must be the last function

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hit":
		$AnimationPlayer.play("idle")
	if anim_name == "die":
		queue_free()
		
func on_collect_item(itemID):
	print("collect something")


func _on_EquipArea_body_entered(body):
	if body != self:
		if in_range_targets.find(body) == -1:
			in_range_targets.push_back(body)
		
func _on_EquipArea_body_exited(body):
	in_range_targets.erase(body)

func _on_CoolDownTimer_timeout():
	cool_down_status = true
