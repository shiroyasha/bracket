describe "Math" do
  it "can add numbers" do
    source = "(+ 1 2)"

    expect(evaluate(source)).to eq(3)
  end

  it "can multiply numbers" do
    source = "(* 1 2)"

    expect(evaluate(source)).to eq(2)
  end

  it "can calculate complex math expressions" do
    source = "(* 100 (+ 1 2 3) 2)"

    expect(evaluate(source)).to eq(1200)
  end
end
