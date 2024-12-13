# frozen_string_literal: true

class CreateProponents < ActiveRecord::Migration[5.2]
  def change
    create_table :proponents do |t|
      t.string :name
      t.string :document
      t.date :birthday
      t.float :salary
      t.float :discount_inss

      t.timestamps
    end
  end
end
