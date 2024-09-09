Racing game created by Team Stingray for GDS2!

The following documentation is written base don the content currently on the `dev` branch
# Kart System
## Kart 
The `kart_controller` script manager the movement of the kart, its stats and camera movement

The current stats that can be changed on the kart are:
- `max_steer`
- `max_speed`
- `engine_power`
- `brake_strength`


# Item System
## Item Boxes
Item boxes have a `part_type` so they are limited to producing 1 kind of part, the specific item within the pool is up to chance 

When a kart enteres the item box it emits the `hit_item_box` signal on the kart and the `ItemManager` is used to selected a random item from the relevant pool

## Items
Each `item_base` resource has a `type` and contains an `upgrade` and `hazard` PackedScene 

### Item Manager
The item manager is an autoload which maintains an array of all the items, a dictionary of all the items and  function to select a random item from the specified pool

### Upgrades
When an item is activated as an upgrade it is instantiated as a child of the kart and its function will run to apply the upgrades changes to the kart

Likewise when it is destroyed `exit_tree()` or another function will be run to reverse the upgrades changes 

Optionally `process()` can be used if we want the upgrade to do something continuously
### Hazards 
not yet implemented
