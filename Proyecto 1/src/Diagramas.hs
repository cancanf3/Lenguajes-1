module
  Diagramas
  ( rectánguloImagen
  , Orientación(Horizontal, Vertical)
  , dividir
  , caminar
  , sustituir
  )
  where

import Graphics.Mosaico.Diagrama (Diagrama((:-:), (:|:), Hoja), Paso(Primero, Segundo), Rectángulo(Rectángulo, color, imagen))
import Graphics.Mosaico.Imagen   (Imagen(Imagen, altura, anchura, datos))

import Imagen (colorPromedio, hSplit, vSplit)



rectánguloImagen :: Imagen -> Rectángulo
rectánguloImagen imagen' = Rectángulo {color = colorPromedio imagen', imagen = imagen'} 

data Orientación
  = Horizontal
  | Vertical
  deriving Show

vefImagen :: Maybe Diagrama -> Maybe Diagrama
vefImagen _ d1 :-: d2       = if (vefImagen d1) == Nothing || (vefImagen d2) == Nothing
                                 then Nothing
                                 else Maybe d1 :-: d2
vefImagen _ d1 :|: d2       = if (vefImagen d1) == Nothing || (vefImagen d2) == Nothing
                                 then Nothing
                                 else Maybe d1 :|: d2
vefImagen _ Hoja Rectángulo colorP Imagen anchura' altura' color = if (anchura' < 2) || (altura' < 2)
                                                         then Nothing
                                                         else Maybe Hoja Rectángulo colorPS Imagen anchura' altura' color


dividir :: Orientación -> Rectángulo -> Maybe Diagrama
dividir orientación Rectángulo _ imagen
  | orientación == Horizontal = vefImagen Maybe (Hoja Rectángulo (colorPromedio h1) h1 :|: Hoja Rectángulo (colorPromedio h2) h2)
  | orientación == Vertical   = vefImagen Maybe (Hoja Rectángulo (colorPromedio v1) v1 :-: Hoja Rectángulo (colorPromedio v2) v2)
  where (h1,h2) = hSplit imagen
        (v1,v2) = vSplit imagen

caminar :: [Paso] -> Diagrama -> Maybe Diagrama
caminar [] diagrama = Maybe diagrama
caminar (x:xs) Hoja _ = Nothing
caminar (x:xs) d1 op d2
  x == Primero = caminar xs d1
  x == Segundo = caminar xs d2

sustituir :: Diagrama -> [Paso] -> Diagrama -> Diagrama
sustituir = undefined
