describe Structurizer do

  def structurize(input)
    Structurizer.new(input).run
  end

  it "should structurize simple forms" do
    input = ["(", "+", "1", "2", ")"]

    output = {:type => :structure, :value => ["+", "1", "2"] }

    expect(structurize(input)).to eq(output)
  end

  it "should structurize nested forms" do
    input = ["(", "+", "1", "(", "*", "1", "2", ")", "1", ")"]

    output = {:type => :structure,
              :value => ["+", "1",
                         {:type => :structure,
                          :value => ["*", "1", "2"]},
                         "1"] }

    expect(structurize(input)).to eq(output)
  end
end
