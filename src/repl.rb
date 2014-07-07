require_relative "../src/tokenizer"
require_relative "../src/structurizer"
require_relative "../src/classifier"
require_relative "../src/evaluator"

require_relative "../src/kernel/kernel"

require "readline"

class Repl
  def initialize
    @line = ""
    @env = stdlib
  end

  def run
    puts "Interactive bracket interpreter"
    puts "Bracket version 0.0.1-alpha"
    puts

    repl_loop
  end

  def repl_loop
    while buf = Readline.readline(">> ", true) do
      begin
        puts evaluate(buf)
      rescue Exception => e
        p e
      end
    end
  end

  def evaluate(input)
    tokens = Tokenizer.new(input).run
    structure = Structurizer.new(tokens).run
    tree = Classifier.new(structure).run
    result = Evaluator.new(tree, @env).run

    result
  end
end

Repl.new.run
