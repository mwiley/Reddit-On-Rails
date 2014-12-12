class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url
      t.string :text

      t.timestamps
    end
  end
end
