class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :title
      t.string :localtion
      t.text :description

      t.timestamps null: false
    end
  end
end
