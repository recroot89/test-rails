# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :team

  has_many :games, dependent: :destroy
  has_many :matches, through: :games
end
