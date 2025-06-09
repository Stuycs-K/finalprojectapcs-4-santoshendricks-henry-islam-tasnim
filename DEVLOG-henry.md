# Dev Log:

This document must be updated daily every time you finish a work session.

## Henry Santos Hendricks

### 2025-05-16
Brainstormed and submitted proposals for Smash Bros, Flappy Bird, and Diep.io

### 2025-05-19
Brainstormed prototype for Diep.io, planned out basic functionality including the decision to add classes, enemies fight each other, etc.

### 2025-05-20
Continued Brainstorming for previous day, drafted prototype, drafted initial UML draft for submission

### 2025-05-21
Wrote first draft of proposal and first draft of UML for submission

### NOTICE: Henry was away from class for several days in this time period due to appointments and the Speech National Competition

### 2025-05-26
Started writing out a lot of the planned boilerplate for the class hierarchy, including making the main game file, drafting the list of fields, methods, and abstract methods necessary for FieldObject, and implemented many of the getters and other implemented functions of the FieldObject class. Also made the Bullet class file, and added some fields and boilerplate, also implementing the abstract function render, which just draws a circle.

### 2025-05-27
Received notes from Mr. K on the prototype and began fixing the noted issues by designing the Field class and making a more complicated/updated UML that included the genral class hierarchy as well as a new class for the main menu.

### 2025-05-28
Wrote basic constructor for AFieldObject (renamed for Processing bug reasons). Added the team identifier to AFieldObject to stop friendly fire, moved the size field from the subclasses up to AFieldObject to make touch sensitivity easier, wrote constructor for the Bullet class and implemented isTouching to help bullets detect players.

### 2025-05-29 - Brief description
Tested and fixed distanceTo, isTouching, and render for Bullet class (successful).

### 2025-05-29 - Brief description
Created the Field class and wrote constructors, getters, and removers. Added tick function to AFieldObject and implemented it in a draft for Bullet.

### 2025-05-30
Started writing tick in a way that differentiated player and enemy ticks. Added mouse pointing fucntionality to the user player.

### 2025-06-01
Added code to remove all dead objects. Added code to make bullets deal damage to players not on their team, and then delete themselves. Coded Field to record keystates, and used those keystates to allow the player to move using the WASD keys. Gave the player the ability to shoot bullets by clicking the mouse. Tinkered with speed and cooldown constants, also reformatting the usage of Field in the main file. Started writing enemy bot algorithm by creating a peaceful mode for the bot in which the bot wanders around a bunch.

### Same work session, but in the morning of 2025-06-02
Finished writing the enemy bot code to strafe, charge, and maintain distance. Coded enemies to die upon losing health. Added lifetime cooldown timer to bullets so they would disappear afer a certain amount of time to reduce lag. Wrote players' names above their heads. Started spawning enemies in random locations and added polygons, giving them the functioonality of dying and taking damage.Enlarged the field size and made enemies respawn instead of being deleted to create a perpetual game.

### 2025-06-03
Changed bot AI to stop it from mostly only attacking the user. Tested and verified that peacfeul mode worked as intended. Added HP bars under each player that change color depending on health. Reduced enemy accuracy to make them easier to fight.

### 2025-06-09
Updated prototype in order to make changes more clear and to lay out our development process. Added ability of player to gain xp by killing enemies and polygons.