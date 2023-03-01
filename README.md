# Knucklebones
A version of the luck and strategy based dice game from [Cult of The Lamb](https://store.steampowered.com/app/1313140/Cult_of_the_Lamb/).

Available at: https://rawenchilada.github.io/Knucklebones/

# Roadmap
 - Hard AI

# How to Play
- Take turns with the ai to place dices on a 3x3 board. 
- Same dices in a column will have their values multiplied. 
- If you place a dice in a column where the opponent already has a same dice, the opponent will lose the dice. 
- The game ends when one of the boards are full. 
- The player with the highest score wins.


# Build
To build the game install the [Dart SDK](https://dart.dev/get-dart).<br>
Then run `make` in the root directory of the project.<br>
The game will be built to the `dist` directory.

 > *'make artifact' builds the game into a '_site' folder, used for github workflows.*



