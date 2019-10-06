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


var viewport = Viewport.new()
var pen = null
var prev_mouse_pos = Vector2(0,0)
var img = null
var img_tmp = ImageTexture.new()

var reset_sculpt = true

var mousedown = false

var max_holes = 8
var holes_left = max_holes
var max_cracks = 32
var cracks_left = max_cracks

var holes = []
var lines = []
var x =0
var mousepos = Vector2(0,0)

var chisel_prog = 0
var chisel_lines = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Replace with function body.
	viewport = Viewport.new()
	viewport.size = self.rect_size
	viewport.usage = Viewport.USAGE_2D
	
	# ?
	viewport.render_target_clear_mode = Viewport.CLEAR_MODE_ONLY_NEXT_FRAME # CLEAR_MODE_NEVER , CLEAR_MODE_ONLY_NEXT_FRAME
	viewport.render_target_v_flip = true
	
	pen = Node2D.new()
	viewport.add_child(pen)
	pen.connect("draw", self, "_on_draw")
	
	add_child(viewport)

	# Use a sprite to display the result texture
	var rt = viewport.get_texture()
	var board = TextureRect.new()
	board.set_texture(rt)
	add_child(board)
	
	updateBut()
	#yield(pen,"draw")
	#


func _on_draw():
	#var D = 4
	#if 3==D:
	#	pass
	if mousedown and tool == 2:
		for l in chisel_lines:
			var true_range = chisel_prog
			if l[0]:
				true_range = true_range*2
			#pen.draw_polyline(l,Color.gray,3) # TODO chisel_prog, and lerp last line
			# TODO remove hinter
			for i in range(1,l.size()):
				var p = l[i]
				if p.distance_to(l[1]) > true_range:
					print("a",p.distance_to(l[1]))
					# TODO lerp last segment
					break
				elif i > 1:
					pen.draw_line(l[i-1],p,Color.black,3)
	###### ?????????????????????????
	#print(reset_sculpt)
	#if reset_sculpt: # and OS.can_draw: #.....
	#	reset_sculpt = false
	#	print(self.rect_size)
	#	pen.draw_rect(Rect2(Vector2(0,0),self.rect_size),Color.navajowhite,true)
	#	pen.draw_line(Vector2(0,0), Vector2(100,50), Color(1, 1, 0))
	#pen.draw_line(Vector2(0,0),Vector2(50,50),Color.red, 5)
	#var mouse_pos = get_local_mouse_position()

	#if Input.is_mouse_button_pressed(BUTTON_LEFT):
	

	#prev_mouse_pos = mouse_pos
	
	#img.set_pixel(5,5,Color.black)
	#print(img.get_pixel(5,5))


# CanvasItem.update() 
func _process(delta):
	x = x+ delta*10
	x = wrapf(x,0,100)
	
	if mousedown and tool == 2:
		chisel_prog += delta*20
	#print(chisel_prog)
	

	
	
	#pen.draw_line(Vector2(0,0),Vector2(50,50),Color.red, 5)
	pen.update() ###
	
	update()
	
	
func _draw():
	pass
	#draw_rect(Rect2(Vector2(0,0),self.rect_size),Color.navajowhite,true)
	
	#if tool == 0:
	#	var a = mousepos.x
	#	var b = mousepos.y
	#	draw_polyline(PoolVector2Array([Vector2(a,b),Vector2(a,b+50),Vector2(a+50,b)]),Color.black,2)
	
	
	
	#draw_line(Vector2(0,0),Vector2(50,50),Color.red,5)
	#draw_circle(Vector2(x,20),5,Color.white)
	
	#for h in holes:
	#	draw_circle(h,10,Color.pink)

	#if tool == 2:
		# progess, lerp
		# rand_range(
		# deg2rad(
		# indicate if prog is sufficient to add crack -> early abort allowed
	#	pass
		
	
	#for l in lines:
	#	draw_polyline(l,Color.black,3) #
	
	#if mousedown and tool ==2:
	#	for l in chisel_lines:
	#		draw_polyline(l,Color.gray,3) # TODO chisel_prog, and lerp last line
			# TODO remove hinter
	#		for i in range(1,l.size()):
	#			var p = l[i]
	#			if p.distance_to(l[1]) > chisel_prog:
					#print("a",p.distance_to(l[0]))
					# TODO lerp last segment
	#				break
	#			elif i > 1:
	#				draw_line(l[i-1],p,Color.black,3)
				
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
	#print(event)
	
	if event is InputEventMouseMotion:
		#print(event.position)
		mousepos = event.position
	elif event is InputEventMouseButton:
		
		#pen.update()
		#yield(pen,"draw") #WOW.
		#pen.draw_line(Vector2(0,0),Vector2(50,50),Color.red, 5)
		
		
		print("clicky")
		mousedown = false
		
		#### UNFINISHED < add truncated cracks to total list, see drawing routine
		#if chisel_prog > 1:
		#	print("added lines")
		#	for l in chisel_lines:
		#		var tmp_line = [l[0]]
		#		for i in range(1,l.size()):
		#			var p = l[i]
		#			if p.distance_to(l[1]) > chisel_prog:
						#print("a",p.distance_to(l[0]))
						# TODO lerp last segment
		#				break
		#			elif i > 0:
		#				tmp_line.append(p)
		#		tmp_line = PoolVector2Array(tmp_line)
		#		if tmp_line.size() > 1:
		#			lines.append(tmp_line)
			# TODO
			
		if event.pressed:
			print("pressy")
			mousedown = true
			# Scrool wheel even counts!
			# event.button_index == BUTTON_LEFT
			
			if tool == 3:
				var xy = event.position
				floodfill(xy.x,xy.y)
			if tool == 1 and holes_left > 0:
				holes_left -= 1
				updateBut()
				holes.append(event.position)
				yield(pen,"draw")
				pen.draw_circle(event.position,5,Color.black) # TODO good?
			if tool == 2 and cracks_left >0:
				cracks_left -= 1
				updateBut()
				###########################################################
				###########################################################
				chisel_prog = 0
				chisel_lines = []
				# randomize fracture, ignore holes TODO <- norm of holes to click < range
				var hole_range = 50
				var holes_in_range = []
				
				for h in holes:
					if h.distance_to(event.position) < hole_range:
						holes_in_range.append(h)
				
				var lines_num = 3+(randi()%3)
				
				for i in range(0,len(holes_in_range)):
					var line = [true,event.position]
					var segments = 4+(randi()%4)
					for j in range(0,segments):
						line.append(lerp(event.position,holes_in_range[i],float(1+j)/segments))
					for j in range(2,len(line)-1): # dont move last one?
						line[j].x = line[j].x+rand_range(-5,5)
						line[j].y = line[j].y+rand_range(-5,5)
					#line = PoolVector2Array(line)
					chisel_lines.append(line)
				
				lines_num -= len(holes_in_range)
				
				if lines_num > 0:
					for i in range(0,lines_num):
						var line = [false,event.position]
						var segments = 4+(randi()%4)
						var sim_hole = Vector2(event.position.x+rand_range(-50,50),event.position.y+rand_range(-50,50))
					#var angle = deg2rad(rand_range(0,360))
						for j in range(0,segments):
							line.append(lerp(event.position,sim_hole,float(1+j)/segments))
						for j in range(2,len(line)-1): # dont move last one?
							line[j].x = line[j].x+rand_range(-5,5)
							line[j].y = line[j].y+rand_range(-5,5)
						# TODO something broken here =)
						#angle = angle+deg2rad(rand_range(rad2deg(angle)-20,rad2deg(angle)+20)) # TODO, limit this to general angle range of previous angle / 
						# from origin
						#var x_tmp = line[-1].x + (length*sin(angle))
						#var y_tmp = line[-1].y + (length*cos(angle)) # sin/cos.. correct.
						#line.append(Vector2(x_tmp,y_tmp))
						chisel_lines.append(line)
					
						
				# randomize lines
			if tool == 3:
				# no idea, this will hurt
				pass
		
		
func getScore():
	var score = 0.0
	
	var correctpixels = 0
	var totalpixels = 250*400
	
	var existing_total = 0
	
	var existing_correct = 0
	var existing_wrong = 0
	
	img = viewport.get_texture().get_data()
	img.lock()
	
	var goal_img = get_node("../TextureRect").texture.get_data()
	#get_node("../TextureRect").get_viewport().get_texture().get_data()
	goal_img.lock()
	
	for x in range(250):
		for y in range(400):
			#var px1 = img.get_pixel(x,y)
			var px1 = Color.navajowhite
			var px2 = goal_img.get_pixel(x,y)
			var r_diff = abs(px1.r-px2.r)
			var g_diff = abs(px1.g-px2.g)
			var b_diff = abs(px1.b-px2.b)
			#print(px1,"AAA",px2)
			if r_diff+g_diff+b_diff < 0.3:
				existing_total += 1
	
	for x in range(250):
		for y in range(400):
			var existing = false
			var px1 = img.get_pixel(x,y)
			var px2 = Color.navajowhite
			#var px2 = goal_img.get_pixel(x,y)
			var r_diff = abs(px1.r-px2.r)
			var g_diff = abs(px1.g-px2.g)
			var b_diff = abs(px1.b-px2.b)
			#print(px1,"AAA",px2)
			if r_diff+g_diff+b_diff < 0.3:
				existing = true
				if existing:
					px1 = img.get_pixel(x,y)
					px2 = goal_img.get_pixel(x,y)
					r_diff = abs(px1.r-px2.r)
					g_diff = abs(px1.g-px2.g)
					b_diff = abs(px1.b-px2.b)
					if r_diff+g_diff+b_diff < 0.3:
						existing_correct += 1
					else:
						existing_wrong += 1
	
	img.unlock()
	goal_img.unlock()
	
	print(existing_correct,":",existing_wrong,":",existing_total)
	
	score = float(existing_correct-existing_wrong)/existing_total
	score = score * 1000
	score = round(score)
	# max is 1000, min is 0; 200 is totally acceptable?
	
	if score < 0:
		score = 0
	
	print("score",score)
	return score
		
func floodfill(x,y):
	var pixels = [Vector2(x,y)]
	
	img = viewport.get_texture().get_data()
	img.lock()
	
	while !pixels.empty():
		var px = pixels.pop_back()
		x = px.x
		y = px.y
		var clr = img.get_pixel(x,y)
		var r_diff = abs(clr.r-Color.navajowhite.r)
		var g_diff = abs(clr.g-Color.navajowhite.g)
		var b_diff = abs(clr.b-Color.navajowhite.b)
		if r_diff+g_diff+b_diff < 0.2:
			print("nice")
			img.set_pixel(x,y,Color.black)
			if x+1 <= self.rect_size.x:
				pixels.append(Vector2(x+1,y))
			if x-1 >= 0:
				pixels.append(Vector2(x-1,y))
			if y-1 >= 0:
				pixels.append(Vector2(x,y-1))
			if y+1 <= self.rect_size.y:
				pixels.append(Vector2(x,y+1))
			# floodfill neighbours, respect borders

	img.unlock()
	img_tmp = ImageTexture.new()
	img_tmp.create_from_image(img)
	yield(pen,"draw") #WOW.
	pen.draw_texture(img_tmp,Vector2(0,0))

func _on_holbut_pressed():
	tool = 1
	#pass # Replace with function body.


func _on_chisbut_pressed():
	tool = 2
	#pass # Replace with function body.

#func getPixel(x,y):
#	img = viewport.get_texture().get_data()
#	img.lock()
#	return img.get_pixel(x,y)

func _on_Button_pressed():
	#pen.draw_line(Vector2(0,0),Vector2(50,50),Color.red, 5)
	img = viewport.get_texture().get_data()
	img.lock()
	print("aaa",img.get_pixel(10,5))
	
	img.set_pixel(10,5,Color.red)
	#img.unlock()
	print("aaa",img.get_pixel(10,5))
	img.unlock()
	img_tmp = ImageTexture.new()
	img_tmp.create_from_image(img)
	
	yield(pen,"draw") #WOW.
	pen.draw_texture(img_tmp,Vector2(0,0))
	pen.draw_circle(Vector2(50,50),5,Color.blue)



func _on_startbut_pressed():
	yield(pen,"draw") #WOW.
	pen.draw_rect(Rect2(Vector2(0,0),self.rect_size),Color.navajowhite,true)
	get_node("../startbut").visible = false


func _on_fldbut_pressed():
	tool = 3
	

func _on_scorebut_pressed():
	var score = getScore()
	get_node("../scorebut").text = str(score)

func updateBut():
	get_node("../chisbut").text = "Chisel "+str(cracks_left)
	get_node("../holbut").text = "Holes  "+str(holes_left)

func _on_restartbut_pressed():
	yield(pen,"draw") #WOW.
	pen.draw_rect(Rect2(Vector2(0,0),self.rect_size),Color.navajowhite,true)
	holes = []
	holes_left = max_holes
	cracks_left = max_cracks
	updateBut()
	
