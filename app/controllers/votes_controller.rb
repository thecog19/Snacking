class VotesController < ApplicationController

  def index
    @permanent = SnackData.permanent_snacks
    @suggested = Suggestion.all
  end
end
