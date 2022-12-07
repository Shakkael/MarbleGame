extends Node2D

onready var Marble := preload("res://scenes/Marble.tscn")

enum TEAM {TEAM1, TEAM2, TEAM3, TEAM4}

export var team1Color := Color(1.2,0.6,0.6)
export var team2Color := Color(0.6,1.2,0.6)
export var team3Color := Color(0.6,0.6,1.2)
export var team4Color := Color(1.2,1.2,0.6)

var TEAMS = [team1Color, team2Color, team3Color, team4Color]
enum {MOVE, DEFEND, ATTACK, SPECIAL}

var crowned = -1

var rotata = 0
var marbles = []

func _ready():
	for team in range(len(TEAM)):
		spawn_marble(team)

func _physics_process(delta):
	$ObstaclesRotates.rotate(1.0*delta)
	$ObstaclesBlocks.rotate(sin(rotata*3)/6*delta)
	$ObstaclesCircles.rotate(-sin(rotata*3)/6*delta)
	rotata += delta

func spawn_marble(team : int):
	var ball = Marble.instance()
	marbles.append(ball)
	ball.position = Vector2(450,150)
	ball.color = TEAMS[team]
	ball.team = team
	ball.connect("crowning",self,"leader")
	ball.add_to_group("Marble")
	call_deferred("add_child",ball)

func leader(teamed):
	crowned = teamed;

func _on_Roulette_action(team, act):
	var marble = marbles[team]
	if act == MOVE:
		if marble.SPEED <= 450:
			#print(marbles[crowned].get_transform())
			marble.SPEED += 10
	elif act == SPECIAL:
		pass
	elif act == ATTACK:
		pass
	elif act == DEFEND:
		pass
