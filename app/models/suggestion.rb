class Suggestion < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.suggestion_data(snackdata = SnackData)
    api_suggestions = snackdata.optional_snacks
    name_list = generate_names(api_suggestions) 
    self.where(name: name_list)
  end

  def self.generate_names(arr)
    name_list = []
    arr.each do |item|
      name_list << item["name"]
    end
    name_list
  end
end
