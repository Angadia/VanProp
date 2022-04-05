class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :location, null: false
      t.integer :price, null: false
      t.text :amenities, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
