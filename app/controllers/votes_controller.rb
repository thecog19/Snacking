class VotesController < ApplicationController
  #TODO: handle the case where the API is down
  #TODO: more snack_api testing, we only test one method atm
  def index
    @permanent = SnackData.permanent_snacks
    @suggested = Suggestion.all
    @online = SnackAPI.new.online?
  end

  def create
  end

end
