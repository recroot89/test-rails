# frozen_string_literal: true

class AddDateToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :game_date, :date
  end
end
