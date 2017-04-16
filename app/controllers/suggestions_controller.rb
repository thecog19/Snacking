class SuggestionsController < ApplicationController

  def index
    if cookies[:suggestions].blank?
      cookies[:suggestions] = 1
    end
    @online = SnackAPI.new.online?
    @submissions_left = cookies[:suggestions].to_i
    @suggestions = Suggestion.unused_api_suggestions
  end

  def create
    #two cases need to be handled here, the dropdown, and the form, we also handle cookie logic
    #not as skinny as I would like for sure. 
    suggestion = Suggestion.new(name: create_params["snack_name"], location: create_params["location"], votes: 0)
    if cookies[:suggestions].to_i < 1
      flash[:danger] = "You are out of suggestions"
      redirect_back(fallback_location: 'suggestion#index')
      return
    end


    if suggestion.valid? && Suggestion.unused_api_suggestions.include?(create_params["snack_name"])

      cookies[:suggestions] = cookies[:suggestions].to_i - 1
      
      suggestion.save
      flash[:success] = "Suggested!"
      redirect_back(fallback_location: 'suggestion#index')
    elsif suggestion.valid?
      SnackAPI.new.add_snack(create_params["snack_name"], create_params["location"])
      
      cookies[:suggestions] = cookies[:suggestions].to_i - 1

      suggestion.save
      flash[:success] = "Suggested!"
      redirect_back(fallback_location: 'suggestion#index')
    else 
      flash[:danger] = error_message(suggestion)
      redirect_back(fallback_location: 'suggestion#index')
    end
  end

  def create_params
    params.require(:suggestion).permit(:snack_name, :location)
  end

  def error_message(suggestion)
    if suggestion.errors.include?(:location) 
      return "A location must be provided"
    else
      return "That snack has already been suggested!"
    end    
  end

end
