{
  'Shanghai' => 24_153_000,
  'Beijing' => 18_590_000,
  'Karachi' => 18_000_000,
  'Istanbul' => 14_657_000,
  'Dhaka' => 14_543_000,
  'Tokyo' => 13_617_000,
  'Moscow' => 13_197_596,
  'Manila' => 12_877_000,
  'Tianjin' => 12_784_000,
  'Mumbai' => 12_400_000
}.each_with_index do |(name, population), rank|
  City.create(name: name,
    description: "The #{(rank + 1).ordinalize} largest city in the world",
    population: population)
end
