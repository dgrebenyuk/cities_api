class Favourite < ApplicationRecord
  belongs_to :city
  belongs_to :user
  validates_uniqueness_of :city_id, scope: :user_id
end
