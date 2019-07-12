extends TouchScreenButton

signal piece_pressed(this_node)

export (Color) var color_default : = Color.white
export (Color) var color_on : = Color.green
export (Color) var color_off : = Color.red
var on : bool = true
onready var anim_color_time : = $ColorAnim

func _ready():
	modulate = color_default
	random_color_anim(3)


#Switch between on/off
func switch_LED() -> void:
	if on:
		modulate = color_off
		on = false
	else:
		modulate = color_on
		on = true


#Change color piece randomly (not change var on)
#@Param time is animation duration
func random_color_anim(time : float = 5.0) -> void:
	disconnect("pressed", self, "_on_Piece_pressed")
	while time >= 0:
		anim_color_time.start()
		yield(anim_color_time,"timeout")
		time = time - anim_color_time.wait_time
		match randi() % 2:
			0:
				modulate = color_on
			1:
				modulate = color_off
	if connect("pressed", self, "_on_Piece_pressed"):
		print_debug("error connetion -> signal: pressed")


func set_board_pos(board_pos : Vector2) -> void:
	position = board_pos * (normal.get_size() * scale)


func get_board_pos()-> Vector2:
	return position / (normal.get_size() * scale)


func get_size() -> float:
	return normal.get_size().x
	
#Change Piece color when is pressed
func _on_Piece_pressed():
	switch_LED()
	emit_signal("piece_pressed", self)