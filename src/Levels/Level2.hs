module Levels.Level2 where

import Engine.CommonTypes
import Engine.Constants

level2Init :: GameState
level2Init = GameState
    { idlvl          = 2
    , player         = initHero
    , leftState      = False
    , rightState     = False
    , upState        = False
    , earth          = initEarth
    , platforms      = initPlatforms
    , spikes         = initSpikes
    , clouds         = []
    , grav           = 0
    , goal           = initGoal
    , cameraY      = 0
    , cameraX        = defaultWall
    , totalTime      = 0
    , death          = False
    , end            = False
    , complete       = False
    }

initEarth :: Platform
initEarth = Platform { ppos = (0, -350), psize = (1200, 100), ptype = Earth }

initHero :: Player
initHero = Player {   playerPos       = (-500, (earthLineAbsPos + halfPlayerHeight))
                    , playerVel       = (0, 0)
                    , onGround      = False
                    , dead          = False
                 }

initGoal :: Goal
initGoal = Goal { goalPos = (400, -200) }

initPlatforms :: [Platform]
initPlatforms = [  pConstruct (-550, -250) 50 Pltfrm
                 , pConstruct (-360, -200) 80 Pltfrm
                 , pConstruct (-145, -140) 80 Pltfrm
                 ]

initSpikes :: [Platform]
initSpikes = [  pConstruct (580, -296) 42 Spike
              , pConstruct (560, -296) 42 Spike
              , pConstruct (-580, -296) 42 Spike
              , pConstruct (-560, -296) 42 Spike
              , pConstruct (-160, -296) 42 Spike
              , pConstruct (-200, -296) 42 Spike

              , pConstruct (-140, -296) 42 Spike
              , pConstruct (-120, -296) 42 Spike
              , pConstruct (-100, -296) 42 Spike
              , pConstruct (-80, -296) 42 Spike
              , pConstruct (-60, -296) 42 Spike
              , pConstruct (-40, -296) 42 Spike
              , pConstruct (-20, -296) 42 Spike
              , pConstruct (0, -296) 42 Spike

              , pConstruct (540, -296) 42 Spike
              , pConstruct (520, -296) 42 Spike
              , pConstruct (500, -296) 42 Spike
              , pConstruct (480, -296) 42 Spike
              , pConstruct (460, -296) 42 Spike
              , pConstruct (440, -296) 42 Spike
              , pConstruct (420, -296) 42 Spike
              , pConstruct (400, -296) 42 Spike
              , pConstruct (380, -296) 42 Spike
              , pConstruct (360, -296) 42 Spike
              , pConstruct (340, -296) 42 Spike
              , pConstruct (320, -296) 42 Spike
              , pConstruct (300, -296) 42 Spike
              , pConstruct (280, -296) 42 Spike
              , pConstruct (260, -296) 42 Spike
              , pConstruct (240, -296) 42 Spike
              , pConstruct (220, -296) 42 Spike
              , pConstruct (200, -296) 42 Spike
              , pConstruct (180, -296) 42 Spike
              , pConstruct (160, -296) 42 Spike
              , pConstruct (140, -296) 42 Spike
              , pConstruct (120, -296) 42 Spike
              , pConstruct (100, -296) 42 Spike
              , pConstruct (80, -296) 42 Spike
              , pConstruct (60, -296) 42 Spike
              , pConstruct (40, -296) 42 Spike
              , pConstruct (20, -296) 42 Spike
              ]
