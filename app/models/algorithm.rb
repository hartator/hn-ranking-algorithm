class Algorithm

  def retrieve_stories
    algolia_url = "http://hn.algolia.com/api/v1/search_by_date?tags=story&numericFilters=points>1&hitsPerPage=1000"
    stories_raw = open(algolia_url).read
    JSON.parse stories_raw, object_class: HashWithIndifferentAccess
  end

  def score_stories
    gravity = 1.8
    stories = retrieve_stories[:hits]
    stories.map! do |story|
      story[:points] = story[:points].to_f
      story[:created_at] = Time.zone.parse(story[:created_at])
      story[:hours_ago] = (Time.zone.now - story[:created_at]) / 1.hour
      story[:score] = (story[:points]-1) ** 0.8 / (story[:hours_ago] + 2) ** 1.8
      story
    end
    stories.sort_by {|e| e[:score]}
  end

end
