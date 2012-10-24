class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.decimal :height
      t.date :date_of_birth
      t.string :nacionality
      t.decimal :weight
      t.string :position
      t.references :team

      t.timestamps
    end
  end
end
