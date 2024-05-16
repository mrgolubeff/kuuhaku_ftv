extends Node


@export var syllable_scene: PackedScene
var katakana: Array = Utils1.katakana
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


func _on_a_button_pressed():
	Utils1.start_index = 0
	Utils1.end_index = 4
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_ka_button_pressed():
	Utils1.start_index = 5
	Utils1.end_index = 9
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_sa_button_pressed():
	Utils1.start_index = 10
	Utils1.end_index = 14
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_ta_button_pressed():
	Utils1.start_index = 15
	Utils1.end_index = 19
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_na_button_pressed():
	Utils1.start_index = 20
	Utils1.end_index = 24
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_ha_button_pressed():
	Utils1.start_index = 25
	Utils1.end_index = 29
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_ma_button_pressed():
	Utils1.start_index = 30
	Utils1.end_index = 34
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_ya_button_pressed():
	Utils1.start_index = 35
	Utils1.end_index = 37
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_ra_button_pressed():
	Utils1.start_index = 38
	Utils1.end_index = 42
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_wa_button_pressed():
	Utils1.start_index = 43
	Utils1.end_index = 45
	get_tree().change_scene_to_file("res://scenes/level.tscn")
