class AddExternalIds < ActiveRecord::Migration
  def up
    add_column :users, :external_id, :string
  end

  def down
    remove_column :users, :external_id
  end
end
