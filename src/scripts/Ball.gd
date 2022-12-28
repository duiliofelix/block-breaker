class_name Ball
extends KinematicBody2D

var cryo_asset = preload("res://assets/ball/ball-cryo.png")
var electro_asset = preload("res://assets/ball/ball-electro.png")
var hydro_asset = preload("res://assets/ball/ball-hydro.png")
var pyro_asset = preload("res://assets/ball/ball-pyro.png")

onready var sprite: Sprite = $Sprite

var current_type = Element.ELECTRO
var SPEED = 700
var velocity = Vector2.ZERO
var bounce_vector = null

func _ready():
	pass

func _physics_process(delta):
	if bounce_vector:
		velocity = velocity.bounce(bounce_vector)
		bounce_vector = null
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		
		if collider.name == "BottomWall":
			queue_free()
		elif collider.name == "Player":
			switch_type_to(collider.current_type)
		
		bounce(collision.normal)

func bounce(normal: Vector2):
	bounce_vector = normal

func shoot(direction: Vector2):
	velocity = direction * SPEED

func switch_type_to(new_type):
	current_type = new_type
	
	match current_type:
		Element.CRYO:
			sprite.texture = cryo_asset
		Element.ELECTRO:
			sprite.texture = electro_asset
		Element.HYDRO:
			sprite.texture = hydro_asset
		Element.PYRO:
			sprite.texture = pyro_asset
