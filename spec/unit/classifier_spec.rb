describe Classifier do
  def classify(input)
    Classifier.new(input).run
  end

  it "classifies simple a simple structure" do
    input = {:type => :structure, :value => [
      "+", "1", "2"
    ]}

    output = {:type => :structure, :value => [
      {:type => :atom, :value => "+"},
      {:type => :number, :value => 1},
      {:type => :number, :value => 2}
    ]}

    expect(classify(input)).to eq(output)
  end

  it "classifies simple a nested structure" do
    input = {:type => :structure, :value => [
      "+", "1", {:type => :structure, :value => ["+", "2", "43"]}, "5"
    ]}

    output = {:type => :structure, :value => [
      {:type => :atom, :value => "+"},
      {:type => :number, :value => 1},
      {:type => :structure, :value => [
        {:type => :atom, :value => "+"},
        {:type => :number, :value => 2},
        {:type => :number, :value => 43}
      ]},
      {:type => :number, :value => 5}
    ]}

    expect(classify(input)).to eq(output)
  end
end
