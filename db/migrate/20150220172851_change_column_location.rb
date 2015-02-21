class ChangeColumnLocation < ActiveRecord::Migration
  def change
  	rename_column :rooms, :localtion, :location
  end
end
