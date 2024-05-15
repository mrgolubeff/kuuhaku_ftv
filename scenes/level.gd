extends Node


@export var syllable_scene: PackedScene
var upper_syllables: Array = []

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
		syllable.position.x += 25 * delta


func _on_timer_timeout():
	create_syllable()


func create_syllable():
	var syllable = syllable_scene.instantiate()
	syllable.position.x = -100
	syllable.position.y = 50
	syllable.get_node("Button").pressed.connect(_on_syllable_pressed.bind(syllable))
	add_child(syllable)
	upper_syllables.append(syllable)


func _on_syllable_pressed(button: Area2D):
	print("Syllable pressed.")
	print(button.position.x)
	button.position.y += 300
	button.get_node("Button").disabled = true
	var button_index = upper_syllables.find(button)
	var roll = randf()
	if roll >= 0.6:
		upper_syllables.remove_at(button_index)
		button.delete()
