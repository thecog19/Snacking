class Suggestion < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  #modify this method, return just the suggestion objects i need witht the number of votes attached. 
  def self.suggestion_data(snackdata = SnackData)
    api_suggestions = snackdata.optional_snacks
    add_votes(api_suggestions) 
  end

  def self.generate_names(arr)
    name_list = []
    arr.each do |item|
      item["votes"] = self.where(name: item["name"]).first.vot
    end
    name_list
  end
end
