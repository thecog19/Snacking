class SnackAPI
  def initialize(url = "https://api-snacks.nerderylabs.com/v1/snacks",
                client = HTTParty,
                key = ENV["APIkey"])
    @url = url
    @client = client
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

c = SnackAPI.new
p c.get_snacks