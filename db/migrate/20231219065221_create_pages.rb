class CreatePages < ActiveRecord::Migration[7.1]
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.boolean :published, default: false, null: false
      t.json :preferences
      t.integer :status, limit: 2, default: 0, null: false

      t.timestamps
    end
  end
end
