# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :matches, dependent: :nullify
end
