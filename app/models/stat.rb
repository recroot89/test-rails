# frozen_string_literal: true

class Stat < ApplicationRecord
  belongs_to :player
  belongs_to :game
end
