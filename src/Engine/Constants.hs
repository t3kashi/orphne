module Engine.Constants where

maxLVL :: Float -- | Максимальное количество уровней
maxLVL = 5

gravity :: Float -- | Гравитация
gravity = -10

jumpVel :: Float -- | Скорость прыжка
jumpVel = 350

velocity :: Float     -- | Сорость передвиижения вбок
velocity = 1

maxSideSpeed :: Float -- | Максимальная скорость движения вбок
maxSideSpeed = 20

sideSpeed :: Float   -- | + вектор движения вбок
sideSpeed = 3

playerImgSize :: (Float, Float) -- | Размер хиитбокса персонважа
playerImgSize = (30, 67)

playerHeight :: Float             -- | Высота хитбокса
playerHeight = snd playerImgSize

playerWidth :: Float              -- | Ширина хитбокса
playerWidth = fst playerImgSize

halfPlayerHeight :: Float        -- | Половина хиитбокса
halfPlayerHeight = playerHeight / 2

constPlatformThick :: Float -- | Стандартная ширина для платформы
constPlatformThick = 8

constPlatformWidth :: Float -- | Стандартная длина для платформы
constPlatformWidth = 40

earthLineAbsPos :: Float   -- | стандартный уровень земли
earthLineAbsPos = -300

defaultWall :: (Float, Float)  -- | границы передвиижения персонажа по X
defaultWall = (-600 + playerWidth / 2, 600 - playerWidth / 2)
-- for testing

thresholdTop :: Float -- | перемещение камеры вверх
thresholdTop = 90

thresholdBottom :: Float -- | перемещение камеры вниз
thresholdBottom = -90

goalSize :: (Float, Float) -- | Хитбокс цели
goalSize = (35, 70)