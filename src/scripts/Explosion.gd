class_name Explosion
extends Area2D

var max_ticks = 10
var ticks = 1


func _process(delta):
	var mult = ticks / 2
	set_scale(Vector2(mult, mult))
	
	ticks += 1
	if ticks >= max_ticks:
		queue_free()

func _on_Explosion_area_entered(brick):
	brick.hit(2)
