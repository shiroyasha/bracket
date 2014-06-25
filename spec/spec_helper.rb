require_relative "../src/tokenizer"
require_relative "../src/structurizer"
require_relative "../src/classifier"
require_relative "../src/evaluator"

require_relative "helpers/evaluate"

RSpec.configure do |config|
  
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.order = :random
  
  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    # Enable only the newer, non-monkey-patching expect syntax.
    # For more details, see:
    #   - http://teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
    mocks.syntax = :expect

    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended.
    mocks.verify_partial_doubles = true
  end
end
