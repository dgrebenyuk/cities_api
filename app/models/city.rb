class City < ApplicationRecord
  has_many :favourites
  has_many :users, through: :favourites

  geocoded_by :name
  after_validation :geocode
end
