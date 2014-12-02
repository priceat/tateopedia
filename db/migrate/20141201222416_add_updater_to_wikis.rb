class AddUpdaterToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :updater, :integer, default: :user_id
  end
end
