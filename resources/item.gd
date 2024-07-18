extends Resource
class_name Item

@export var name : String
@export var icon : Texture2D
@export_enum("usable","tool","material") var type : int
@export var stackable : bool = true
