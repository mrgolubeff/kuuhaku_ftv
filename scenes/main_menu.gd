extends Node


@export var syllable_scene: PackedScene
var katakana: Array = Utils.new().katakana
const VER_OFFSET: int = 135
const HOR_OFFSET: int = 85
const FRAME_SIZE: int = 94
const DISTANCE: int = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	create_table()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func create_table():
	var i = 0
	var y = 0
	for syllable_pair in katakana:
		var syllable = syllable_scene.instantiate()
		syllable.syllable = syllable_pair[0]
		syllable.en_syllable = syllable_pair[1]
		syllable.get_node("Button").disabled = true
		syllable.get_node("En").visible = true
		syllable.position.x = HOR_OFFSET + (y * (FRAME_SIZE + DISTANCE))
		syllable.position.y = VER_OFFSET + (i * (FRAME_SIZE + DISTANCE))
		add_child(syllable)
		#i += 1
		if y == 7:
			i += 2
			if i == 6:
				y += 1
				i = 0
		else:
			i += 1
			if i == 5:
				y += 1
				i = 0
