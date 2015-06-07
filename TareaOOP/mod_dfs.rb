=begin

Mixin:              Permite obtener la funcionalidad de recorridos Depth-first search.
Requerimientos:     La clase debe tener implementado un iterador bajo el nombre de each.
Metodos:            dfs : Realiza un recorrido depth-first search sobre la estructura,
                          mientras permite realizar instrucciones con los nodos recorridos.
                    dfs!: Realiza un recorrido depth-first search sobre la estructura, 
                          mientras permite realizar instrucciones con los nodos recorridos
                          y estas instrucciones pueden modificar a los mismos.
Autores:            Jose Peña 11-10775 y Amin Arria 11-10053

=end





module DFS
    def dfs &block
      yield self
      self.each { |x| x.dfs(&block) }
    end

    def dfs! &block
      @n = yield self
      self.each { |x| x.dfs!(&block) }
    end
end