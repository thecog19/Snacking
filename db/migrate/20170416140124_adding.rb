class Adding < ActiveRecord::Migration[5.0]
  def change
    add_column :suggestions, :location, :string
  end
end
