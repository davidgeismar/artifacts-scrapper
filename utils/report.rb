class Report
  def initialize(filepath)
    @filepath = filepath
    @file = File.open(@filepath, "a")
  end

  def writte(content)
    @file.puts(content)
  end
end
