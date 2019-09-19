# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :player
  belongs_to :match
end
