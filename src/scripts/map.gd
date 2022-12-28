extends Node2D

onready var player: Player = get_node("Player")
onready var left_wall = get_node("LeftWall")
onready var right_wall = get_node("RightWall")
onready var top_wall = get_node("TopWall")
onready var bottom_wall = get_node("BottomWall")
onready var brick_spawner: BrickSpawner = get_node("BrickSpawner")
onready var pause_menu = get_node("PauseMenu")

var BallScene = preload("res://src/Ball.tscn")
var prep_ball: Ball
var shots = 3

enum { PREPARING, PLAYING }
var state = PLAYING

func _ready():
	var screen_w = get_viewport().get_visible_rect().size.x
	var screen_h = get_viewport().get_visible_rect().size.y
	
	player.position.x = screen_w / 2
	player.position.y = screen_h * 0.9

#	left_wall.position.x = 0
#	left_wall.position.y = screen_h / 2
#	right_wall.position.x = screen_w
#	right_wall.position.y = screen_h / 2
#
#	top_wall.position.x = screen_w / 2
#	top_wall.position.y = 0
#	bottom_wall.position.x = screen_w / 2
#	bottom_wall.position.y = screen_h
#
	brick_spawner.position.x = screen_w / 2
	brick_spawner.position.y = screen_h * 0.25
	brick_spawner.spawn()

func _process(delta):
	if Input.is_action_pressed("shoot"):
		shoot()
	
	var current_ball: Ball = find_node("Ball")
	if state == PREPARING:
		current_ball.set_position(player.transform.origin + Vector2(0, -30))
	elif not current_ball:
		if shots > 0:
			prepare()
		else:
			get_tree().paused = true
			pause_menu.show()


func _on_Reset_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_Exit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://src/MainMenu.tscn")

func prepare():
	shots -= 1
	var counter = $GUI/HBoxContainer/Shots
	counter.text = String(shots)
	state = PREPARING
	
	prep_ball = BallScene.instance()
	prep_ball.set_position(player.transform.origin + Vector2(0, -30))
	prep_ball.set_collision_mask_bit(0, false)
	
	player.set_collision_mask_bit(2, false)
	add_child(prep_ball)
	prep_ball.switch_type_to(player.current_type)
	prep_ball.set_owner(self)
	
func shoot():
	state = PLAYING
	
	prep_ball.set_collision_mask_bit(0, true)
	player.set_collision_mask_bit(2, true)
	prep_ball.shoot(Vector2.UP)
