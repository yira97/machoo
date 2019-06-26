extends Node

class_name CharacterAttribute

var mHealth:int
var mMagic:int
var mStrength:int
var mConstitution:int
var mDexterity:int
var mIntelligence:int
var mLuck:int

func _init(health:int = 100, magic:int = 0, strength:int = 10, constitution:int = 10, dexterity:int = 10, intelligence:int = 10, luck:int = 10):
	mHealth = health
	mMagic = magic
	mStrength = strength
	mConstitution = constitution
	mDexterity = dexterity
	mIntelligence = intelligence
	mLuck = luck
	
	assert(mHealth>0)
	assert(mMagic>=0)
	assert(strength>0)
	assert(mConstitution>0)
	assert(mDexterity>0)
	assert(mIntelligence>0)
	assert(mLuck>0)


func get_alive_status()->bool:
	return mHealth > 0


func take_damge(damage:int)->void:
	if mHealth > 0:
		if damage > 0:
			mHealth -= damage
			if mHealth < 0:
				mHealth = 0


func generate_damge()->int:
	return mStrength
	
func get_move_speed()->int:
	return mDexterity * 10