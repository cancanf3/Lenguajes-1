module Imagen
  ( hSplit, vSplit
  , colorPromedio
  )
  where

import Graphics.Mosaico.Imagen (Color(Color, rojo, verde, azul), Imagen(Imagen, altura, anchura, datos))
import Data.List (genericDrop, genericTake, genericIndex)


subImagen
  :: Integer -> Integer
  -> Integer -> Integer
  -> Imagen -> Imagen

subImagen xInicial yInicial anchura' altura' (Imagen _ _ pixels) = 
    Imagen anchura' altura' [ genericTake anchura' (genericDrop xInicial (genericIndex pixels x)) | x <- [yInicial..altura'] ]



hSplit :: Imagen -> (Imagen, Imagen)
hSplit (Imagen anchura' altura' pixels) = (subImagen 0 (quot altura' 2) anchura' (quot altura' 2) (Imagen anchura' altura' pixels), 
        subImagen 0 0 anchura' (quot altura' 2) (Imagen anchura' altura' pixels))

vSplit :: Imagen -> (Imagen, Imagen)
vSplit (Imagen anchura' altura' pixels) = (subImagen 0 0 (quot anchura' 2) altura' (Imagen anchura' altura' pixels), 
        subImagen (quot anchura' 2) 0 (quot anchura' 2) altura' (Imagen anchura' altura' pixels))

colorPromedio :: Imagen -> Color
colorPromedio = undefined
