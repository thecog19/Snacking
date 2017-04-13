require "faker"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
TIMES = 5

p "purging database"
Vote.destroy_all
Suggestion.destroy_all

p "generating suggestions"

TIMES.times do
  Suggestion.create(name:  Faker::Pokemon.name)
end

p "generating votes"

TIMES.times do 
  Vote.create(suggestion_id: Faker::Number.between(Suggestion.first.id, Suggestion.last.id) , votes: Faker::Number.between(1, 10))
end

p "all done."
