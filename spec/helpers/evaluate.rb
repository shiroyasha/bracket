def evaluate(input)
  tokens = Tokenizer.new(input).run
  structure = Structurizer.new(tokens).run
  tree = Classifier.new(structure).run
  result = Evaluator.new(tree).run

  result[:value]
end
