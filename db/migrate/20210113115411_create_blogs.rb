class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :body
      t.references :user

      t.timestamps
    end
  end
end
