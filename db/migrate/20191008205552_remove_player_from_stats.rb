# frozen_string_literal: true

class RemovePlayerFromStats < ActiveRecord::Migration[6.0]
  def change
    remove_reference :stats, :player, null: false, foreign_key: true
  end
end
