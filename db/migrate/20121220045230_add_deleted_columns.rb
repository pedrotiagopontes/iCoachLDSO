class AddDeletedColumns < ActiveRecord::Migration
  def up

    add_column :clubs, :deleted_at, :datetime
    add_column :convocations, :deleted_at, :datetime
    add_column :events, :deleted_at, :datetime
    add_column :games, :deleted_at, :datetime
    add_column :injuries, :deleted_at, :datetime
    add_column :notes, :deleted_at, :datetime
    add_column :players, :deleted_at, :datetime
    add_column :playersteams, :deleted_at, :datetime
    add_column :practices, :deleted_at, :datetime
    add_column :presences, :deleted_at, :datetime
    add_column :roles, :deleted_at, :datetime
    add_column :substitutions, :deleted_at, :datetime
    add_column :teams, :deleted_at, :datetime
    add_column :users, :deleted_at, :datetime

  end

  def down

    remove_column :clubs, :deleted_at
    remove_column :convocations, :deleted_at
    remove_column :events, :deleted_at
    remove_column :games, :deleted_at
    remove_column :injuries, :deleted_at
    remove_column :notes, :deleted_at
    remove_column :players, :deleted_at
    remove_column :playersteams, :deleted_at
    remove_column :practices, :deleted_at
    remove_column :presences, :deleted_at
    remove_column :roles, :deleted_at
    remove_column :substitutions, :deleted_at
    remove_column :teams, :deleted_at
    remove_column :users, :deleted_at

  end
end
