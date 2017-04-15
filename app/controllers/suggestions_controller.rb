class SuggestionsController < ApplicationController

  def index
    @online = SnackAPI.new.online?
  end

  def create
  end
end
