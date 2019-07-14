extends Node

const Board : PackedScene = preload("res://Board/Board.tscn")
onready var UI : = $GameHUD


func _ready():
	var board = Board.instance()
	board.board_size = 1
	UI.add_board(board)


