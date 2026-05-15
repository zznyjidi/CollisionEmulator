extends Node2D

var BlockObj = preload("res://block/Block.tscn")

var blocks_obj: Array = []
var emulation_running = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if emulation_running:
		for block in blocks_obj:
			block.step_emulation(delta)

func _on_control_window_emulation_start() -> void:
	emulation_running = true

func _on_control_window_emulation_stop() -> void:
	emulation_running = false

func _on_control_window_emulation_reset(blocks: Array) -> void:
	for block in blocks_obj:
		remove_child(block)
	blocks_obj.clear()
	for block_info in blocks:
		var block = BlockObj.instantiate()
		block.apply_settings(block_info)
		blocks_obj.append(block)
		add_child(block)
