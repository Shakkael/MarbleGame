extends Node2D

export var length := 150.0
export var size = 20.0
var scaling = size/200
# 150 skala * 15 - size
func _ready():
	$BlockStart.scale = Vector2(scaling, scaling)
	$BlockMid.scale = Vector2(scaling, scaling)
	$BlockEnd.scale = Vector2(scaling, scaling)
	
	if length == size:
		$BlockMid.visible = false
		$BlockEnd.position.x = size/2
	else:
		$BlockMid.visible = true
		$BlockMid.scale.x = length/5
		
		$BlockStart.position.x = -length
		$BlockEnd.position.x = length
		
