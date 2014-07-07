def stdlib(env={})
  env["+"] = Proc.new do |elements|
    result = elements.inject(0) do |sum, el|
      raise "value error" unless el[:type] == :number
      sum += el[:value]
    end

    {:type => :number, :value => result}
  end

  env["-"] = Proc.new do |elements|
    result = elements.inject(0) do |sum, el|
      raise "value error" unless el[:type] == :number
      sum += el[:value]
    end

    {:type => :number, :value => result}
  end

  env["*"] = {
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

      {:type => :number, :value => env["a"][:value] * env["b"][:value]}
     end
  }

  env["exit"] = Proc.new do |elements|
    exit
  end

  env
end
