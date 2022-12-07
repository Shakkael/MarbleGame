extends Control

enum TEAM {TEAM1, TEAM2, TEAM3, TEAM4}
#enum OBJECT {BG,VP}

export var team1Color := Color(1.2,0.6,0.6)
export var team2Color := Color(0.6,1.2,0.6)
export var team3Color := Color(0.6,0.6,1.2)
export var team4Color := Color(1.2,1.2,0.6)

var TEAMS = [team1Color, team2Color, team3Color, team4Color]

onready var TeamObjects = \
[[$Viewports/VpTeam1/Viewport/Roulette,$BG/BgTeam1,$Points/Team1],
[$Viewports/VpTeam2/Viewport/Roulette,$BG/BgTeam2,$Points/Team2],
[$Viewports/VpTeam3/Viewport/Roulette,$BG/BgTeam3,$Points/Team3],
[$Viewports/VpTeam4/Viewport/Roulette,$BG/BgTeam4,$Points/Team4]]

func _ready():
	$Popup.show()
	get_tree().paused = true
	for x in range(len(TeamObjects)):
		TeamObjects[x][0]._color = TEAMS[x]
		TeamObjects[x][0].start()
		TeamObjects[x][1].modulate = Color(TEAMS[x].r+0.5,TEAMS[x].g+0.5,TEAMS[x].b+0.5)
		TeamObjects[x][2].modulate = TEAMS[x]

func _unhandled_key_input(_event):
	if Input.is_key_pressed(KEY_P):
		$Popup.show()
		get_tree().paused = true
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit(0)


func _on_Button_pressed():
	$Popup.hide()
	$Popup/Timer.start()


func _on_Timer_timeout():
	get_tree().paused = false


func _on_Button2_pressed():
	$Popup.hide()
	get_tree().paused = false


func _on_Point_timeout():
	var board = $Viewports/Board/Viewport/Board.crowned
	if board > -1:
		var label = TeamObjects[board][2]
		label.text = str(int(label.text)+1)
