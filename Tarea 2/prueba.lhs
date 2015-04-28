> data Expresión
>   = Suma           Expresión Expresión
>   | Resta          Expresión Expresión
>   | Multiplicación Expresión Expresión
>   | División       Expresión Expresión
>   | Negativo       Expresión
>   | Literal        Integer
>   deriving (Eq, Read, Show)

> t1, t2, t3 :: Expresión
> t1 = Literal 42
> t2 = Suma (Literal 42) t1
> t3 = Suma (Multiplicación t2 (Multiplicación t2 (Literal 1) )) (Negativo (División (Suma t1 (Literal 0) ) (Literal 3) ))

> evaluar :: Expresión -> Double
> evaluar
>   = \ case
>     Suma           e1 e2 -> evaluar e1 + evaluar e2
>     Resta          e1 e2 -> evaluar e1 - evaluar e2
>     Multiplicación e1 e2 -> evaluar e1 * evaluar e2
>     División       e1 e2 -> evaluar e1 / evaluar e2
>     Negativo       e     -> - evaluar e
>     Literal        n     -> fromIntegral n :: Double