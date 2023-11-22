extends Node

@export var mob_scene: PackedScene
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	pass # Replace with function body.


func new_game():
	score = 0
	$Player.start($StartPosition.position)