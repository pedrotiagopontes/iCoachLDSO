class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.date :date
      t.time :hour
      t.references :team

      t.timestamps
    end
    add_index :practices, :team_id
  end
end
