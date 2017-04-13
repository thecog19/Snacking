require "rails_helper"

describe SnackData do
  #we're once again stubbing out the API, although this time its the SnackAPI class!
  describe "#permanent_snacks" do
    let(:client) {double("client")}
    let(:sample_group) do
      [{
          #these actually have to be a hashrockets not colens, or else
          #ruby will convert the string to symbols
          #which is not what API actually returns
          "id"=> 6,
          "name" => "Gorp",
          "optional" => true,
          "purchaseLocations"=>  "John's Grocery, Corner C-Store",
          "purchaseCount"=> 0,
          "lastPurchaseDate"=> nil
        },
        {
          "id"=> 17,
          "name"=> "Bacon Jerky",
          "optional" => false,
          "purchaseLocations"=> "John's Grocery",
          "purchaseCount"=> 542,
          "lastPurchaseDate"=> "4/12/2017"
        }]
    end

    it "calls the client to request the snacks" do
      expect(client).to receive(:get_snacks).and_return([])
      SnackData.permanent_snacks(client)
    end  

    it "returns an array" do 
      allow(client).to receive(:get_snacks).and_return([])
      expect(SnackData.permanent_snacks(client)).to be_a(Array)
    end

    it "returns an empty array if all snacks are optional" do 
       allow(client).to receive(:get_snacks).and_return([{
          "id"=> 6,
          "name"=> "Gorp",
          "optional" => true,
          "purchaseLocations"=>  "John's Grocery, Corner C-Store",
          "purchaseCount"=> 0,
          "lastPurchaseDate"=> nil
        },
        {
          "id"=> 17,
          "name"=> "Bacon Jerky",
          "optional" => true,
          "purchaseLocations"=> "John's Grocery",
          "purchaseCount"=> 542,
          "lastPurchaseDate"=> "4/12/2017"
        }])
      expect(SnackData.permanent_snacks(client)).to eq([])
    end

    it "returns the non-optional snacks" do
      allow(client).to receive(:get_snacks).and_return(sample_group)

      expect(SnackData.permanent_snacks(client)).to contain_exactly({
          "id"=> 17,
          "name"=> "Bacon Jerky",
          "optional"=> false,
          "purchaseLocations"=> "John's Grocery",
          "purchaseCount"=> 542,
          "lastPurchaseDate"=> "4/12/2017"
        })
    end  

    it "doesn't return optional snacks" do
      allow(client).to receive(:get_snacks).and_return(sample_group)

      expect(SnackData.permanent_snacks(client)).to_not include({
          "id"=> 6,
          "name"=> "Gorp",
          "optional"=> true,
          "purchaseLocations"=>  "John's Grocery, Corner C-Store",
          "purchaseCount"=> 0,
          "lastPurchaseDate"=> nil
        })
    end
  end


  describe "#optional_snacks" do
    let(:client) {double("client")}
    let(:sample_group) do
      [{
          #these actually have to be a hashrockets not colens, or else
          #ruby will convert the string to symbols
          #which is not what API actually returns
          "id"=> 6,
          "name" => "Gorp",
          "optional" => true,
          "purchaseLocations"=>  "John's Grocery, Corner C-Store",
          "purchaseCount"=> 0,
          "lastPurchaseDate"=> nil
        },
        {
          "id"=> 17,
          "name"=> "Bacon Jerky",
          "optional" => false,
          "purchaseLocations"=> "John's Grocery",
          "purchaseCount"=> 542,
          "lastPurchaseDate"=> "4/12/2017"
        }]
    end

    it "calls the client to request the snacks" do
      expect(client).to receive(:get_snacks).and_return([])
      SnackData.optional_snacks(client)
    end  

    it "returns an array" do 
      allow(client).to receive(:get_snacks).and_return([])
      expect(SnackData.optional_snacks(client)).to be_a(Array)
    end

    it "returns an empty array if all snacks are mandatory" do 
       allow(client).to receive(:get_snacks).and_return([{
          "id"=> 6,
          "name"=> "Gorp",
          "optional" => false,
          "purchaseLocations"=>  "John's Grocery, Corner C-Store",
          "purchaseCount"=> 0,
          "lastPurchaseDate"=> nil
        },
        {
          "id"=> 17,
          "name"=> "Bacon Jerky",
          "optional" => false,
          "purchaseLocations"=> "John's Grocery",
          "purchaseCount"=> 542,
          "lastPurchaseDate"=> "4/12/2017"
        }])
      expect(SnackData.optional_snacks(client)).to eq([])
    end

    it "returns the optional snacks" do
      allow(client).to receive(:get_snacks).and_return(sample_group)

      
      expect(SnackData.optional_snacks(client)).to contain_exactly({
          "id"=> 6,
          "name"=> "Gorp",
          "optional"=> true,
          "purchaseLocations"=>  "John's Grocery, Corner C-Store",
          "purchaseCount"=> 0,
          "lastPurchaseDate"=> nil
        })
    end  

    it "doesn't return optional snacks" do
      allow(client).to receive(:get_snacks).and_return(sample_group)

      expect(SnackData.optional_snacks(client)).to_not include({
          "id"=> 17,
          "name"=> "Bacon Jerky",
          "optional"=> false,
          "purchaseLocations"=> "John's Grocery",
          "purchaseCount"=> 542,
          "lastPurchaseDate"=> "4/12/2017"
        })
    end
  end
end
