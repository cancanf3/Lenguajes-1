module Imagen
  ( hSplit, vSplit
  , colorPromedio
  )
  where

import Graphics.Mosaico.Imagen (Color(Color, rojo, verde, azul), Imagen(Imagen, altura, anchura, datos))
import Data.List (genericDrop, genericTake, genericIndex, genericLength)


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
colorPromedio (Imagen anchura' altura' color) = Color {rojo = fromInteger ((rojoSuma todo)`div`cantidad) , verde = fromInteger ((verdeSuma todo)`div`cantidad), azul = fromInteger ((azulSuma todo)`div`cantidad) }
    where todo = [ genericIndex (genericIndex color y) x | y <- [0..(altura'-1)], x <- [0..(anchura'-1)] ]
          cantidad = genericLength todo

rojoSuma :: [Color] -> Integer
rojoSuma []                 = 0
rojoSuma (Color r _ _:xs)   = toInteger(r) + rojoSuma xs 
verdeSuma :: [Color] -> Integer
verdeSuma []                 = 0
verdeSuma ((Color _ v _):xs) = toInteger(v) + verdeSuma xs 
azulSuma :: [Color]  -> Integer
azulSuma []                  = 0
azulSuma ((Color _ _ a):xs)  = toInteger(a) + azulSuma xs 
