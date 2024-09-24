class_name ItemHoverMenu
extends Control

# Variables
var item : Item
var item_label_template : String
var item_description : String

# Onready Variables
@onready var item_label = $PanelContainer/PanelMarginRect/PanelContainer/LabelVBoxContainer/ItemLabel
@onready var description_label = $PanelContainer/PanelMarginRect/PanelContainer/LabelVBoxContainer/DescriptionLabel

# Functions
func _ready():
	if(item == null):
		var new_item_label = "None"
		item_label.text = new_item_label
		var new_description_label = "None"
		description_label = new_description_label
	else:
		item = get_parent().inventory_slot.get_item()
		item_label.text = item.get_item_name()
		description_label.text = item.get_description()

	
