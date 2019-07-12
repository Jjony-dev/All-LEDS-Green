extends Node2D

var Piece : = preload("res://Piece/Piece.tscn")
export (int,3,6) var board_size : = 3
export (int) var board_px_size : = 256
var scale_factor : float = 1.0
var positions : Array = []


func _ready():
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
				print_debug("error connetion -> signal: pressed")
			positions[r].append(piece)
			add_child(positions[r][c])


func _Piece_on_Board_pressed(_piece : Node2D) -> void:
	print(_piece.get_board_pos())
