require('pry-byebug')
require_relative('db/sqlrunner')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/screening')

customer = Customer.new({
  'name' => 'George',
  'funds' => 100
  })

customer.save()

film = Film.new({
  'title' => 'Foob Life',
  'price' => 10
  })

film.save()

screening = Screening.new({
  'film_id' => film.id,
  'screening_time' => '18:00',
  'capacity' => 20
  })

binding.pry
nil
