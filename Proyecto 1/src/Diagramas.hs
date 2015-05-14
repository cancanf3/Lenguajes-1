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

import Imagen (colorPromedio, hSplit, vSplit, colorAltura, colorAnchura)



rectánguloImagen :: Imagen -> Rectángulo
rectánguloImagen imagen' = Rectángulo {color = colorPromedio imagen', imagen = imagen'} 

data Orientación
  = Horizontal
  | Vertical
  deriving Show



dividir :: Orientación -> Rectángulo -> Maybe Diagrama
dividir orientación (Rectángulo _ imagen) = case orientación of Horizontal -> if ((colorAltura h1) < 2) || ((colorAltura h2) < 2)
                                                                              then Just (Hoja (Rectángulo (colorPromedio h1) h1) :|: Hoja (Rectángulo (colorPromedio h2) h2))
                                                                              else Nothing
                                                                Vertical   -> if ((colorAnchura h1) < 2) || ((colorAnchura h2) < 2)
                                                                              then Just (Hoja (Rectángulo (colorPromedio v1) v1) :-: Hoja (Rectángulo (colorPromedio v2) v2))
                                                                              else Nothing
  where (h1,h2) = hSplit imagen
        (v1,v2) = vSplit imagen

caminar :: [Paso] -> Diagrama -> Maybe Diagrama
caminar [] diagrama     = Just diagrama
caminar (x:xs) (Hoja _) = Nothing
caminar (x:xs) (d1 :|: d2) = case x of Primero -> caminar xs d1
                                       Segundo -> caminar xs d2
caminar (x:xs) (d1 :-: d2) = case x of Primero -> caminar xs d1
                                       Segundo -> caminar xs d2

sustituir :: Diagrama -> [Paso] -> Diagrama -> Diagrama
sustituir = undefined
