# frozen_string_literal: true

class CreateStats < ActiveRecord::Migration[6.0]
  def change
    create_table :stats do |t|
      t.integer :goals
      t.integer :assists
      t.integer :passes
      t.integer :pass_accuracy
      t.integer :distance
      t.integer :fouls
      t.integer :yellow_cards
      t.references :player, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
