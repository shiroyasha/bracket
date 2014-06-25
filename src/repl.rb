require_relative "../src/tokenizer"
require_relative "../src/structurizer"
require_relative "../src/classifier"
require_relative "../src/evaluator"

class Repl
  def initialize
  end

  def run
    puts "Interactive bracket interpreter"
    puts "Bracket version 0.0.1-alpha"
    puts "\n"

    repl_loop
  end

  def repl_loop
    while true do
      print ">> "
      input = $stdin.gets

      puts evaluate(input)
    end
  end

  def evaluate(input)
    tokens = Tokenizer.new(input).run
    structure = Structurizer.new(tokens).run
    tree = Classifier.new(structure).run
    result = Evaluator.new(tree).run

    result
  end
end

Repl.new.run
