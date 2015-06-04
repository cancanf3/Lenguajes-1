module DFS
    def dfs &block
      yield self
      self.each &block
    end

    def dfs! &block
    end
end