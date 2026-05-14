extends VBoxContainer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func set_block_number(index: int) -> void:
	$BlockLabel.text = "Block %d" % index

func get_value() -> Dictionary:
	return {
		"initvx": float($InputVx.text),
		"pos": Vector2(
			float($InputX.text),
			float($InputY.text)
		),
		"mass": float($InputMass.text)
	}
