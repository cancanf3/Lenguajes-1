=begin

mixin:              Permite obtener flexibilidad en el uso de operaciones a toda una estructura
                    conectada. A través de un recorrido breadth-first search, los metodos pueden
                    realizar operaciones sobre toda la estructura.
Requerimientos:     La clase debe tener implementado un iterador bajo el nombre de each.
Metodos:            fold:   Es un metodo que al ir iterando sobre la estructura va realizando
                            operaciones binarias entre el valor del nodo y un acomulador, las 
                            cuales se van acomulando en el acomulador.
                    map:    Es un metodo que aplica una operacion sobre cada uno de los valores 
                            del nodo que va recorriendo.
                    map!:   Es un meotodo que aplica una operacion sobre cada uno de los valores
                            del nodo que va recorriendo y almacena el resultado en el valor del 
                            nodo.
                    bfs:    Es el metodo que permite recorrer la estructura con un sentido 
                            breadth-first search, todos los metodos de este mixin hacen uso de
                            este procedimiento para recorrer sobre las estructuras.
Autores:            Jose Peña 11-10775 y Amin Arria 11-10053


=end 



module Foldable

    def fold(b, &bloque)
        self.bfs { |x| b = yield b, x.n }
        return b 
    end

    def map &block
        self.bfs { |x| yield x }

    end

    def map! &block
        self.bfs { |x| x.n = yield x }
    end

    def bfs &block
        cola = []
        cola = cola.push(self)
        result = nil
        while (cola.any?) do
            aux = cola.pop
            aux.each { |x| cola.unshift(x) }
            yield aux
        end         
    end
            

end