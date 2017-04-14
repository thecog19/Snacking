class CreateSuggestions < ActiveRecord::Migration[5.0]
  def change
    create_table :suggestions do |t|
      t.string :name
      t.integer :votes

      t.timestamps
    end
  end
end
