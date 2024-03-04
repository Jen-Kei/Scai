# Trailer
[![Trailer](https://img.youtube.com/vi/8gQW6DgU7WE/0.jpg)](https://www.youtube.com/watch?v=8gQW6DgU7WE)


# Scai - ReadMe / Design Document
## Table Of Contents
[Overview](#Overview)
[Project Scope](#Project-Scope)
[Organisation](#Organisation)
[Gameplay](#Gameplay)
[Mechanics](#Mechanics)
[Game Elements](#Game-Elements)

## Background Info
Game name: Scai
Authors:  [Keith Salhani](https://github.com/chubbyyb) & [Jenny Thao Huynh](https://github.com/jenitaoo) 
Our Resources & Video: [Github Repo](https://github.com/Jen-Kei/Scai) & [Google Drive](https://drive.google.com/drive/folders/1ryVLIF-ESaVR3VmjwkZqxL4-G8rU59PK?usp=drive_link) & video_placeholder
Date: February 16th, 2024

# Overview
---
## Game-Concept
Embark on a captivating journey in "Scai," a top-down, 2D pixel RPG adventure set amidst the lush landscapes, mysterious dungeons and a cosy town.

You wake up with no memory & nothing - no money, no sense of self and  besides a dinky old van & your old journal. All the pages are torn except for a map with crossed out locations and a town. With no ambitions and a curiosity about the only thing you left behind, you embark on a mission to travel to every location on the map - but you need gas money! The quota of money you have to make increases daily.

Each location has a dungeon where you navigate through the depths and survive enemies to gather treasures that slow you down, but treasures aren't just shiny artefacts; they're a collection of seemingly random, miscellaneous objects. Your challenge lies not only in uncovering these relics but also in understanding their true worth. Venturing back to the cosy town, you encounter a vibrant cast of townspeople, each adorned with distinct and colourful personalities.

Powered by advanced AI, these townsfolk serve as more than just merchants; they become dynamic entities with unique preferences and quirks. As you engage in barter and trade, your ability to adapt your bargaining technique becomes paramount. Whether charming a pretty lady or appealing to the logic of a stoic old man, every interaction shapes your journey and decides whether you've enough gas money to meet your quota!

## Genres
1) **Role-Playing Game (RPG)**
- Play into different personas and roles as you persuade the NPCs to give you high offers for your treasures.
2) **Adventure**
- Explore ancient forests & abandoned dungeons, discover mysterious treasures & encounter a range of diverse characters.
1) **Puzzle**
- Decode the value of seemingly random treasures, navigate the complexities of social interaction to secure the best deals. You've to be careful about which items you try sell to certain characters & adapt your bargaining style to match their personalities!
4) **Survival**
- Scavenge for treasures in the dungeons while surviving various enemies!
5) **Rogue-Like**
- Endlessly play and explore procedurally generated dungeons until you fail to meet the daily quote of money made .

# Project-Scope
---
With the deadline within 3 weeks of starting our project, we decided to use the game concept to **create a beta version** which aims to provide a glimpse into the core mechanics and gameplay features of the full release. We added the basic features of the game but **not all the features** as outlined in the [game concept](#Game-Concept). 

Decided to make this as a Windows application and created using the Godot Game Engine.

**From this point forward in the document, unless explicitly said otherwise, the document will refer to Scai Beta and not the ideal, full release.**

## Scai Beta Objectives
- Introduce players to the game's world, mechanics & key features - scavenging & bartering with AI-powered NPC's.
- Gather feedback and identify bugs on gameplay, user experience 
- Test the AI-driven trading system and use the conversations between the NPC's and the players to tweak the NPC's prompts.

## Scai Beta Features 
- Exploration - Allow the player to explore the base location - the ancient forest and it's abandoned dungeon as well as the town.
- Scavenging - Player gathers randomly spawned treasures in the forest and dungeon
- Bartering - Player can have text conversations with various NPC's of distinct, vibrant personalities & barter with the NPC's to earn money for their gathered treasures.
- Survival - Survival & Combat parked for beta


# Organisation
---
## Naming Conventions
Script and folder names: pascal case
Function names: snake case
Everything else camel case

```
Variables = helloThisIsVariable 
Functions = hello_this_is_a_function 
Scripts/Scenes= HelloThisIsASceneOrScript 
Folder Names = ThisIsAFolder
```

## Folder Organisation
Organise folders, Scenes folder >> several diff Object folders >> script & scenes & assets folder
Maps are stored in their own scene and are instantiated in others.

Objects/
-> Gun/
	--> Scene, Script
	 -> Assets/
		 - -> All the textures

## Conventions
- Always start a scene with a Node2D
- Functions


# Gameplay
---
## Objectives

| Beta                                                                                                                              | Full                                                                                                                                                                |
| :-------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Explore the ancient forest and the abandoned dungeon                                                                              | Explore several locations, each with a procedurally generated dungeon                                                                                               |
| Scavenge and pick up treasures which have an impact on your speed and running ability                                             | Scavenge and pick up treasures which have an impact on all your stats - fire rate (shooter <br>combat), stamina capacity, stamina gain, hp capacity, hp gain, speed |
| Barter with the NPC's to sell your goods at a high price with them knowing the name of your item and how much it's actually worth | Barter with the NPC's to sell your goods at a high price with them knowing the name of your item and how much it's actually worth                                   |
| Gain as much money as you can                                                                                                     | Gain as much money as you can within a day in game with an increasing daily quota                                                                                   |


## Game Progressions

| Beta                                            | Full                                                                                                                                           |
| :---------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------- |
| Gather as many treasures as possible            | Gather as many treasures as possible                                                                                                           |
| Gain as much money as you can through bartering | Gain as much money as you can through bartering                                                                                                |
|                                                 | Increase your hearts with the NPCs as you<br>continue trading with them and build good<br>relationships with them (they'll give higher offers) |
|                                                 | Unlock new levels as you continue meeting quotes                                                                                               |
|                                                 | Spend leftover money from meeting quotas<br>on van upgrades and decoration                                                                     |


# Mechanics
---
## AI NPC's & Bartering System
We are using the OpenAI API to call GPT3.5 Turbo in order to connect it to our game. We chose this model as it has a large context window, which allows us to pass the AI more information.

Each Non-Player Character (NPC) is equipped with a detailed prompt engineered to its unique personality traits, preferred responses to player interactions, error case handling and pricing strategies for items.

During player-NPC interactions, contextual information about the item(s) is relayed to the NPC to prevent the player from selling items for significantly more than their actual value.

NPC communication with the player occurs via pop-up messages, and the system interprets various triggers such as the NPC's current mood, desired price for items, and actions such as calling guards or agreeing to a deal using regex processing.

When a deal is triggered, the selected items are removed from the players inventory and the agreed value of the deal is transferred to the players wallet.


## Stat Bank And Effective Treasures
[Diagram](https://imgur.com/a/7r03hpi)
We wanted to have a very large number of items, and creating a new object for each item is time consuming, so we made a json file with all the item information, and a base node that inherits from the json file. The json file has 3 sections, which are the rarities, the code is implemented in godot to make that work. 

We decided to consolidate all player-affecting stats within a designated node "StatBank." This node serves as the central repository for all relevant stats, accessible by various game elements. For instance, when the player needs to retrieve their speed, they interact directly with this node.

This centralized approach proves vital as it facilitates the seamless transfer of collected treasures directly to a single node, preventing the fragmentation of stats throughout the game world. 

The treasures when picked up or dropped impact the StatBank
Everything else inherits from StatBank

We also wanted to preserve treasure info incase we dropped the treasure again, we implemented an initialization function within the treasures script. This function enables us to easily apply the current treasure's info (self.info) to any newly acquired treasure added to our inventory or dropped on the floor. For example, when we drop a treasure, we create a new instance, call the init function with the current info, and then destroy the current instance.

See the Google Sheets we used to organise treasure data before creating a json file [here](https://docs.google.com/spreadsheets/d/1KSMvTxMwG0vNtmLA9Kzll2xNiqJgOkUOx4N7_deNGUY/edit?usp=sharing):


## Procedurally Generated Dungeons (Unused)
This feature unfortunately was unusable for the beta but a lot of work was put into it so I'm keeping it here! Theoretically it should've worked, in practice? It did not. If you'd like to see the attempt, it's in Dungeon.tscn and Dungeon.gd. 

We wanted to procedurally generate the dungeons for each day, the locations on the map e.g Forest, would be manually made but the Dungeon's found inside the maps were meant to be procedurally generated for replayability and chaos.

First, we needed to generate outlines for rooms with random dimensions using Godot's RigidBody2D nodes for each room as they have built-in physics properties that allow the rectangles to seperate from each other. Then we delete half the room outlines to allow for gaps between the rooms. 
Next, we use Godot's AStar2D to turn these rooms into points in a graph and then use an Prim-Dijkstra's algorithm to connect these points (Minimum Spanning Tree). 
[Here's a link to what this looked like for us](https://imgur.com/a/Yugsrkb)

Using these rooms and paths, we generate the tilemap cells for the rooms and paths between rooms using terrains (Godot's autotiling feature). This was the tricky part and we didn't quite nail paths between rooms.

[Our procedurally generated rooms:]![[Godot_v4.2.1-stable_win64_ReHuPv2UUj.png]]


## Combat
Limited combat implemented in Beta version but we aim for shooter-style combat in the full release

| Beta                                                                    | Full                                                                                                             |
| :---------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------- |
| Avoid exploding kittens that dash <br>towards you and explode on impact | Face several different enemies, including dinosaurs,<br>chicken cerberus, exploding kittens, mutated honey bears |
| Shoot the cats to death                                                 | Enemies impact your HP and it's game over if you're down                                                         |
|                                                                         |                                                                                                                  |
## Cat
The cat uses the A* algorithm to navigate around the dungeon and avoid walls. The cat does not attack you until you are close to it, at which point it will dash and explode on you.


## Randomly Spawned Treasures and Enemies
In the forest & dungeon map, we spawn a certain amount of treasures & enemies in random positions on the map. In future development we would customise the amount of treasures & enemies to the difficulty of the location but we only have the forest for now.

We generate a random coordinate and check if that coordinate it suitable for generation (e.g isn't a cliffside, isn't on a rock, isn't a wall) and then generate the treasure there.

# Game-Elements
---
## Worldbuilding
The world should have several different locations that can be accessed on the map, each location has an entrance to a dungeon.
Beta version has unlocked the ancient forest!


## Characters
Within the town are several vibrant and distinct personalities that are fed into the AI so that the players feel like they're talking with real, dynamic characters. For this, the characters are meticulously prompt engineered. [View the prompts doc here.](https://docs.google.com/document/d/1eZyvnEMmUkFRKJoBXGe870QygUdMF4vPlT7YNm3lU6A/edit?usp=sharing)


## Locations
The player starts off in the ancient forest, surrounded by evergreen trees, eroded pathways and sculptures of old. They make their way through creaky, worn bridges (the ones that haven't yet disintegrated) to travel to the abandoned dungeon.

The dungeon is filled with exploding kittens, enemies and treasures!



# Assets
---
## Visual Art
We chose Itch.io to source our asset packs because of their quality and ease of implementing in our game. However, we used a huge number of asset packs and customised them, their shapes & colours using Aseprite in order for our game to look visually cohesive.

We wanted to go for a cosy, earthy feeling for the town & forest map but a spookier and darker look for the dungeon map.


# Appendices
--- 
## Sketches Made During Game Development
[our sketches](https://imgur.com/a/BNcagiS)
