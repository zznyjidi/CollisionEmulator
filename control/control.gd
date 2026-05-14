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
	for i in range(2):
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

func _on_add_button_pressed() -> void:
	add_input_block(len(block_inputs))

func _on_remove_button_pressed() -> void:
	var input_obj = block_inputs.pop_back()
	$Margin/BlockInputs.remove_child(input_obj)

func _on_align_button_pressed() -> void:
	var Y = $Buttons/AlignButtons/InputBlockY.text
	var X = float($Buttons/AlignButtons/InputBlockStart.text)
	var XSpace = float($Buttons/AlignButtons/InputBlockSpace.text)
	for input in block_inputs:
		input.get_node("InputY").text = Y
		input.get_node("InputX").text = str(X)
		X += XSpace
