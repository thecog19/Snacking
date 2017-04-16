namespace :monthly do
  desc "clears all suggestions!"
  task clear: :environment do
    Suggestion.destroy_all
  end

end
