module Orphne ( runRPHN ) where

import Graphics.Gloss

import Renderer.Render
import Renderer.VisualConstants
import Renderer.TextureLoader

import Levels.Level1

import Engine.Engine


runRPHN :: IO ()
runRPHN = do
  -- | Загрузка текстур
  playa <- texIdle

  tWR1 <- texWR1
  tWR2 <- texWR2
  tWR3 <- texWR3

  tWL1 <- texWL1
  tWL2 <- texWL2
  tWL3 <- texWL3

  earth <- texEa
  gate <- texGo
  wal <- texPlatform
  sss <- texSpikes

  cld <- texCloud

  let heroImgs = playa:tWR1:tWR2:tWR3:tWL1:tWL2:tWL3:[]  -- | объединяем все текстурки иигрока в список

  play newWindow backgroundColor fps level1Init (render heroImgs gate earth wal sss cld) handleInput update
