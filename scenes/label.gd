extends Label

func _ready() -> void:
	visible = false

var amount := 1:
	set(value):
		amount = value
		text = str(amount)
		if value > 1:
			visible = true
		else:
			visible = false
