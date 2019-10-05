extends Control


## Godot is not very flexible.... ? ?!!!


var tool = 2
# 0 = eye, whatever, migrate outside of sculpture
# 1 = clean hole, done
# 2 = chisel, PAIN, godot why
# 3 = flood fill remove piece, PAIN

#### Until minimal playable game =)
## Big TODOs:
### adapt chisel to holes:
# check if hole within range, make sure one path goes there, exhaust until random necessary
# display distance of when holes are relevant
### make cracks better
# something funky with angles, adapt rands and distance
### !! removing pieces
# have: lines and border of rectangle (also as lines..)
# make polygon surrounding mouse click, bordered by lines, remember polygon, draw as black
# use polygons for victory algorithm
## how to get polygons? shit. 
#so originally just wanted floodfill. easier to force this into godot?
### victory algorithm
# have goal statue, compare "pixel by pixel", get score


var mousedown = false

var holes = []
var lines = []
var x =0
var mousepos = Vector2(0,0)

var chisel_prog = 0
var chisel_lines = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# CanvasItem.update() 
func _process(delta):
	x = x+ delta*10
	x = wrapf(x,0,100)
	
	if mousedown and tool == 2:
		chisel_prog += delta*19
	print(chisel_prog)
	
	update()
	
	
func _draw():
	draw_rect(Rect2(Vector2(0,0),self.rect_size),Color.navajowhite,true)
	
	#if tool == 0:
	#	var a = mousepos.x
	#	var b = mousepos.y
	#	draw_polyline(PoolVector2Array([Vector2(a,b),Vector2(a,b+50),Vector2(a+50,b)]),Color.black,2)
	
	
	
	draw_line(Vector2(0,0),Vector2(50,50),Color.red,5)
	draw_circle(Vector2(x,20),5,Color.white)
	
	for h in holes:
		draw_circle(h,10,Color.pink)

	if tool == 2:
		# progess, lerp
		# rand_range(
		# deg2rad(
		# indicate if prog is sufficient to add crack -> early abort allowed
		pass
		
	
	for l in lines:
		draw_polyline(l,Color.black,3) #
	
	if mousedown and tool ==2:
		for l in chisel_lines:
			draw_polyline(l,Color.gray,3) # TODO chisel_prog, and lerp last line
			# TODO remove hinter
			for i in range(l.size()):
				var p = l[i]
				if p.distance_to(l[0]) > chisel_prog:
					print("a",p.distance_to(l[0]))
					# TODO lerp last segment
					break
				elif i > 0:
					draw_line(l[i-1],p,Color.black,3)
				
			#draw_polyline(l,Color.black,3) # TODO chisel_prog, and lerp last line

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	pass
   # Mouse in viewport coordinates
#   if event is InputEventMouseButton:
#       print("Mouse Click/Unclick at: ", event.position)
#   elif event is InputEventMouseMotion:
#       print("Mouse Motion at: ", event.position)

   # Print the size of the viewport
#   print("Viewport Resolution is: ", get_viewport_rect().size)

func _on_sculpture_gui_input(event):
	if event is InputEventMouseMotion:
		print(event.position)
		mousepos = event.position
	elif event is InputEventMouseButton:
		print("clicky")
		mousedown = false
		
		#### UNFINISHED < add truncated cracks to total list, see drawing routine
		if chisel_prog > 1:
			print("added lines")
			for l in chisel_lines:
				var tmp_line = [l[0]]
				for i in range(l.size()):
					var p = l[i]
					if p.distance_to(l[0]) > chisel_prog:
						#print("a",p.distance_to(l[0]))
						# TODO lerp last segment
						break
					elif i > 0:
						tmp_line.append(p)
				tmp_line = PoolVector2Array(tmp_line)
				if tmp_line.size() > 1:
					lines.append(tmp_line)
			# TODO
			
		if event.pressed:
			print("pressy")
			mousedown = true
			# Scrool wheel even counts!
			# event.button_index == BUTTON_LEFT
			if tool == 1:
				holes.append(event.position)
			if tool == 2:
				chisel_prog = 0
				chisel_lines = []
				# randomize fracture, ignore holes TODO <- norm of holes to click < range
				for i in range(0,2+(randi()%3)):
					var line = [event.position]
					var angle = deg2rad(rand_range(0,360))
					for i in range(0,2+(randi()%4)):
						var length = rand_range(10,30)
						# TODO something broken here =)
						angle = angle+deg2rad(rand_range(rad2deg(angle)-20,rad2deg(angle)+20)) # TODO, limit this to general angle range of previous angle / 
						# from origin
						var x_tmp = line[-1].x + (length*sin(angle))
						var y_tmp = line[-1].y + (length*cos(angle)) # sin/cos.. correct.
						line.append(Vector2(x_tmp,y_tmp))
					line = PoolVector2Array(line)
					chisel_lines.append(line)
					
						
				# randomize lines
			if tool == 3:
				# no idea, this will hurt
				pass
		
		
		


func _on_holbut_pressed():
	tool = 1
	#pass # Replace with function body.


func _on_chisbut_pressed():
	tool = 2
	#pass # Replace with function body.
