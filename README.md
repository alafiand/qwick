# TIC TAC TOE

My first experience with Haskell was facilitated by several resources, listed below. The resources available for learning Haskell are fewer and farther between than those available for popular OOP languages. The answers I sought were found scattered across numerous sites, often from selfless bloggers who documented their own struggles and triumphs with the language.

## Learning Experience

As promised, making the shift to functional programming was jarring and had quite a learning curve. I started out by watching several generic "Welcome to Haskell" tutorials to get my bearings and set up my developer environment. From there I read "Learn You a Haskell" to begin learning syntax and basic data manipulation. One concept that I struggled with for large portion of the exercise was the lack of state in the sense that I knew it--there were no global variables representing the board or the player or the status of a given game.

To get moving, I wrote some basic functions to manipulate lists and designed the tic-tac-toe board and began thinking of ways to structure the game. A big breakthrough happened when I stumbled upon a [hangman](https://gist.github.com/Epitaph64/0cb73c025e5db56da969) game written in Haskell, which laid out the structure of a CLI game. I was able to use that as a model for my first test app, which was a simple text interaction that would repeat (e.g. What is your name? Hello -name-!). I also looked at tic-tac-toe games written in several languages to help formulate structure.

My plan for the app was to keep the board in a list of lists, where each nested list would represent a row of the board, and each element within those would represent a space to play a move. I wrote a function (updateBoard) to take the board (the nested lists) and return newBoard with the move having been played.

With nearly all functions I wrote, I first tested them in GHCi to make sure I was getting the correct results. I often had to comment out large blocks of code just to get my function to compile for testing. As a backup, I also used a playground file where I could write a standalone function and try it out with some prepped input.

In order to get the game flowing, I set up main with the beginning state (basically all nine spaces were " ") and invoked the playRound function, which would be called recursively until an ending scenario was reached. To begin, I just set playRound to be called recursively, because I hadn't defined ending scenarios.

I wrote printBoard and printRow to facilitate drawing the board. I also began seeing opportunities for writing small functions to take care of simple tasks that would make my larger functions more lightweight. (Note: there are still several opportunities for more of these small functions which I did not implement!) Examples of helper functions include getColumn, getDiag, getWinner, getCoords, catsGame.

As I got each function to work independently, then together with the other functions, I picked up momentum and was able to troubleshoot faster. I enjoyed the type declarations at the beginning of each funciton because it made me think about what ingredients I needed and what I wanted to produce. The syntax afterwards was relatively straightforward.

## Areas for Improvement

I learned quite a bit as I got to know Haskell, and wished that I had started breaking down the assignment into subtasks earlier because I really enjoyed getting one function to play nicely with another.

In several parts of the app, I opted for "frankenstein-ing" the intended result instead of using functions included in Haskell. One example where I managed to avoid the frankenstein mess was with intercalate, which was fun to learn. My checkWinner function was also clunky, and I would liked to have refactored to be a more Haskell-y solution.

One big flaw in the application I made was the fact that I didn't handle user input gracefully. It requires users to enter coordinates, which are taken as a string, then parsed to return ints. If the user mistypes and includes two commas for example, it causes the app the crash. I think this could be handled by changing my errorChecker function, or perhaps adding another function in between.

## Resources

* [Learn You a Haskell](http://learnyouahaskell.com/) - Likely the most well-known reference, this book held my hand for learning the fundamentals, and served as a reference when I got to more complex steps in the app
* [tutorialspoint](https://www.tutorialspoint.com/haskell/) - Another great reference site with helpful examples, though less friendly navigation
* [Hackage](https://hackage.haskell.org/) - The community's cheat sheet was very helpful throughout
* [Tsoding Daily](https://www.youtube.com/c/TsodingDaily) - A youtube channel which offered several walkthroughs using Haskell
* [Dev.to](https://dev.to/) - Several Haskell tutorials, including those by Theofanis Despoudis, Steadylearner, and Nikhil Thomas
* [stackoverflow](https://stackoverflow.com/) - Needs no introduction, I was surprised at how helpful most of the responses were, compared with responses for JavaScript questions
