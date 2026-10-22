extends Pickups

class_name Experience

@export var XP : float

func activate():
	super.activate()
	prints("+" + str(XP) + "XP")
	player.gain_XP(XP)
