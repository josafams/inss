# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.references :proponent, foreign_key: true
      t.string :type
      t.string :value

      t.timestamps
    end
  end
end
