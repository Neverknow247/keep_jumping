extends Node2D

@export var animation = "short_jump"

func play():
	$AnimationPlayer.play(animation)
