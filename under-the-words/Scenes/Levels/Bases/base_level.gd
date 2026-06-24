extends Node2D

@export var lvl_text : Array[String]

@onready var c_width = GlobalVariables.character_width
@onready var c_height = GlobalVariables.character_height

@onready var base_character = preload("res://Scenes/Levels/Bases/base_character.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_level(lvl_text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Creates level from array of strings
func make_level(strings):
	var y = 0
	# For each string in the array
	for string in strings:
		var x = 0
		# For each character in the string
		for character in string.split():
			var lvl_character = base_character.instantiate()
			var label = lvl_character.get_child(0).get_child(0)
			# Setting the text of label of the scene
			# Checking if the character is one of the special characters
			match character:
				'_':
					label.text = ' '
					lvl_character.hidden_character = character
				# If not we just use the character as is
				_:
					label.text = character
					lvl_character.hidden_character = character
			lvl_character.position.x = x
			lvl_character.position.y = y
			add_child(lvl_character)
			# Updating x coordinate
			x += c_width
		# Updating y coordinate
		y += c_height
		
