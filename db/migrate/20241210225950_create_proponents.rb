class CreateProponents < ActiveRecord::Migration[5.2]
  def change
    create_table :proponents do |t|
      t.string :name
      t.string :document
      t.date :birthday
      t.decimal10 :salary
      t.decimal2 :salary
      t.decimal10 :discount_inss
      t.decimal2 :discount_inss

      t.timestamps
    end
  end
end
