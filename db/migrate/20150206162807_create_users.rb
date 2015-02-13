class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email, unique: true #cria indice com unicidade
      t.string :password
      t.string :location
      t.text :bio

      t.timestamps null: false
    end
  end
end
