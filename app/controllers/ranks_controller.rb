class RanksController < ApplicationController

  def scored
    algorithm = Algorithm.new
    @stories = algorithm.score_stories
  end

end
