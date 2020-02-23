class Mechanize::Page
  def safe_search(selector)
    results = search(selector)
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
