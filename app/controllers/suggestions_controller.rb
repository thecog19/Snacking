class SuggestionsController < ApplicationController

  def index
    @online = SnackAPI.new.online?
    @suggestions = Suggestion.unused_api_suggestions
  end

  def create
    #two cases need to be handled here, the dropdown, and the form
    #if it comes from the form, we need to do one thing
    #if it comes from the dropdown, another
    #need to account for blank location
    #add that validation to the model?
    suggestion = Suggestion.new(name: create_params["snack_name"])
    if suggestion.valid? && Suggestion.unused_api_suggestions.include?(create_params["snack_name"])
      suggestion.save
      flash[:success] = "Suggested!"
    elsif suggestion.valid?
      SnackAPI.new.add_snack(create_params["snack_name"], create_params["location"])
      suggestion.save
      flash[:success] = "Suggested!"
    # elsif 
    #   flash[:danger] = "That has already been suggested"
    #   redirect_back(fallback_location: 'suggestion#index')
    else 
      flash[:danger] = "You did not include a location"
      redirect_back(fallback_location: 'suggestion#index')
    end
  end

  def create_params
    params.require(:suggestion).permit(:snack_name, :location)
  end
end
