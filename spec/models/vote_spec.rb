require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:suggestion) {Suggestion.create(name: "test")}
  let(:vote) {Vote.create(suggestion_id: suggestion.id, votes: 3)}
  
  it "belongs to one suggestion" do 
    expect(vote.suggestion).to eq(suggestion)
  end

  it "has a votes value" do 
    expect(vote.votes).to eq(3)
  end

  it "requires a suggestion_id" do 
    expect(Vote.create(votes: 3).valid?).to be false
  end

  it "allows for a blank votes value" do
    expect(Vote.create(suggestion_id: suggestion.id, votes: 3).valid?).to be true 
  end
end
