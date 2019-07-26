class City < ApplicationRecord
  has_many :favourites
  has_many :users, through: :favourites

  geocoded_by :name
  after_validation :geocode

  scope :list, -> { order('created_at') }
  scope :featured, -> do
    left_joins(:favourites).group(:id)
      .order(Arel.sql('COUNT(favourites.id) DESC, cities.created_at'))
  end
end
