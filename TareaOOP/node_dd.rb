class Node
    attr_reader :x, :y
    
    def initialize x, y
      @x = x
      @y = y
    end

    def visitado_por v
      v.visitanteNodo self
    end

    def to_s
      return "#{@x} - #{@y}"
    end
end

# Se extiende la clase Fixnum
class Fixnum
   def visitado_por v
      v.visitanteFixnum self
   end
end

# Se extiende la clase Symbol
class Symbol
   def visitado_por v
      v.visitanteSymbol self
   end
end

class Visitor; end

class Mirror < Visitor
   def visitanteFixnum num
      return -num
   end

   def visitanteSymbol simbolo
      return (simbolo.to_s + simbolo.to_s.reverse).to_sym
   end

   def visitanteNodo nodo
      return Node.new(-nodo.x, -nodo.y)
   end
end

class Next < Visitor
   def visitanteFixnum num
      return num.succ      
   end

   def visitanteSymbol simbolo
      nuevo = ""
      simbolo.to_s.each_char { |x| 
         nuevo << x.next[0]
      }
      return nuevo.to_sym
   end

   def visitanteNodo nodo
      return Node.new(nodo.x.succ, nodo.y.succ)
   end
end

class Strong < Visitor
   def visitanteFixnum num
      return num*100
   end

   def visitanteSymbol simbolo
      return simbolo.upcase
   end

   def visitanteNodo nodo
      return Node.new(nodo.x*100, nodo.y*100)
   end
end