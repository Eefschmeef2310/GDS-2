extends MarginContainer
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Exported Variables
@export_group("Slots")
@export var engine : TextureRect
@export var tire : TextureRect
@export var spoiler : TextureRect
@export var oil : TextureRect
#endregion

#region Other methods (please try to separate and organise!)
func update(data : PlayerData):
	engine.modulate.a = 1 if data.inventory[Item.Part.Engine] else 0.5
	tire.modulate.a = 1 if data.inventory[Item.Part.Tire] else 0.5
	spoiler.modulate.a = 1 if data.inventory[Item.Part.Spoiler] else 0.5
	oil.modulate.a = 1 if data.inventory[Item.Part.Oil] else 0.5
#endregion
