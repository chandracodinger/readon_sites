class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :image
      t.text :body
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
