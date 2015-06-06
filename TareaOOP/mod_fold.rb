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