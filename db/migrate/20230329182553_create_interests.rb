class CreateInterests < ActiveRecord::Migration[7.0]
  def change
    create_table :interests do |t|
      t.string :name
      t.string :experience
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
