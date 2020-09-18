require 'csv'

namespace :import do
  desc 'Import countries from CSV'
  task countries: :environment do
    CSV.foreach('lib/countries.csv', headers: true) do |row|
      Country.new(code: row['code'], name: row['name']).save
    end
  end

  desc 'Import cities from CSV'
  task cities: :environment do
    CSV.foreach('lib/airports.csv', headers: true) do |row|
      country = Country.find_by(name: row['country'])
      City.create(country: country, name: row['city']) if country
    end
  end

  desc 'Import airports from CSV'
  task airports: :environment do
    CSV.foreach('lib/airports.csv', headers: true) do |row|
      country = Country.find_by(name: row['country'])
      city = City.find_by(name: row['city'], country: country)

      Airport.create(city: city, name: row['name'], code: row['code']) if city
    end
  end
end
