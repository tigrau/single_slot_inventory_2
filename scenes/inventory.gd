extends GridContainer

@onready var slots = get_children() 

func _ready() -> void:
	pass
	add_item(load("res://resources/test_item.tres"))
	add_item(load("res://resources/test_item.tres"))
	add_item(load("res://resources/test_item.tres"))
	add_item(load("res://resources/test_item.tres"))
	add_item(load("res://resources/test_item.tres"))
	add_item(load("res://resources/test_item.tres"))
	add_item(load("res://resources/test_item.tres"))


func add_item(item:Item):
	if item.stackable:
		for slot in slots:
			if slot.item:
				if slot.item.name == item.name:
					if slot.amount < 5:
						slot.amount += 1
						return
	for slot in slots:
		if slot.item == null:
			slot.item = item
			slot.amount = 1
			return
	print("can't add more item")

func delete_item(item:Item):
	if item.stackable:
		for slot in slots:
			if slot.item:
				if slot.item.name == item.name:
					if slot.amount > 1:
						slot.amount -= 1
						return
					else:
						slot.item = null
						slot.amount = 0
						return
	else:
		for slot in slots:
			if slot.item:
				if slot.item.name == item.name:
					slot.item = null
					slot.amount = 0
					return
	print("can't delete item")
