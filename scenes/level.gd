extends Node


@export var syllable_scene: PackedScene
var upper_syllables: Array = []
var lower_syllables: Array = []
const UPPER_SPEED: int = 55
const UPPER_HIGH_SPEED: int = 500
const LOWER_SPEED: int = -125
const OFFSET: int = 430
const FRAME_SIZE: int = 94
const DISTANCE: int = 5
const MIDPOINT: int = 500
const CHANCE: float = 0.6
var score: int = 0
const WIN_SCORE: int = 21
var game_running: bool = false

var katakana: Array = Utils1.katakana
var scoring: Array = []

signal finish


func _ready():
	scoring = []
	for syllable_pair in katakana.slice(Utils1.start_index, Utils1.end_index+1):
		scoring.append(syllable_pair[1])
	create_memo()
	create_memo2()
	
	game_running = true
	create_syllable()


func _process(delta):
	if game_running:
		for syllable in upper_syllables:
			var syllable_index = upper_syllables.find(syllable)
			if (syllable_index != 0) and (syllable.position.x + FRAME_SIZE + DISTANCE <
					upper_syllables[syllable_index-1].position.x):
				syllable.position.x += UPPER_HIGH_SPEED * delta
				if (syllable_index != 0) and (syllable.position.x + FRAME_SIZE + DISTANCE >
						upper_syllables[syllable_index-1].position.x):
					syllable.position.x = (upper_syllables[syllable_index-1].position.x -
							DISTANCE - FRAME_SIZE)
			elif (syllable_index == 0) and (syllable.position.x < MIDPOINT):
				syllable.position.x += UPPER_HIGH_SPEED * delta
			else:
				syllable.position.x += UPPER_SPEED * delta
		for syllable in lower_syllables:
			syllable.position.x += LOWER_SPEED * delta


func create_syllable():
	var syllable = syllable_scene.instantiate()
	var rand_index: int
	if randf() > CHANCE:
		rand_index = randi_range(Utils1.start_index, Utils1.end_index)
	else:
		rand_index = randi_range(0, katakana.size()-1)
	syllable.syllable = katakana[rand_index][0]
	syllable.en_syllable = katakana[rand_index][1]
	syllable.position.x = -(FRAME_SIZE + DISTANCE)
	syllable.position.y = 50
	syllable.get_node("Button").pressed.connect(_on_syllable_pressed.bind(syllable))
	call_deferred("add_child", syllable)
	upper_syllables.append(syllable)


func create_memo():
	var text = ""
	for syllable in scoring:
		text += syllable.to_upper() + " "
	$Memo.text = text


func create_memo2():
	var text = "Reach " + str(WIN_SCORE) + " points"
	$Memo2.text = text


func _on_syllable_pressed(syllable: Area2D):
	syllable.position.y += OFFSET
	syllable.get_node("Button").disabled = true
	syllable.get_node("En").visible = true
	if syllable.en_syllable in scoring:
		syllable.get_node("FrameGreen").visible = true
	var syllable_index = upper_syllables.find(syllable)
	upper_syllables.remove_at(syllable_index)
	lower_syllables.append(syllable)


func _on_upper_end_area_entered(area):
	var syllable_index = upper_syllables.find(area)
	upper_syllables.remove_at(syllable_index)
	area.delete()


func _on_lower_end_area_entered(area):
	if area.en_syllable in scoring:
		increase_score()
	else:
		decrease_score()
	var syllable_index = lower_syllables.find(area)
	lower_syllables.remove_at(syllable_index)
	area.delete()


func increase_score():
	score += 1
	$Score.text = str(score)
	if score == WIN_SCORE:
		call_deferred("finish_game")


func decrease_score():
	score -= 1
	if score < 0:
		score = 0
	$Score.text = str(score)


func finish_game():
	finish.emit()


func _on_spawning_area_area_exited(_area):
	create_syllable()


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_finish():
	get_tree().change_scene_to_file("res://scenes/success.tscn")
