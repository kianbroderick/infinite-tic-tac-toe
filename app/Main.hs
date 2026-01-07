module Main where

import Game
import Graphics.Gloss
import Logic
import Rendering

backgroundColor :: Color
backgroundColor = makeColorI 0 0 0 255

window :: Display
window = InWindow "Tic Tac Toe" (screenWidth + 30, screenHeight + 30) (100, 100)

main :: IO ()
main = play window backgroundColor 30 initialGame gameAsPicture transformGame (const id)
