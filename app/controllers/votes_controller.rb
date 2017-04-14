class VotesController < ApplicationController
  #Write seeds file
  #write rake task to be run every month (via cron, to reset "selected") (will delete the suggestions table and the votes table)

  def index
    if cookies[:votes].blank?
      #cookie expirations need to be in time format
      #or else they'll throw an error when they try to call .gmt on the expiration value
      #so we converte the date object to a time object
      expiration = Time.parse(Date.today.end_of_month.to_s)
      cookies[:votes] = {value: 3, :expires => expiration}
    end

    @votes = cookies[:votes]
    @permanent = SnackData.permanent_snacks
    @suggestions = Suggestion.suggestion_data
    @online = SnackAPI.new.online?
  end

  def create
    respond_to :json
    if cookies[:votes].to_i > 0 
      cookies[:votes] = cookies[:votes].to_i - 1
      render :json => {:status => 200, return: cookies[:votes]}
    else
      render :json => { :errors => "No votes left" }, :status => 403
    end

  end

end
