extends Control

var board : Control
onready var game_container = $VBoxC/GameContainer/CenterC
onready var level : = $VBoxC/InfoContainer/CenterC/HBoxC2/Level
onready var moves : = $VBoxC/InfoContainer/CenterC/HBoxC/Moves
onready var button_reset : = $VBoxC/ButtonsContainer/HBoxC/Reset
onready var win_message : = $Win


func add_board(_board : Control) -> void:
	board = _board
	game_container.add_child(board)
	if board.connect("level_completed", self, "update_tag_level"):
		print_debug("error connetion -> signal: level_completed")
	if board.connect("piece_touched", self, "update_tag_moves"):
		print_debug("error connetion -> signal: piece_touched")
	if board.connect("all_completed", self, "show_win_message"):
		print_debug("error connetion -> signal: all_completed")


func update_tag_level(_level : int) -> void:
	level.text = str(_level) + " - " + str(board.MAX_BOARD_SIZE)


func update_tag_moves(_moves : int) -> void:
	moves.text = str(_moves)

func _on_Reset_pressed():
	board.board_size = 1
	board.moves = 0
	update_tag_level(0)

func show_win_message() -> void:
	win_message.show_win(moves.text)