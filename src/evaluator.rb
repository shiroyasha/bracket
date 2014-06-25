class Evaluator
  def initialize(input)
    @source = input
  end

  def run
    evaluate(@source)
  end

  private

  def evaluate(input)
    if input[:type] == :structure

      head = evaluate input[:value][0]
      tail = input[:value][1..-1].map { |el| evaluate el }

      case head
      when "+" then sum tail
      when "*" then product tail
      when "exit" then exit(1)
      else raise "unrecognized symbol"
      end

    else
      input[:value]
    end
  end

  def sum(elements)
    sum = 0
    elements.each { |el| sum += el }
    sum
  end

  def product(elements)
    sum = 1
    elements.each { |el| sum *= el }
    sum
  end
end
