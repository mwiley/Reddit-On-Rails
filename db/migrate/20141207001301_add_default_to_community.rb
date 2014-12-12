class AddDefaultToCommunity < ActiveRecord::Migration
  def change
    add_column :communities, :default, :boolean
  end
end
