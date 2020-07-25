user = User.create(name: 'Faruk', email: 'faruk@gmail.com')
departure = Place.create(name: 'Dhaka')
destination = Place.create(name: 'Kuala Lumpur')
trip = Trip.create(user: user,  date: Time.zone.today, departure: departure, destination: destination, status: :draft)
