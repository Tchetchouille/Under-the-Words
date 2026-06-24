extends Node2D

@export var word : String
@export var color : Color
@export var bold_font : FontFile

@onready var c_width = GlobalVariables.character_width

@onready var base_character = preload("res://Scenes/Levels/Bases/base_character.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_body(word)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_body(string):
	var x = 0
	for character in string.split():
		var p_character = base_character.instantiate()
		var label = p_character.get_child(0).get_child(0)
		# In the case of the protag, I don't use special characters yet.
		label.text = character
		p_character.hidden_character = character
		# Making it bold and colored
		label.add_theme_font_override('font', bold_font)
		label.add_theme_color_override('font_color', color)
		p_character.position.x = x
		add_child(p_character)
		x += c_width
