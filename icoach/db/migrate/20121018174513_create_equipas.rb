class CreateEquipas < ActiveRecord::Migration
  def change
    create_table :equipas do |t|
      t.string :epoca
      t.string :nome
      t.references :clube

      t.timestamps
    end
    add_index :equipas, :clube_id
  end
end
