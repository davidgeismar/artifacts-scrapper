class Mechanize::Page
  def safe_search(selector)
    results = search(selector)
    binding.pry
    if results.present?
      results
    else
      begin
        raise NodeNotFoundError
      rescue
      end
    end
  end
end
