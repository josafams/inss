# frozen_string_literal: true

class CreateProponents < ActiveRecord::Migration[5.2]
  def change
    create_table :proponents do |t|
      t.string :name
      t.string :document
      t.date :birthday
      t.bigint :salary
      t.bigint :discount_inss

      t.timestamps
    end
  end
end
