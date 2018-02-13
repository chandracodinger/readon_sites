class AddUsernameToReadonusers < ActiveRecord::Migration[5.1]
  def change
    add_column :readonusers, :username, :string
    add_index :readonusers, :username, unique: true
  end
end
