class AddCustomFieldsToSignup < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :contact_number, :string
    add_column :users, :state, :string
    add_column :users, :city, :string
    add_column :users, :area, :string
    add_column :users, :date_of_birth, :date
    
  end
end
