class SearchAirport
  attr_reader :query

  def self.call(query)
    new(query).call
  end

  def initialize(query)
    @query = query
  end

  def call
    Airport.joins(city: :country).where("
      airports.code ILIKE :query
      OR airports.name ILIKE :query
      OR cities.name ILIKE :query
      OR countries.name ILIKE :query",
      query: "%#{query}%")
  end
end
