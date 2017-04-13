require "rails_helper"

describe SnackAPI do
  #our goal here is explicitly to not test the API
  #but rather to ensure what we're sending is what we intend to be sending
  #essentially these tests make sure httparty is being passed the params we specify
  #this means that if we swap out httparty with another class
  #these tests will still be useful! 
  let(:client) {class_double("client")}
  let(:api) {SnackAPI.new(client, "http://test.com", "testkey")}
  let(:fake_response) { class_double("response")}

  describe "#get_snacks" do
    it "sends request to the desired url" do
      expect(client).to receive(:get).with("http://test.com", any_args)
      api.get_snacks
    end  

    it "has the desired key in the header " do
      expect(client).to receive(:get).with(any_args, 
        hash_including(
          headers: hash_including(
            :Authorization => "ApiKey testkey"
            )
          )
        )
      api.get_snacks
    end  

    it "returns the api's response" do 
      allow(client).to receive(:get).and_return(fake_response)
      expect(api.get_snacks).to be(fake_response)
    end
  end

  describe "#online?" do
    before do 
      allow(client).to receive(:get).and_return(fake_response)
    end

    it "it sends out a request" do
      allow(fake_response).to receive(:code).and_return(200)
      expect(client).to receive(:get)
      api.online?
    end  

    it "returns false if the service is offline " do
      allow(fake_response).to receive(:code).and_return(404
        )
      expect(api.online?).to be false
    end  

    it "returns true if the service is online " do
      allow(fake_response).to receive(:code).and_return(200
        )
      expect(api.online?).to be true
    end  
  end

  describe 'add_snack' do 
    #due to time constraints, I'm not testing the that we're sending the correct json object
    #as dealing with json structures in rspec is difficult

    it "Sends a post request" do
      expect(client).to receive(:post)
      api.add_snack("aaa", "bbb")
    end


    it "has the API key" do
      expect(client).to receive(:post).with(any_args, 
        hash_including(
          headers: hash_including(
            :Authorization => "ApiKey testkey"
            )
          )
        )
      api.add_snack("aaa", "bbb")
    end

    it "sends the request to the proper url." do
      expect(client).to receive(:post).with("http://test.com", any_args)
      api.add_snack("aaa", "bbb")
    end

    it "returns the api's response" do 
      allow(client).to receive(:post).and_return(fake_response)
      expect(api.add_snack("aaa", "bbb")).to be(fake_response)
    end
  end
end

 
