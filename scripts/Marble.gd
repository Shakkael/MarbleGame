extends KinematicBody2D

export var color := Color(1.2,0.6,0.6)
signal crowning(team)

export var length := 50
var point = Vector2.ZERO
var team = -1

var GRAVITY := Vector2(0,-1)
var SPEED := 300
var direction := Vector2(1,0)

func _ready():
	restart()

func restart():
	randomize()
	$Sprite.modulate = color;
	$Crown.modulate = color;
	$Line2D.default_color = color
	direction = direction.rotated(deg2rad(rand_range(0,360)))

func _physics_process(delta):
	var collision = move_and_collide(direction*SPEED*delta)
	if collision:
		direction = direction.bounce(collision.normal.rotated(deg2rad(rand_range(-10,10))))
		if is_in_group("crowned"):
			$CrownCooldown.start()
		else:
			if collision.collider.is_in_group("crowned"):
				if $CrownCooldown.is_stopped():
					collision.collider.decrown()
					crown()
	
	$Line2D.global_rotation = 0
	$Line2D2.global_rotation = 0
	$Line2D.global_position = Vector2.ZERO
	$Line2D2.global_position = Vector2.ZERO
	
	point = global_position
	
	$Line2D.add_point(point)
	$Line2D2.add_point(point)
	while $Line2D.get_point_count()>length:
		$Line2D.remove_point(0)
		$Line2D2.remove_point(0)

func crown():
	$Line2D2.visible = true
	$Crown.visible = true
	SPEED = 300
	add_to_group("crowned")
	emit_signal("crowning",team)
	
func decrown():
	$Line2D2.visible = false
	$Crown.visible = false
	SPEED = 300
	remove_from_group("crowned")
