extends Node2D
# Generate terrain chuck by chuck. Delete the previous chuck then generate new chuck.
# 根據玩家位置與距離生成與刪除區塊
@export var tilemap : TileMapLayer
@export var actor : Character
@export var chunk_size : Vector2i = Vector2i(80, 6)
@export var tile_size : int = 8.0
var tile_coords : Dictionary = {"grass_land": Vector2i(1, 0), "dirt": Vector2i(1, 1)}
var grass_deco_coord : int = 4: # grass deco tile from (4,2) to (6,2)
	set(value):
		if value <= 6:
			grass_deco_coord = value
		else:
			grass_deco_coord = 4
var chunk
func _ready() -> void:
	generate_meadow_chunk()

func generate_meadow_chunk():
	for x in range(chunk_size.x):
		for y in range(chunk_size.y):
			var tile_pos : Vector2i = Vector2i(x, -(y + 1))
			if (y + 1 < chunk_size.y - 1):
				tilemap.set_cell(tile_pos, 0, tile_coords["dirt"])
			elif (y + 1 == chunk_size.y -1):
				tilemap.set_cell(tile_pos, 0, tile_coords["grass_land"])
			# Add grass deco
			elif (y + 1 == chunk_size.y):
				tilemap.set_cell(tile_pos, 0, Vector2i(grass_deco_coord, 2))
				grass_deco_coord += 1
			
