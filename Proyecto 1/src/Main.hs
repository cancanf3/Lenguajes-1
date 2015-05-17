module Main (main) where

import Graphics.Mosaico.Diagrama (Diagrama((:-:), (:|:), Hoja), Paso(Primero, Segundo))
import Graphics.Mosaico.Imagen   (Imagen(Imagen, altura, anchura, datos), leerImagen)
import Graphics.Mosaico.Ventana  (Ventana, cerrar, crearVentana, leerTecla, mostrar)

import Diagramas (Orientación(Horizontal, Vertical), caminar, dividir, rectánguloImagen, sustituir)

import System.Environment (getArgs)



ciclo :: Ventana -> Diagrama -> [Paso] -> IO ()
ciclo v raiz pasos = do
		mostrar v pasos raiz
		tecla <- leerTecla v
		case tecla of 
			(Just "Up") -> case actual of
				(Just (Hoja rect)) -> case dividirH rect of
					(Just diag) -> ciclo v (sustituir diag pasos raiz) (pasos++[Primero])
					Nothing -> ciclo v raiz pasos
				(Just (_ :-: _)) -> ciclo v raiz (pasos++[Primero])
				(Just (_ :|: _)) -> ciclo v raiz pasos
				Nothing -> error "Quedan pasos y no más arbol que recorrer"
			(Just "Down") -> case actual of
				(Just (Hoja rect)) -> case dividirH rect of
					(Just diag) -> ciclo v (sustituir diag pasos raiz) (pasos++[Segundo])
					Nothing -> ciclo v raiz pasos
				(Just (_ :-: _)) -> ciclo v raiz (pasos++[Segundo])
				(Just (_ :|: _)) -> ciclo v raiz pasos
				Nothing -> error "Quedan pasos y no más arbol que recorrer"
			(Just "Left") -> case actual of
				(Just (Hoja rect)) -> case dividirV rect of
					(Just diag) -> ciclo v (sustituir diag pasos raiz) (pasos++[Primero])
					Nothing -> ciclo v raiz pasos
				(Just (_ :-: _)) -> ciclo v raiz pasos
				(Just (_ :|: _)) -> ciclo v raiz (pasos++[Primero])
				Nothing -> error "Quedan pasos y no más arbol que recorrer"
			(Just "Right") -> case actual of
				(Just (Hoja rect)) -> case dividirV rect of
					(Just diag) -> ciclo v (sustituir diag pasos raiz) (pasos++[Segundo])
					Nothing -> ciclo v raiz pasos
				(Just (_ :-: _)) -> ciclo v raiz pasos
				(Just (_ :|: _)) -> ciclo v raiz (pasos++[Segundo])
				Nothing -> error "Quedan pasos y no más arbol que recorrer"
			(Just "BackSpace") -> case pasos of 
				[] -> ciclo v raiz []
				p -> ciclo v raiz (init p)
			(Just "q") -> cerrar v
			(Just _) -> ciclo v raiz pasos
		where
			actual = caminar pasos raiz
			dividirH = dividir Horizontal 
			dividirV = dividir Vertical 

main :: IO ()
main = do
		args <- getArgs
		if(length args /= 1)
			then putStrLn "Falta argumento de la imagen"
		else
			do
				preimg <- leerImagen "foto.jpg"
				case preimg of
					(Left err) -> putStrLn err
					(Right img) -> do
						v <- crearVentana (ancho img) (alto img)
						ciclo v (Hoja (rectánguloImagen img)) []
	where
		ancho (Imagen x _ _) = x
		alto (Imagen _ y _) = y