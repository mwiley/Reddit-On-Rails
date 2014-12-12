class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name
      t.boolean :private

      t.timestamps
    end
  end
end
