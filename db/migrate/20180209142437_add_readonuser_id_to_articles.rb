class AddReadonuserIdToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :readonuser_id, :integer
  end
end
