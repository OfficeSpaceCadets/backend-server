class CreateUsersAndSessions < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name, null: false
      t.string :username, null: false
      t.string :email, null: false
    end

    create_table :pairing_sessions do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
    end

    create_table :pairing_sessions_users do |t|
      t.belongs_to :pairing_session, null: false
      t.belongs_to :user, null: false
    end

    add_foreign_key :pairing_sessions_users, :users
    add_foreign_key :pairing_sessions_users, :pairing_sessions
  end

  def down
    remove_foreign_key :pairing_sessions_users, :users
    remove_foreign_key :pairing_sessions_users, :pairing_sessions

    drop_table :pairing_sessions_users
    drop_table :pairing_sessions
    drop_table :users
  end
end
