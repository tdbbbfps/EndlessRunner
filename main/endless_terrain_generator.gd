extends Node2D
# Generate terrain chuck by chuck. Delete the previous chuck then generate new chuck.
# 根據玩家位置與距離生成與刪除區塊
@export var tilemap : TileMapLayer
@export var actor : Character
@export var chuck_size : int = 320.0
@export var tile_size : int = 8.0

func _ready() -> void:
	generate_chuck()

func generate_chuck():
	for x in range(360):
		for y in range(5):
			tilemap.set_cell(Vector2i(x, -y))
