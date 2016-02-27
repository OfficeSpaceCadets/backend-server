class CreateApiTokens < ActiveRecord::Migration
  def up
    create_table :api_tokens do |t|
      t.string :token, null: false
    end
  end

  def down
    drop_table :api_tokens
  end
end
