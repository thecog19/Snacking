class VotesController < ApplicationController
  #TODO: handle the case where the API is down
  def index
    @permanent = SnackData.permanent_snacks
    @suggested = Suggestion.all
  end
end
