class Tokenizer
  def initialize(source)
    @source = source 
  end

  def run
    @source.gsub(/\(/, " ( ")
           .gsub(/\)/, " ) ")
           .strip
           .split(/\s+/)
  end
end
