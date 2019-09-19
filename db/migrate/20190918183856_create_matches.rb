# frozen_string_literal: true

class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.references :home_team, index: true, foreign_key: { to_table: :teams }
      t.references :guest_team, index: true, foreign_key: { to_table: :teams }
      t.date :match_date

      t.timestamps
    end
  end
end
