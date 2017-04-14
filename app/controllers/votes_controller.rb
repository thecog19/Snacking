class VotesController < ApplicationController
  #Write seeds file
  #write rake task to be run every month (via cron, to reset "selected") (will delete the suggestions table and the votes table)

  def index
    @permanent = SnackData.permanent_snacks
    @suggestions = Suggestion.all
    @suggestions_info = nil #this will contain all the data for each suggestion
    @online = SnackAPI.new.online?
  end

  def create
  end

end
