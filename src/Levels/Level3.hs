module Levels.Level3 where

import Engine.CommonTypes
import Engine.Constants

level3Init :: GameState
level3Init = GameState
    { idlvl          = 3
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
initHero = Player {   playerPos     = (-300, (earthLineAbsPos + halfPlayerHeight))
                    , playerVel     = (0, 0)
                    , onGround      = False
                    , dead          = False
                 }

initGoal :: Goal
initGoal = Goal { goalPos = (460, -260) }

initPlatforms :: [Platform]
initPlatforms = [  pConstruct (250, -200) 90 Pltfrm
                 , pConstruct (250, -260) 90 Pltfrm

                 , pConstruct (-450, -250) 160 Pltfrm
                 , pConstruct (-560, -200) 100 Pltfrm
                 , pConstruct (-430, -137) 10 Pltfrm
                 , pConstruct (-390, -97) 10 Pltfrm

                 , pConstruct (-350, -57) 10 Pltfrm
                 , pConstruct (-310, -17) 10 Pltfrm

                 , pConstruct (-257, -7) 16 Pltfrm
                 , pConstruct (-223, 24) 10 Pltfrm

                 , pConstruct (-167, -30) 30 Pltfrm
                 , pConstruct (-102, -14) 10 Pltfrm

                 , pConstruct (10, -7) 60 Pltfrm
                 , pConstruct (140, 18) 40 Pltfrm
                 ]

initSpikes :: [Platform]
initSpikes = [  pConstruct (410, -296) 42 Spike
              , pConstruct (510, -296) 42 Spike
              , pConstruct (530, -296) 40 Spike
              , pConstruct (550, -296) 40 Spike
              , pConstruct (570, -296) 40 Spike
              , pConstruct (590, -296) 40 Spike
              , pConstruct (390, -296) 40 Spike
              , pConstruct (370, -296) 40 Spike
              , pConstruct (350, -296) 40 Spike




              ]