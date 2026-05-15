extends CharacterBody2D

var currentVelocity: Vector2
var mass: float
var isWall: bool

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	update_lable()

func apply_settings(info: Dictionary) -> void:
	isWall = info['isWall']
	position = info['pos']
	currentVelocity = Vector2(info['initvx'], 0)
	mass = info['mass']
	scale = Vector2(1, 1)
	scale *= pow(mass, 1.0/3.0)

func step_emulation(delta: float) -> void:
	if isWall:
		return
	var collision = move_and_collide(currentVelocity * delta * 100)
	if collision:
		var collisionBody = collision.get_collider()
		if collisionBody.isWall:
			currentVelocity = -currentVelocity
		else:
			var massTotal = mass + collisionBody.mass
			var massDiff = mass - collisionBody.mass
			var v1 = (massDiff / massTotal) * currentVelocity + (2 * collisionBody.mass / massTotal) * collisionBody.currentVelocity
			var v2 = (2 * mass / massTotal) * currentVelocity + (-massDiff / massTotal) * collisionBody.currentVelocity
			currentVelocity = v1
			collisionBody.currentVelocity = v2

func update_lable() -> void:
	$Info.visible = !isWall
	$Info/Value/MassLabel.text = "%.2f" % mass
	$Info/Value/VelocityLabel.text = "%.2f" % currentVelocity.x
