class Evaluator
  def initialize(input)
    @source = input
  end

  def run
    evaluate(@source, [])
  end

  private

  def evaluate(input, env_stack)
    env_stack << {}

    if input[:type] == :structure

      #head = evaluate input[:value][0], env_stack
      head = input[:value][0][:value]

      if head == "let"
        return define(input[:value][1..-1], env_stack)
      end

      tail = input[:value][1..-1].map { |el| evaluate el, env_stack }

      return case head
        when "+" then sum tail
        when "*" then product tail
        when "exit" then exit(1)
        else raise "unrecognized symbol"
        end

    else
      if input[:type] == :atom
        return lookup(input[:value], env_stack)
      else
        return input[:value]
      end
    end

    env_stack.pop
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

  def define(elements, env_stack)
    env_stack.last[elements[0]] = elements[1]
  end

  def lookup(element, env_stack)
    env_stack[element]
  end
end
