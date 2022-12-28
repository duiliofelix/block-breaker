class_name Brick
extends Area2D

const ExplosionScene = preload("res://src/Explosion.tscn")
var health = 2

func _ready():
	pass

func hit(amount = 1):
	health -= amount
	if health <= 0:
		destroy()

func destroy():
	self.queue_free()

func _on_Brick_body_entered(ball: Ball):
	match ball.current_type:
		Element.CRYO:
			destroy()
		Element.PYRO:
			hit(2)
			ball.bounce(Vector2.UP)
			var explosion = ExplosionScene.instance()
			explosion.set_position(transform.origin)
			get_parent().add_child(explosion)
		_:
			hit()
			ball.bounce(Vector2.UP)
