extends KinematicBody2D

var GRAVITY := Vector2(0,-1)
var SPEED := 300
var direction := Vector2(0,-1)

func _physics_process(delta):
	var collision = move_and_collide(direction*SPEED*delta)
	if collision:
		direction = direction.bounce(collision.normal.rotated(deg2rad(rand_range(-10,10))))

func crown():
	$Peg.visible = true
	$Crown.visible = true
	$CollisionShape2D.disabled = false
	SPEED = 300
	
func decrown():
	$Peg.visible = false
	$Crown.visible = false
	$CollisionShape2D.disabled = true
	SPEED = 0
	position = Vector2(450, 700)
