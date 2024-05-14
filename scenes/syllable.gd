extends Node


var syllable: String
var en_syllable: String
var grabable: bool


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func delete():
	queue_free()
