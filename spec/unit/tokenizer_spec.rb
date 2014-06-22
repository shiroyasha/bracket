describe Tokenizer do

  def tokenize(input)
    Tokenizer.new(input).run
  end

  it "can tokenize a simple srtucture" do
    input  = "(+ 1 2 3)"
    output = tokenize(input)

    expect(output).to eq(["(", "+", "1", "2", "3", ")"])
  end 
end
