module Renderer.TextureLoader where

import Graphics.Gloss


texIdle :: IO Picture      -- | стандартная текстура персонажа
texIdle = loadBMP "img/idle.bmp"

                          -- | Идём вправо
texWR1 :: IO Picture
texWR1 = loadBMP "img/walk_right/WR1.bmp"

texWR2 :: IO Picture
texWR2 = loadBMP "img/walk_right/WR2.bmp"

texWR3 :: IO Picture
texWR3 = loadBMP "img/walk_right/WR3.bmp"
                          -- |////////////

                          -- | Идём влево
texWL1 :: IO Picture
texWL1 = loadBMP "img/walk_left/WR1.bmp"

texWL2 :: IO Picture
texWL2 = loadBMP "img/walk_left/WR2.bmp"

texWL3 :: IO Picture
texWL3 = loadBMP "img/walk_left/WR3.bmp"
                          -- |////////////

texEa :: IO Picture       -- | Земля
texEa = loadBMP "img/earth.bmp"

texGo :: IO Picture       -- | Дверь
texGo = loadBMP "img/doo.bmp"

texPlatform :: IO Picture -- | Платформа
texPlatform = loadBMP "img/platform.bmp"

texCloud :: IO Picture -- | Платформа
texCloud = loadBMP "img/cloud.bmp"

texSpikes :: IO Picture   -- | Шипы
texSpikes = loadBMP "img/spike.bmp"