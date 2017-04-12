class SnackAPI
  def initialize(url = "https://api-snacks.nerderylabs.com/v1/snacks",
                client = HTTParty,
                key = ENV["APIkey"])
    @url = url
    @client = client
    @key = key
  end


  def api_test
    @client.get(@url, 
                headers: {
                  Authorization: "ApiKey #{@key}"
                  })
  end

end

c = SnackAPI.new
p c.api_test
