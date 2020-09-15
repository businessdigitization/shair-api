user = User.create(name: 'Faruk', email: 'faruk@gmail.com')
currency = Currency.create(name: 'Bangladeshi Taka', code: 'BDT')
departure = Place.create(name: 'Dhaka')
destination = Place.create(name: 'Kuala Lumpur')
trip = Trip.create(transporter: user, date: Time.zone.today, departure: departure, destination: destination, status: :draft)
trip_pricing = TripPricing.create(trip: trip, unit_price: 10, minimum_price: 7, currency: currency)
package = Package.create(transiter: user, departure: departure, destination: destination, status: :draft)
package_item = PackageItem.create(name: 'Golla', count: 1, package: package)
booking = Booking.create(package: package, trip: trip, currency: currency, transporter_proposed_price: 150, status: 'proposed')
