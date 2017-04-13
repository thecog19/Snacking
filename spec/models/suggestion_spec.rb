require 'rails_helper'

RSpec.describe Suggestion, type: :model do
  let(:suggestion) {Suggestion.create(name: "test")}
  let(:vote) {Vote.create(suggestion_id: suggestion.id, votes: 3)}
  
  it "has many votes" do
    #basically ensure that when you call votes you get back an active record array
    expect(suggestion.votes).to be_a(ActiveRecord::Associations::CollectionProxy)
  end

  it "validates for name existance" do
    expect(Suggestion.create(name: nil).valid?).to be false
  end

  it "validates for name uniqueness" do
    #let lazy loads so we need to make sure it actually loads here by including the 
    #variable suggestion
    suggestion
    expect(Suggestion.create(name: "test").valid?).to be false
  end
end
