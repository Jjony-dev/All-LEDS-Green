extends PanelContainer

onready var total_moves : = $MarginContainer/VBoxContainer/TotalMoves

func show_win(_moves: String) -> void:
	total_moves.text += _moves
	show() 