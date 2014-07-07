describe Evaluator do
  def evaluate(input)
    Evaluator.new(input).run
  end

  it "should calculate simple math expressions" do
    input = {:type => :structure, 
             :value => [
               {:type => :atom, :value => "+"},
               {:type => :number, :value => 1},
               {:type => :number, :value => 2}
              ]
            }

    expect(evaluate(input)).to eq :type => :number, :value => 3
  end

  it "should calculate nested math expressions" do
    input = {:type => :structure, :value => [
               {:type => :atom, :value => "+"},
               {:type => :number, :value => 1},
               {:type => :structure, :value => [
                 {:type => :atom, :value => "*"},
                 {:type => :number, :value => 7},
                 {:type => :number, :value => 3}
               ]},
               {:type => :number, :value => 2}
            ]}

    expect(evaluate(input)).to eq :type => :number, :value => 24
  end
end
