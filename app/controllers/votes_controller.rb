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
      cookies[:disabled] = {value: "", :expires => expiration}
    end

    @votes = cookies[:votes]
    @permanent = SnackData.permanent_snacks
    @suggestions = Suggestion.suggestion_data
    @disabled = deserialize_cookie(cookies[:disabled])
    @online = SnackAPI.new.online?
    
  end

  def create
    respond_to :json
    if cookies[:votes].to_i > 0 && includes_disabled?
                     
      cookies[:votes] = cookies[:votes].to_i - 1

      cookies[:disabled] = update_cookie_val(cookies[:disabled], params["name"])
      suggestion = Suggestion.where(name: params["name"]).first

      suggestion.update(votes: suggestion.votes += 1)

      render :json => {:status => 200, return: cookies[:votes]}

    elsif cookies[:votes].to_i > 0
      render :json => { 
                      :errors => "You already voted for that" 
                      }, 
                      :status => 403

    else
      render :json => { :errors => "No votes left" }, 
                        :status => 403
    end

  end

  def includes_disabled?
     !deserialize_cookie(cookies[:disabled]).include?(params["name"])
  end

  def deserialize_cookie(cookie)
    #we're using | to create the split between new items added to the cookie
    #its not elegant, but without an user login
    #there's no good way to keep track of what people have voted for
    #which is a pain, in the real world, it'd be less time intensive to just roll out devise.
   cookie.split("|")
  end

  def update_cookie_val(cookie, value)
      #for some reason trying to update the cookie we pass on doesn't work
      #we're probably passing the value not the reference. 
    value_array = deserialize_cookie(cookie)
    value_array << value
    value_array.join("|")
  end

end
