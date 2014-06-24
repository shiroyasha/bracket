class Classifier
  def initialize(input)
    @input = input
  end

  def run
    classify(@input)
  end

  private

  def classify(tree)
    tree[:value].map! do |element|
      if element.kind_of?(Hash) && element[:type] == :structure
        classify(element)
      else
        find_class(element)
      end
    end

    tree
  end

  def find_class(element)
    if element =~ /[1-9]([0-9]+)?/
      {:type => :number, :value => element.to_i}
    else
      {:type => :atom, :value => element}
    end
  end
end
