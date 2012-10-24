class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean

    add_column :users, :is_doctor, :boolean

    add_column :users, :is_coach, :boolean

    add_column :users, :is_manager, :boolean

  end
end
