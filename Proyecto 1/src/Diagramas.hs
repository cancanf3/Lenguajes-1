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

import Imagen (subImagen, colorPromedio, hSplit, vSplit, colorAltura, colorAnchura)



rectánguloImagen :: Imagen -> Rectángulo
rectánguloImagen imagen' = Rectángulo {color = colorPromedio imagen', imagen = imagen'} 

data Orientación
  = Horizontal
  | Vertical
  deriving Show



dividir :: Orientación -> Rectángulo -> Maybe Diagrama
dividir orientación (Rectángulo _ imagen) = case orientación of Horizontal -> if ((colorAltura h1) >= 2) || ((colorAltura h2) >= 2)
                                                                              then Just (Hoja (rectánguloImagen h1) :-: (Hoja (rectánguloImagen h2)))
                                                                              else Nothing
                                                                Vertical   -> if ((colorAnchura v1) >= 2) || ((colorAnchura v2) >= 2)
                                                                              then Just (Hoja (rectánguloImagen v1) :|: (Hoja (rectánguloImagen v2)))
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
sustituir ds [] _ = ds
sustituir ds (x:[]) (d1 :|: d2) = case x of Primero -> (ds :|: d2)
                                            Segundo -> (d1 :|: ds)
sustituir ds (x:[]) (d1 :-: d2) = case x of Primero -> (ds :-: d2)
                                            Segundo -> (d1 :-: ds)
sustituir ds (x:xs) (d1 :|: d2) = case x of Primero -> (sustituir ds xs d1 :|: d2)
                                            Segundo -> (d1 :|: sustituir ds xs d2)
sustituir ds (x:xs) (d1 :-: d2) = case x of Primero -> (sustituir ds xs d1 :-: d2)
                                            Segundo -> (d1 :-: sustituir ds xs d2)
sustituir _ _ (Hoja _)    = error "La lista de pasos no concuerda con la estructura provista"

