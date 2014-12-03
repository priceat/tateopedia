class AddUpdaterToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :updater, :string
  end
end
