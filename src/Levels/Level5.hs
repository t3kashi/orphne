module Levels.Level5 where

import Engine.CommonTypes
import Engine.Constants

level5Init :: GameState
level5Init = GameState
    { idlvl          = 5
    , player         = initHero
    , leftState      = False
    , rightState     = False
    , upState        = False
    , earth          = initEarth
    , platforms      = initPlatforms
    , spikes         = initSpikes
    , clouds         = initClouds
    , grav           = 3
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
initHero = Player {   playerPos     = (500, (earthLineAbsPos + halfPlayerHeight + 1200))
                    , playerVel     = (0, 0)
                    , onGround      = False
                    , dead          = False
                 }

initGoal :: Goal
initGoal = Goal { goalPos = (50, -265) }

initPlatforms :: [Platform]
initPlatforms = [  pConstruct (500, 600) 70 Pltfrm
                 , pConstruct (220, 600) 90 Pltfrm
                 , pConstruct (-100, 10) 10 Pltfrm


              , pConstruct (-50, 300) 10 Pltfrm
              , pConstruct (0, 300) 40 Pltfrm
              , pConstruct (-130, 300) 60 Pltfrm
                 ]

initSpikes :: [Platform]
initSpikes = [  pConstruct (-580, 500) 40 Spike
              , pConstruct (-520, 500) 40 Spike
              , pConstruct (-470, 500) 40 Spike
              , pConstruct (-410, 500) 40 Spike
              , pConstruct (-350, 500) 40 Spike
              , pConstruct (-290, 500) 40 Spike
              , pConstruct (-230, 500) 40 Spike
              , pConstruct (-170, 500) 40 Spike
              , pConstruct (-110, 500) 40 Spike
              , pConstruct (-50, 500) 40 Spike
              , pConstruct (0,   500) 40 Spike
              , pConstruct (580, 500) 40 Spike
              , pConstruct (520, 500) 40 Spike
              , pConstruct (470, 500) 40 Spike
              , pConstruct (410, 500) 40 Spike
              , pConstruct (350, 500) 40 Spike
              , pConstruct (290, 500) 40 Spike
              , pConstruct (230, 500) 40 Spike
              , pConstruct (170, 500) 40 Spike
              , pConstruct (110, 500) 40 Spike



              ,  pConstruct (-580, 300) 40 Spike
              , pConstruct (-520, 300) 40 Spike
              , pConstruct (-470, 300) 40 Spike
              , pConstruct (-410, 300) 40 Spike
              , pConstruct (-350, 300) 40 Spike
              , pConstruct (-290, 300) 40 Spike
              , pConstruct (-230, 300) 40 Spike


              , pConstruct (50, 300) 40 Spike
              , pConstruct (580, 300) 40 Spike
              , pConstruct (520, 300) 40 Spike
              , pConstruct (470, 300) 40 Spike
              , pConstruct (410, 300) 40 Spike
              , pConstruct (350, 300) 40 Spike
              , pConstruct (290, 300) 40 Spike
              , pConstruct (230, 300) 40 Spike
              , pConstruct (170, 300) 40 Spike
              , pConstruct (110, 300) 40 Spike

              , pConstruct (-580, 0) 40 Spike
              , pConstruct (-520, 0) 40 Spike
              , pConstruct (-470, 0) 40 Spike
              , pConstruct (-410, 0) 40 Spike
              , pConstruct (-350, 0) 40 Spike
              , pConstruct (-290, 0) 40 Spike
              --, pConstruct (-230, 0) 40 Spike
              , pConstruct (-170, 0) 40 Spike
              , pConstruct (-110, 0) 40 Spike
              , pConstruct (-50, 0) 40 Spike
              , pConstruct (0, 0) 40 Spike
              , pConstruct (580, 0) 40 Spike
              , pConstruct (520, 0) 40 Spike
              , pConstruct (470, 0) 40 Spike
              , pConstruct (410, 0) 40 Spike
              , pConstruct (350, 0) 40 Spike
              , pConstruct (290, 0) 40 Spike
              , pConstruct (230, 0) 40 Spike
              , pConstruct (170, 0) 40 Spike
              , pConstruct (110, 0) 40 Spike
              , pConstruct (50, 0) 40 Spike

              , pConstruct (90, -296) 40 Spike
              ]

initClouds :: [Platform]
initClouds = [   pConstruct (350, 680) 90 Cloud
               ]
