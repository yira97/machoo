extends Node2D

var mCharacterAttribute:CharacterAttribute
var mCharacterBag:Dictionary
var mMoveDirection:Vector2


func _init():
	mCharacterAttribute = CharacterAttribute.new(100,0,10,10,10,10,10)
	mCharacterBag = {}
	mMoveDirection = Vector2(0,0)


func _enter_tree():
	$AnimationPlayer.play("idle")


func dead():
	$AnimationPlayer.play("die")


func take_damage(damge:int):
	mCharacterAttribute.take_damge(damge)


func hit():
	if cool_down_status == true:
		cool_down_status = false
		print("hit...")
		$AnimationPlayer.play("hit")
		for t in in_range_targets:
			t.take_damage(mCharacterAttribute.generate_damge())


#=========================

var in_range_targets:Array = []
var cool_down_status:bool = true
var last_face:int = 1 # 1==right, -1==left



func move(delta):
	var move:Vector2 = mMoveDirection * mCharacterAttribute.get_move_speed() * delta
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
	if mCharacterAttribute.get_alive_status() == false:
		dead()
	$".".move_and_collide(move)
	
func clear_status():
	mMoveDirection = Vector2(0,0)


	
func move_to(direction:Vector2):
	mMoveDirection = direction.normalized()
	

func _physics_process(delta):
	move(delta)
	clear_status() # must be the last function

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hit":
		$AnimationPlayer.play("idle")
	if anim_name == "die":
		queue_free()
		
func on_collect_item(itemID):
	var item_number:int = mCharacterBag.get(itemID,0)
	mCharacterBag[itemID] = item_number + 1
	print("collect something")


func _on_EquipArea_body_entered(body):
	if body != self:
		if in_range_targets.find(body) == -1:
			in_range_targets.push_back(body)
		
func _on_EquipArea_body_exited(body):
	in_range_targets.erase(body)

func _on_CoolDownTimer_timeout():
	cool_down_status = true
	



class CharacterHandEquip:
	var EquipCoolDown:bool
	