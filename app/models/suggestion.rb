class Suggestion < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  #this method gets the optional snacks and adds the current vote total to the ones that are still there.  
  def self.suggestion_data(snackdata = SnackData)
    add_votes(snackdata.optional_snacks) 
  end

  def self.unused_api_suggestions(snackdata = SnackData)
    api_snacks = reduce_to_names(snackdata.optional_snacks)
    suggestions = reduce_to_names(Suggestion.all)
    api_snacks - suggestions || suggestions - api_snacks
  end

  private 

  def self.reduce_to_names(arr)
    #this method takes an array of hashes returned and reduces it to an array of names
    new_arr = arr.map do |snack|
      snack = snack[:name] || snack["name"]
    end
    new_arr
  end

  def self.add_votes(arr)
    #this method takes the array of hashes returned by the API and turns it into a list of those which have been suggested this month, it also appends the number of votes to each hash.
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
