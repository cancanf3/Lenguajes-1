module Imagen
  ( hSplit, vSplit
  , colorPromedio
  )
  where

import Graphics.Mosaico.Imagen (Color(Color, rojo, verde, azul), Imagen(Imagen, altura, anchura, datos))



subImagen
  :: Integer -> Integer
  -> Integer -> Integer
  -> Imagen -> Imagen

subImagen xInicial yInicial anchura' altura' = Imagen anchura' altura' [[Color | x <- [0..anchura' - xInicial] | y <- [0..altura' - yInicial] ]]



hSplit :: Imagen -> (Imagen, Imagen)
hSplit = undefined

vSplit :: Imagen -> (Imagen, Imagen)
vSplit = undefined

colorPromedio :: Imagen -> Color
colorPromedio = undefined
