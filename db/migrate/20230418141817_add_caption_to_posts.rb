class AddCaptionToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :caption, :string
  end
end
