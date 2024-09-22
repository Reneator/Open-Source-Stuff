extends PanelContainer


@export var icon : Texture2D
@export var title : String
@export var shard_cost : int
@export_multiline var tooltip : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/Label.text = title
	$HBoxContainer/Icon.texture = icon
	$HBoxContainer/HBoxContainer/Shard_Icon/Cost_Label.text = "%s" % shard_cost
