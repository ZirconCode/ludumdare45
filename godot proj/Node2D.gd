extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	if get_node("../sculpture").tool == 2:
		var x = get_local_mouse_position().x
		var y = get_local_mouse_position().y
		draw_circle(Vector2(x,y),50,Color(0,0,0,0.2))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
    update()
