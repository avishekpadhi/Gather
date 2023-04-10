class AddArrayAttributeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :store, :jsonb,  default: []
  end
end
