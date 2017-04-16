require 'rails_helper'

RSpec.describe Suggestion, type: :model do
  let(:suggestion) {Suggestion.create(name: "test", votes: 8, location: "red")}

  it "validates for name existance" do
    expect(Suggestion.create(name: nil, location: "Red").valid?).to be false
  end

  it "validates for location existence" do
    expect(Suggestion.create(name: "POTATO", votes: 9).valid?).to be false
  end

  it "validates for name uniqueness" do
    #let lazy loads so we need to make sure it actually loads here by including the 
    #variable suggestion
    suggestion
    expect(Suggestion.create(name: "test").valid?).to be false
  end

  describe "#suggestion_data" do
    let(:snackdata) {double("snackdata")}
    #we explicitly don't test #add_votes, its a private method, and an implementation detail
    it "returns an array" do
      allow(snackdata).to receive(:optional_snacks).and_return([{"name" => "test"}]) 
      expect(Suggestion.suggestion_data(snackdata)).to be_a(Array )
    end 

    it "Adds vote to the items returned by snackdata" do
      suggestion
      allow(snackdata).to receive(:optional_snacks).and_return([{"name" => "test"}]) 
      expect(Suggestion.suggestion_data(snackdata).first).to eq({"name" => "test", "votes" => 8})
    end 

    it "calls the SnackData" do 
      expect(snackdata).to receive(:optional_snacks).and_return([{"name" => "test"}]) 
      Suggestion.suggestion_data(snackdata)
    end

    it "returns the expected array of hashes" do
      suggestion
      allow(snackdata).to receive(:optional_snacks).and_return([{"name" => "test"}]) 
      expect(Suggestion.suggestion_data(snackdata)).to eq([{"name" => "test", "votes" => 8}])
    end
  end
  describe "#unused_api_suggestions" do
    let(:snackdata) {double("snackdata")}

    it "returns an array" do
       allow(snackdata).to receive(:optional_snacks).and_return([{"name" => "test"}]) 
      expect(Suggestion.unused_api_suggestions(snackdata)).to be_a(Array)
    end

    it "gets data from the API" do 
       expect(snackdata).to receive(:optional_snacks).and_return([{"name" => "test"}]) 
      Suggestion.unused_api_suggestions(snackdata)
    end

    it "returns only unused names" do 
      suggestion
      allow(snackdata).to receive(:optional_snacks).and_return([{"name" => "test"}, {"name" => "orange"}]) 
      expect(Suggestion.unused_api_suggestions(snackdata)).to eq(["orange"])
    end
  
  end

  describe "#permanent_names" do
    let(:snackdata) {double("snackdata")}

    it "returns an array" do
       allow(snackdata).to receive(:permanent_snacks).and_return([{"name" => "test"}]) 
      expect(Suggestion.permanent_names(snackdata)).to be_a(Array)
    end

    it "gets data from the API" do 
       expect(snackdata).to receive(:permanent_snacks).and_return([{"name" => "test"}]) 
      Suggestion.permanent_names(snackdata)
    end

    it "returns only names" do 
      suggestion
      allow(snackdata).to receive(:permanent_snacks).and_return([{"name" => "test"}, {"name" => "orange"}]) 
      expect(Suggestion.permanent_names(snackdata)).to contain_exactly("orange", "test")
    end
  end
end
