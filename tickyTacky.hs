import Data.Char(digitToInt)
import Data.List(intercalate)

--parses user input for coordinates, input is a string and we need Ints to place our move
getCoords :: String -> (Int, Int)
getCoords input = (digitToInt (input !! 0), digitToInt (input !! 2))

--makes sure the input is valid AND prevents writing over previous moves
errorChecker :: String -> [[[Char]]] -> Bool
errorChecker input board =
  or [
    not (elem (digitToInt (input !! 0)) [0,1,2]),
    not (elem (digitToInt (input !! 2)) [0,1,2]),
    not (((board !! (digitToInt (input !! 2))) !! (digitToInt (input !! 0))) == " ")
  ]

--get strings of each column to facilite checking winners
getColumn :: Int -> [[[Char]]] -> String
getColumn n board = ((board !! 0) !! n) ++ ((board !! 1) !! n) ++ ((board !! 2) !! n)

--get strings of each diag to facilite checking winners
getDiag :: [[[Char]]] -> [[Char]]
getDiag board =
    [
      ((board !! 0) !! 0) ++ ((board !! 1) !! 1) ++ ((board !! 2) !! 2),
      ((board !! 0) !! 2) ++ ((board !! 1) !! 1) ++ ((board !! 2) !! 0)
    ]

--get winning sequence, "XXX" or "OOO"
getWinner :: String -> String
getWinner move = move ++ move ++ move

--checks the board to see if the end result is a draw (aka "Cat's Game") if no more blank spaces are found
catsGame :: [[[Char]]] -> Bool
catsGame board = not (elem " " (concat board))

--replaces an item in a one dimensional list
updateBoard :: [[a]] -> a -> (Int, Int) -> [[a]]
updateBoard board move (x,y) =
  take y board ++ [take x (board !! y) ++ [move] ++ drop (x + 1) (board !! y)] ++ drop (y + 1) board

--this returns the opposite player so turns alternate.
nextMove :: String -> String
nextMove "X" = "O"
nextMove "O" = "X"

--prints a row with " | " between each item in the row
printRow :: [[Char]] -> String
printRow row = intercalate " | " row

--prints the board with numerical guides
printBoard :: [[[Char]]] -> IO ()
printBoard board = do
  putStrLn "   0   1   2"
  putStrLn $ "0  " ++ printRow (head board)
  putStrLn $ "  " ++ "-----------"
  putStrLn $ "1  " ++ printRow (last (take 2 board))
  putStrLn $ "  " ++ "-----------"
  putStrLn $ "2  " ++ printRow (last board)

--checks to see if the most recent move has caused a winning scenario
checkWinner :: String -> [[[Char]]] -> Bool
checkWinner move board =
  or [
    --checking rows for winner
    (concat (head board)) == getWinner move,
    (concat (last (take 2 board))) == getWinner move,
    (concat (last board)) == getWinner move,

    -- --checking columns
    getColumn 0 board == getWinner move,
    getColumn 1 board == getWinner move,
    getColumn 2 board == getWinner move,

    --checking diags
    (getDiag board) !! 0 == getWinner move,
    (getDiag board) !! 1 == getWinner move
  ]

--runs the game logic, accepting input, checking board state, then proceeding accordingly
playRound :: [[[Char]]] -> String -> IO ()
playRound board move = do
  putStrLn $ "It's " ++ (move) ++ "'s turn, choose a square from 0,0 to 2,2 (Horiz, Vert), separated by a comma"
  printBoard board
  putStr "\nEnter Move: "
  input <- getLine
  let newBoard = updateBoard board move (getCoords input)
  if errorChecker input board then do
    putStrLn "ILLEGAL MOVE"
    playRound board move
  else if checkWinner move newBoard then do
    putStrLn $ move ++ " wins!"
    printBoard newBoard
    return()
  else if catsGame newBoard then do
    putStrLn "Cats game! Everyone loses!"
    printBoard newBoard
    return()
  else playRound newBoard (nextMove move)

--loads the game and kicks off the playing
main = do
  putStrLn $ "Let's play tic tac toe!"
  let newBoard = [[" "," "," "],[" "," "," "],[" "," "," "]]
  playRound newBoard "X"

