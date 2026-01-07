module Logic where

import Data.Array
import Game
import Graphics.Gloss.Interface.Pure.Game

isCoordCorrect :: (Int, Int) -> Bool
isCoordCorrect = inRange ((0, 0), (n - 1, n - 1))

switchPlayer :: Game -> Game
switchPlayer game = case gamePlayer game of
  PlayerX -> game {gamePlayer = PlayerO}
  PlayerO -> game {gamePlayer = PlayerX}

playerWon :: Player -> Board -> Bool
playerWon player board = any isVictoryProj projs
  where
    projs = allRowCoords ++ allColumnCoords ++ allDiagCoords
    allRowCoords = [[(i, j) | j <- [0 .. n - 1]] | i <- [0 .. n - 1]]
    allColumnCoords = [[(j, i) | j <- [0 .. n - 1]] | i <- [0 .. n - 1]]
    allDiagCoords = [[(i, i) | i <- [0 .. n - 1]], [(i, n - 1 - i) | i <- [0 .. n - 1]]]
    isVictoryProj proj =
      (n ==) $
        length $
          filter (\cell -> cell == Full player) $
            map (board !) proj

countCells :: Cell -> Board -> Int
countCells cell = length . filter (cell ==) . elems

playerHist :: Game -> Player -> PlayerHist
playerHist game PlayerX = playerXHistory game
playerHist game PlayerO = playerOHistory game

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x : _) = Just x

updateBoard :: Game -> (Int, Int) -> Game
updateBoard game cellCoord
  | player == PlayerX = game {gameBoard = newBoard, playerXHistory = newPlayerHist}
  | player == PlayerO = game {gameBoard = newBoard, playerOHistory = newPlayerHist}
  | otherwise = game
  where
    board = gameBoard game
    player = gamePlayer game
    currentPlayerHist = playerHist game player
    newPlayerHist = cellCoord : currentPlayerHist
    toRender = take n newPlayerHist
    toRemove = safeHead $ drop n newPlayerHist
    newBoard = case toRemove of
      Nothing -> board // [(coord, Full player) | coord <- toRender]
      Just coords -> board // ((coords, Empty) : [(coord, Full player) | coord <- toRender])

checkGameOver :: Game -> Game
checkGameOver game
  | playerWon PlayerX board =
      game {gameState = GameOver $ Just PlayerX}
  | playerWon PlayerO board =
      game {gameState = GameOver $ Just PlayerO}
  | countCells Empty board == 0 =
      game {gameState = GameOver Nothing}
  | otherwise = game
  where
    board = gameBoard game

playerTurn :: Game -> (Int, Int) -> Game
playerTurn game cellCoord
  | isCoordCorrect cellCoord && board ! cellCoord == Empty =
      checkGameOver $
        switchPlayer $
          -- game {gameBoard = board // [(cellCoord, Full player)]}
          -- game {gameBoard = board // [(cellCoord, Full player)]}
          updateBoard game cellCoord
  | otherwise = game
  where
    board = gameBoard game

mousePosAsCellCoord :: (Float, Float) -> (Int, Int)
mousePosAsCellCoord (x, y) =
  ( floor ((y + (fromIntegral screenHeight * 0.5)) / cellHeight),
    floor ((x + (fromIntegral screenWidth * 0.5)) / cellWidth)
  )

transformGame :: Event -> Game -> Game
transformGame (EventKey (MouseButton LeftButton) Up _ mousePos) game =
  case gameState game of
    Running -> playerTurn game $ mousePosAsCellCoord mousePos
    GameOver _ -> initialGame
transformGame _ game = game
