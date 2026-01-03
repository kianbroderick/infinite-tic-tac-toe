{-# LANGUAGE TupleSections #-}

module Game where

import Data.Array

data Player = PlayerX | PlayerO deriving (Eq, Show)

type Board = Array (Int, Int) Cell

data State = Running | GameOver (Maybe Player) deriving (Eq, Show)

data Cell = Empty | Full Player deriving (Eq, Show)

type PlayerHist = (Maybe (Int, Int), Maybe (Int, Int), Maybe (Int, Int))

data Game
  = Game
  { gameBoard :: Board,
    gamePlayer :: Player,
    gameState :: State,
    playerXHistory :: PlayerHist,
    playerOHistory :: PlayerHist
  }
  deriving
    (Eq, Show)

n :: Int
n = 3

screenWidth :: Int
screenWidth = 640

screenHeight :: Int
screenHeight = 480

cellWidth :: Float
cellWidth = fromIntegral screenWidth / fromIntegral n

cellHeight :: Float
cellHeight = fromIntegral screenHeight / fromIntegral n

initHist :: PlayerHist
initHist = (Nothing, Nothing, Nothing)

initialGame :: Game
initialGame =
  Game
    { gameBoard = array indexRange $ map (,Empty) (range indexRange),
      gamePlayer = PlayerX,
      gameState = Running,
      playerXHistory = initHist,
      playerOHistory = initHist
    }
  where
    indexRange = ((0, 0), (n - 1, n - 1))
