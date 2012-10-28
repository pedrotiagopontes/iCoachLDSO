class CreateRoles < ActiveRecord::Migration
  def change
    drop_table :roles
    create_table :roles do |t|
      t.boolean :is_admin
      t.boolean :is_doctor
      t.boolean :is_coach
      t.boolean :is_manager
      t.references :user
      t.references :club

      t.timestamps
    end
    add_index :roles, :user_id
    add_index :roles, :club_id
  end
end
