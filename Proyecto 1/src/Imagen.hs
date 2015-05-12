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

subImagen xInicial yInicial anchura' altura' (Imagen anchura'' altura'' pixels) = Imagen anchura' altura' [ take anchura' (drop xInicial (color!!x)) | x <- [yInicial..altura'] ]



hSplit :: Imagen -> (Imagen, Imagen)
hSplit = undefined

vSplit :: Imagen -> (Imagen, Imagen)
vSplit = undefined

colorPromedio :: Imagen -> Color
colorPromedio = undefined
