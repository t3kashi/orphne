module Levels.Level1 where

import Engine.CommonTypes
import Engine.Constants



level1Init :: GameState
level1Init = GameState
    { idlvl          = 1
    , player           = initHero
    , leftState      = False
    , rightState     = False
    , upState        = False
    , earth          = initEarth
    , platforms      = initPlatforms
    , spikes         = initSpikes
    , clouds         = []
    , grav           = 0
    , goal           = initGoal
    , cameraY        = 0
    , cameraX        = defaultWall
    , totalTime      = 0
    , death          = False
    , end            = False
    , complete       = False
    }

initEarth :: Platform
initEarth = Platform { ppos = (0, -350), psize = (1200, 100), ptype = Earth }

initHero :: Player
initHero = Player {   playerPos       = (-190, (earthLineAbsPos + halfPlayerHeight))
                    , playerVel       = (0, 0)
                    , onGround        = False
                    , dead            = False
                 }

initGoal :: Goal
initGoal = Goal { goalPos = (340, -230) }

initPlatforms :: [Platform]
initPlatforms = [  pConstruct (-100, -250) 70 Pltfrm
                 , pConstruct (20, -190)   90 Pltfrm
                 , pConstruct (230, -150) 70 Pltfrm
                 , pConstruct (370, -100) 80 Pltfrm
                 ]

initSpikes :: [Platform]
initSpikes = [  pConstruct (110, -296) 40 Spike
              , pConstruct (60, -296) 40 Spike
              , pConstruct (160, -296) 40 Spike
              , pConstruct (210, -296) 40 Spike
              , pConstruct (260, -296) 40 Spike
              , pConstruct (310, -296) 40 Spike
              , pConstruct (360, -296) 40 Spike
          ]