> data Expresión
>   = Suma           Expresión Expresión
>   | Resta          Expresión Expresión
>   | Multiplicación Expresión Expresión
>   | División       Expresión Expresión
>   | Negativo       Expresión
>   | Literal        Integer
>   deriving (Eq, Read, Show)