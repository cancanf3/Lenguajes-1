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
        return self.fmap(a,fb)
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

    def self.fmap(ab, fa)
        return fa.gsub(/[\s\S]/, ab)
    end
end

class Fixnum
    extend Functor

    def self.fmap(ab, fa)
        return Array.new(fa.length) { ab }
    end
end