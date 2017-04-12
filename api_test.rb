class SnackAPI
  def initalize(url = "https://api-snacks.nerderylabs.com/v1/snacks",
                client = HTTParty,
                key = ENV["APIkey"])
    @url = url
    @client = client
    @key = key
  end


  def api_test
    @client.get(@url, 
                headers: {
                  "key" => @key
                  })
  end

end
