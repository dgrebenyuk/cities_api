class SerializableCity < JSONAPI::Serializable::Resource
  type 'city'
  attributes :name, :description, :population, :latitude, :longitude, :created_at
end
