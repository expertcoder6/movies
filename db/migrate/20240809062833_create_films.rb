class CreateFilms < ActiveRecord::Migration[7.0]
  def change
    create_table :films do |t|
      t.text :title
      t.integer :publishing_year

      t.timestamps
    end
  end
end
