
# Technical Details:
Player will be in a center ~~and a map object with reflect the movement of the player. To keep all other objects consistent with the movement of the player the vector of the map movement will be applied onto all other objects.~~ The player and objects will be kept on screen using the translate() function to emulate a map and will be implemented in the general abstract class.

Players will have different tank classes:

Twin: shoots two bullets at a time
Sniper: greater FOV and faster bullets
Machine Gun: faster shooting
Flank Guard: shoot in both directions
     
# Project Design

There will be an abstract class for all movable and renderable objects on the gameplay field, which will be capable of moving, taking/healing damage, turning, detecting each other's touch, becoming visible, and ticking.

Enemies and player objects are the same class; the enemies will be stored in a list, while the player will be a single instance variable.

All objects on the field will be stored in the Field class, which contains info like size and also the list of FieldObjects.

Health, weapon damage and rendering will be affected by a player object's type.

Polygons will float around that give xp upon breaking but damage the players on contact.

Enemies will be given basic decision making skills. While the project may be expanded further, this will involve detecting incoming bullets and moving away from them, detecting players and strafe shooting at them, shooting at polygons, and selecting class upgrades when they appear.

![First UML](Prototype0-1.PNG)
New UML
![Second UML](Prototype.PNG)

    
# Intended pacing:

Pacing schedule:

May 27: finish abstract FieldObject class
May 28: finish Bullet class
May 29: finish Polygon class
May 30: finish Player class
June 1: Finish upgrade system
