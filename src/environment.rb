class Environment
  
  def initialize(parent=nil)
    @parent = parent
    @elements = {}
  end

  def lookup(symbol)
     if @elements[symbol] != nil
       @elements[symbol]
     elsif @parent != nil
       @parent.lookup(symbol)
     else
       nil
     end
  end

  def define(symbol, value)
    @elements[symbol] = value
    value
  end

  def to_s
    @elements.to_s
  end
end
