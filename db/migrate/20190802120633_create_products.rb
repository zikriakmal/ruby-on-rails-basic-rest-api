class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :nama
      t.string :kode
      t.string :jumlah

      t.timestamps
    end
  end
end
