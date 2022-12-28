class_name Player
extends KinematicBody2D

var cryo_asset = preload("res://assets/player/player-cryo.png")
var electro_asset = preload("res://assets/player/player-electro.png")
var hydro_asset = preload("res://assets/player/player-hydro.png")
var pyro_asset = preload("res://assets/player/player-pyro.png")

onready var sprite = $Sprite

export var speed = 10
export var current_type = Element.ELECTRO

func _ready():
	pass

func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	if Input.is_action_pressed("switch_1"):
		switch_type_to(Element.CRYO)
	if Input.is_action_pressed("switch_2"):
		switch_type_to(Element.ELECTRO)
	if Input.is_action_pressed("switch_3"):
		switch_type_to(Element.HYDRO)
	if Input.is_action_pressed("switch_4"):
		switch_type_to(Element.PYRO)
	
	move_and_slide(velocity, Vector2.UP)

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
