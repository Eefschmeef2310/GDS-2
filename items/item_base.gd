extends Resource
class_name Item
#Created by Ethan

#This resource stores the upgrade Node and hazard scene. This means we could mix and match if we wish :eyes:
enum Part {Engine, Tire, Spoiler, Oil}
@export var upgrade : PackedScene
@export var hazard : PackedScene
@export var type : Part

@export var item_name : String
