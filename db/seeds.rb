dispatcher = User.create(name: 'Faruk', email: 'faruk@gmail.com')
transporter = User.create(name: 'Tuly', email: 'tuly@gmail.com')
currency = Currency.create(name: 'Bangladeshi Taka', code: 'BDT')
ochinpur = Country.create(name: 'Ochinpur', code: 'XU')
nomanland = Country.create(name: 'Nomanland', code: 'XO')
ochinpur_city = City.create(country: ochinpur, name: 'Ochinpur City')
nomanland_city = City.create(country: nomanland, name: 'Nomanland City')
ochinpur_airport = Airport.create(name: 'Ochinpur Airport', city: ochinpur_city, code: 'XUA')
nomanland_airport = Airport.create(name: 'Nomanland Airport', city: nomanland_city, code: 'XUL')
trip = Trip.create(transporter: transporter, departure_at: Time.zone.today, origin: ochinpur_airport, destination: nomanland_airport, status: :draft)
trip_pricing = TripPricing.create(trip: trip, unit_price: 10, minimum_price: 7, currency: currency)
parcel = Parcel.create(dispatcher: dispatcher, origin: ochinpur_airport, destination: nomanland_airport, status: :draft)
item_type = ParcelItemType.create(name: 'Electronic')
ParcelItemType.create(name: 'Cosmetics')
parcel_item = ParcelItem.create(name: 'Golla', count: 1, parcel: parcel, item_type: item_type)
booking = Booking.create(parcel: parcel, trip: trip, currency: currency, transporter_proposed_price: 150, status: 'proposed')
