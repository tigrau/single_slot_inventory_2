extends PanelContainer
class_name Slot

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label

@export var item : Item = null:
	set(value):
		item = value
		
		if get_parent().name == "Character":
			get_parent().equip(item)
			
		if value != null:
			texture_rect.texture = value.icon
		else:
			texture_rect.texture = null

@export_range(0,5,1) var amount := 0:
	set(value):
		amount = value
		
		if amount != null:
			label.amount = amount
			
func get_preview():
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture_rect.texture
	preview_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview_texture.custom_minimum_size = Vector2(60,60)

	var preview = Control.new()
	preview.add_child(preview_texture)
	preview_texture.position = -0.5*Vector2(60,60)
	
	return preview

func _get_drag_data(at_position: Vector2) -> Variant:
	if item == null:
		return
	set_drag_preview(get_preview())
	return self

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is Slot and get_parent().name == "Character":
		return data.item.type == 1
	return data is Slot
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	if item and data:
		if item.name == data.item.name:
			if item.stackable and amount < 5:
				var amount_temp_sum = amount + data.amount
				var amount_temp_rem = amount_temp_sum - 5
				if amount_temp_sum > 4:
					amount = 5
					data.amount = amount_temp_rem
				else:
					amount += data.amount
					data.amount = 0
					data.item = null
				return
	var temp = item
	var temp2 = amount
	item = data.item
	amount = data.amount
	data.item = temp
	data.amount = temp2
