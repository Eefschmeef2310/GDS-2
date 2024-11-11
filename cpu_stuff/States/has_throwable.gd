extends BasicState
#class_name
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables
var item: Item
#endregion

#region Godot methods

#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)
func enter():
	super.enter()
	#item = Get item in hand
	#Check what kind of item is in hands
	#Set up timer and colliders
#endregion
