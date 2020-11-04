class SearchAirport
  attr_reader :query

  def self.call(query)
    new(query).call
  end

  def initialize(query)
    @query = query
  end

  def call
    airports = search_by_code
    return airports if airports.any?

    search_by_others
  end

  def search_by_code
    Airport.where(code: query.upcase)
  end

  def search_by_others
    Airport.joins(city: :country).where("
      airports.name ILIKE :query
      OR cities.name ILIKE :query
      OR countries.name ILIKE :query",
      query: "%#{query}%")
  end
end
