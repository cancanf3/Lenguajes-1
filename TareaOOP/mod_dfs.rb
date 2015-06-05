module DFS
    def dfs &block
      yield self
      self.each &block
    end

    def dfs! &block
      @n = yield self
      self.each &block
    end
end