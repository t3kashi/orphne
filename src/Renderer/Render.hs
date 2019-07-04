module Renderer.Render where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Renderer.VisualConstants
import Engine.CommonTypes
import Engine.Constants

-- |////////////          Окно
newWindow :: Display
newWindow = InWindow windowName initialWindowDimensions initialWindowPosition

atmosphere :: Picture -- | Фон
atmosphere = color (greyN 0.97) $ rectangleSolid 1200 800

drawGoal :: Goal -> Picture -> Picture   -- | Рисуем цель
drawGoal g goal = uncurry translate (goalPos g) $ goal

drawPlayer :: Player -> Picture -> Picture -- | Рисуем игрока
drawPlayer currPlayer playerImg = uncurry translate ppos $ playerImg
        where
            ppos     = playerPos currPlayer

platToPic :: Picture -> Platform -> Picture -- | Риисуем платформу || землю || шипы
platToPic mp p = uncurry translate (ppos p) $ platPic
    where
        (width, len)  = psize p
        scaleFactorW  = width / constPlatformWidth
        scaleFactorL  = len / constPlatformThick
        platPic
            | (ptype p) == Pltfrm     = scale scaleFactorW scaleFactorL $ mp
            | (ptype p) == Earth      = mp
            | (ptype p) == Spike      = mp
            | (ptype p) == Cloud      = scale scaleFactorW scaleFactorL $ mp

-- | рисуем всё по списку
platformGenerator :: [Platform] -> Picture -> [Picture]
platformGenerator ps bmp = map (platToPic bmp) ps

-- | гамовер screen
endGameScreen :: GameState -> Picture
endGameScreen state = pictures [ failedImg, tip ]
    where
          tip  = translate (-320) (-50) $ scale 1 1 $ Text "YOU DIED."
          failedImg = color (light (light red)) $ rectangleSolid 1200 800

-- | winner winner screen
goodGameScreen :: GameState  -> Picture
goodGameScreen state  = pictures [ failedImg, tip ]
    where
          tip  = translate (-320) (-50) $ scale 1 1 $ Text "YOU WON!"
          failedImg = color (light (light (light green))) $ rectangleSolid 1200 800

-- | Анимация движения персонажа вправо
walkAnimationControlR :: [Picture] -> Int -> Picture
walkAnimationControlR walkAN i
                          | i < 10 = walkAN !! 1
                          | i < 30 =  walkAN !! 2
                          | i < 40 =  walkAN !! 1
                          | otherwise =  walkAN !! 3

-- | Анимация прыжка вправо
walkAnimationControlUPR :: [Picture] -> Int -> Picture
walkAnimationControlUPR walkAN i
                          | i < 30 = walkAN !! 2
                          | otherwise =  walkAN !! 3

-- | Анимация движения персонажа влево
walkAnimationControlL :: [Picture] -> Int -> Picture
walkAnimationControlL walkAN i
                          | i < 10 = walkAN !! 4
                          | i < 30 =  walkAN !! 5
                          | i < 40 =  walkAN !! 4
                          | otherwise =  walkAN !! 6

-- | Анимация прыжка влево
walkAnimationControlUPL :: [Picture] -> Int -> Picture
walkAnimationControlUPL walkAN i
                          | i < 30 = walkAN !! 5
                          | otherwise =  walkAN !! 6


-- | Отрисовка всего
render :: [Picture] -> Picture -> Picture -> Picture -> Picture -> Picture -> GameState -> Picture
render playerImgs goalImg earthImg platform spiik clds state
      | complete state = pictures [ goodGameScreen state ] -- | персонаж выиграл
      | death state   = pictures [ endGameScreen state  ]  -- | персонаж умер
      | upState state && leftState state  = pictures [ atmosphere, currEarth, currGoal, pictures pltfrms, pictures cluds, picPlayerUPL, pictures spi ] -- | прыжок влево
      | upState state && rightState state = pictures [ atmosphere, currEarth, currGoal, pictures pltfrms, pictures cluds,  picPlayerUPR,  pictures spi ] -- | прыжок вправо
      | upState state  = pictures [ atmosphere, currEarth, currGoal,   pictures pltfrms, pictures cluds,  picPlayerUP, pictures spi ]   -- | прыжок вверх
      | rightState state = pictures [ atmosphere, currEarth, currGoal, pictures pltfrms, pictures cluds, walkRight, pictures spi ] -- | движения вправо
      | leftState state = pictures [ atmosphere, currEarth, currGoal,  pictures pltfrms, pictures cluds,  walkLeft, pictures spi ]   -- | движение влево
      | otherwise = pictures [ atmosphere, currEarth, currGoal, pictures pltfrms, pictures cluds, picPl, pictures spi ]          -- | стоим на месте
        where
            state'        = scroll state (cameraY state)
            st            = totalTime state'
            picPl         = drawPlayer (player state') (playerImgs !! 0)
            picPlayerUP   = drawPlayer (player state') (playerImgs !! 2)
            picPlayerUPL  = drawPlayer (player state') (walkAnimationControlUPL playerImgs ((round st) `mod` 60))
            picPlayerUPR  = drawPlayer (player state') (walkAnimationControlUPR playerImgs ((round st) `mod` 60))
            walkRight     = drawPlayer (player state') (walkAnimationControlR playerImgs ((round st) `mod` 60))
            walkLeft      = drawPlayer (player state') (walkAnimationControlL playerImgs ((round st) `mod` 60))
            currGoal      = drawGoal (goal state') goalImg
            currEarth     = platToPic earthImg (earth state')
            pltfrms       = platformGenerator (platforms state') platform
            spi           = platformGenerator (spikes state') spiik
            cluds        = platformGenerator (clouds state') clds

-- | Меняем позицию всех объектов относительно игрока
scroll :: GameState -> Float -> GameState
scroll state trans = state {   player = player' , platforms = platforms', goal = goal'
                             , earth = earth', spikes = spikes', clouds = clds }
    where
        (hx, hy)   = playerPos $ player state
        player'    = (player state) { playerPos = (hx, hy - trans) }
        platforms' = map (\p -> p { ppos = changeY (ppos p) trans }) (platforms state)
        earth'     = (\e -> e { ppos = changeY (ppos e) trans }) $ earth state
        spikes'    = map (\p -> p { ppos = changeY (ppos p) trans }) (spikes state)
        goal'      = (\g -> g { goalPos = changeY (goalPos g) trans }) $ goal state
        clds       = map (\p -> p { ppos = changeY (ppos p) trans }) $ clouds state

-- | вспомогательная функция
changeY :: Position -> Float -> Position
changeY (x, y) z = (x, y - z)
