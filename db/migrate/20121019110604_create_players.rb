class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :number
      t.string :name
      t.decimal :height
      t.date :date_of_birth
      t.string :nationality
      t.decimal :weight
      t.string :position
      t.references :team

      t.timestamps
    end
  end
end