extends Resource
class_name Item
#Created by Ethan

#This resource stores the upgrade Node and hazard scene. This means we could mix and match if we wish :eyes:
enum Part {Engine, Tire, Spoiler, Oil}
enum Stat {Speed, Acceleration, Handling, Boost_Strength, Weight}
@export var upgrade : PackedScene
@export var hazard : PackedScene
@export var type : Part

@export var item_name : String
@export var up_stat : Stat
@export var down_stat : Stat
