class AddPositionToLists < ActiveRecord::Migration[8.1]
  def change
    add_column :lists, :position, :integer
  end
end
