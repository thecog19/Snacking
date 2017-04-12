#i've rolled all our API interactions into its own model
#thus if the api ever changes all we have to do is modify this file
#remember to set up your api key as an env variable using figaro
#https://github.com/laserlemon/figaro


class SnackAPI
  #in case the url changes or there's a need to use a client other than 
  #httparty this makes life easier for testing purposes as well, letting us stub
  #out the requests, and reducing load on the actual api
  #api docs: https://api-snacks.nerderylabs.com/v1/help
  def initialize(client = HTTParty,  
                url = "https://api-snacks.nerderylabs.com/v1/snacks",
                key = ENV["APIkey"])

    @url = url
    @client = client
    #header requires the content type or else the post requests will fail
    #not technically needed for the get request but it doesn't adversely affect it
    @header =  {Authorization: "ApiKey #{key}",
                'Content-Type' => 'application/json'}
  end


  def get_snacks
    @client.get(@url, 
                headers: @header
                )
  end

  def add_snack(snack, location, lattitude = nil, longitude = nil)
    @client.post(@url, 
                headers: @header,
                body: {
                  "name" => snack,
                  "location" => location,
                  "lattitude" => lattitude,
                  "longitude" => longitude
                  }.to_json)
  end

end
