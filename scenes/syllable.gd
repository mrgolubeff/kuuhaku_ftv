extends Node


var syllable: String
var en_syllable: String
var grabable: bool


func _init(symbol: String = "ア", en_symbol: String = ""):
	syllable = symbol
	en_syllable = en_symbol


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.text = syllable


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func delete():
	queue_free()
