require "rails_helper"

describe SnackAPI do
  #our goal here is explicitly to not test the API
  #but rather to ensure what we're sending is what we intend to be sending
  #essentially these tests make sure httparty is being passed the params we specify
  #this means that if we swap out httparty with another class
  #these tests will still be useful! 

  describe "#get_snacks" do
    it "sends request to the desired url" do
      client = class_double("client")
      expect(client).to receive(:get).with("http://test.com", any_args)
      API = SnackAPI.new(client, "http://test.com", "testkey")
      API.get_snacks
    end  

    it "has the desired key in the header " do
      client = class_double("client")
      expect(client).to receive(:get).with(any_args, hash_including(headers: hash_including(:Authorization => "ApiKey testkey")))
      API = SnackAPI.new(client, "http://test.com", "testkey")
      API.get_snacks
    end  
  end
end

 
