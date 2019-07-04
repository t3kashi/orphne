module Engine.Engine where

import Graphics.Gloss.Interface.Pure.Game

import Engine.CommonTypes
import Engine.Constants
import Levels.Level1
import Levels.Level2
import Levels.Level3
import Levels.Level4
import Levels.Level5

-- | Обрабатываем нажатие клавиш * fromIntegral (fromEnum (complete state))
handleInput :: Event -> GameState -> GameState
handleInput e state = playerMovement e state

evalStats :: Bool -> Bool -> Float
evalStats x y  | (x && y)         = 1
               | otherwise        = 0


-- | Назначаем действия на клавишы
playerMovement :: Event -> GameState -> GameState
playerMovement (EventKey (Char 'd') Down _ _) state =
    state { player = currPlayer { playerVel = (velocity, vy)  } , rightState = True && ((not (complete state)) && (not (death state))) }
        where
            currPlayer = player state
            (_, vy)  = playerVel currPlayer
playerMovement (EventKey (Char 'a') Down _ _) state =
    state { player = currPlayer { playerVel = (-velocity, vy) } , leftState = True && (not (complete state)) && (not (death state)) }
        where
            currPlayer = player state
            (_, vy) = playerVel currPlayer

playerMovement (EventKey (Char 'd') Up _ _) state =
    state { rightState = False }
playerMovement (EventKey (Char 'a') Up _ _) state =
    state { leftState = False }
playerMovement (EventKey (Char 'w') Down _ _) state =
    state { upState = True }
playerMovement (EventKey (Char 'w') Up _ _) state =
    state { upState = False }
playerMovement (EventKey (Char 'r') Up _ _) state =
    stateIn
      where
        ii = idlvl state
        stateIn
             | ii == 1 = level1Init
             | ii == 2 = level2Init
             | ii == 3 = level3Init
             | ii == 4 = level4Init
             | ii == 5 = level5Init
playerMovement (EventKey (Char '1') Up _ _) state = level1Init
playerMovement (EventKey (Char '2') Up _ _) state = level2Init
playerMovement (EventKey (Char '3') Up _ _) state = level3Init
playerMovement (EventKey (Char '4') Up _ _) state = level4Init
playerMovement (EventKey (Char '5') Up _ _) state = level5Init
playerMovement _ state = state

-- | Обновление позиций объектов в кадре
motion :: Float -> GameState -> GameState
motion s state = state { player = player', cameraY = sa', totalTime = (totalTime state) + 1 }
        where
            player'      = movePlayer s state
            (hx, hy) = playerPos $ player state

            sa = cameraY state -- | Движение камеры вверх/вниз
            satemp
                | hy > thresholdTop + sa     = (hy - thresholdTop)
                | hy < thresholdBottom + sa  = (hy - thresholdBottom)
                | otherwise                  = sa
            sa'
                | satemp < 0                 = 0
                | otherwise                  = satemp

-- | Обработка движения персонажа
movePlayer :: Float -> GameState -> Player
movePlayer s state = currPlayer { playerPos = (x', y') , playerVel = (vx', vy') , onGround = grounded', dead = isSpiked }
    where
        currPlayer = player state
        (x, y)   = playerPos currPlayer
        (vx, vy) = playerVel currPlayer
        (leftWall, rightWall) = cameraX state
        left     = leftState state
        right    = rightState state
        jump     = upState state
        grounded = onGround currPlayer

        -- | Определение новых возможных координат
        xtemp     | x + (vx * s) <= leftWall = leftWall
                  | x + (vx * s) >= rightWall = rightWall
                  | otherwise                 = x + (vx * s)
        ytemp     = y + (vy * s)

        -- | Падение на шиипы
        topColSpike  = fst (isGrounded currPlayer (xtemp, ytemp) (spikes state))
        botColSpike  = fst $ fst (collideObj currPlayer (xtemp, ytemp) (spikes state))
        sideColSpike = snd $ fst (collideObj currPlayer (xtemp, ytemp) (spikes state))
        isSpiked  = topColSpike || botColSpike || sideColSpike

        -- | Находимся ли на платформе
        posInfo   = isGrounded currPlayer (xtemp, ytemp) ((earth state) : (platforms state) ++ (clouds state))
        grounded' = fst posInfo
        (xtemp', ytemp') = snd posInfo
        colPosInfo  = collideObj currPlayer (xtemp', ytemp') ((earth state) : (platforms state) ++ (spikes state))
        (x', y')  = snd colPosInfo
        collided = fst colPosInfo

        -- | Движение вбок (с помощью клавиатуры)
        vxtemp = 0
        vx'
            | snd collided = 0
            | vxtemp <  maxSideSpeed && vxtemp >= 0 && right       = (vx + sideSpeed) * (evalStats (not (complete state)) (not (death state))) -- | + проверка на конец игры/смерть. везде.
            | vxtemp > -maxSideSpeed && vxtemp <= 0 && left        = (vx - sideSpeed) * (evalStats (not (complete state)) (not (death state)))
            | otherwise                                            = vxtemp * (evalStats (not (complete state)) (not (death state)))

        vytemp
            | fst collided = 0
            | otherwise = vy + gravity + (grav state) -- | Гравитация
        vy' -- | Движение вверх/вниз (с помощью клавиатуры)
            | grounded && jump                        = jumpVel * (evalStats (not (complete state)) (not (death state)))
            | grounded && not jump                    = 0
            | not grounded && not jump && vytemp > 0  = vytemp * (evalStats (not (complete state)) (not (death state)))
            | otherwise                               = vytemp * (evalStats (not (complete state)) (not (death state)))


collideObj :: Player -> Position -> [Platform] -> ( (Bool, Bool), Position)
collideObj currPlayer (x', y') [] = ((False, False), (x', y'))
collideObj currPlayer (x', y') ps
    | (fst $ fst platColl) || (snd $ fst platColl) = platColl
    | otherwise     = collideObj currPlayer (x', y') remainingPlatforms
        where
            (x, y) = playerPos currPlayer
            grounded = onGround currPlayer
            currPlayerHeight = halfPlayerHeight


            currPlatform = head ps
            currType = ptype currPlatform
            remainingPlatforms = tail ps

            (platPosX, platPosY) = ppos currPlatform
            (platWidth, platHeight) = psize currPlatform

            platTop    = platPosY + 2 + platHeight / 2
            platBottom = platPosY - 2 - platHeight / 2
            rightEdge  = platPosX + 2 + platWidth / 2
            leftEdge   = platPosX - 2 - platWidth / 2

            platColl | y <= platBottom - currPlayerHeight  -- | подходим снизу
                       && y' >= platBottom - currPlayerHeight
                       && x' > leftEdge - (playerWidth / 6)
                       && x' < rightEdge + (playerWidth / 6)
                       && (currType == Pltfrm || currType == Spike) = ( (True, False), (x',y))

                     | x <= leftEdge - (playerWidth / 4)  -- | подходим слева
                      && x' >= leftEdge - (playerWidth /4)
                      && y' > platBottom - currPlayerHeight
                      && y' < platTop + currPlayerHeight
                      && (currType == Pltfrm || currType == Spike) = ((False, True), (x,y'))

                     | x >= rightEdge + (playerWidth / 4)  -- | подходим справа
                      && x' <= rightEdge + (playerWidth / 4)
                      && y' > platBottom - currPlayerHeight
                      && y' < platTop + currPlayerHeight
                      && (currType == Pltfrm || currType == Spike) = ((False,True), (x,y') )
                     | otherwise = ( (False, False), (x',y') )

-- | Проверяем приземление
isGrounded :: Player -> Position -> [Platform] -> (Bool, Position)
isGrounded currPlayer (x', y') [] = (False, (x', y'))
isGrounded currPlayer (x', y') (p:ps)
    | onPlatform    = ( True, (x', platTop + halfPlayerHeight) )
    | otherwise     = isGrounded currPlayer (x', y') ps
        where
            (x, y) = playerPos currPlayer  -- | Позииция до пересечения
            grounded = onGround currPlayer
            y'cr = y'
            ycr = y
            currPlatform = p
            (platPosX, platPosY)    = ppos currPlatform
            (platWidth, platHeight) = psize currPlatform

            -- | Если более чем на 2/3 находится не над платформой -- не приземляется/падает
            platTop    = platPosY + platHeight / 2
            platBottom = platPosY - platHeight / 2
            rightEdge  = platPosX + platWidth / 2
            leftEdge   = platPosX - platWidth / 2
            onPlatform  = ( ycr >= platTop + halfPlayerHeight
                          && y'cr <= platTop + halfPlayerHeight
                          && x' > leftEdge - (playerWidth / 6)
                          && x' < rightEdge + (playerWidth / 6) )

-- | Проверяем условие смерти
checkDeath :: GameState -> GameState
checkDeath state
    | death state = state { complete = dd }
    | otherwise = state { death = dd }
        where
            currPlayer       = player state
            dd               = dead currPlayer

-- | Проверяем достижение цели
checkGoal :: GameState -> GameState
checkGoal state
   | end state && not (complete state) && (idlvl state) >= maxLVL = state { complete = inGoal, death = False }
   | end state && not (complete state) && (idlvl state) == 2 = level3Init {end = False}
   | end state && not (complete state) && (idlvl state) == 1 = level2Init {end = False}
   | end state && not (complete state) && (idlvl state) == 3 = level4Init {end = False}
   | end state && not (complete state) && (idlvl state) == 4 = level5Init {end = False}
   | otherwise = state { end = inGoal }
       where
          currGoal              = goal state
          (hx, hy)              = playerPos (player state)
          (gx, gy)              = goalPos currGoal
          (goalWid, goalHeight) = goalSize

          top        = gy + goalHeight / 2 + 3
          bottom     = gy - goalHeight / 2 - 3
          rightEdge  = gx + goalWid / 2 + 3
          leftEdge   = gx - goalWid / 2 - 3

          inGoal = hx >= leftEdge  &&  hx <= rightEdge  &&  hy >= bottom  && hy <= top

-- | Вспомогательная функция. Возвращает число, если передана правда, иначе -- 0
takeIf :: Float -> Bool -> Float
takeIf x b  | b         = x
            | otherwise = 0

-- | Переходим на новый кадр
update :: Float -> GameState -> GameState
update seconds = checkDeath . checkGoal . motion seconds