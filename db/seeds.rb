user = User.create(name: 'Faruk', email: 'faruk@gmail.com')
trip = Trip.create(user: user,  date: Time.zone.today, departure: 'KL', destination: 'Dhaka', status: :draft)
