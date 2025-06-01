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

### 2024-05-29 - Brief description
Tested and fixed distanceTo, isTouching, and render for Bullet class (successful).

### 2024-05-29 - Brief description
Created the Field class and wrote constructors, getters, and removers. Added tick function to AFieldObject and implemented it in a draft for Bullet.

