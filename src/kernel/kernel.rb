def stdlib(env={})
  env = Environment.new
  
#  env.define "+", Proc.new do |elements|
#    result = elements.inject(0) do |sum, el|
#      raise "value error" unless el[:type] == :number
#      sum += el[:value]
#    end
#
#    {:type => :number, :value => result}
#  end

#  env.define "-", Proc.new do |elements|
#    result = elements.inject(0) do |sum, el|
#      raise "value error" unless el[:type] == :number
#      sum += el[:value]
#    end

#    {:type => :number, :value => result}
#  end

  env.define "*", {
    :type => :function,
    :arguments => {:type => :structure, :value => 
                     [{:type => :atom, :value => "a"},
                      {:type => :atom, :value => "b"}]
                  },
    :value => Proc.new do |env|
      #result = elements.inject(1) do |sum, el|
      #  raise "value error" unless el[:type] == :number
      #  sum *= el[:value]
      #end

      a = env.lookup("a")[:value]
      b = env.lookup("b")[:value]

      {:type => :number, :value => a * b }
     end
  }

#  env.define "exit", Proc.new do |elements|
#    exit
#  end

  env
end
