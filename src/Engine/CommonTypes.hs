module Engine.CommonTypes where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Engine.Constants

type Position = (Float, Float)         -- | Позиция объекта

type PlatformSize = (Float, Float)     -- | Размер платформ

data GameState = GameState
    { idlvl          :: Float          -- | номер уровня
    , player         :: Player         -- | игрок
    , leftState      :: Bool           -- | нажата ли кнопка передвижения влево
    , rightState     :: Bool           -- | нажата ли кнопка передвижения вправо
    , upState        :: Bool           -- | нажата ли кнопка передвижения вверх
    , earth          :: Platform       -- | положение землии
    , platforms      :: [Platform]     -- | список платформ
    , spikes         :: [Platform]     -- | список шипов
    , clouds         :: [Platform]
    , grav           :: Float
    , goal           :: Goal           -- | цель
    , cameraY        :: Float          -- | позиция камеры
    , cameraX        :: (Float, Float) -- | границы уровня слева и справа
    , totalTime      :: Float          -- | время
    , death          :: Bool           -- | СМЭРТЬ
    , end            :: Bool           -- | конец уровня
    , complete       :: Bool           -- | конец игры (победа)
    }

-- | Платформа
data Platform = Platform
    {   ppos   :: Position
      , psize  :: PlatformSize
      , ptype  :: PlatformType
     }

-- | Цель
data Goal = Goal { goalPos :: Position }

-- | Тип платформы (земля included)
data PlatformType =  Pltfrm
                   | Earth
                   | Spike
                   | Cloud
     deriving Eq

-- | Игрок
data Player = Player
    {   playerPos       :: Position          -- | позиция игрока
      , playerVel       :: (Float, Float)    -- | скорость передвижения
      , onGround        :: Bool              -- | находится ли на земле
      , dead            :: Bool              -- | приземлился ли на шипы
    }

-- | Создание одной платформы
pConstruct :: Position -> Float -> PlatformType -> Platform
pConstruct pos wi tp = Platform { ppos = pos, psize = (wi, constPlatformThick), ptype = tp }
