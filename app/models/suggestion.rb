class Suggestion < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.suggestion_data(snackdata = SnackData)
    api_suggestions = snackdata.optional_snacks
    names = generate_names(api_suggestions) 
    self.where('name IN (?)', name_list))
  end

  def self.generate_names(arr)
    name_list = []
    arr.each do |item|
      name_list << item["name"]
    end
    name_list
  end
end
