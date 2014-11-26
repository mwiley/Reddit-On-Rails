class CreateCommunityUsers < ActiveRecord::Migration
  def change
    create_table :community_users do |t|
      t.references :user, index: true
      t.references :community, index: true
      t.boolean :admin
      t.boolean :subscriber
      t.boolean :banned

      t.timestamps
    end
  end
end
