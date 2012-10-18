class CreateClubes < ActiveRecord::Migration
  def change
    create_table :clubes do |t|
      t.string :nome
      t.string :sigla

      t.timestamps
    end
  end
end
