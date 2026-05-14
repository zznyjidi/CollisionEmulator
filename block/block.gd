extends CharacterBody2D

var currentVelocity: Vector2
var mass: float

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	update_lable()

func step_emulation(delta: float) -> void:
	var collision = move_and_collide(currentVelocity * delta * 100)
	if collision:
		var collisionBody = collision.get_collider()
		if collisionBody.currentVelocity == Vector2(0,0):
			var massRatio = collisionBody.mass / mass
			var v2 = (2 * currentVelocity) / (massRatio + 1)
			var v1 = currentVelocity - (massRatio * v2)
			currentVelocity = v1
			collisionBody.currentVelocity = v2

func update_lable() -> void:
	$Info/Value/MassLabel.text = "%.2f" % mass
	$Info/Value/VelocityLabel.text = "%.2f" % currentVelocity.x
