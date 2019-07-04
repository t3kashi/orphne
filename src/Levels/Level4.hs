module Levels.Level4 where

import Engine.CommonTypes
import Engine.Constants

level4Init :: GameState
level4Init = GameState
    { idlvl          = 4
    , player         = initHero
    , leftState      = False
    , rightState     = False
    , upState        = False
    , earth          = initEarth
    , platforms      = initPlatforms
    , spikes         = initSpikes
    , clouds         = initClouds
    , grav           = 4
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
initHero = Player {   playerPos     = (-500, (earthLineAbsPos + halfPlayerHeight))
                    , playerVel     = (0, 0)
                    , onGround      = False
                    , dead          = False
                 }

initGoal :: Goal
initGoal = Goal { goalPos = (0, 200) }

initPlatforms :: [Platform]
initPlatforms = [  pConstruct (-150, -110) 40 Pltfrm
                 , pConstruct (250, -260) 90 Pltfrm
                 , pConstruct (-100, -210) 10 Pltfrm
                 ]

initSpikes :: [Platform]
initSpikes = [  pConstruct (-320, -200) 40 Spike
              , pConstruct (-180, -200) 40 Spike
              , pConstruct (-160, -296) 40 Spike
              , pConstruct (-110, -296) 40 Spike
              , pConstruct (-60, -296) 40 Spike
              , pConstruct (15, -296) 40 Spike
              , pConstruct (75, -296) 40 Spike
              , pConstruct (130, -296) 40 Spike
              , pConstruct (210, -296) 40 Spike
              , pConstruct (-60, -80) 40 Spike
              , pConstruct (-40, 0) 40 Spike
              ]

initClouds :: [Platform]
initClouds = [   pConstruct (-250, -200) 90 Cloud
               , pConstruct (270, -160) 90 Cloud
               , pConstruct (300, -80) 90 Cloud
               , pConstruct (260, 0) 90 Cloud
               , pConstruct (220, 80) 110 Cloud
               ]
