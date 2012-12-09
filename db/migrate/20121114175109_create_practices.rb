class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.date :date
      t.time :hour
      t.text :program
      t.boolean :presences_checked
      t.references :team

      t.timestamps
    end
    add_index :practices, :team_id
  end
end
