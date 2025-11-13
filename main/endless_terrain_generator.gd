extends Node2D
# 檢測玩家位置，當玩家到達當前區塊中點，生成下個區塊；當玩家到達下個區塊中點，刪除前一區塊
@export var ground_layer : TileMapLayer
@export var background_layer : TileMapLayer
@export var actor : Character
@export var chunk_size : Vector2i = Vector2i(80, 6)
@export var tile_size : int = 8
var start_pos : Vector2i = Vector2i.ZERO # 生成區塊的起始點
var end_pos : Vector2i = chunk_size # 生成區塊的終點
var generate_next_chunk_pos = 0 # 玩家到達此x座標時生成下一個區塊(當前區塊中點)
var delete_previous_chunk_pos = 0 # 玩家到達此x座標時刪除上個區塊(下個區塊中點)
var chunks : Array = [] # 存放區塊中每個tile的位置
var obstacles : Array = [] # 存放區塊中每個障礙物的位置
var tile_coords : Dictionary = {"grass_land": Vector2i(1, 0), "dirt": Vector2i(1, 1)}
var grass_deco_coords : int = 4: # grass deco tile from (4,2) to (6,2)
	set(value):
		if value <= 6:
			grass_deco_coords = value
		else:
			grass_deco_coords = 4
var dirt_coords : Array = [Vector2i(1, 1), Vector2i(9, 0), Vector2i(8, 1), Vector2i(9, 1)]


func _ready() -> void:
	# 初始化生成下個區塊的檢查位置(當前區塊中點)
	generate_next_chunk_pos = chunk_size.x * 0.5 * tile_size
	# 初始化移除上個區塊的檢查位置(下個區塊中點)
	delete_previous_chunk_pos = chunk_size.x * 1.5 * tile_size
	# 生成初始區塊
	generate_meadow_chunk()

func _physics_process(delta: float) -> void:
	if not actor: return
	# 當玩家位置到達generate_next_chunk_pos時生成下個區塊
	if actor.global_position.x >= generate_next_chunk_pos:
		generate_next_chunk_pos += chunk_size.x * tile_size
		generate_meadow_chunk()
	# 當玩家位置到達delete_previous_chunk_pos時一除上個區塊	
	if actor.global_position.x >= delete_previous_chunk_pos:
		delete_previous_chunk_pos += chunk_size.x * tile_size
		delete_previous_chunk()

# 生成五層地基(泥土、草、石頭)
func generate_meadow_chunk():
	var chunk : Array
	for x in range(start_pos.x, end_pos.x):
		for y in range(start_pos.y, end_pos.y - 1):
			var tile_pos : Vector2i = Vector2i(x, -(y + 1))
			chunk.append(tile_pos)
			# 在底層生成泥土
			if (y + 1 < end_pos.y - 1):
				ground_layer.set_cell(tile_pos, 0, weighted_dirt_picker())
			# 在第二層生成草地同時生成草裝飾或大石、小石(用權重生成)
			elif (y + 1 == end_pos.y -1):
				ground_layer.set_cell(tile_pos, 0, tile_coords["grass_land"])
				ground_layer.set_cell(tile_pos + Vector2i.UP, 0, Vector2i(grass_deco_coords, 2))
				grass_deco_coords += 1
	generate_obstacle()
	chunks.append(chunk)
	start_pos.x += chunk_size.x
	end_pos.x += chunk_size.x

func generate_obstacle():
	var obstacle : Array
	var y = -(chunk_size.y)
	for x in range(start_pos.x, end_pos.x, chunk_size.x / 4):
		var obstacle_pos : Vector2i = Vector2i(x, y)
		%Obstacle.set_cell(obstacle_pos, 0, Vector2i(12, 4))

func weighted_dirt_picker():
	if randi_range(0, 10) < 10:
		return dirt_coords[0]
	else:
		return dirt_coords[randf_range(1, dirt_coords.size() - 1)]

func delete_previous_chunk():
	for tile_pos in chunks[0]:
		ground_layer.set_cell(tile_pos, -1, Vector2i(-1, -1))
	chunks.erase(chunks[0])
