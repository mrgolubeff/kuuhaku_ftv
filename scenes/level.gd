extends Node


@export var syllable_scene: PackedScene
var upper_syllables: Array = []


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
	syllable.pressed.connect(_on_syllable_pressed.bind(syllable))
	add_child(syllable)
	upper_syllables.append(syllable)


func _on_syllable_pressed(button: Button):
	print("Syllable pressed.")
	print(button.position.x)
	button.position.y += 300
	button.disabled = true
	var button_index = upper_syllables.find(button)
	var roll = randf()
	if roll >= 0.6:
		upper_syllables.remove_at(button_index)
		button.delete()
