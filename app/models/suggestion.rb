class Suggestion < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  #this method gets the optional snacks and adds the current vote total to the ones that are still there.  
  def self.suggestion_data(snackdata = SnackData)
    add_votes(snackdata.optional_snacks) 
  end

  private 

  def self.add_votes(arr)
    name_list = []
    arr.each do |item|
      unless self.where(name: item["name"]).empty? 
        item["votes"] = self.where(name: item["name"]).first.votes
        name_list << item
      end
    end
    name_list
  end
end
