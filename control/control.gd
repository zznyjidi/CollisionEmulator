extends Window

var block_input_scene = preload("res://control/BlockInput.tscn")

signal emulation_start
signal emulation_stop
signal emulation_reset(blocks: Array)

var block_inputs = []

func add_input_block(index: int) -> void:
	var block_input_obj = block_input_scene.instantiate()
	block_input_obj.set_block_number(index)
	$Margin/BlockInputs.add_child(block_input_obj)
	block_inputs.append(block_input_obj)

func _ready() -> void:
	for i in range(3):
		add_input_block(i)

func _process(_delta: float) -> void:
	pass

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_run_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		emulation_start.emit()
	else:
		emulation_stop.emit()

func _on_reset_button_pressed() -> void:
	var blocks_info = []
	for input in block_inputs:
		blocks_info.append(input.get_value())
	emulation_reset.emit(blocks_info)
