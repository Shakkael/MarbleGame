extends Node2D

export var _color := Color(1.2,0.5,0.5)
onready var Marble := preload("res://scenes/Marble.tscn")
export var team := -1

enum {MOVE, DEFEND, ATTACK, SPECIAL}

signal action(teams, act)

var rotata = 0
var action = -1

onready var Icons = [$Circle/Icons/Move,$Circle/Icons/Shield,$Circle/Icons/Sword,$Circle/Icons/Special]

func start():
	$Circle/RFrame.modulate = _color
	$Circle/Circle.modulate = _color
	spawn_marble()

func _physics_process(delta):
	$Circle.rotate(sin(rotata/4)*delta)
	rotata += delta
	if !$Unlock.is_stopped():
		for x in Icons:
			x.value = 100-int(($Unlock.time_left/$Unlock.wait_time)*100)
	

func spawn_marble():
	var ball = Marble.instance()
	ball.position = Vector2.ZERO
	ball.color = _color
	ball.add_to_group("Marble")
	call_deferred("add_child",ball)

func _on_MarbleArea_body_exited(body):
	if(body.is_in_group("Marble")):
		$Circle/CollisionCircle.set_deferred("disabled",false)
		$Unlock.start()
		body.position = Vector2.ZERO
		match action:
			MOVE:
				$IconReact.play("MoveReact")
				emit_signal("action", team, MOVE)
			DEFEND:
				$IconReact.play("ShieldReact")
				emit_signal("action", team, MOVE)
			ATTACK:
				$IconReact.play("SwordReact")
				emit_signal("action", team, MOVE)
			SPECIAL:
				$IconReact.play("SpecialReact")
				emit_signal("action", team, MOVE)
		$RReact.play("Reaction")
		$Unlock.start()


func _on_Move_body_entered(body):
	action = MOVE


func _on_Shield_body_entered(body):
	action = DEFEND


func _on_Attack_body_entered(body):
	action = ATTACK


func _on_Special_body_entered(body):
	action = SPECIAL


func _on_Unlock_timeout():
		$Circle/CollisionCircle.set_deferred("disabled",true)
