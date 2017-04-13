class VotesController < ApplicationController
  #Write seeds file
  #write rake task to be run every month (via cron, to reset "selected") (will delete the suggestions table and the votes table)

  def index
    @permanent = SnackData.permanent_snacks
    @suggested = Suggestion.all
    @online = SnackAPI.new.online?
  end

  def create
  end

end
