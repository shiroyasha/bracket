require_relative "../src/kernel/kernel"

class Evaluator
  def initialize(input, stack = nil)
    @source = input
    @stack = stack || stdlib
  end

  def run
    evaluate(@source, @stack)
  end

  private

  def evaluate(input, env)
    if input[:type] == :structure
      structure = input[:value]
      
      head = structure[0]
      tail = structure[1..-1]

      if head[:type] == :atom

        case head[:value]
        when "def" then define(tail, env)
        when "fun" then define_fun(tail)
        else call(head, tail, env)
        end

      end

    else
      if input[:type] == :atom
        lookup(input[:value], env)
      else
        input
      end
    end
  end

  def define(elements, env)
    raise "Not enought arguments for define" if elements.length < 2
    raise "Too many arguments for define" if elements.length > 2
    
    name = elements[0][:value]
    what = evaluate(elements[1], env)

    env[name] = what
  end

  def define_fun(elements)
    { 
      :type => :function, 
      :arguments => elements[0], 
      :value => Proc.new do |env|
        result = elements[1..-1].map { |el| evaluate(el, env) }

        result.last
      end 
    }
  end

  def call(head, tail, env)
    name = head[:value]

    raise "no such function" if env[name] == nil
    func = env[name][:value]
    
    parameters = env[name][:arguments]
    arguments = tail.map { |el| evaluate(el, env) }

    parameters[:value].each_with_index do |el, i|
      name = el[:value]

      env[name] = arguments[i]
    end

    func.call(env)
  end

  def lookup(element, env)
    env[element] if env[element]
  end
end
