extends Node2D

var Piece : = preload("res://Piece/Piece.tscn")
export (int,3,6) var board_size : = 3
export (int) var board_px_size : = 256
var scale_factor : float = 1.0
var ready_match : bool = false
var positions : Array = []
var random : RandomNumberGenerator


func _ready():
	random = RandomNumberGenerator.new()
	random.seed = 12345
	scale_factor = board_px_size / float(board_size)
	$ColorRect.rect_size = Vector2(board_px_size, board_px_size)
	init_board()


func init_board() -> void:
	for r in board_size:
		positions.append([])
		for c in board_size:
			var piece : = Piece.instance()
			piece.scale *= scale_factor / piece.get_size()
			piece.set_board_pos(Vector2(r, c))
			if piece.connect("piece_pressed", self, "_Piece_on_Board_pressed"):
				print_debug("error connetion -> signal: piece_pressed")
			positions[r].append(piece)
			add_child(positions[r][c])
	start_match()


func start_match() -> void:
	ready_match = false
	var iterations = 100 + random.randi() % 100 * pow(board_size,2)
	for i in iterations:
		var random_positon := Vector2(random.randi() % board_size,
				random.randi() % board_size)
		positions[random_positon.x][random_positon.y]._on_Piece_pressed()
	ready_match = true


func switch_neighbors(_piece : Node2D) -> void:
	var neighbor_pos : Vector2 = _piece.get_board_pos() + Vector2.UP
	if is_board_position(neighbor_pos):
		positions[neighbor_pos.x][neighbor_pos.y].switch_LED()
	neighbor_pos = _piece.get_board_pos() + Vector2.DOWN
	if is_board_position(neighbor_pos):
		positions[neighbor_pos.x][neighbor_pos.y].switch_LED()
	neighbor_pos = _piece.get_board_pos() + Vector2.LEFT
	if is_board_position(neighbor_pos):
		positions[neighbor_pos.x][neighbor_pos.y].switch_LED()
	neighbor_pos = _piece.get_board_pos() + Vector2.RIGHT
	if is_board_position(neighbor_pos):
		positions[neighbor_pos.x][neighbor_pos.y].switch_LED()


func is_board_position(_position : Vector2) -> bool:
	return _position.x >= 0 and _position.x < board_size and _position.y >= 0 and _position.y < board_size


func won() -> bool:
	for r in board_size:
		for c in board_size:
			if !positions[r][c].is_on():
				return false
	return true
	


func _Piece_on_Board_pressed(_piece : Node2D) -> void:
	switch_neighbors(_piece)
	if ready_match and won():
		print("Congratulations!!!")
