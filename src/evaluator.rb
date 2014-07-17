require_relative "../src/kernel/kernel"
require_relative "../src/environment"

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
        when "if" then (evaluate(tail[0], env)[:value] == true ? evaluate(tail[1], env) : evaluate(tail[2], env))
        when "show" then env.lookup(tail[0])
        when "def" then env.define(tail[0][:value], evaluate(tail[1], env) )
        when "fun" then fun(tail)
        else call(head, tail, env)
        end

      end

    elsif input[:type] == :atom
      env.lookup input[:value]
    else
      input
    end
  end

  def fun(elements)
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

    raise "no such function" if env.lookup(name) == nil
    func = env.lookup(name)[:value]
    
    parameters = env.lookup(name)[:arguments]
    arguments = tail.map { |el| evaluate(el, env) }

    new_scope = Environment.new(env)

    parameters[:value].each_with_index do |el, i|
      name = el[:value]

      new_scope.define name, arguments[i]
    end

    func.call(new_scope)
  end
end
