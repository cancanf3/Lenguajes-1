=begin

Mixin:              Permite tener clases que si cumplen los minimal implementation
                    pueden usar los metodos de Monoid y Functor.
Requerimientos:     Las clases que se extiendan de estos modulos deberan tener los
                    siguientes metodos implementados:
                    Monoid:
                        mempty: Da el elemento neutra de esa clase
                        mappend: Dos elementos de la clase son operados entre si
                    Functor:
                        fmap: Dado un bloque y una lista de elementos, esta es
                        operada para crear una nueva lista usando ese bloque.
Metodos:            Monoid:
                        mconcat: Concatena una lista de elementos.
                    Functor:
                        inj: Dado un elemento y una lista de elementos, remplaza
                        todos los elementos de la lista por el elemento dado
Autores:            Jose Peña 11-10775 y Amin Arria 11-10053

=end


module Monoid
    #Minimal implementation
        # mempty  :: a
        # mappend :: a -> a -> a

    # mconcat :: [a] -> a
    def mconcat(as)
        acumulador = self.mempty
        as.each { |x| 
            acumulador = self.mappend(acumulador, x)
        }
        return acumulador
    end
end

module Functor
    #Minimal implementation
        # fmap :: (a -> b) -> f a -> f b

    # (<$) :: a -> f b -> f a
    def inj a, fb
        fa = self.fmap(fb) { |b| a }
        return fa
    end
end

# Monoid Instances

# All
class TrueClass
    extend Monoid

    def self.mempty
        return true
    end

    def self.mappend(x, y)
        return (x and y)
    end
end

# Any
class FalseClass
    extend Monoid

    def self.mempty
        return false
    end

    def self.mappend(x, y)
        return (x or y)
    end
end

class String
    extend Monoid

    def self.mempty
        return ""
    end

    def self.mappend(x, y)
        return (x + y)
    end
end

class Fixnum
    extend Monoid

    def self.mempty
        return 0
    end

    def self.mappend(x, y)
        return (x + y)
    end
end

# Functor Instances

class String
    extend Functor

    def self.fmap fa, &block
        # return fa.gsub(/[\s\S]/, ab)
        fb = ""
        fa.each_char { |x| fb << (yield x) }
        return fb
    end
end

class Fixnum
    extend Functor

    def self.fmap(fa, &block)
        # return Array.new(fa.length) { ab }
        fb = []
        fa.each { |x| fb << (yield x) }
        return fb
    end
end