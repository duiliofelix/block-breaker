class_name BrickSpawner
extends Node2D

export(int) var lines = 10
export(int) var columns = 10

export(PackedScene) var BrickScene
var brick_w = 1
var brick_h = 1

func _ready():
	var brick: Brick = BrickScene.instance()
	
	var scale_x = brick.scale.x
	var scale_y = brick.scale.y
	
	brick_w = brick.get_node("Sprite").texture.get_width() * scale_x
	brick_h = brick.get_node("Sprite").texture.get_height() * scale_y

func spawn():
	var base_x = - (brick_w * (columns - 1) / 2.0)
	var base_y = - (brick_h * (lines - 1) / 2.0)
	
	for i in range(lines):
		for j in range(columns):
			var new_brick = BrickScene.instance()
			var new_position = Vector2(base_x + brick_w * j, base_y + brick_h * i)
			new_brick.set_position(new_position)
			add_child(new_brick)

