extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var mapWidth = 24
export var mapHeight = 24
export var percentWalls = 45

var simpleMatrix = []

func _prettyPrint():
	for x in range(mapWidth):
		var prettymap = ""
		for y in range(mapHeight):
			prettymap += " " + simpleMatrix[x][y]
		print(prettymap)
			
	pass

func _isOutOfBoundary(var x, var y):
	if (x < 0 || y < 0):
		return true
	if (x > mapWidth -1 || y > mapWidth -1):
		return true
	pass

func _isWall(var x, var y):
	if (_isOutOfBoundary(x, y)):
		return true
	if (simpleMatrix[x][y] == '#'):
		return true
	else:
		return false
	pass

func _checkAdjacency(var x, var y):
	var backX = x - 1
	var upY = y - 1
	var foreX = x + 1
	var downY = y + 1
	
	var numSurround = 0
	
	# CII
	# IXI
	# III
	if (_isWall(backX,upY)):
		numSurround += 1
	
	# III
	# CXI
	# III
	if (_isWall(backX,y)):
		numSurround += 1
	
	# III
	# IXI
	# CII
	if (_isWall(backX,downY)):
		numSurround += 1
	
	# ICI
	# IXI
	# III
	if (_isWall(x, upY)):
		numSurround += 1
		
	# III
	# IXI
	# ICI
	if (_isWall(x, downY)):
		numSurround += 1

	# IIC
	# IXI
	# III
	if (_isWall(foreX,upY)):
		numSurround += 1
	# III
	# IXC
	# III
	if(_isWall(foreX, y)):
		numSurround += 1

	# III
	# IXI
	# IIC
	if (_isWall(foreX,downY)):
		numSurround += 1
					
	#print("Total found: " + String(numSurround))
	return numSurround
	pass

func _permutate():
	for x in range(mapWidth -1 ):
		for y in range(mapWidth -1 ):
			if ( simpleMatrix[x][y] == '#' ):
				if ( _checkAdjacency(x, y) >= 5 ): #Seems to be the ideal bounds after some testing
					simpleMatrix[x][y] = '#'
				elif ( _checkAdjacency(x, y) < 3 ):
					simpleMatrix[x][y] = '.'
			else:
				if ( _checkAdjacency(x, y) >= 6 ):
					simpleMatrix[x][y] = '#'
	print("Permutation complete")
	pass

func _populateMatrix():
	var center = [floor(mapWidth/2) -1 , floor(mapWidth/2) -1]
	
	for x in range(mapWidth):
		for y in range(mapHeight):
			if (x == 0 ):
				simpleMatrix[x][y] = '#';
			elif (y == 0):
				simpleMatrix[x][y] = '#';
			elif (x == mapWidth - 1):
				simpleMatrix[x][y] = '#';
			elif (y == mapHeight - 1):
				simpleMatrix[x][y] = '#';
			else:
				if(x == center[0] && y == center[1]):
					simpleMatrix[x][y] = '.'
				else:
					simpleMatrix[x][y] = '#' if percentWalls >=randi()%101 else '.'
	pass

func _ready():
	for x in range(mapWidth):
		simpleMatrix.append([])
		simpleMatrix[x].resize(mapHeight)
		
		for y in range(mapHeight):
			simpleMatrix[x][y] = 0
	
	print("Simple terrain matrix was initialized")

	# Called when the node is added to the scene for the first time.
	# Initialization here
	_populateMatrix()
	_permutate()
	#_prettyPrint()
	_permutate()
	#_prettyPrint()
	_permutate()
	_permutate()
	_prettyPrint()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
