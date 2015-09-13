class Algorithm

  def retrieve_stories
    algolia_url = "http://hn.algolia.com/api/v1/search_by_date?tags=story&numericFilters=points>1&hitsPerPage=1000"
    stories_raw = open(algolia_url).read
    JSON.parse stories_raw, object_class: HashWithIndifferentAccess
  end

  def score_stories
    stories = retrieve_stories[:hits]
    stories[0..3].map do |story|
      story[:hours_ago] = (Time.zone.now - Time.zone.parse(story[:created_at])) / 1.hour
      story[:score] = 
      binding.pry
    end
  end

end
