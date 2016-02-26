class CreateApiTokens < ActiveRecord::Migration
  def up
    create_table :api_tokens do |t|
      t.string :token
    end
  end

  def down
    drop_table :api_tokens
  end
end
