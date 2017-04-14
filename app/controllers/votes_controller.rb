class VotesController < ApplicationController
  #Write seeds file
  #write rake task to be run every month (via cron, to reset "selected") (will delete the suggestions table and the votes table)

  def index
    if cookies[:votes].blank?
      cookies[:votes] = {value: 3, :expires => end_of_month}

    end
    @votes = cookies[:votes]
    @permanent = SnackData.permanent_snacks
    @suggestions = Suggestion.suggestion_data
    @online = SnackAPI.new.online?
  end

  def create
    respond_to :json
    unless cookies[:votes] == 0 
      cookies[:votes] = cookies[:votes].to_i - 1
    else
      "No votes left this month"
    end

  end

end
