class Structurizer
  def initialize(source)
    @source = source
  end

  def run
    token = @source.shift
    result = []

    if token == "("

      while @source[0] != ")"

        if @source[0] == "("
          result << run
        else
          result << @source.shift
        end

        if @source.length == 0
          raise "expected closing bracket"
        end
      end

      # take down the closing bracket
      @source.shift

      {:type => :structure, :value => result }

    else
      raise "expected opening bracket"
    end
  end
end
