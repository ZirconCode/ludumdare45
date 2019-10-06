extends AudioStreamPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var start = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	play(start)
	yield(get_tree().create_timer(stream.get_length()-start),"timeout")
	stop()
	get_children()[0].play()	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
