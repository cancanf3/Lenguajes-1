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