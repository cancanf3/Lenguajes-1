class BT
    attr_accessor :n
    attr_reader   :l, :r

    def initialize(n, l=nil, r=nil)
        @n = n
        @l = l
        @r = r
    end

    def each &block
        nodos = []
        if(l)
            yield l
        end
        if(r)
            yield r
        end
        return nodos
    end
end

class RT
    attr_accessor :n
    attr_reader   :ss

    def initialize(n, *sons)
        @n = n
        @ss = []
        sons.each { |x| @ss << x }
    end

    def each &block
        @ss.each { |nodo|
            yield nodo
            nodo.each &block
        }
    end
end