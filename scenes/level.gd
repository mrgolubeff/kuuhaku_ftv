extends Node


@export var syllable_scene: PackedScene
var upper_syllables: Array = []
var lower_syllables: Array = []
const UPPER_SPEED: int = 25
const LOWER_SPEED: int = 75

var katakana = [
	["ア", "a"], # 0
	["イ", "i"],
	["ウ", "u"],
	["エ", "e"],
	["オ", "o"],
	["カ", "ka"], # 5
	["キ", "ki"],
	["ク", "ku"],
	["ケ", "ke"],
	["コ", "ko"],
	["サ", "sa"], # 10
	["シ", "shi"],
	["ス", "su"],
	["セ", "se"],
	["ソ", "so"],
	["タ", "ta"], # 15
	["チ", "chi"],
	["ツ", "tsu"],
	["テ", "te"],
	["ト", "to"],
	["ナ", "na"], # 20
	["ニ", "ni"],
	["ヌ", "nu"],
	["ネ", "ne"],
	["ノ", "no"],
	["ハ", "ha"], # 25
	["ヒ", "hi"],
	["フ", "fu"],
	["ヘ", "he"],
	["ホ", "ho"],
	["マ", "ma"], # 30
	["ミ", "mi"],
	["ム", "mu"],
	["メ", "me"],
	["モ", "mo"],
	["ヤ", "ya"], # 35
	["ユ", "yu"],
	["ヨ", "yo"],
	["ラ", "ra"], # 38
	["リ", "ri"],
	["ル", "ru"],
	["レ", "re"],
	["ロ", "ro"],
	["ワ", "wa"], # 43
	["ヲ", "wo"], # 44
	["ン", "n"] # 45
]


func _ready():
	create_syllable()
	$Timer.start()


func _process(delta):
	for syllable in upper_syllables:
		syllable.position.x += UPPER_SPEED * delta
	for syllable in lower_syllables:
		syllable.position.x += LOWER_SPEED * delta


func _on_timer_timeout():
	create_syllable()


func create_syllable():
	var syllable = syllable_scene.instantiate()
	var rand_index = randi_range(0, katakana.size() - 1)
	syllable.syllable = katakana[rand_index][0]
	syllable.en_syllable = katakana[rand_index][1]
	syllable.position.x = -100
	syllable.position.y = 50
	syllable.get_node("Button").pressed.connect(_on_syllable_pressed.bind(syllable))
	add_child(syllable)
	upper_syllables.append(syllable)


func _on_syllable_pressed(syllable: Area2D):
	print("Syllable pressed.")
	print(syllable.position.x)
	syllable.position.y += 300
	syllable.get_node("Button").disabled = true
	var syllable_index = upper_syllables.find(syllable)
	upper_syllables.remove_at(syllable_index)
	lower_syllables.append(syllable)


func _on_upper_end_area_entered(area):
	print("Syllable area entered.")


func _on_lower_end_area_entered(area):
	print("Lower syllable area entered.")
